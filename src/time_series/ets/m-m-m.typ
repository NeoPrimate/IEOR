#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Fully multiplicative

$ "ETS"(M, M, M) $

$ x_t = cL(l_(t-1)) cT(b_(t-1)) cS(s_(t-m)) (1 + epsilon_t) $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) (1 + alpha epsilon_t) $
$ cT(b_t) = cT(b_(t-1)) (1 + beta epsilon_t) $
$ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) cS(s_(t+h-m_h^+)) $







#example(title: $"ETS"(M, M, M)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (1.2, 1, 0.8, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) cT(b_(t-1)) cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)) cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) (1 + alpha epsilon_t) $
  $ cT(b_t) = cT(b_(t-1)) (1 + beta epsilon_t) $
  $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1) dot cS(1.2) = 14.4 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 14.4) \/ 14.4 = -0.1667 $
  $ cL(l_1) = cL(12) dot cT(1) (1 + 0.5 dot (-0.1667)) = cL(11) $
  $ cT(b_1) = cT(1) (1 + 0.4 dot (-0.1667)) = cT(0.9333) $
  $ cS(s_1) = cS(1.2) (1 + 0.2 dot (-0.1667)) = cS(1.16) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) cT(b_(t-1)) cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) (1 + alpha epsilon_t)$],
      [$cT(b_t) = cT(b_(t-1)) (1 + beta epsilon_t)$],
      [$cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t)$],

      [1], [12], [$14.4$], [$-0.1667$], [$cL(11)$], [$cT(0.9333)$], [$cS(1.16)$],
      [2], [10], [$10.2667$], [$-0.026$], [$cL(10.1333)$], [$cT(0.9236)$], [$cS(0.9948)$],
      [3], [8], [$7.4876$], [$0.0684$], [$cL(9.6798)$], [$cT(0.9489)$], [$cS(0.8109)$],
      [4], [11], [$9.1853$], [$0.1976$], [$cL(10.0927)$], [$cT(1.0239)$], [$cS(1.0395)$],
      [5], [14], [$11.9874$], [$0.1679$], [$cL(11.2015)$], [$cT(1.0927)$], [$cS(1.199)$],
      [6], [12], [$12.1759$], [$-0.0144$], [$cL(12.1511)$], [$cT(1.0864)$], [$cS(0.9919)$],
      [7], [9], [$10.7049$], [$-0.1593$], [$cL(12.1493)$], [$cT(1.0172)$], [$cS(0.7851)$],
      [8], [13], [$12.8459$], [$0.012$], [$cL(12.4317)$], [$cT(1.022)$], [$cS(1.042)$],
      [9], [16], [$15.2334$], [$0.0503$], [$cL(13.0253)$], [$cT(1.0426)$], [$cS(1.211)$],
      [10], [14], [$13.4706$], [$0.0393$], [$cL(13.8471)$], [$cT(1.059)$], [$cS(0.9997)$],
      [11], [11], [$11.5129$], [$-0.0446$], [$cL(14.3373)$], [$cT(1.0401)$], [$cS(0.7781)$],
      [12], [15], [$15.5389$], [$-0.0347$], [$cL(14.6539)$], [$cT(1.0257)$], [$cS(1.0348)$],
      [13], [18], [$18.202$], [$-0.0111$], [$cL(14.9469)$], [$cT(1.0211)$], [$cS(1.2083)$],
      [14], [16], [$15.2587$], [$0.0486$], [$cL(15.6336)$], [$cT(1.041)$], [$cS(1.0094)$],
      [15], [13], [$12.6634$], [$0.0266$], [$cL(16.4906)$], [$cT(1.052)$], [$cS(0.7823)$],
      [16], [17], [$17.9523$], [$-0.053$], [$cL(16.8888)$], [$cT(1.0297)$], [$cS(1.0238)$],
    )
  ]
]
