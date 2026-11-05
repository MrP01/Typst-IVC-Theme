// Report and thesis templates for the IVC, extending definitely-not-isec-thesis
// (https://typst.app/universe/package/definitely-not-isec-thesis, MIT, Ernesto Martínez García).
//
//   report           seminar report: title block, numbered sections
//   bachelor-thesis  + title page, affidavit, abstract (+ Kurzfassung), contents, chapters
//   master-thesis    + lists of figures and tables
//   phd-thesis       + large chapter numbers
//
// Each template only states what it adds or changes and passes everything else on,
// so the user's arguments always win.
#import "definitions.typ": ivc-color, link-color, tug-color
#import "ivc-thesis-macros.typ": in-outline, keywords-line, small-heading, thesis-outline

#let _chapters = state("ivc-thesis-chapters", false) // level-1 headings are chapters
#let _appendix = state("ivc-thesis-appendix", false)

// figure and equation numbers: "2.3" in chapters ("B.3" in the appendix), "3" otherwise.
// Hand it to packages with their own numbering: subpar.grid(numbering: figure-number, numbering-sub-ref: figure-number)
#let figure-number(..n) = if _chapters.get() {
  numbering(if _appendix.get() { "A.1a" } else { "1.1a" }, counter(heading).get().first(), ..n.pos())
} else { numbering("1a", ..n.pos()) }

#let _as-array(x) = if type(x) == array { x } else { (x,) }
#let _date(d) = if type(d) == datetime { d.display("[month repr:long] [year]") } else { d }
// author: "Name", (name: "Name", name-with-title: [Dipl.-Ing. Name, BSc]), or an array of these;
// the PDF metadata gets the names, the title page the names with titles
#let _authors(o) = _as-array(o.author).map(a => if type(a) == dictionary { a } else { (name: a) })
#let _author-names(o) = _authors(o).map(a => a.name)
#let _authors-with-titles(o) = _authors(o).map(a => a.at("name-with-title", default: a.name)).join(", ")
#let _plural(label, names) = label + if names.len() > 1 { "s" }
#let _logos(height) = grid(
  columns: (1fr, 1fr),
  align(left, image("assets/ivc-logo.pdf", height: height)), align(right, image("assets/tugraz-logo.pdf", height: height)),
)

// ---------------------------------------------------------------------------
// Title pages and front matter

#let _blank-page = page(header: none, footer: none)[] // for blank-pages: true

