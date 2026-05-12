#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped additive HW, mult. errors

$ "ETS"(M, "Ad", A) $

$ x_t = (cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m))) (1 + epsilon_t) $


$ cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha mu_t epsilon_t $
$ cT(b_t) = cT(phi b_(t-1)) + beta mu_t epsilon_t $
$ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) + cS(s_(t+h-m_h^+)) $
where $ mu_t = cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m)) $






#example(title: $"ETS"(M, "Ad", A)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 0.5$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (2, 0, -3, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha mu_t epsilon_t $
  $ cT(b_t) = cT(phi b_(t-1)) + beta mu_t epsilon_t $
  $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) + cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) + cT(0.8 dot 0.5) + cS(2) = 14.4 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 14.4) \/ 14.4 = -0.1667 $
  $ cL(l_1) = cL(12) + cT(0.8 dot 0.5) + 0.5 dot 14.4 dot (-0.1667) = cL(11.2) $
  $ cT(b_1) = cT(0.8 dot 0.5) + 0.4 dot 14.4 dot (-0.1667) = cT(-0.56) $
  $ cS(s_1) = cS(2) + 0.2 dot 14.4 dot (-0.1667) = cS(1.52) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha mu_t epsilon_t$],
      [$cT(b_t) = cT(phi b_(t-1)) + beta mu_t epsilon_t$],
      [$cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t$],

      [1], [12], [$14.4$], [$-0.1667$], [$cL(11.2)$], [$cT(-0.56)$], [$cS(1.52)$],
      [2], [10], [$10.752$], [$-0.0699$], [$cL(10.376)$], [$cT(-0.7488)$], [$cS(-0.1504)$],
      [3], [8], [$6.777$], [$0.1805$], [$cL(10.3885)$], [$cT(-0.1098)$], [$cS(-2.7554)$],
      [4], [11], [$11.3006$], [$-0.0266$], [$cL(10.1503)$], [$cT(-0.2081)$], [$cS(0.9399)$],
      [5], [14], [$11.5038$], [$0.217$], [$cL(11.2319)$], [$cT(0.832)$], [$cS(2.0192)$],
      [6], [12], [$11.7471$], [$0.0215$], [$cL(12.0239)$], [$cT(0.7667)$], [$cS(-0.0998)$],
      [7], [9], [$9.882$], [$-0.0892$], [$cL(12.1964)$], [$cT(0.2606)$], [$cS(-2.9318)$],
      [8], [13], [$13.3447$], [$-0.0258$], [$cL(12.2325)$], [$cT(0.0706)$], [$cS(0.8709)$],
      [9], [16], [$14.3082$], [$0.1182$], [$cL(13.1349)$], [$cT(0.7332)$], [$cS(2.3576)$],
      [10], [14], [$13.6216$], [$0.0278$], [$cL(13.9106)$], [$cT(0.7379)$], [$cS(-0.0241)$],
      [11], [11], [$11.5692$], [$-0.0492$], [$cL(14.2164)$], [$cT(0.3627)$], [$cS(-3.0456)$],
      [12], [15], [$15.3774$], [$-0.0245$], [$cL(14.3178)$], [$cT(0.1392)$], [$cS(0.7954)$],
      [13], [18], [$16.7867$], [$0.0723$], [$cL(15.0358)$], [$cT(0.5966)$], [$cS(2.6003)$],
      [14], [16], [$15.4889$], [$0.033$], [$cL(15.7686)$], [$cT(0.6817)$], [$cS(0.0781)$],
      [15], [13], [$13.2684$], [$-0.0202$], [$cL(16.1798)$], [$cT(0.438)$], [$cS(-3.0993)$],
      [16], [17], [$17.3257$], [$-0.0188$], [$cL(16.3674)$], [$cT(0.2202)$], [$cS(0.7303)$],
    )
  ]
]
