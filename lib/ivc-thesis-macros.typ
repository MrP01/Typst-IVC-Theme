// Helpers for reports and theses, usable with or without the templates in ivc-thesis.typ.
#import "definitions.typ": ivc-color

// small all-caps label, e.g. for the chapter front matter below
#let small-heading(body) = block(above: 2em, below: 1em, text(
  size: 0.8em,
  weight: "bold",
  tracking: 0.06em,
  fill: ivc-color,
  upper(body),
))

// "Keywords: a · b · c"
#let keywords-line(title, keywords) = if keywords.len() > 0 {
  block(above: 1.5em)[*#title:* #h(0.5em) #keywords.join(" · ")]
}

// full references of the publications a chapter is based on (none = unpublished),
// e.g. #this-chapter-is-based-on(<key1>, <key2>)
#let this-chapter-is-based-on(..sources) = {
  small-heading[Based on]
  if sources.pos().len() == 0 [Unpublished work.] else {
    list(spacing: 1em, ..sources.pos().map(k => cite(k, form: "full")))
  }
}

// table of contents of the current chapter's sections, up to the next chapter heading
#let chapter-outline() = context {
  small-heading[Contents]
  let target = heading.where(level: 2).after(here())
  let next = query(heading.where(level: 1).after(here()))
  if next.len() > 0 { target = target.before(next.first().location()) }
  {
    set text(size: 0.9em)
    show outline.entry: set block(above: 0.8em)
    outline(title: none, target: target)
  }
  v(2em)
}

// main table of contents: chapters large and bold with space above, sections bold
#let thesis-outline(..args) = {
  show outline.entry.where(level: 1): set block(above: 1.6em)
  show outline.entry.where(level: 1): set text(size: 1.15em, weight: "bold")
  show outline.entry.where(level: 2): set text(weight: "bold")
  outline(..args)
}

// like \caption[short]{long}: the figure shows long, lists of figures/tables short
// (the templates set in-outline; without them: #show outline: it => in-outline.update(true) + it + in-outline.update(false))
#let in-outline = state("in-outline", false)
#let flex-caption(short, long) = context if in-outline.get() { short } else { long }
