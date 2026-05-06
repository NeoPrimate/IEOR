#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

SES, multiplicative errors

$ "ETS"(M, N, N) $

$ x_t = cL(l_(t-1)) (1 + epsilon_t) $

$ cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t) $
$ hat(x)_(t+h | t) = cL(l_t) $







#example(title: $"ETS"(M, N, N)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$
  - Initial states: #cL[$l_0 = 12$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) $

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) = 12 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 12) \/ 12 = 0 $
  $ cL(l_1) = cL(12) (1 + 0.5 dot 0) = cL(12) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 5,
      inset: 0.4em,
      align: center,
      [$t$], [$x_t$], [$mu_t = cL(l_(t-1))$], [$epsilon_t$], [$cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t)$],
      [1], [12], [$12$], [$0$], [$cL(12)$],
      [2], [10], [$12$], [$-0.1667$], [$cL(11)$],
      [3], [8], [$11$], [$-0.2727$], [$cL(9.5)$],
      [4], [11], [$9.5$], [$0.1579$], [$cL(10.25)$],
      [5], [14], [$10.25$], [$0.3659$], [$cL(12.125)$],
      [6], [12], [$12.125$], [$-0.0103$], [$cL(12.0625)$],
      [7], [9], [$12.0625$], [$-0.2539$], [$cL(10.5312)$],
      [8], [13], [$10.5312$], [$0.2344$], [$cL(11.7656)$],
      [9], [16], [$11.7656$], [$0.3599$], [$cL(13.8828)$],
      [10], [14], [$13.8828$], [$0.0084$], [$cL(13.9414)$],
      [11], [11], [$13.9414$], [$-0.211$], [$cL(12.4707)$],
      [12], [15], [$12.4707$], [$0.2028$], [$cL(13.7354)$],
      [13], [18], [$13.7354$], [$0.3105$], [$cL(15.8677)$],
      [14], [16], [$15.8677$], [$0.0083$], [$cL(15.9338)$],
      [15], [13], [$15.9338$], [$-0.1841$], [$cL(14.4669)$],
      [16], [17], [$14.4669$], [$0.1751$], [$cL(15.7335)$],
    )
  ]
]
