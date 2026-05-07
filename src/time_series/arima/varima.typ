#import "/lib/imports.typ": *

#import "./summary.typ": cAR, cDiff, cMA
#import "../_data.typ" as data

Vector ARIMA

$ "VARIMA"(p,d,q) $

$ cAR(bold(Phi)(B)) cDiff((1-B)^d) bold(x)_t = bold(c) + cMA(bold(Theta)(B)) bold(epsilon)_t $

Differencing applied component-wise to each of the $K$ series. \
In practice, cointegrated systems use VECM (Vector Error Correction) rather than VARIMA — VECM models the long-run equilibrium directly.


*Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$], #cMA[$bold(Theta)_1, ..., bold(Theta)_q$],
$bold(c)$, $bold(Sigma)$ \
*Orders:* #cAR[$p$], #cDiff[$d$], #cMA[$q$], $K$


#example(title: $"VARIMA"(1, 1, 1) ", " K = 2$)[
  *Given*
  - Orders: #cAR[$p = 1$], #cDiff[$d = 1$], #cMA[$q = 1$], $K = 2$
  - Coefficient matrices:
    $ cAR(bold(Phi)_1) = mat(0.4, 0.2; 0.2, 0.4) quad cMA(bold(Theta)_1) = mat(0.4, 0.2; 0.2, 0.4) $
  - Intercept: $bold(c) = vec(0, 0)$
  - Initial conditions: $cDiff(bold(d)_1) = vec(0, 0)$, $bold(epsilon)_1 = vec(0, 0)$
  - Two series stacked into $bold(x)_t = vec(x_(1\,t), x_(2\,t))$:

  #data.show-table(data.x, name: "x_(1\,)")
  #data.show-table(data.y, name: "x_(2\,)")

  *Step 1 — formula*

  Substitute orders into the VARIMA recursion:
  $ cAR((bold(I) - bold(Phi)_1 B)) cDiff((1-B)) bold(x)_t = bold(c) + cMA((bold(I) + bold(Theta)_1 B)) bold(epsilon)_t $

  *Difference* — apply #cDiff[$(1-B)$] component-wise:
  $ cDiff(bold(d)_t) := cDiff((1-B) bold(x)_t) = bold(x)_t - bold(x)_(t-1) $

  In differenced space, the model is VARMA$(1, 1)$:
  $
    cDiff(bold(d)_t) = bold(c) + cAR(bold(Phi)_1) cDiff(bold(d)_(t-1)) + bold(epsilon)_t + cMA(bold(Theta)_1) cDiff(bold(epsilon)_(t-1))
  $

  Forecast the difference (set $bold(epsilon)_t = bold(0)$):
  $ hat(cDiff(bold(d)))_t = bold(c) + cAR(bold(Phi)_1) cDiff(bold(d)_(t-1)) + cMA(bold(Theta)_1) bold(epsilon)_(t-1) $

  *Undifference* — convert back to a forecast for $bold(x)_t$:
  $ hat(bold(x))_t = bold(x)_(t-1) + hat(cDiff(bold(d)))_t $

  Innovation:
  $ bold(epsilon)_t = cDiff(bold(d)_t) - hat(cDiff(bold(d)))_t = bold(x)_t - hat(bold(x))_t $

  *Step 2 — apply at $t = 2$*

  First difference: #cDiff[$bold(d)_2 = bold(x)_2 - bold(x)_1 = vec(10, 9) - vec(12, 8) = vec(-2, 1)$].

  Plug in #cAR[$bold(Phi)_1$], #cMA[$bold(Theta)_1$], #cDiff[$bold(d)_1 = vec(0, 0)$], $bold(epsilon)_1 = vec(0, 0)$:
  $ hat(cDiff(bold(d)))_2 = cAR(bold(Phi)_1) vec(0, 0) + cMA(bold(Theta)_1) vec(0, 0) = vec(0, 0) $
  $ hat(bold(x))_2 = bold(x)_1 + hat(cDiff(bold(d)))_2 = vec(12, 8) + vec(0, 0) = vec(12, 8) $
  $ bold(epsilon)_2 = bold(x)_2 - hat(bold(x))_2 = vec(10, 9) - vec(12, 8) = vec(-2, 1) $

  *Step 3 — iterate*

  Pipeline at each $t$: difference $arrow.r$ VARMA-forecast $arrow.r$ undifference. Values rounded to 4 decimal places.

  #align(center)[
    #table(
      columns: 5,
      inset: 0.45em,
      align: center,
      [$t$],
      [$cDiff(bold(d)_t)$],
      [$hat(cDiff(bold(d)))_t = cAR(bold(Phi)_1) cDiff(bold(d)_(t-1)) + cMA(bold(Theta)_1) bold(epsilon)_(t-1)$],
      [$hat(bold(x))_t = bold(x)_(t-1) + hat(cDiff(bold(d)))_t$],
      [$bold(epsilon)_t$],

      [2], [$cDiff(vec(-2, 1))$], [$vec(0, 0) + vec(0, 0) = vec(0, 0)$], [$vec(12, 8)$], [$vec(-2, 1)$],
      [3], [$cDiff(vec(-2, -2))$], [$vec(-0.6, 0) + vec(-0.6, 0) = vec(-1.2, 0)$], [$vec(8.8, 9)$], [$vec(-0.8, -2)$],
      [4],
      [$cDiff(vec(3, -1))$],
      [$vec(-1.2, -1.2) + vec(-0.72, -0.96) = vec(-1.92, -2.16)$],
      [$vec(6.08, 4.84)$],
      [$vec(4.92, 1.16)$],

      [5],
      [$cDiff(vec(3, 4))$],
      [$vec(1, 0.2) + vec(2.2, 1.448) = vec(3.2, 1.648)$],
      [$vec(14.2, 7.648)$],
      [$vec(-0.2, 2.352)$],

      [6],
      [$cDiff(vec(-2, 1))$],
      [$vec(2, 2.2) + vec(0.3904, 0.9008) = vec(2.3904, 3.1008)$],
      [$vec(16.3904, 13.1008)$],
      [$vec(-4.3904, -2.1008)$],

      [7],
      [$cDiff(vec(-3, -2))$],
      [$vec(-0.6, -0) + vec(-2.1763, -1.7184) = vec(-2.7763, -1.7184)$],
      [$vec(9.2237, 9.2816)$],
      [$vec(-0.2237, -0.2816)$],

      [8],
      [$cDiff(vec(4, -1))$],
      [$vec(-1.6, -1.4) + vec(-0.1458, -0.1573) = vec(-1.7458, -1.5573)$],
      [$vec(7.2542, 7.4427)$],
      [$vec(5.7458, 0.5573)$],

      [9],
      [$cDiff(vec(3, 4))$],
      [$vec(1.4, 0.4) + vec(2.4098, 1.3721) = vec(3.8098, 1.7721)$],
      [$vec(16.8098, 9.7721)$],
      [$vec(-0.8098, 2.2279)$],

      [10],
      [$cDiff(vec(-2, 1))$],
      [$vec(2, 2.2) + vec(0.1217, 0.7292) = vec(2.1217, 2.9292)$],
      [$vec(18.1217, 14.9292)$],
      [$vec(-4.1217, -1.9292)$],

      [11],
      [$cDiff(vec(-3, -2))$],
      [$vec(-0.6, 0) + vec(-2.0345, -1.596) = vec(-2.6345, -1.596)$],
      [$vec(11.3655, 11.404)$],
      [$vec(-0.3655, -0.404)$],

      [12],
      [$cDiff(vec(4, -1))$],
      [$vec(-1.6, -1.4) + vec(-0.227, -0.2347) = vec(-1.827, -1.6347)$],
      [$vec(9.173, 9.3653)$],
      [$vec(5.827, 0.6347)$],

      [13],
      [$cDiff(vec(3, 4))$],
      [$vec(1.4, 0.4) + vec(2.4577, 1.4193) = vec(3.8577, 1.8193)$],
      [$vec(18.8577, 11.8193)$],
      [$vec(-0.8577, 2.1807)$],

      [14],
      [$cDiff(vec(-2, 1))$],
      [$vec(2, 2.2) + vec(0.093, 0.7008) = vec(2.093, 2.9008)$],
      [$vec(20.093, 16.9008)$],
      [$vec(-4.093, -1.9008)$],

      [15],
      [$cDiff(vec(-3, -2))$],
      [$vec(-0.6, 0) + vec(-2.0174, -1.5789) = vec(-2.6174, -1.5789)$],
      [$vec(13.3826, 13.4211)$],
      [$vec(-0.3826, -0.4211)$],

      [16],
      [$cDiff(vec(4, -1))$],
      [$vec(-1.6, -1.4) + vec(-0.2372, -0.2449) = vec(-1.8372, -1.6449)$],
      [$vec(11.1628, 11.3551)$],
      [$vec(5.8372, 0.6449)$],
    )
  ]
]
