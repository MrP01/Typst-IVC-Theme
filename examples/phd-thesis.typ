#import "/lib/lib.typ": phd-thesis, this-chapter-is-based-on, chapter-outline

#show: phd-thesis.with(
  title: [Interpretable Visual Analytics for Clinical EEG],
  author: (name: "Leonhard Euler", name-with-title: [Dipl.-Ing. Leonhard Euler, BSc]),
  curriculum: [Computer Science],
  supervisors: [Carl Friedrich Gauss],
  assessors: ([Emmy Noether], [David Hilbert]),
  date: datetime(day: 27, month: 9, year: 2026),
  acknowledgements: [#lorem(60)],
  abstract: [#lorem(150)],
  keywords: ("EEG", "Interpretability", "Visual Analytics"),
  kurzfassung: [Deutsche Kurzfassung der Arbeit. #lorem(80)],
  keywords-de: ("EEG", "Interpretierbarkeit", "Visual Analytics"),
)

// a chapter based on a publication
= A Published Paper <chap:paper>
#this-chapter-is-based-on(<2025-Zanola-xEEGNet>, <2023-miltiadous-dataset>)
#chapter-outline()

== Abstract
#lorem(80)

== Introduction
#lorem(120)

== Conclusion
#lorem(60)

#include "thesis-content.typ"
