#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Mult. trend + add. season., mult. errors

$ "ETS"(M, M, A) $

$ x_t = (cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m))) (1 + epsilon_t) $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha mu_t epsilon_t $
$ cT(b_t) = cT(b_(t-1)) + beta mu_t epsilon_t \/ cL(l_(t-1)) $
$ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) + cS(s_(t+h-m_h^+)) $
where $ mu_t = cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m)) $






#example(title: $"ETS"(M, M, A)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (2, 0, -3, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = (cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m)))(1 + epsilon_t) $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = (x_t - mu_t) \/ mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha mu_t epsilon_t $
  $ cT(b_t) = cT(b_(t-1)) + beta mu_t epsilon_t \/ cL(l_(t-1)) $
  $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) + cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1) + cS(2) = 14 $
  $ epsilon_1 = (x_1 - mu_1) \/ mu_1 = (12 - 14) \/ 14 = -0.1429 $
  $ cL(l_1) = cL(12) dot cT(1) + 0.5 dot 14 dot (-0.1429) = cL(11) $
  $ cT(b_1) = cT(1) + 0.4 dot 14 dot (-0.1429) \/ 12 = cT(0.9333) $
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
      [$mu_t = cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha mu_t epsilon_t$],
      [$cT(b_t) = cT(b_(t-1)) + beta mu_t epsilon_t \/ cL(l_(t-1))$],
      [$cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t$],

      [1], [12], [$14$], [$-0.1429$], [$cL(11)$], [$cT(0.9333)$], [$cS(1.6)$],
      [2], [10], [$10.2667$], [$-0.026$], [$cL(10.1333)$], [$cT(0.9236)$], [$cS(-0.0533)$],
      [3], [8], [$6.3595$], [$0.258$], [$cL(10.1798)$], [$cT(0.9884)$], [$cS(-2.6719)$],
      [4], [11], [$11.0616$], [$-0.0056$], [$cL(10.0308)$], [$cT(0.986)$], [$cS(0.9877)$],
      [5], [14], [$11.4901$], [$0.2184$], [$cL(11.145)$], [$cT(1.0861)$], [$cS(2.102)$],
      [6], [12], [$12.0509$], [$-0.0042$], [$cL(12.0788)$], [$cT(1.0842)$], [$cS(-0.0635)$],
      [7], [9], [$10.4243$], [$-0.1366$], [$cL(12.3841)$], [$cT(1.0371)$], [$cS(-2.9568)$],
      [8], [13], [$13.8308$], [$-0.0601$], [$cL(12.4277)$], [$cT(1.0102)$], [$cS(0.8215)$],
      [9], [16], [$14.6569$], [$0.0916$], [$cL(13.2265)$], [$cT(1.0535)$], [$cS(2.3706)$],
      [10], [14], [$13.8701$], [$0.0094$], [$cL(13.9985)$], [$cT(1.0574)$], [$cS(-0.0375)$],
      [11], [11], [$11.8452$], [$-0.0714$], [$cL(14.3794)$], [$cT(1.0332)$], [$cS(-3.1258)$],
      [12], [15], [$15.6789$], [$-0.0433$], [$cL(14.5179)$], [$cT(1.0144)$], [$cS(0.6857)$],
      [13], [18], [$17.097$], [$0.0528$], [$cL(15.1779)$], [$cT(1.0392)$], [$cS(2.5512)$],
      [14], [16], [$15.7359$], [$0.0168$], [$cL(15.9055)$], [$cT(1.0462)$], [$cS(0.0153)$],
      [15], [13], [$13.5145$], [$-0.0381$], [$cL(16.383)$], [$cT(1.0333)$], [$cS(-3.2287)$],
      [16], [17], [$17.6137$], [$-0.0348$], [$cL(16.6211)$], [$cT(1.0183)$], [$cS(0.563)$],
    )
  ]
]
