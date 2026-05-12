#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cAR, cDiff, cMA
#import "../_data.typ" as data

Vector ARIMA with exogenous regressors

$ "VARIMAX"(p,d,q) $

$ cAR(bold(Phi)(B)) cDiff((1-B)^d) bold(y)_t = bold(c) + bold(B) bold(x)_t + cMA(bold(Theta)(B)) bold(epsilon)_t $

$bold(y)_t in RR^K$ = endogenous vector series \
$bold(x)_t in RR^k$ = exogenous regressor vector \
$bold(B) in RR^(K times k)$ = matrix of regression coefficients \
Each of the $K$ series can depend on the same set of $k$ exogenous variables.


*Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$], #cMA[$bold(Theta)_1, ..., bold(Theta)_q$],
$bold(B)$ ($K times k$), $bold(c)$, $bold(Sigma)$ \
*Orders:* #cAR[$p$], #cDiff[$d$], #cMA[$q$], $K$, $k$ (regressors)


#example(title: $"VARIMAX"(1, 0, 1) ", " K = 2 ", " k = 1$)[
  *Given*
  - Orders: #cAR[$p = 1$], #cDiff[$d = 0$], #cMA[$q = 1$], $K = 2$, $k = 1$ (one exog)
  - Coefficient matrices:
    $
      cAR(bold(Phi)_1) = mat(0.4, 0.2; 0.2, 0.4) quad cMA(bold(Theta)_1) = mat(0.4, 0.2; 0.2, 0.4) quad bold(B) = vec(0.5, 0.5)
    $
  - Intercept: $bold(c) = vec(0, 0)$
  - Initial conditions: $bold(y)_0 = vec(0, 0)$, $bold(epsilon)_0 = vec(0, 0)$
  - Endogenous $bold(y)_t = vec(y_(1\,t), y_(2\,t))$:

  #data.show-table(data.x, name: "y_(1\,)")
  #data.show-table(data.y, name: "y_(2\,)")

  - Exogenous $z_t$:

  #data.show-table(data.z, name: "z")

  *Step 1 — formula*

  Substitute orders into the VARIMAX recursion (with $d = 0$, no differencing):
  $
    cAR((bold(I) - bold(Phi)_1 B)) bold(y)_t = bold(c) + bold(B) z_t + cMA((bold(I) + bold(Theta)_1 B)) bold(epsilon)_t
  $

  Forecast (set $bold(epsilon)_t = bold(0)$):
  $ hat(bold(y))_t = bold(c) + cAR(bold(Phi)_1) bold(y)_(t-1) + bold(B) z_t + cMA(bold(Theta)_1) bold(epsilon)_(t-1) $

  Three contributions: AR product, exogenous regression $bold(B) z_t$, MA product.

  Componentwise:
  $
    hat(y)_(1\,t) = c_1 + cAR(0.4) y_(1\,t-1) + cAR(0.2) y_(2\,t-1) + 0.5 z_t + cMA(0.4) epsilon_(1\,t-1) + cMA(0.2) epsilon_(2\,t-1)
  $
  $
    hat(y)_(2\,t) = c_2 + cAR(0.2) y_(1\,t-1) + cAR(0.4) y_(2\,t-1) + 0.5 z_t + cMA(0.2) epsilon_(1\,t-1) + cMA(0.4) epsilon_(2\,t-1)
  $

  Innovation:
  $ bold(epsilon)_t = bold(y)_t - hat(bold(y))_t $

  *Step 2 — apply at $t = 2$*

  Compute the three contributions separately, then sum.

  AR part: $cAR(bold(Phi)_1) bold(y)_1 = cAR(bold(Phi)_1) vec(12, 8) = vec(cAR(0.4)(12) + cAR(0.2)(8), cAR(0.2)(12) + cAR(0.4)(8)) = vec(6.4, 5.6)$

  Exog part: $bold(B) z_2 = vec(0.5, 0.5) dot 2 = vec(1, 1)$

  MA part: $cMA(bold(Theta)_1) bold(epsilon)_1$. With $bold(epsilon)_0 = bold(0)$, the $t = 1$ step gives $hat(bold(y))_1 = bold(B) z_1 = vec(0.5, 0.5)$ and $bold(epsilon)_1 = vec(12, 8) - vec(0.5, 0.5) = vec(11.5, 7.5)$.
  $
    cMA(bold(Theta)_1) bold(epsilon)_1 = vec(cMA(0.4)(11.5) + cMA(0.2)(7.5), cMA(0.2)(11.5) + cMA(0.4)(7.5)) = vec(6.1, 5.3)
  $

  Sum: $hat(bold(y))_2 = vec(6.4, 5.6) + vec(1, 1) + vec(6.1, 5.3) = vec(13.5, 11.9)$

  $bold(epsilon)_2 = vec(10, 9) - vec(13.5, 11.9) = vec(-3.5, -2.9)$

  *Step 3 — iterate*

  Three contributions per row: AR #cAR[$bold(Phi)_1 bold(y)_(t-1)$], exog $bold(B) z_t$, MA #cMA[$bold(Theta)_1 bold(epsilon)_(t-1)$]. Values rounded to 4 decimal places.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.4em,
      align: center,
      [$t$],
      [$bold(y)_t$],
      [$cAR(bold(Phi)_1 bold(y)_(t-1))$],
      [$bold(B) z_t$],
      [$cMA(bold(Theta)_1 bold(epsilon)_(t-1))$],
      [$hat(bold(y))_t " / " bold(epsilon)_t$],

      [1], [$vec(12, 8)$], [$vec(0, 0)$], [$vec(0.5, 0.5)$], [$vec(0, 0)$], [$vec(0.5, 0.5) " / " vec(11.5, 7.5)$],
      [2],
      [$vec(10, 9)$],
      [$vec(6.4, 5.6)$],
      [$vec(1, 1)$],
      [$vec(6.1, 5.3)$],
      [$vec(13.5, 11.9) " / " vec(-3.5, -2.9)$],

      [3],
      [$vec(8, 7)$],
      [$vec(5.8, 5.6)$],
      [$vec(1.5, 1.5)$],
      [$vec(-1.98, -1.86)$],
      [$vec(5.32, 5.24) " / " vec(2.68, 1.76)$],

      [4],
      [$vec(11, 6)$],
      [$vec(4.6, 4.4)$],
      [$vec(2, 2)$],
      [$vec(1.424, 1.24)$],
      [$vec(8.024, 7.64) " / " vec(2.976, -1.64)$],

      [5],
      [$vec(14, 10)$],
      [$vec(5.6, 4.6)$],
      [$vec(2.5, 2.5)$],
      [$vec(0.8624, -0.0608)$],
      [$vec(8.9624, 7.0392) " / " vec(5.0376, 2.9608)$],

      [6],
      [$vec(12, 11)$],
      [$vec(7.6, 6.8)$],
      [$vec(3, 3)$],
      [$vec(2.6072, 2.1918)$],
      [$vec(13.2072, 11.9918) " / " vec(-1.2072, -0.9918)$],

      [7],
      [$vec(9, 9)$],
      [$vec(7, 6.8)$],
      [$vec(3.5, 3.5)$],
      [$vec(-0.6812, -0.6381)$],
      [$vec(9.8188, 9.6619) " / " vec(-0.8188, -0.6619)$],

      [8],
      [$vec(13, 8)$],
      [$vec(5.4, 5.4)$],
      [$vec(4, 4)$],
      [$vec(-0.4599, -0.4286)$],
      [$vec(8.9401, 8.9714) " / " vec(4.0599, -0.9714)$],

      [9],
      [$vec(16, 12)$],
      [$vec(6.8, 5.8)$],
      [$vec(4.5, 4.5)$],
      [$vec(1.4297, 0.4234)$],
      [$vec(12.7297, 10.7234) " / " vec(3.2703, 1.2766)$],

      [10],
      [$vec(14, 13)$],
      [$vec(8.8, 8)$],
      [$vec(5, 5)$],
      [$vec(1.5634, 1.1647)$],
      [$vec(15.3634, 14.1647) " / " vec(-1.3634, -1.1647)$],

      [11],
      [$vec(11, 11)$],
      [$vec(8.2, 8)$],
      [$vec(5.5, 5.5)$],
      [$vec(-0.7783, -0.7386)$],
      [$vec(12.9217, 12.7614) " / " vec(-1.9217, -1.7614)$],

      [12],
      [$vec(15, 10)$],
      [$vec(6.6, 6.6)$],
      [$vec(6, 6)$],
      [$vec(-1.1209, -1.0889)$],
      [$vec(11.4791, 11.5111) " / " vec(3.5209, -1.5111)$],

      [13],
      [$vec(18, 14)$],
      [$vec(8, 7)$],
      [$vec(6.5, 6.5)$],
      [$vec(1.0861, 0.0598)$],
      [$vec(15.5861, 13.5598) " / " vec(2.4139, 0.4402)$],

      [14],
      [$vec(16, 15)$],
      [$vec(10, 9.2)$],
      [$vec(7, 7)$],
      [$vec(1.0536, 0.6589)$],
      [$vec(18.0536, 16.8589) " / " vec(-2.0536, -1.8589)$],

      [15],
      [$vec(13, 13)$],
      [$vec(9.4, 9.2)$],
      [$vec(7.5, 7.5)$],
      [$vec(-1.1932, -1.1543)$],
      [$vec(15.7068, 15.5457) " / " vec(-2.7068, -2.5457)$],

      [16],
      [$vec(17, 12)$],
      [$vec(7.8, 7.8)$],
      [$vec(8, 8)$],
      [$vec(-1.5919, -1.5597)$],
      [$vec(14.2081, 14.2403) " / " vec(2.7919, -2.2403)$],
    )
  ]
]
