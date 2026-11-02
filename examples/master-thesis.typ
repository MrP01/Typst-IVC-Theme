#import "/lib/lib.typ": master-thesis

#show: master-thesis.with(
  title: [Interpretable EEG Classification in the Browser],
  subtitle: [Explaining a Small Neural Network to Clinicians],
  author: (name: "Leonhard Euler", name-with-title: [Leonhard Euler, BSc]),
  curriculum: [Computer Science],
  supervisors: ([Carl Friedrich Gauss], [Emmy Noether]),
  date: datetime(day: 27, month: 9, year: 2026),
  acknowledgements: [#lorem(60)],
  abstract: [#lorem(150)],
  keywords: ("EEG", "Interpretability", "Visual Analytics"),
  kurzfassung: [Deutsche Kurzfassung der Arbeit. #lorem(80)],
  keywords-de: ("EEG", "Interpretierbarkeit", "Visual Analytics"),
)

#include "thesis-content.typ"
