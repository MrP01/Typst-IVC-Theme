#import "/lib/lib.typ": bachelor-thesis

#show: bachelor-thesis.with(
  title: [Interpretable EEG Classification in the Browser],
  author: "Leonhard Euler",
  curriculum: [Computer Science],
  supervisors: [Carl Friedrich Gauss],
  date: datetime(day: 27, month: 9, year: 2026),
  abstract: [#lorem(120)],
  keywords: ("EEG", "Interpretability", "Visual Analytics"),
)

#include "thesis-content.typ"
