#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped mult. trend, mult. errors

$ "ETS"(M, "Md", N) $

$ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + epsilon_t) $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + alpha epsilon_t) $
$ cT(b_t) = cT(b_(t-1)^phi) (1 + beta epsilon_t) $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) $







#example(title: $"ETS"(M, "Md", N)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) cT(b_(t-1)^phi))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + alpha epsilon_t) $
  $ cT(b_t) = cT(b_(t-1)^phi) (1 + beta epsilon_t) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1^0.8) = 12 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 12) \/ 12 = 0 $
  $ cL(l_1) = cL(12) dot cT(1^0.8) (1 + 0.5 dot 0) = cL(12) $
  $ cT(b_1) = cT(1^0.8) (1 + 0.4 dot 0) = cT(1) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) cT(b_(t-1)^phi)$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + alpha epsilon_t)$],
      [$cT(b_t) = cT(b_(t-1)^phi) (1 + beta epsilon_t)$],

      [1], [12], [$12$], [$0$], [$cL(12)$], [$cT(1)$],
      [2], [10], [$12$], [$-0.1667$], [$cL(11)$], [$cT(0.9333)$],
      [3], [8], [$10.4093$], [$-0.2315$], [$cL(9.2047)$], [$cT(0.8587)$],
      [4], [11], [$8.1485$], [$0.3499$], [$cL(9.5742)$], [$cT(1.0092)$],
      [5], [14], [$9.6444$], [$0.4516$], [$cL(11.8222)$], [$cT(1.1893)$],
      [6], [12], [$13.581$], [$-0.1164$], [$cL(12.7905)$], [$cT(1.0953)$],
      [7], [9], [$13.7565$], [$-0.3458$], [$cL(11.3782)$], [$cT(0.9268)$],
      [8], [13], [$10.7066$], [$0.2142$], [$cL(11.8533)$], [$cT(1.0216)$],
      [9], [16], [$12.0577$], [$0.327$], [$cL(14.0288)$], [$cT(1.1503)$],
      [10], [14], [$15.6915$], [$-0.1078$], [$cL(14.8457)$], [$cT(1.0703)$],
      [11], [11], [$15.6748$], [$-0.2982$], [$cL(13.3374)$], [$cT(0.9299)$],
      [12], [15], [$12.5839$], [$0.192$], [$cL(13.792)$], [$cT(1.016)$],
      [13], [18], [$13.9678$], [$0.2887$], [$cL(15.9839)$], [$cT(1.1297)$],
      [14], [16], [$17.6219$], [$-0.092$], [$cL(16.8109)$], [$cT(1.0619)$],
      [15], [13], [$17.6382$], [$-0.263$], [$cL(15.3191)$], [$cT(0.9388)$],
      [16], [17], [$14.565$], [$0.1672$], [$cL(15.7825)$], [$cT(1.0144)$],
    )
  ]
]
