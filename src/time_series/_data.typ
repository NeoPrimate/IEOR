#import "/lib/imports.typ": *

// Shared dataset for ARIMA and ETS worked examples.
//
// Values are integers by construction so all arithmetic is verifiable by hand.
// The series x has level + linear trend + m=4 seasonality (no random noise).
//   - Cycle averages: 10.25, 12, 14, 16  → upward drift of ~2 per cycle
//   - Within-cycle pattern: high at position 1, low at position 3
//
// y is a second integer series (for K=2 vector models in VAR/VMA/VARMA/VARIMA/VARIMAX).
// z is a pure-trend integer series used as the exogenous regressor in SARIMAX/VARIMAX.

#let x = (12, 10, 8, 11, 14, 12, 9, 13, 16, 14, 11, 15, 18, 16, 13, 17)
#let y = (8, 9, 7, 6, 10, 11, 9, 8, 12, 13, 11, 10, 14, 15, 13, 12)
#let z = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)

// Render a series as a single horizontal table.
// `name` is what to show as the row label (defaults to "x").
#let show-table(series, name: "x") = {
  let n = series.len()
  let header = ([$t$], ..range(1, n + 1).map(i => [#i]))
  let row = ([$#name _t$], ..series.map(v => [#v]))
  align(center)[
    #table(
      columns: n + 1,
      inset: 0.4em,
      align: center,
      ..header,
      ..row,
    )
  ]
}
