#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped multiplicative trend

$ "ETS"(A, "Md", N) $

$ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t $
$ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1)) $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) $







#example(title: $"ETS"(A, "Md", N)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) + epsilon_t $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) $
  Innovation:
  $ epsilon_t = x_t - mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t $
  $ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1)) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1^0.8) = 12 $
  $ epsilon_1 = x_1 - mu_1 = 12 - 12 = 0 $
  $ cL(l_1) = cL(12) dot cT(1^0.8) + 0.5 dot 0 = cL(12) $
  $ cT(b_1) = cT(1^0.8) + 0.4 dot 0 \/ 12 = cT(1) $

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
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t$],
      [$cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1))$],

      [1], [12], [$12$], [$0$], [$cL(12)$], [$cT(1)$],
      [2], [10], [$12$], [$-2$], [$cL(11)$], [$cT(0.9333)$],
      [3], [8], [$10.4093$], [$-2.4093$], [$cL(9.2047)$], [$cT(0.8587)$],
      [4], [11], [$8.1485$], [$2.8515$], [$cL(9.5742)$], [$cT(1.0092)$],
      [5], [14], [$9.6444$], [$4.3556$], [$cL(11.8222)$], [$cT(1.1893)$],
      [6], [12], [$13.581$], [$-1.581$], [$cL(12.7905)$], [$cT(1.0953)$],
      [7], [9], [$13.7565$], [$-4.7565$], [$cL(11.3782)$], [$cT(0.9268)$],
      [8], [13], [$10.7066$], [$2.2934$], [$cL(11.8533)$], [$cT(1.0216)$],
      [9], [16], [$12.0577$], [$3.9423$], [$cL(14.0288)$], [$cT(1.1503)$],
      [10], [14], [$15.6915$], [$-1.6915$], [$cL(14.8457)$], [$cT(1.0703)$],
      [11], [11], [$15.6748$], [$-4.6748$], [$cL(13.3374)$], [$cT(0.9299)$],
      [12], [15], [$12.5839$], [$2.4161$], [$cL(13.792)$], [$cT(1.016)$],
      [13], [18], [$13.9678$], [$4.0322$], [$cL(15.9839)$], [$cT(1.1297)$],
      [14], [16], [$17.6219$], [$-1.6219$], [$cL(16.8109)$], [$cT(1.0619)$],
      [15], [13], [$17.6382$], [$-4.6382$], [$cL(15.3191)$], [$cT(0.9388)$],
      [16], [17], [$14.565$], [$2.435$], [$cL(15.7825)$], [$cT(1.0144)$],
    )
  ]
]
