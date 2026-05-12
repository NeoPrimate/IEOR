#import "/lib/imports.typ": *
#show: formatting

*Cash* *inflows* and *outflows* over a period of time

#align(center)[
  #grid(
    columns: 2,
    inset: 1em,
    align: (right, center),
    stroke: (x, y) => if x == 1 and 
    (
      y == 2
    ) { (bottom: 1pt) },
    
    [], [MM-DD-YY],
    [Cash Inflow], [X],
    [Cash Outflow], [(X)],
    [*Net Cash Flow*], [*X / (X)*],
  )
]

=== Direct Method

=== Indirect Method