#let report-title(o) = {
  _logos(1.2cm)
  v(1.5cm)
  text(size: 0.85em, weight: "bold", tracking: 0.08em, fill: tug-color, upper(o.kind))
  block(above: 0.6em, below: 0.6em, text(size: 2em, weight: "bold", fill: ivc-color, o.title))
  if o.subtitle != none { text(size: 1.3em, o.subtitle) }
  block(above: 1.2em, below: 1.2em, {
    text(size: 1.1em, _authors-with-titles(o))
    set text(size: 0.9em, fill: luma(60))
    let sup = _as-array(o.supervisors)
    if sup.len() > 0 [ \ #_plural("Supervisor", sup): #sup.join(", ")]
    [ \ #o.institute, Graz University of Technology \ #_date(o.date)]
  })
  line(length: 100%, stroke: 0.5pt)
  if o.abstract != none {
    small-heading[Abstract]
    o.abstract
    keywords-line([Keywords], o.keywords)
  }
  v(1em)
}

#let thesis-title-page(o) = page(
  margin: (x: 2.5cm, top: 2cm, bottom: 2.5cm),
  header: none,
  footer: none,
  background: if o.at("title-bar", default: true) { place(left, rect(width: 6mm, height: 100%, fill: ivc-color)) },
  {
    set align(center)
    set par(justify: false, first-line-indent: 0pt, spacing: 0.8em)
    _logos(1.3cm)
    v(2.5cm)
    text(size: 14pt, _authors-with-titles(o))
    v(1cm)
    text(size: 22pt, weight: "bold", fill: ivc-color, o.title)
    if o.subtitle != none { block(text(size: 14pt, o.subtitle)) }
    v(1fr)
    text(size: 12pt, weight: "bold", tracking: 0.08em, upper(o.kind))
    [ \ to achieve the university degree of \ #o.degree]
    if o.at("curriculum", default: none) != none [ \ #if o.programme != none [#o.programme: ]#o.curriculum]
    v(1cm)
    [#text(size: 10pt)[submitted to] \ *Graz University of Technology*]
    v(1cm)
    set text(size: 10pt)
    for (label, names) in (("Supervisor", o.supervisors), ("Assessor", o.at("assessors", default: ()))) {
      let names = _as-array(names)
      if names.len() > 0 { block(above: 1.4em)[*#_plural(label, names)* \ #names.join(linebreak())] }
      if label == "Supervisor" { o.institute }
    }
    v(1cm)
    text(size: 9pt)[Graz, #_date(o.date)]
  },
)

#let affidavit-page(o) = page(header: none, footer: none, {
  v(1fr)
  align(center, text(weight: "bold", tracking: 0.08em)[AFFIDAVIT])
  v(1em)
  [I declare that I have authored this thesis independently, that I have not used other than the declared
    sources/resources, and that I have explicitly indicated all material which has been quoted either literally
    or by content from the sources used. The text document uploaded to TUGRAZonline is identical to the present
    #lower(o.kind).]
  v(3cm)
  line(length: 100%, stroke: 0.5pt)
  align(center, text(size: 8pt)[Date, Signature])
  v(2fr)
})

// affidavit, acknowledgements, abstract, Kurzfassung, contents
#let thesis-front-matter(o) = {
  set heading(numbering: none, outlined: false)
  if o.at("affidavit", default: true) { affidavit-page(o) }
  let ack = o.at("acknowledgements", default: none)
  if ack != none { heading[Acknowledgements] + ack }
  let kurz = o.at("kurzfassung", default: none)
  for (title, body, kw-title, kws) in (
    ([Abstract], o.abstract, [Keywords], o.keywords),
    ([Kurzfassung], if kurz != none { text(lang: "de", kurz) }, [Schlagwörter], o.at("keywords-de", default: ())),
  ) {
    if body != none { heading(title) + body + keywords-line(kw-title, kws) }
    if body != none and title == [Abstract] and o.blank-pages { _blank-page }
  }
  thesis-outline()
  if o.blank-pages { _blank-page }
}

// lists of figures/tables/listings switched on by list-of-figures, list-of-tables, list-of-listings:
// placed where #thesis-lists() is called (e.g. before the acronyms), else at the end of the document
#let _list-kinds = (
  ("list-of-figures", [List of Figures], image),
  ("list-of-tables", [List of Tables], table),
  ("list-of-listings", [List of Listings], raw),
)
#let _lists = state("ivc-thesis-lists", ())
#let _render-lists = context for (title, kind) in _lists.get() {
  heading(numbering: none, title)
  outline(title: none, target: figure.where(kind: kind))
}
#let thesis-lists() = [#metadata(none)<ivc-thesis-lists>] + _render-lists

// ---------------------------------------------------------------------------
// Headings

// chapter start (called from a show rule): new page, figure/equation numbers restart,
// `top` draws what goes above the title and gets the chapter number (none if unnumbered)
#let _chapter(it, top) = {
  pagebreak(weak: true)
  for kind in query(figure).map(f => f.kind).dedup() { counter(figure.where(kind: kind)).update(0) }
  counter(math.equation).update(0)
  block(width: 100%, below: 2em, sticky: true, {
    top(if it.numbering != none { numbering(it.numbering, ..counter(heading).get()) })
    text(size: 1.9em, weight: "bold", it.body)
  })
}

// "Chapter 3" above the title
#let chapter-heading(it) = _chapter(it, num => {
  v(2cm)
  if num != none { block(below: 0.8em, text(size: 1.2em, weight: "bold", fill: ivc-color)[#it.supplement #num]) }
})

// large chapter number at the top right, above a rule
#let phd-chapter-heading(it) = _chapter(it, num => {
  block(width: 100%, height: 7em, align(right + bottom, text(size: 7em, weight: "bold", fill: ivc-color, num)))
  line(length: 100%, stroke: 1pt)
  v(0.4em)
})

// running header: the current chapter (none where one starts), or the report title
#let _running-title(o) = {
  if not o.chapters { return o.title }
  let page = here().page()
  if query(heading.where(level: 1)).any(c => c.location().page() == page) { return none }
  let prev = query(heading.where(level: 1).before(here()))
  if prev.len() == 0 { return none }
  let c = prev.last()
  if c.numbering != none [#numbering(c.numbering, ..counter(heading).at(c.location()))#h(1em)]
  c.body
}

// ---------------------------------------------------------------------------
// Templates

