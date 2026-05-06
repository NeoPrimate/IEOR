#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Simple exponential smoothing

$ "ETS"(A, N, N) $

$ x_t = cL(l_(t-1)) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) $


#example(title: $"ETS"(A, N, N)$)[
  *Given*
  - Smoothing parameter: $alpha = 0.5$
  - Initial level: #cL[$l_0 = 12$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) + epsilon_t $
  Innovation (rearrange):
  $ epsilon_t = x_t - cL(l_(t-1)) $
  State update:
  $ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t $
  One-step-ahead forecast:
  $ hat(x)_(t | t-1) = cL(l_(t-1)) $

  *Step 2 — apply at $t = 1$*

  Use #cL[$l_0 = 12$] and $x_1 = 12$:
  $ hat(x)_(1 | 0) = cL(l_0) = cL(12) $
  $ epsilon_1 = x_1 - cL(l_0) = 12 - cL(12) = 0 $
  $ cL(l_1) = cL(l_0) + alpha epsilon_1 = cL(12) + 0.5 dot 0 = cL(12) $

  *Step 3 — iterate*

  Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 5,
      inset: 0.55em,
      align: center,
      [$t$],
      [$x_t$],
      [$hat(x)_(t | t-1) = cL(l_(t-1))$],
      [$epsilon_t = x_t - cL(l_(t-1))$],
      [$cL(l_t) = cL(l_(t-1)) + 0.5 epsilon_t$],

      [1], [12], [$cL(12)$], [$0$], [$cL(12)$],
      [2], [10], [$cL(12)$], [$-2$], [$cL(11)$],
      [3], [8], [$cL(11)$], [$-3$], [$cL(9.5)$],
      [4], [11], [$cL(9.5)$], [$1.5$], [$cL(10.25)$],
      [5], [14], [$cL(10.25)$], [$3.75$], [$cL(12.125)$],
      [6], [12], [$cL(12.125)$], [$-0.125$], [$cL(12.0625)$],
      [7], [9], [$cL(12.0625)$], [$-3.0625$], [$cL(10.5313)$],
      [8], [13], [$cL(10.5313)$], [$2.4688$], [$cL(11.7656)$],
      [9], [16], [$cL(11.7656)$], [$4.2344$], [$cL(13.8828)$],
      [10], [14], [$cL(13.8828)$], [$0.1172$], [$cL(13.9414)$],
      [11], [11], [$cL(13.9414)$], [$-2.9414$], [$cL(12.4707)$],
      [12], [15], [$cL(12.4707)$], [$2.5293$], [$cL(13.7354)$],
      [13], [18], [$cL(13.7354)$], [$4.2646$], [$cL(15.8677)$],
      [14], [16], [$cL(15.8677)$], [$0.1323$], [$cL(15.9338)$],
      [15], [13], [$cL(15.9338)$], [$-2.9338$], [$cL(14.4669)$],
      [16], [17], [$cL(14.4669)$], [$2.5331$], [$cL(15.7335)$],
    )
  ]

  Forecast for any future $t > 16$: $hat(x)_(t | 16) = cL(l_16) = cL(15.7335)$ (flat — SES has no trend).
]
