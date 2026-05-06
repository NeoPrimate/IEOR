#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Multiplicative trend

$ "ETS"(A, M, N) $

$ x_t = cL(l_(t-1)) cT(b_(t-1)) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha epsilon_t $
$ cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ cL(l_(t-1)) $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) $






#example(title: $"ETS"(A, M, N)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) cT(b_(t-1)) + epsilon_t $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)) $
  Innovation:
  $ epsilon_t = x_t - mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha epsilon_t $
  $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ cL(l_(t-1)) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1) = 12 $
  $ epsilon_1 = x_1 - mu_1 = 12 - 12 = 0 $
  $ cL(l_1) = cL(12) dot cT(1) + 0.5 dot 0 = cL(12) $
  $ cT(b_1) = cT(1) + 0.4 dot 0 \/ 12 = cT(1) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) cT(b_(t-1))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha epsilon_t$],
      [$cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ cL(l_(t-1))$],

      [1], [12], [$12$], [$0$], [$cL(12)$], [$cT(1)$],
      [2], [10], [$12$], [$-2$], [$cL(11)$], [$cT(0.9333)$],
      [3], [8], [$10.2667$], [$-2.2667$], [$cL(9.1333)$], [$cT(0.8509)$],
      [4], [11], [$7.7716$], [$3.2284$], [$cL(9.3858)$], [$cT(0.9923)$],
      [5], [14], [$9.3135$], [$4.6865$], [$cL(11.6568)$], [$cT(1.192)$],
      [6], [12], [$13.8951$], [$-1.8951$], [$cL(12.9476)$], [$cT(1.127)$],
      [7], [9], [$14.5918$], [$-5.5918$], [$cL(11.7959)$], [$cT(0.9542)$],
      [8], [13], [$11.2561$], [$1.7439$], [$cL(12.1281)$], [$cT(1.0134)$],
      [9], [16], [$12.2903$], [$3.7097$], [$cL(14.1451)$], [$cT(1.1357)$],
      [10], [14], [$16.065$], [$-2.065$], [$cL(15.0325)$], [$cT(1.0773)$],
      [11], [11], [$16.195$], [$-5.195$], [$cL(13.5975)$], [$cT(0.9391)$],
      [12], [15], [$12.7694$], [$2.2306$], [$cL(13.8847)$], [$cT(1.0047)$],
      [13], [18], [$13.9502$], [$4.0498$], [$cL(15.9751)$], [$cT(1.1214)$],
      [14], [16], [$17.9143$], [$-1.9143$], [$cL(16.9571)$], [$cT(1.0735)$],
      [15], [13], [$18.2027$], [$-5.2027$], [$cL(15.6014)$], [$cT(0.9507)$],
      [16], [17], [$14.8327$], [$2.1673$], [$cL(15.9163)$], [$cT(1.0063)$],
    )
  ]
]
