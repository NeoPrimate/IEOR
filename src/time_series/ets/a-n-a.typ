#import "/lib/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

SES + additive seasonality

$ "ETS"(A, N, A) $

$ x_t = cL(l_(t-1)) + cS(s_(t-m)) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t $
$ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) + cS(s_(t+h-m_h^+)) $







#example(title: $"ETS"(A, N, A)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (2, 0, -3, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) + cS(s_(t-m)) + epsilon_t $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) + cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = x_t - mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t $
  $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) + cS(s_(t+h-m_h^+)) $
  where $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) + cS(2) = 14 $
  $ epsilon_1 = x_1 - mu_1 = 12 - 14 = -2 $
  $ cL(l_1) = cL(12) + 0.5 dot (-2) = cL(11) $
  $ cS(s_1) = cS(2) + 0.2 dot (-2) = cS(1.6) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) + cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) + alpha epsilon_t$],
      [$cS(s_t) = cS(s_(t-m)) + gamma epsilon_t$],

      [1], [12], [$14$], [$-2$], [$cL(11)$], [$cS(1.6)$],
      [2], [10], [$11$], [$-1$], [$cL(10.5)$], [$cS(-0.2)$],
      [3], [8], [$7.5$], [$0.5$], [$cL(10.75)$], [$cS(-2.9)$],
      [4], [11], [$11.75$], [$-0.75$], [$cL(10.375)$], [$cS(0.85)$],
      [5], [14], [$11.975$], [$2.025$], [$cL(11.3875)$], [$cS(2.005)$],
      [6], [12], [$11.1875$], [$0.8125$], [$cL(11.7937)$], [$cS(-0.0375)$],
      [7], [9], [$8.8937$], [$0.1063$], [$cL(11.8469)$], [$cS(-2.8787)$],
      [8], [13], [$12.6969$], [$0.3031$], [$cL(11.9984)$], [$cS(0.9106)$],
      [9], [16], [$14.0034$], [$1.9966$], [$cL(12.9967)$], [$cS(2.4043)$],
      [10], [14], [$12.9592$], [$1.0408$], [$cL(13.5171)$], [$cS(0.1707)$],
      [11], [11], [$10.6384$], [$0.3616$], [$cL(13.6979)$], [$cS(-2.8064)$],
      [12], [15], [$14.6086$], [$0.3914$], [$cL(13.8937)$], [$cS(0.9889)$],
      [13], [18], [$16.298$], [$1.702$], [$cL(14.7447)$], [$cS(2.7447)$],
      [14], [16], [$14.9153$], [$1.0847$], [$cL(15.287)$], [$cS(0.3876)$],
      [15], [13], [$12.4806$], [$0.5194$], [$cL(15.5467)$], [$cS(-2.7025)$],
      [16], [17], [$16.5356$], [$0.4644$], [$cL(15.7789)$], [$cS(1.0818)$],
    )
  ]
]