// Seminar report, and the base of the theses below.
// Info: title, subtitle, author (see _authors), supervisors, institute, date, kind, abstract, keywords (strings).
// Layout: line-spacing (factor, like \linespread), blank-pages (an empty page after the title page, abstract,
// contents and every chapter).
// Hooks for derived templates: title-page(o), front-matter(o) (roman page numbers), chapters, chapter-heading(it).
#let report(..args) = {
  let o = (
    title: [Title],
    subtitle: none,
    author: "Author",
    supervisors: (),
    institute: [Institute of Visual Computing],
    date: datetime.today(),
    kind: [Seminar Report],
    abstract: none,
    keywords: (),
    title-page: report-title,
    front-matter: none,
    chapters: false,
    chapter-heading: chapter-heading,
    line-spacing: 1,
    blank-pages: false,
  ) + args.named()

  set document(title: o.title, author: _author-names(o), keywords: o.keywords)
  set page(
    paper: "a4",
    margin: (x: 3cm, top: 3.5cm, bottom: 3.5cm),
    numbering: "1",
    header: context {
      let running = if here().page() > 1 { _running-title(o) }
      if running != none {
        set text(size: 0.85em, fill: luma(90))
        block(width: 100%, stroke: (bottom: 0.5pt), inset: (bottom: 0.4em), running)
      }
    },
    footer: context align(right, box(fill: ivc-color, inset: (x: 0.5em, y: 0.35em), text(
      size: 0.85em,
      fill: white,
      counter(page).display(),
    ))),
  )
  set text(size: 11pt)
  // 1.26em is the baseline distance at line-spacing 1 (0.6em leading + the cap height of the font)
  let leading = 0.6em + (o.line-spacing - 1) * 1.26em
  set par(justify: true, leading: leading, spacing: leading, first-line-indent: 1.2em)
  set list(marker: text(fill: ivc-color)[•])
  show link: it => if type(it.dest) == str { text(fill: link-color, it) } else { it } // URLs; refs, cites, outlines stay

  set heading(numbering: "1.1")
  show heading.where(level: 5): set heading(numbering: none, outlined: false) // \paragraph
  show heading: set par(justify: false)
  show heading: it => {
    let size = (1.4em, 1.2em, 1.1em).at(calc.max(0, it.level - 1 - int(o.chapters)), default: 1em)
    let num = if it.numbering != none { text(fill: ivc-color, counter(heading).display(it.numbering)) + h(0.6em) }
    block(above: 1.6em, below: 0.9em, sticky: true, text(size: size, weight: "bold", num + it.body))
  }
  show heading.where(level: 1): set heading(supplement: if o.chapters [Chapter] else { auto })
  show heading.where(level: 1): it => if o.chapters {
    if o.blank-pages {
      let prev = query(heading.where(level: 1).before(here(), inclusive: false))
      if prev.len() > 0 and prev.last().numbering != none { _blank-page } // after a chapter
    }
    (o.chapter-heading)(it)
  } else { it }

  set figure(numbering: figure-number)
  show figure.where(placement: none): set block(spacing: 1.6em)
  set math.equation(numbering: n => [(#figure-number(n))])
  show figure.caption: it => align(center, box(align(left, if it.numbering == none { it.body } else [
    #text(weight: "bold", fill: ivc-color)[#it.supplement~#it.counter.display(it.numbering)#it.separator]#it.body
  ])))
  show raw.where(block: true): set block(fill: luma(245), inset: 0.8em, radius: 3pt, width: 100%)
  show outline: it => in-outline.update(true) + it + in-outline.update(false) // for flex-caption

  _chapters.update(o.chapters)
  _lists.update(_list-kinds.filter(((key, ..)) => o.at(key, default: false)).map(((_, title, kind)) => (title, kind)))
  (o.title-page)(o)
  if o.blank-pages { _blank-page }
  if o.front-matter != none {
    set page(numbering: "i")
    counter(page).update(1)
    (o.front-matter)(o)
  }
  counter(page).update(1)
  counter(heading).update(0)
  args.pos().first()
  context if query(<ivc-thesis-lists>).len() == 0 { _render-lists }
}

// Info on top of report: degree, programme, curriculum, acknowledgements, kurzfassung, keywords-de,
// affidavit (true), title-bar (true), list-of-figures/-tables/-listings (false, see thesis-lists).
#let bachelor-thesis(..args) = report(
  kind: [Bachelor's Thesis],
  degree: [Bachelor of Science (BSc)],
  programme: [Bachelor's degree programme],
  title-page: thesis-title-page,
  front-matter: thesis-front-matter,
  chapters: true,
  ..args,
)

#let master-thesis(..args) = bachelor-thesis(
  kind: [Master's Thesis],
  degree: [Diplom-Ingenieur (Dipl.-Ing.)],
  programme: [Master's degree programme],
  list-of-figures: true,
  list-of-tables: true,
  ..args,
)

// Info on top of master-thesis: assessors.
#let phd-thesis(..args) = master-thesis(
  kind: [Doctoral Thesis],
  degree: [Doktor der technischen Wissenschaften (Dr. techn.)],
  programme: none, // just the curriculum
  chapter-heading: phd-chapter-heading,
  ..args,
)

// #show: thesis-appendix — chapters (sections in reports) and their figures numbered A, B, ...
#let thesis-appendix(body) = {
  set heading(numbering: "A.1")
  show heading.where(level: 1): set heading(supplement: [Appendix])
  _appendix.update(true)
  counter(heading).update(0)
  body
}
