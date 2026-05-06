#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Multiplicative Holt-Winters

$ "ETS"(M, A, M) $

$ x_t = (cL(l_(t-1)) + cT(b_(t-1))) cS(s_(t-m)) (1 + epsilon_t) $

$ cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t) $
$ cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t $
$ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
$ hat(x)_(t+h | t) = (cL(l_t) + h cT(b_t)) cS(s_(t+h-m_h^+)) $










#example(title: $"ETS"(M, A, M)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 0.5$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (1.2, 1, 0.8, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = ((cL(l_(t-1)) + cT(b_(t-1))) cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = (cL(l_(t-1)) + cT(b_(t-1))) cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t) $
  $ cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t $
  $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = (cL(l_t) + h cT(b_t)) cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = (cL(12) + cT(0.5)) dot cS(1.2) = 15 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 15) \/ 15 = -0.2 $
  $ cL(l_1) = (cL(12) + cT(0.5)) (1 + 0.5 dot (-0.2)) = cL(11.25) $
  $ cT(b_1) = cT(0.5) + 0.4 (12 + 0.5) dot (-0.2) = cT(-0.5) $
  $ cS(s_1) = cS(1.2) (1 + 0.2 dot (-0.2)) = cS(1.152) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = (cL(l_(t-1)) + cT(b_(t-1))) cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t)$],
      [$cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t$],
      [$cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t)$],

      [1], [12], [$15$], [$-0.2$], [$cL(11.25)$], [$cT(-0.5)$], [$cS(1.152)$],
      [2], [10], [$10.75$], [$-0.0698$], [$cL(10.375)$], [$cT(-0.8)$], [$cS(0.986)$],
      [3], [8], [$7.66$], [$0.0444$], [$cL(9.7875)$], [$cT(-0.63)$], [$cS(0.8071)$],
      [4], [11], [$9.1575$], [$0.2012$], [$cL(10.0787)$], [$cT(0.107)$], [$cS(1.0402)$],
      [5], [14], [$11.734$], [$0.1931$], [$cL(11.1693)$], [$cT(0.8938)$], [$cS(1.1965)$],
      [6], [12], [$11.8948$], [$0.0088$], [$cL(12.1164)$], [$cT(0.9365)$], [$cS(0.9878)$],
      [7], [9], [$10.5351$], [$-0.1457$], [$cL(12.102)$], [$cT(0.1757)$], [$cS(0.7836)$],
      [8], [13], [$12.7718$], [$0.0179$], [$cL(12.3874)$], [$cT(0.2635)$], [$cS(1.044)$],
      [9], [16], [$15.1367$], [$0.057$], [$cL(13.0117)$], [$cT(0.5521)$], [$cS(1.2101)$],
      [10], [14], [$13.3982$], [$0.0449$], [$cL(13.8684)$], [$cT(0.7958)$], [$cS(0.9967)$],
      [11], [11], [$11.4906$], [$-0.0427$], [$cL(14.3512)$], [$cT(0.5454)$], [$cS(0.7769)$],
      [12], [15], [$15.5513$], [$-0.0355$], [$cL(14.6325)$], [$cT(0.3341)$], [$cS(1.0366)$],
      [13], [18], [$18.1117$], [$-0.0062$], [$cL(14.9204)$], [$cT(0.2972)$], [$cS(1.2086)$],
      [14], [16], [$15.1669$], [$0.0549$], [$cL(15.6356)$], [$cT(0.6316)$], [$cS(1.0076)$],
      [15], [13], [$12.6378$], [$0.0287$], [$cL(16.5003)$], [$cT(0.8181)$], [$cS(0.7813)$],
      [16], [17], [$17.9514$], [$-0.053$], [$cL(16.8594)$], [$cT(0.4509)$], [$cS(1.0256)$],
    )
  ]
]
