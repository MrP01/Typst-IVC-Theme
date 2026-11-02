#import "/lib/lib.typ": report

#show: report.with(
  title: [Interpretable EEG Classification],
  subtitle: [A Short Survey],
  author: "Leonhard Euler",
  supervisors: [Carl Friedrich Gauss],
  date: datetime(day: 27, month: 9, year: 2026),
  abstract: [#lorem(60)],
  keywords: ("EEG", "Interpretability", "Visual Analytics"),
)

#include "thesis-content.typ"
