#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

SES + mult. seasonality and errors

$ "ETS"(M, N, M) $

$ x_t = cL(l_(t-1)) cS(s_(t-m)) (1 + epsilon_t) $

$ cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t) $
$ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
$ hat(x)_(t+h | t) = cL(l_t) cS(s_(t+h-m_h^+)) $











#example(title: $"ETS"(M, N, M)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (1.2, 1, 0.8, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t) $
  $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cS(s_(t+h-m_h^+)) $
  where $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cS(1.2) = 14.4 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 14.4) \/ 14.4 = -0.1667 $
  $ cL(l_1) = cL(12) (1 + 0.5 dot (-0.1667)) = cL(11) $
  $ cS(s_1) = cS(1.2) (1 + 0.2 dot (-0.1667)) = cS(1.16) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t)$],
      [$cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t)$],

      [1], [12], [$14.4$], [$-0.1667$], [$cL(11)$], [$cS(1.16)$],
      [2], [10], [$11$], [$-0.0909$], [$cL(10.5)$], [$cS(0.9818)$],
      [3], [8], [$8.4$], [$-0.0476$], [$cL(10.25)$], [$cS(0.7924)$],
      [4], [11], [$10.25$], [$0.0732$], [$cL(10.625)$], [$cS(1.0146)$],
      [5], [14], [$12.325$], [$0.1359$], [$cL(11.347)$], [$cS(1.1915)$],
      [6], [12], [$11.1407$], [$0.0771$], [$cL(11.7846)$], [$cS(0.997)$],
      [7], [9], [$9.3379$], [$-0.0362$], [$cL(11.5714)$], [$cS(0.7866)$],
      [8], [13], [$11.7407$], [$0.1073$], [$cL(12.1919)$], [$cS(1.0364)$],
      [9], [16], [$14.5271$], [$0.1014$], [$cL(12.81)$], [$cS(1.2157)$],
      [10], [14], [$12.7711$], [$0.0962$], [$cL(13.4263)$], [$cS(1.0162)$],
      [11], [11], [$10.5618$], [$0.0415$], [$cL(13.7049)$], [$cS(0.7932)$],
      [12], [15], [$14.2037$], [$0.0561$], [$cL(14.089)$], [$cS(1.048)$],
      [13], [18], [$17.1279$], [$0.0509$], [$cL(14.4477)$], [$cS(1.2281)$],
      [14], [16], [$14.681$], [$0.0898$], [$cL(15.0967)$], [$cS(1.0344)$],
      [15], [13], [$11.9743$], [$0.0857$], [$cL(15.7433)$], [$cS(0.8068)$],
      [16], [17], [$16.4993$], [$0.0303$], [$cL(15.9822)$], [$cS(1.0544)$],
    )
  ]
]
