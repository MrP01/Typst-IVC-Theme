# ivc-theme

Presentation slides (built on [Touying](https://typst.app/universe/package/touying)) and posters
for the [Institute of Visual Computing (IVC)](https://ivc.tugraz.at), Graz University of Technology.

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

Poster:

```typ
#import "@preview/ivc-theme:0.1.0": placard, card

#show: placard.with(title: [My Poster], authors: ([Jane Doe],), paper: "a0")

#card(title: [Intro])[...]
```

Each part is also available as a submodule:

```typ
#import "@preview/ivc-theme:0.1.0": poster
#import poster: placard, card
// or in one line:
#import "@preview/ivc-theme:0.1.0": poster.placard, poster.card
```

Full examples: [`examples/presentation.typ`](examples/presentation.typ), [`examples/poster.typ`](examples/poster.typ).

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

Code: MIT. The TU Graz and IVC logos and the building photo in `lib/assets/` are
property of Graz University of Technology and are not covered by the MIT license.
