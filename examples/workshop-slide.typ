#import "@preview/touying:0.7.4": *
#import themes.simple: *
#import "/lib/lib.typ": ivc-theme, slide, title-slide, title-slide-open-projects, footcite, ivc-color, focus-slide

#show: ivc-theme.with(
  aspect-ratio: "16-9",
  config-info(short-author: [Leonhard Euler], short-conference: [IVC Thesis Writing Workshop (06.10.2026)]),
  config-common(enable-nav: true, enable-footer: true),
)

= My Thesis Project
== Catchy Slide Title
- What I want to do
- How I want to do it
- All in one slide
- Don't use many word when few word do trick
- Feel free to add an equation or figure
