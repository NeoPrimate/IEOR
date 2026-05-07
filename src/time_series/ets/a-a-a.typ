#import "/lib/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Additive Holt-Winters

$ "ETS"(A, A, A) $

$ x_t = cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m)) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha epsilon_t $
$ cT(b_t) = cT(b_(t-1)) + beta epsilon_t $
$ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) + cS(s_(t+h-m_h^+)) $







#example(title: $"ETS"(A, A, A)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 0.5$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (2, 0, -3, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m)) + epsilon_t $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = x_t - mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha epsilon_t $
  $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t $
  $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) + cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) + cT(0.5) + cS(2) = 14.5 $
  $ epsilon_1 = x_1 - mu_1 = 12 - 14.5 = -2.5 $
  $ cL(l_1) = cL(12) + cT(0.5) + 0.5 dot (-2.5) = cL(11.25) $
  $ cT(b_1) = cT(0.5) + 0.4 dot (-2.5) = cT(-0.5) $
  $ cS(s_1) = cS(2) + 0.2 dot (-2.5) = cS(1.5) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha epsilon_t$],
      [$cT(b_t) = cT(b_(t-1)) + beta epsilon_t$],
      [$cS(s_t) = cS(s_(t-m)) + gamma epsilon_t$],

      [1], [12], [$14.5$], [$-2.5$], [$cL(11.25)$], [$cT(-0.5)$], [$cS(1.5)$],
      [2], [10], [$10.75$], [$-0.75$], [$cL(10.375)$], [$cT(-0.8)$], [$cS(-0.15)$],
      [3], [8], [$6.575$], [$1.425$], [$cL(10.2875)$], [$cT(-0.23)$], [$cS(-2.715)$],
      [4], [11], [$11.0575$], [$-0.0575$], [$cL(10.0287)$], [$cT(-0.253)$], [$cS(0.9885)$],
      [5], [14], [$11.2757$], [$2.7243$], [$cL(11.1379)$], [$cT(0.8367)$], [$cS(2.0449)$],
      [6], [12], [$11.8246$], [$0.1754$], [$cL(12.0623)$], [$cT(0.9069)$], [$cS(-0.1149)$],
      [7], [9], [$10.2542$], [$-1.2542$], [$cL(12.3421)$], [$cT(0.4052)$], [$cS(-2.9658)$],
      [8], [13], [$13.7358$], [$-0.7358$], [$cL(12.3794)$], [$cT(0.1109)$], [$cS(0.8413)$],
      [9], [16], [$14.5351$], [$1.4649$], [$cL(13.2227)$], [$cT(0.6968)$], [$cS(2.3378)$],
      [10], [14], [$13.8046$], [$0.1954$], [$cL(14.0172)$], [$cT(0.775)$], [$cS(-0.0758)$],
      [11], [11], [$11.8264$], [$-0.8264$], [$cL(14.379)$], [$cT(0.4444)$], [$cS(-3.1311)$],
      [12], [15], [$15.6648$], [$-0.6648$], [$cL(14.4911)$], [$cT(0.1785)$], [$cS(0.7084)$],
      [13], [18], [$17.0074$], [$0.9926$], [$cL(15.1659)$], [$cT(0.5756)$], [$cS(2.5363)$],
      [14], [16], [$15.6656$], [$0.3344$], [$cL(15.9086)$], [$cT(0.7093)$], [$cS(-0.009)$],
      [15], [13], [$13.4868$], [$-0.4868$], [$cL(16.3745)$], [$cT(0.5146)$], [$cS(-3.2285)$],
      [16], [17], [$17.5975$], [$-0.5975$], [$cL(16.5904)$], [$cT(0.2756)$], [$cS(0.5889)$],
    )
  ]
]
