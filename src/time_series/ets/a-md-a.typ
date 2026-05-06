#import "/src/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped mult. trend, add. seasonality

$ "ETS"(A, "Md", A) $

$ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t $
$ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1)) $
$ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) + cS(s_(t+h-m_h^+)) $







#example(title: $"ETS"(A, "Md", A)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (2, 0, -3, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) + epsilon_t $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = x_t - mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t $
  $ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1)) $
  $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) + cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1^0.8) + cS(2) = 14 $
  $ epsilon_1 = x_1 - mu_1 = 12 - 14 = -2 $
  $ cL(l_1) = cL(12) dot cT(1^0.8) + 0.5 dot (-2) = cL(11) $
  $ cT(b_1) = cT(1^0.8) + 0.4 dot (-2) \/ 12 = cT(0.9333) $
  $ cS(s_1) = cS(2) + 0.2 dot (-2) = cS(1.6) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t$],
      [$cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1))$],
      [$cS(s_t) = cS(s_(t-m)) + gamma epsilon_t$],

      [1], [12], [$14$], [$-2$], [$cL(11)$], [$cT(0.9333)$], [$cS(1.6)$],
      [2], [10], [$10.4093$], [$-0.4093$], [$cL(10.2047)$], [$cT(0.9314)$], [$cS(-0.0819)$],
      [3], [8], [$6.6408$], [$1.3592$], [$cL(10.3204)$], [$cT(0.998)$], [$cS(-2.7282)$],
      [4], [11], [$11.3041$], [$-0.3041$], [$cL(10.152)$], [$cT(0.9866)$], [$cS(0.9392)$],
      [5], [14], [$11.6433$], [$2.3567$], [$cL(11.2217)$], [$cT(1.0821)$], [$cS(2.0713)$],
      [6], [12], [$11.8714$], [$0.1286$], [$cL(12.0176)$], [$cT(1.0698)$], [$cS(-0.0561)$],
      [7], [9], [$9.9557$], [$-0.9557$], [$cL(12.206)$], [$cT(1.0236)$], [$cS(-2.9193)$],
      [8], [13], [$13.3754$], [$-0.3754$], [$cL(12.2485)$], [$cT(1.0066)$], [$cS(0.8641)$],
      [9], [16], [$14.3841$], [$1.6159$], [$cL(13.1207)$], [$cT(1.058)$], [$cS(2.3945)$],
      [10], [14], [$13.6701$], [$0.3299$], [$cL(13.8912)$], [$cT(1.0562)$], [$cS(0.0098)$],
      [11], [11], [$11.5931$], [$-0.5931$], [$cL(14.2158)$], [$cT(1.0276)$], [$cS(-3.0379)$],
      [12], [15], [$15.3934$], [$-0.3934$], [$cL(14.3326)$], [$cT(1.011)$], [$cS(0.7854)$],
      [13], [18], [$16.8529$], [$1.1471$], [$cL(15.0319)$], [$cT(1.0408)$], [$cS(2.6239)$],
      [14], [16], [$15.5303$], [$0.4697$], [$cL(15.7553)$], [$cT(1.045)$], [$cS(0.1038)$],
      [15], [13], [$13.2821$], [$-0.2821$], [$cL(16.179)$], [$cT(1.0287)$], [$cS(-3.0943)$],
      [16], [17], [$17.3345$], [$-0.3345$], [$cL(16.3818)$], [$cT(1.0146)$], [$cS(0.7185)$],
    )
  ]
]
