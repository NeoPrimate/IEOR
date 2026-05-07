#import "/lib/imports.typ": *

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped mult. trend + add. season., mult. errors

$ "ETS"(M, "Md", A) $

$ x_t = (cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m))) (1 + epsilon_t) $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha mu_t epsilon_t $
$ cT(b_t) = cT(b_(t-1)^phi) + beta mu_t epsilon_t \/ cL(l_(t-1)) $
$ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) + cS(s_(t+h-m_h^+)) $
where $ mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) $






#example(title: $"ETS"(M, "Md", A)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (2, 0, -3, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha mu_t epsilon_t $
  $ cT(b_t) = cT(b_(t-1)^phi) + beta mu_t epsilon_t \/ cL(l_(t-1)) $
  $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) + cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1^0.8) + cS(2) = 14 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 14) \/ 14 = -0.1429 $
  $ cL(l_1) = cL(12) dot cT(1^0.8) + 0.5 dot 14 dot (-0.1429) = cL(11) $
  $ cT(b_1) = cT(1^0.8) + 0.4 dot 14 dot (-0.1429) \/ 12 = cT(0.9333) $
  $ cS(s_1) = cS(2) + 0.2 dot 14 dot (-0.1429) = cS(1.6) $

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
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha mu_t epsilon_t$],
      [$cT(b_t) = cT(b_(t-1)^phi) + beta mu_t epsilon_t \/ cL(l_(t-1))$],
      [$cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t$],

      [1], [12], [$14$], [$-0.1429$], [$cL(11)$], [$cT(0.9333)$], [$cS(1.6)$],
      [2], [10], [$10.4093$], [$-0.0393$], [$cL(10.2047)$], [$cT(0.9314)$], [$cS(-0.0819)$],
      [3], [8], [$6.6408$], [$0.2047$], [$cL(10.3204)$], [$cT(0.998)$], [$cS(-2.7282)$],
      [4], [11], [$11.3041$], [$-0.0269$], [$cL(10.152)$], [$cT(0.9866)$], [$cS(0.9392)$],
      [5], [14], [$11.6433$], [$0.2024$], [$cL(11.2217)$], [$cT(1.0821)$], [$cS(2.0713)$],
      [6], [12], [$11.8714$], [$0.0108$], [$cL(12.0176)$], [$cT(1.0698)$], [$cS(-0.0561)$],
      [7], [9], [$9.9557$], [$-0.096$], [$cL(12.206)$], [$cT(1.0236)$], [$cS(-2.9193)$],
      [8], [13], [$13.3754$], [$-0.0281$], [$cL(12.2485)$], [$cT(1.0066)$], [$cS(0.8641)$],
      [9], [16], [$14.3841$], [$0.1123$], [$cL(13.1207)$], [$cT(1.058)$], [$cS(2.3945)$],
      [10], [14], [$13.6701$], [$0.0241$], [$cL(13.8912)$], [$cT(1.0562)$], [$cS(0.0098)$],
      [11], [11], [$11.5931$], [$-0.0512$], [$cL(14.2158)$], [$cT(1.0276)$], [$cS(-3.0379)$],
      [12], [15], [$15.3934$], [$-0.0256$], [$cL(14.3326)$], [$cT(1.011)$], [$cS(0.7854)$],
      [13], [18], [$16.8529$], [$0.0681$], [$cL(15.0319)$], [$cT(1.0408)$], [$cS(2.6239)$],
      [14], [16], [$15.5303$], [$0.0302$], [$cL(15.7553)$], [$cT(1.045)$], [$cS(0.1038)$],
      [15], [13], [$13.2821$], [$-0.0212$], [$cL(16.179)$], [$cT(1.0287)$], [$cS(-3.0943)$],
      [16], [17], [$17.3345$], [$-0.0193$], [$cL(16.3818)$], [$cT(1.0146)$], [$cS(0.7185)$],
    )
  ]
]
