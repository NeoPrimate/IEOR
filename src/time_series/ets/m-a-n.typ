#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Holt's linear, multiplicative errors

$ "ETS"(M, A, N) $

$ x_t = (cL(l_(t-1)) + cT(b_(t-1))) (1 + epsilon_t) $

$ cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t) $
$ cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) $








#example(title: $"ETS"(M, A, N)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 0.5$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) + cT(b_(t-1)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) + cT(b_(t-1)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t) $
  $ cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) + cT(0.5) = 12.5 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 12.5) \/ 12.5 = -0.04 $
  $ cL(l_1) = (cL(12) + cT(0.5)) (1 + 0.5 dot (-0.04)) = cL(12.25) $
  $ cT(b_1) = cT(0.5) + 0.4 (12 + 0.5) dot (-0.04) = cT(0.3) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) + cT(b_(t-1))$],
      [$epsilon_t$],
      [$cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t)$],
      [$cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t$],

      [1], [12], [$12.5$], [$-0.04$], [$cL(12.25)$], [$cT(0.3)$],
      [2], [10], [$12.55$], [$-0.2032$], [$cL(11.275)$], [$cT(-0.72)$],
      [3], [8], [$10.555$], [$-0.2421$], [$cL(9.2775)$], [$cT(-1.742)$],
      [4], [11], [$7.5355$], [$0.4598$], [$cL(9.2677)$], [$cT(-0.3562)$],
      [5], [14], [$8.9116$], [$0.571$], [$cL(11.4558)$], [$cT(1.6792)$],
      [6], [12], [$13.135$], [$-0.0864$], [$cL(12.5675)$], [$cT(1.2252)$],
      [7], [9], [$13.7927$], [$-0.3475$], [$cL(11.3963)$], [$cT(-0.6919)$],
      [8], [13], [$10.7045$], [$0.2144$], [$cL(11.8522)$], [$cT(0.2263)$],
      [9], [16], [$12.0786$], [$0.3247$], [$cL(14.0393)$], [$cT(1.7949)$],
      [10], [14], [$15.8342$], [$-0.1158$], [$cL(14.9171)$], [$cT(1.0612)$],
      [11], [11], [$15.9783$], [$-0.3116$], [$cL(13.4892)$], [$cT(-0.9301)$],
      [12], [15], [$12.5591$], [$0.1944$], [$cL(13.7795)$], [$cT(0.0463)$],
      [13], [18], [$13.8258$], [$0.3019$], [$cL(15.9129)$], [$cT(1.716)$],
      [14], [16], [$17.6289$], [$-0.0924$], [$cL(16.8144)$], [$cT(1.0644)$],
      [15], [13], [$17.8788$], [$-0.2729$], [$cL(15.4394)$], [$cT(-0.8871)$],
      [16], [17], [$14.5523$], [$0.1682$], [$cL(15.7761)$], [$cT(0.092)$],
    )
  ]
]
