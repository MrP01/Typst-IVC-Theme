# ivc-theme

Presentation slides (built on [Touying](https://typst.app/universe/package/touying)), posters,
seminar reports and theses for the [Institute of Visual Computing (IVC)](https://ivc.tugraz.at), Graz University of Technology.
The report and thesis templates extend Ernesto Martínez García's
[definitely-not-isec-thesis](https://typst.app/universe/package/definitely-not-isec-thesis)
([source](https://github.com/ecomaikgolf/typst-isec-master-thesis-template)).

## Usage

```typ
#import "@preview/touying:0.7.4": *
#import "@preview/ivc-theme:0.1.0": *

#show: ivc-theme.with(aspect-ratio: "16-9", config-info(
  title: [My Talk],
  author: [Jane Doe],
  date: datetime.today(),
  institute_url: [ivc.tugraz.at],
))

#title-slide()

= Section
== Slide
Hello!
```

For two-line slide titles, give the header more room with `ivc-theme.with(header-title-height: 4em, header-title-size: 1.3em, ..)`.
`header-aside[..]` in a slide's body puts content right of that slide's title.

Open projects: `#title-slide-open-projects(area: .., image_person: ..)`, then `#project-type("B", "S", "M")` on each topic slide to show which of Bachelor's Thesis, Seminar Project and Master's Thesis it is offered as.

Poster:

```typ
#import "@preview/ivc-theme:0.1.0": placard, card

#show: placard.with(title: [My Poster], authors: ([Jane Doe],), paper: "a0")

#card(title: [Intro])[...]
```

Reports and theses (extending [definitely-not-isec-thesis](https://typst.app/universe/package/definitely-not-isec-thesis)):

```typ
#import "@preview/ivc-theme:0.1.0": phd-thesis, thesis-appendix

#show: phd-thesis.with(
  title: [My Thesis],
  author: (name: "Jane Doe", name-with-title: [Dipl.-Ing. Jane Doe, BSc]), // or just "Jane Doe"
  curriculum: [Computer Science],
  supervisors: ([Supervisor],),
  date: datetime.today(),
  abstract: [...],
  keywords: ("A", "B"),
)

= Introduction
...
#bibliography("sources.bib")

#show: thesis-appendix
= Additional Material
```

Each template builds on the previous one and only adds or changes what it needs:

| Template          | Adds                                                                                     |
| ----------------- | ---------------------------------------------------------------------------------------- |
| `report`          | seminar report: title block with abstract, numbered sections, IVC headings, captions and page footer |
| `bachelor-thesis` | title page, affidavit, abstract (+ `kurzfassung`, `keywords-de`), `acknowledgements`, contents, chapters on new pages, figures numbered per chapter |
| `master-thesis`   | lists of figures and tables (`list-of-figures`, `list-of-tables`, `list-of-listings`), placed where `#thesis-lists()` is called (e.g. before the acronyms), else at the end |
| `phd-thesis`      | large chapter numbers at the top right, `assessors` on the title page                    |

Common options: `title`, `subtitle`, `author` (a name string, `(name: "..", name-with-title: [..])` to show academic titles on the title page, or an array of these), `supervisors`, `institute`, `date`,
`abstract`, `keywords` (strings), `curriculum`, `title-bar` (purple bar on the title page, default `true`); `kind`, `degree` and `programme` override the title page wording (`programme: none` shows the curriculum without prefix, the default for `phd-thesis`).
Options of a later template also work on an earlier one (e.g. `acknowledgements` in a report is ignored, in a
bachelor's thesis it adds the page).

Helpers (also usable without the templates): `chapter-outline()` (contents of the current chapter),
`this-chapter-is-based-on(<key>, ..)`, `flex-caption[short][long]` (short caption in the lists of figures),
`thesis-outline()`, `small-heading[..]`, and `figure-number` for packages with their own figure numbering,
e.g. `subpar.grid.with(numbering: figure-number, numbering-sub-ref: figure-number)`.

Each part is also available as a submodule:

```typ
#import "@preview/ivc-theme:0.1.0": poster
#import poster: placard, card
// or in one line:
#import "@preview/ivc-theme:0.1.0": poster.placard, poster.card
```

Full examples: [`examples/presentation.typ`](examples/presentation.typ), [`examples/poster.typ`](examples/poster.typ),
[`examples/seminar-report.typ`](examples/seminar-report.typ), [`examples/bachelor-thesis.typ`](examples/bachelor-thesis.typ),
[`examples/master-thesis.typ`](examples/master-thesis.typ), [`examples/phd-thesis.typ`](examples/phd-thesis.typ).

### Passing your own files

Package code cannot read files from your project via plain strings. Wherever the
template accepts a file (poster `header-logo-left`, `header-logo-right`, `footer.logo`,
`title-slide-open-projects(image_person: ..)`), pass either content or a `path`:

```typ
header-logo-left: path("figures/my-logo.pdf"),   // sized by the template
header-logo-left: image("figures/my-logo.pdf", height: 3cm), // sized by you
```

### Fonts

The title slide uses **PT Sans Caption**. Fonts cannot be shipped in packages; install it
locally (or pass `--font-path`), otherwise Typst falls back to the default font.

## Local installation

```sh
make install   # extracts the tarball to $XDG_DATA_HOME/typst/packages/local/ivc-theme/<version>
make link      # symlinks this repo there instead (edits apply live)
make           # just builds dist/ivc-theme-<version>.tar.gz
```

Then import with `#import "@local/ivc-theme:0.1.0": *`.

To compile the examples from within this repo (no install needed): `make examples`.

## License

The report and thesis templates (`lib/ivc-thesis.typ`) are adapted from
[definitely-not-isec-thesis](https://typst.app/universe/package/definitely-not-isec-thesis) by Ernesto Martínez García (MIT):
title page, affidavit, abstract/Kurzfassung pages and per-chapter numbering follow its layout.

Code: MIT. The TU Graz and IVC logos and the building photo in `lib/assets/` are
property of Graz University of Technology and are not covered by the MIT license.
