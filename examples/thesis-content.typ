// Demo body shared by the report and thesis examples: level-1 headings are sections in the report,
// chapters in the theses.
#import "/lib/lib.typ": flex-caption, thesis-appendix, thesis-lists
#import "macros.typ": placeholder

= Introduction <sec:intro>
#lorem(70)

#lorem(50) Interpretable models such as xEEGNet @2025-Zanola-xEEGNet are small enough to be inspected in full,
which matters for clinical use @2023-miltiadous-dataset.

- a first point,
- a second one, and
- a third.

== Contributions
#lorem(40) @fig:overview gives an overview, @tab:results the results, and @sec:methods the details.

#figure(
  placeholder[Overview],
  caption: flex-caption[Overview of the approach.][Overview of the approach. Only the figure shows this long
    caption, the list of figures shows the short one. #lorem(15)],
) <fig:overview>

= Methods <sec:methods>
#lorem(60)
$ bold(y) = arg max_k (M bold(x))_k $ <eq:model>
As @eq:model shows, #lorem(30)

== Data
#lorem(80)

#figure(
  table(
    columns: 3,
    stroke: none,
    table.hline(),
    table.header[*Model*][*Parameters*][*Accuracy*],
    table.hline(stroke: 0.5pt),
    [xEEGNet], [168], [0.62],
    [EEGNet], [3 k], [0.66],
    table.hline(),
  ),
  caption: [Results on the test set.],
) <tab:results>

=== Preprocessing
#lorem(50)

```python
def bandpower(x, axis=-1):
    return 10 * np.log10(np.mean(x**2, axis=axis))
```

= Conclusion
#lorem(80)

#thesis-lists() // lists of figures/tables (master and PhD), before acronyms and bibliography
#bibliography("sources.bib")

#show: thesis-appendix
= Additional Material
#lorem(40)
#figure(placeholder[Appendix figure], caption: [A figure in the appendix.])
