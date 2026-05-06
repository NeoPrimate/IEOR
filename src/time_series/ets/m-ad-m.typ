#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped multiplicative Holt-Winters

$ "ETS"(M, "Ad", M) $

$ x_t = (cL(l_(t-1)) + cT(phi b_(t-1))) cS(s_(t-m)) (1 + epsilon_t) $

$ cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t) $
$ cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t $
$ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
$ hat(x)_(t+h | t) = (cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t)) cS(s_(t+h-m_h^+)) $










#example(title: $"ETS"(M, "Ad", M)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 0.5$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (1.2, 1, 0.8, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = ((cL(l_(t-1)) + cT(phi b_(t-1))) cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = (cL(l_(t-1)) + cT(phi b_(t-1))) cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t) $
  $ cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t $
  $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = (cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t)) cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = (cL(12) + cT(0.8 dot 0.5)) dot cS(1.2) = 14.88 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 14.88) \/ 14.88 = -0.1935 $
  $ cL(l_1) = (cL(12) + cT(0.8 dot 0.5)) (1 + 0.5 dot (-0.1935)) = cL(11.2) $
  $ cT(b_1) = cT(0.8 dot 0.5) + 0.4 (12 + 0.8 dot 0.5) dot (-0.1935) = cT(-0.56) $
  $ cS(s_1) = cS(1.2) (1 + 0.2 dot (-0.1935)) = cS(1.1535) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = (cL(l_(t-1)) + cT(phi b_(t-1))) cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t)$],
      [$cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t$],
      [$cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t)$],

      [1], [12], [$14.88$], [$-0.1935$], [$cL(11.2)$], [$cT(-0.56)$], [$cS(1.1535)$],
      [2], [10], [$10.752$], [$-0.0699$], [$cL(10.376)$], [$cT(-0.7488)$], [$cS(0.986)$],
      [3], [8], [$7.8216$], [$0.0228$], [$cL(9.8885)$], [$cT(-0.5098)$], [$cS(0.8037)$],
      [4], [11], [$9.4806$], [$0.1603$], [$cL(10.2403)$], [$cT(0.1999)$], [$cS(1.0321)$],
      [5], [14], [$11.9972$], [$0.1669$], [$cL(11.2683)$], [$cT(0.8544)$], [$cS(1.1921)$],
      [6], [12], [$11.7847$], [$0.0183$], [$cL(12.0611)$], [$cT(0.7709)$], [$cS(0.9896)$],
      [7], [9], [$10.1885$], [$-0.1166$], [$cL(11.9383)$], [$cT(0.0252)$], [$cS(0.7849)$],
      [8], [13], [$12.3418$], [$0.0533$], [$cL(12.2774)$], [$cT(0.2752)$], [$cS(1.0431)$],
      [9], [16], [$14.8979$], [$0.074$], [$cL(12.9598)$], [$cT(0.59)$], [$cS(1.2097)$],
      [10], [14], [$13.2924$], [$0.0532$], [$cL(13.7894)$], [$cT(0.758)$], [$cS(1.0002)$],
      [11], [11], [$11.2993$], [$-0.0265$], [$cL(14.2052)$], [$cT(0.4539)$], [$cS(0.7807)$],
      [12], [15], [$15.1956$], [$-0.0129$], [$cL(14.4745)$], [$cT(0.2881)$], [$cS(1.0404)$],
      [13], [18], [$17.7887$], [$0.0119$], [$cL(14.7924)$], [$cT(0.3004)$], [$cS(1.2126)$],
      [14], [16], [$15.0349$], [$0.0642$], [$cL(15.5151)$], [$cT(0.6263)$], [$cS(1.013)$],
      [15], [13], [$12.5045$], [$0.0396$], [$cL(16.3335)$], [$cT(0.7549)$], [$cS(0.7869)$],
      [16], [17], [$17.6212$], [$-0.0353$], [$cL(16.6388)$], [$cT(0.3651)$], [$cS(1.033)$],
    )
  ]
]
