#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped linear, mult. errors

$ "ETS"(M, "Ad", N) $

$ x_t = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + epsilon_t) $

$ cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t) $
$ cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) $







#example(title: $"ETS"(M, "Ad", N)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 0.5$]
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) + cT(phi b_(t-1)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) + cT(phi b_(t-1)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t) $
  $ cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) + cT(0.8 dot 0.5) = 12.4 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 12.4) \/ 12.4 = -0.0323 $
  $ cL(l_1) = (cL(12) + cT(0.8 dot 0.5)) (1 + 0.5 dot (-0.0323)) = cL(12.2) $
  $ cT(b_1) = cT(0.8 dot 0.5) + 0.4 (12 + 0.8 dot 0.5) dot (-0.0323) = cT(0.24) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) + cT(phi b_(t-1))$],
      [$epsilon_t$],
      [$cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t)$],
      [$cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t$],

      [1], [12], [$12.4$], [$-0.0323$], [$cL(12.2)$], [$cT(0.24)$],
      [2], [10], [$12.392$], [$-0.193$], [$cL(11.196)$], [$cT(-0.7648)$],
      [3], [8], [$10.5842$], [$-0.2442$], [$cL(9.2921)$], [$cT(-1.6455)$],
      [4], [11], [$7.9757$], [$0.3792$], [$cL(9.4878)$], [$cT(-0.1067)$],
      [5], [14], [$9.4025$], [$0.489$], [$cL(11.7012)$], [$cT(1.7537)$],
      [6], [12], [$13.1042$], [$-0.0843$], [$cL(12.5521)$], [$cT(0.9613)$],
      [7], [9], [$13.3211$], [$-0.3244$], [$cL(11.1605)$], [$cT(-0.9594)$],
      [8], [13], [$10.393$], [$0.2508$], [$cL(11.6965)$], [$cT(0.2753)$],
      [9], [16], [$11.9167$], [$0.3427$], [$cL(13.9584)$], [$cT(1.8535)$],
      [10], [14], [$15.4412$], [$-0.0933$], [$cL(14.7206)$], [$cT(0.9063)$],
      [11], [11], [$15.4457$], [$-0.2878$], [$cL(13.2228)$], [$cT(-1.0532)$],
      [12], [15], [$12.3803$], [$0.2116$], [$cL(13.6901)$], [$cT(0.2053)$],
      [13], [18], [$13.8544$], [$0.2992$], [$cL(15.9272)$], [$cT(1.8225)$],
      [14], [16], [$17.3852$], [$-0.0797$], [$cL(16.6926)$], [$cT(0.9039)$],
      [15], [13], [$17.4157$], [$-0.2535$], [$cL(15.2079)$], [$cT(-1.0432)$],
      [16], [17], [$14.3733$], [$0.1827$], [$cL(15.6867)$], [$cT(0.2161)$],
    )
  ]
]
