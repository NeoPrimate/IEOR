#import "/lib/imports.typ": *

#import "./summary.typ": cAR, cMA
#import "../_data.typ" as data

Vector autoregressive moving average

$"VARMA"(p,q)$

$ cAR(bold(Phi)(B)) bold(x)_t = bold(c) + cMA(bold(Theta)(B)) bold(epsilon)_t $

$ cAR(bold(Phi)(B)) = bold(I) - cAR(bold(Phi)_1) B - dots - cAR(bold(Phi)_p) B^p $
$ cMA(bold(Theta)(B)) = bold(I) + cMA(bold(Theta)_1) B + dots + cMA(bold(Theta)_q) B^q $
Vector analog of ARMA. Identifiability requires care (e.g., echelon forms).



*Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$], #cMA[$bold(Theta)_1, ..., bold(Theta)_q$],
$bold(c)$, $bold(Sigma)$ \
*Orders:* #cAR[$p$], #cMA[$q$], $K$


#example(title: $"VARMA"(1, 1) ", " K = 2$)[
  *Given*
  - Orders: #cAR[$p = 1$], #cMA[$q = 1$], $K = 2$
  - Coefficient matrices:
    $ cAR(bold(Phi)_1) = mat(0.4, 0.2; 0.2, 0.4) quad cMA(bold(Theta)_1) = mat(0.4, 0.2; 0.2, 0.4) $
  - Intercept: $bold(c) = vec(0, 0)$
  - Initial conditions: $bold(x)_0 = vec(0, 0)$, $bold(epsilon)_0 = vec(0, 0)$
  - Two series stacked into $bold(x)_t = vec(x_(1\,t), x_(2\,t))$:

  #data.show-table(data.x, name: "x_(1\,)")
  #data.show-table(data.y, name: "x_(2\,)")

  *Step 1 — formula*

  Substitute #cAR[$p = 1$], #cMA[$q = 1$] into the VARMA recursion:
  $ bold(x)_t = bold(c) + cAR(bold(Phi)_1) bold(x)_(t-1) + bold(epsilon)_t + cMA(bold(Theta)_1) bold(epsilon)_(t-1) $

  Forecast (set $bold(epsilon)_t = bold(0)$):
  $ hat(bold(x))_t = bold(c) + cAR(bold(Phi)_1) bold(x)_(t-1) + cMA(bold(Theta)_1) bold(epsilon)_(t-1) $

  Componentwise:
  $
    hat(x)_(1\,t) = c_1 + cAR(0.4) x_(1\,t-1) + cAR(0.2) x_(2\,t-1) + cMA(0.4) epsilon_(1\,t-1) + cMA(0.2) epsilon_(2\,t-1)
  $
  $
    hat(x)_(2\,t) = c_2 + cAR(0.2) x_(1\,t-1) + cAR(0.4) x_(2\,t-1) + cMA(0.2) epsilon_(1\,t-1) + cMA(0.4) epsilon_(2\,t-1)
  $

  Innovation:
  $ bold(epsilon)_t = bold(x)_t - hat(bold(x))_t $

  *Step 2 — apply at $t = 1$*

  With $bold(x)_0 = bold(0)$, $bold(epsilon)_0 = bold(0)$, every product is zero:
  $ hat(bold(x))_1 = vec(0, 0), quad bold(epsilon)_1 = bold(x)_1 - hat(bold(x))_1 = vec(12, 8) $

  *Step 2b — apply at $t = 2$*

  Plug in $bold(x)_1 = vec(12, 8)$, $bold(epsilon)_1 = vec(12, 8)$:
  $ hat(x)_(1\,2) = cAR(0.4)(12) + cAR(0.2)(8) + cMA(0.4)(12) + cMA(0.2)(8) = 4.8 + 1.6 + 4.8 + 1.6 = 12.8 $
  $ hat(x)_(2\,2) = cAR(0.2)(12) + cAR(0.4)(8) + cMA(0.2)(12) + cMA(0.4)(8) = 2.4 + 3.2 + 2.4 + 3.2 = 11.2 $
  $ bold(epsilon)_2 = vec(10, 9) - vec(12.8, 11.2) = vec(-2.8, -2.2) $

  *Step 3 — iterate*

  Two contributions per row: AR part #cAR[$bold(Phi)_1 bold(x)_(t-1)$] and MA part #cMA[$bold(Theta)_1 bold(epsilon)_(t-1)$]. Values rounded to 4 decimal places.

  #align(center)[
    #table(
      columns: 5,
      inset: 0.45em,
      align: center,
      [$t$],
      [$bold(x)_t$],
      [$cAR(bold(Phi)_1 bold(x)_(t-1))$],
      [$cMA(bold(Theta)_1 bold(epsilon)_(t-1))$],
      [$hat(bold(x))_t" / " bold(epsilon)_t$],

      [1], [$vec(12, 8)$], [$vec(0, 0)$], [$vec(0, 0)$], [$vec(0, 0) " / " vec(12, 8)$],
      [2], [$vec(10, 9)$], [$vec(6.4, 5.6)$], [$vec(6.4, 5.6)$], [$vec(12.8, 11.2) " / " vec(-2.8, -2.2)$],
      [3], [$vec(8, 7)$], [$vec(5.8, 5.6)$], [$vec(-1.56, -1.44)$], [$vec(4.24, 4.16) " / " vec(3.76, 2.84)$],
      [4], [$vec(11, 6)$], [$vec(4.6, 4.4)$], [$vec(2.072, 1.888)$], [$vec(6.672, 6.288) " / " vec(4.328, -0.288)$],
      [5],
      [$vec(14, 10)$],
      [$vec(5.6, 4.6)$],
      [$vec(1.6736, 0.7504)$],
      [$vec(7.2736, 5.3504) " / " vec(6.7264, 4.6496)$],

      [6],
      [$vec(12, 11)$],
      [$vec(7.6, 6.8)$],
      [$vec(3.6206, 3.2051)$],
      [$vec(11.2206, 10.0051) " / " vec(0.7794, 0.9949)$],

      [7], [$vec(9, 9)$], [$vec(7, 6.8)$], [$vec(0.5108, 0.5538)$], [$vec(7.5108, 7.3538) " / " vec(1.4892, 1.6462)$],
      [8],
      [$vec(13, 8)$],
      [$vec(5.4, 5.4)$],
      [$vec(0.9249, 0.9563)$],
      [$vec(6.3249, 6.3563) " / " vec(6.6751, 1.6437)$],

      [9],
      [$vec(16, 12)$],
      [$vec(6.8, 5.8)$],
      [$vec(2.9988, 1.9925)$],
      [$vec(9.7988, 7.7925) " / " vec(6.2012, 4.2075)$],

      [10],
      [$vec(14, 13)$],
      [$vec(8.8, 8)$],
      [$vec(3.3220, 2.9232)$],
      [$vec(12.122, 10.9232) " / " vec(1.878, 2.0768)$],

      [11],
      [$vec(11, 11)$],
      [$vec(8.2, 8)$],
      [$vec(1.1666, 1.2071)$],
      [$vec(9.3666, 9.2071) " / " vec(1.6334, 1.7929)$],

      [12],
      [$vec(15, 10)$],
      [$vec(6.6, 6.6)$],
      [$vec(1.0119, 1.0438)$],
      [$vec(7.6119, 7.6438) " / " vec(7.3881, 2.3562)$],

      [13], [$vec(18, 14)$], [$vec(8, 7)$], [$vec(3.4265, 2.4201)$], [$vec(11.4265, 9.4201) " / " vec(6.5735, 4.5799)$],
      [14],
      [$vec(16, 15)$],
      [$vec(10, 9.2)$],
      [$vec(3.5454, 3.1467)$],
      [$vec(13.5454, 12.3467) " / " vec(2.4546, 2.6533)$],

      [15],
      [$vec(13, 13)$],
      [$vec(9.4, 9.2)$],
      [$vec(1.5125, 1.5523)$],
      [$vec(10.9125, 10.7523) " / " vec(2.0875, 2.2477)$],

      [16],
      [$vec(17, 12)$],
      [$vec(7.8, 7.8)$],
      [$vec(1.2845, 1.3166)$],
      [$vec(9.0845, 9.1166) " / " vec(7.9155, 2.8834)$],
    )
  ]
]
