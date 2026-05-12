#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cL, cS, cT
#import "../_data.typ" as data

Damped mult. trend, mult. seasonality

$ "ETS"(A, "Md", M) $

$ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) cS(s_(t-m)) + epsilon_t $

$ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t \/ cS(s_(t-m)) $
$ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ (cL(l_(t-1)) cS(s_(t-m))) $
$ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) cT(b_(t-1)^phi)) $
$ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) cS(s_(t+h-m_h^+)) $








#example(title: $"ETS"(A, "Md", M)$)[
  *Given*
  - Smoothing parameters: $alpha = 0.5$, $beta = 0.4$, $phi = 0.8$, $gamma = 0.2$
  - Initial states: #cL[$l_0 = 12$], #cT[$b_0 = 1$], #cS[$(s_(-3), s_(-2), s_(-1), s_0) = (1.2, 1, 0.8, 1)$], seasonal period $m = 4$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Observation:
  $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) cS(s_(t-m)) + epsilon_t $
  Conditional mean (one-step-ahead forecast $hat(x)_(t | t-1) = mu_t$):
  $ mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) cS(s_(t-m)) $
  Innovation:
  $ epsilon_t = x_t - mu_t $
  State updates:
  $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t \/ cS(s_(t-m)) $
  $ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ (cL(l_(t-1)) cS(s_(t-m))) $
  $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) cT(b_(t-1)^phi)) $
  Forecast $h$ steps ahead from time $t$ (using current-period states):
  $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) cS(s_(t+h-m_h^+)) $
  where $h in {1, 2, 3, dots}$ is the forecast horizon (how many steps ahead); $m_h^+ = ((h - 1) mod m) + 1$ picks the right seasonal slot for the period $h$ steps ahead (cycles through $1, 2, dots, m$).

  *Step 2 — apply at $t = 1$*

  $ mu_1 = cL(12) dot cT(1^0.8) dot cS(1.2) = 14.4 $
  $ epsilon_1 = x_1 - mu_1 = 12 - 14.4 = -2.4 $
  $ cL(l_1) = cL(12) dot cT(1^0.8) + 0.5 dot (-2.4) \/ cS(1.2) = cL(11) $
  $ cT(b_1) = cT(1^0.8) + 0.4 dot (-2.4) \/ (12 dot 1.2) = cT(0.9333) $
  $ cS(s_1) = cS(1.2) + 0.2 dot (-2.4) \/ (12 dot 1^0.8) = cS(1.16) $

  *Step 3 — iterate*

  Each column header is the equation that produced its values. Values rounded to 4 decimal places; arithmetic performed at full precision.

  #align(center)[
    #table(
      columns: 7,
      inset: 0.4em,
      align: center,
      [$t$],
      [$x_t$],
      [$mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) cS(s_(t-m))$],
      [$epsilon_t$],
      [$cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t \/ cS(s_(t-m))$],
      [$cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ (cL(l_(t-1)) cS(s_(t-m)))$],
      [$cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) cT(b_(t-1)^phi))$],

      [1], [12], [$14.4$], [$-2.4$], [$cL(11)$], [$cT(0.9333)$], [$cS(1.16)$],
      [2], [10], [$10.4093$], [$-0.4093$], [$cL(10.2047)$], [$cT(0.9314)$], [$cS(0.9921)$],
      [3], [8], [$7.7127$], [$0.2873$], [$cL(9.8204)$], [$cT(0.9588)$], [$cS(0.806)$],
      [4], [11], [$9.4956$], [$1.5044$], [$cL(10.2478)$], [$cT(1.0282)$], [$cS(1.0317)$],
      [5], [14], [$12.1549$], [$1.8451$], [$cL(11.2737)$], [$cT(1.0846)$], [$cS(1.1952)$],
      [6], [12], [$11.9357$], [$0.0643$], [$cL(12.0627)$], [$cT(1.0694)$], [$cS(0.9932)$],
      [7], [9], [$10.2583$], [$-1.2583$], [$cL(11.9474)$], [$cT(1.0034)$], [$cS(0.7862)$],
      [8], [13], [$12.3594$], [$0.6406$], [$cL(12.2902)$], [$cT(1.0235)$], [$cS(1.0424)$],
      [9], [16], [$14.965$], [$1.035$], [$cL(12.9537)$], [$cT(1.0469)$], [$cS(1.2118)$],
      [10], [14], [$13.3466$], [$0.6534$], [$cL(13.7668)$], [$cT(1.0577)$], [$cS(1.0029)$],
      [11], [11], [$11.32$], [$-0.32$], [$cL(14.1951)$], [$cT(1.0341)$], [$cS(0.7817)$],
      [12], [15], [$15.1986$], [$-0.1986$], [$cL(14.4854)$], [$cT(1.0218)$], [$cS(1.0397)$],
      [13], [18], [$17.858$], [$0.142$], [$cL(14.796)$], [$cT(1.0206)$], [$cS(1.2137)$],
      [14], [16], [$15.0837$], [$0.9163$], [$cL(15.4965)$], [$cT(1.0412)$], [$cS(1.0151)$],
      [15], [13], [$12.5116$], [$0.4884$], [$cL(16.3171)$], [$cT(1.0489)$], [$cS(0.7878)$],
      [16], [17], [$17.6251$], [$-0.6251$], [$cL(16.6521)$], [$cT(1.0242)$], [$cS(1.0323)$],
    )
  ]
]
