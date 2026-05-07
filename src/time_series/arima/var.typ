#import "/lib/imports.typ": *

#import "./summary.typ": cAR
#import "../_data.typ" as data

Vector autoregression

$ "VAR"(p) $

$ cAR(bold(Phi)(B)) bold(x)_t = bold(c) + bold(epsilon)_t $
$ cAR(bold(Phi)(B)) = bold(I) - cAR(bold(Phi)_1) B - dots - cAR(bold(Phi)_p) B^p $

i.e.,

$
  bold(x)_t = bold(c) + cAR(bold(Phi)_1) bold(x)_(t-1) + dots + cAR(bold(Phi)_p) bold(x)_(t-p) + bold(epsilon)_t
$

Each component depends on $p$ lags of all $K$ series.

*Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$ ($K^2$ each)],
$bold(c)$ ($K$), $bold(Sigma)$ ($K(K+1)\/2$) \
*Orders:* #cAR[$p$], $K$ (series)


#example(title: $"VAR"(1) ", " K = 2$)[
  *Given*
  - Order: #cAR[$p = 1$], $K = 2$
  - Coefficient matrix:
    $ cAR(bold(Phi)_1) = mat(0.4, 0.2; 0.2, 0.4) $
  - Intercept: $bold(c) = vec(0, 0)$
  - Two series stacked into a vector $bold(x)_t = vec(x_(1, t), x_(2, t))$:

  #data.show-table(data.x, name: "x_(1\,)")
  #data.show-table(data.y, name: "x_(2\,)")

  *Step 1 — formula*

  Substitute #cAR[$p = 1$] into the VAR$(p)$ recursion:
  $ bold(x)_t = bold(c) + cAR(bold(Phi)_1) bold(x)_(t-1) + bold(epsilon)_t $

  Forecast (set $bold(epsilon)_t = bold(0)$):
  $ hat(bold(x))_t = bold(c) + cAR(bold(Phi)_1) bold(x)_(t-1) $

  Componentwise (write out the matrix-vector product):
  $
    vec(hat(x)_(1\,t), hat(x)_(2\,t)) = vec(c_1, c_2) + mat(cAR(0.4), cAR(0.2); cAR(0.2), cAR(0.4)) vec(x_(1\,t-1), x_(2\,t-1))
  $
  $ hat(x)_(1\,t) = c_1 + cAR(0.4) x_(1\,t-1) + cAR(0.2) x_(2\,t-1) $
  $ hat(x)_(2\,t) = c_2 + cAR(0.2) x_(1\,t-1) + cAR(0.4) x_(2\,t-1) $

  Innovation:
  $ bold(epsilon)_t = bold(x)_t - hat(bold(x))_t $

  *Step 2 — apply at $t = 2$*

  Plug in $bold(c) = bold(0)$, #cAR[$bold(Phi)_1$], $bold(x)_1 = vec(12, 8)$:
  $ hat(x)_(1\,2) = cAR(0.4) dot 12 + cAR(0.2) dot 8 = 4.8 + 1.6 = 6.4 $
  $ hat(x)_(2\,2) = cAR(0.2) dot 12 + cAR(0.4) dot 8 = 2.4 + 3.2 = 5.6 $
  $ bold(epsilon)_2 = vec(10, 9) - vec(6.4, 5.6) = vec(3.6, 3.4) $

  *Step 3 — iterate*

  #align(center)[
    #table(
      columns: 5,
      inset: 0.45em,
      align: center,
      [$t$],
      [$bold(x)_t$],
      [$hat(x)_(1\,t) = cAR(0.4) x_(1\,t-1) + cAR(0.2) x_(2\,t-1)$],
      [$hat(x)_(2\,t) = cAR(0.2) x_(1\,t-1) + cAR(0.4) x_(2\,t-1)$],
      [$bold(epsilon)_t$],

      [2],
      [$vec(10, 9)$],
      [$cAR(0.4)(12) + cAR(0.2)(8) = 6.4$],
      [$cAR(0.2)(12) + cAR(0.4)(8) = 5.6$],
      [$vec(3.6, 3.4)$],

      [3], [$vec(8, 7)$], [$cAR(0.4)(10) + cAR(0.2)(9) = 5.8$], [$cAR(0.2)(10) + cAR(0.4)(9) = 5.6$], [$vec(2.2, 1.4)$],
      [4], [$vec(11, 6)$], [$cAR(0.4)(8) + cAR(0.2)(7) = 4.6$], [$cAR(0.2)(8) + cAR(0.4)(7) = 4.4$], [$vec(6.4, 1.6)$],
      [5],
      [$vec(14, 10)$],
      [$cAR(0.4)(11) + cAR(0.2)(6) = 5.6$],
      [$cAR(0.2)(11) + cAR(0.4)(6) = 4.6$],
      [$vec(8.4, 5.4)$],

      [6],
      [$vec(12, 11)$],
      [$cAR(0.4)(14) + cAR(0.2)(10) = 7.6$],
      [$cAR(0.2)(14) + cAR(0.4)(10) = 6.8$],
      [$vec(4.4, 4.2)$],

      [7], [$vec(9, 9)$], [$cAR(0.4)(12) + cAR(0.2)(11) = 7$], [$cAR(0.2)(12) + cAR(0.4)(11) = 6.8$], [$vec(2, 2.2)$],
      [8], [$vec(13, 8)$], [$cAR(0.4)(9) + cAR(0.2)(9) = 5.4$], [$cAR(0.2)(9) + cAR(0.4)(9) = 5.4$], [$vec(7.6, 2.6)$],
      [9],
      [$vec(16, 12)$],
      [$cAR(0.4)(13) + cAR(0.2)(8) = 6.8$],
      [$cAR(0.2)(13) + cAR(0.4)(8) = 5.8$],
      [$vec(9.2, 6.2)$],

      [10],
      [$vec(14, 13)$],
      [$cAR(0.4)(16) + cAR(0.2)(12) = 8.8$],
      [$cAR(0.2)(16) + cAR(0.4)(12) = 8$],
      [$vec(5.2, 5)$],

      [11],
      [$vec(11, 11)$],
      [$cAR(0.4)(14) + cAR(0.2)(13) = 8.2$],
      [$cAR(0.2)(14) + cAR(0.4)(13) = 8$],
      [$vec(2.8, 3)$],

      [12],
      [$vec(15, 10)$],
      [$cAR(0.4)(11) + cAR(0.2)(11) = 6.6$],
      [$cAR(0.2)(11) + cAR(0.4)(11) = 6.6$],
      [$vec(8.4, 3.4)$],

      [13], [$vec(18, 14)$], [$cAR(0.4)(15) + cAR(0.2)(10) = 8$], [$cAR(0.2)(15) + cAR(0.4)(10) = 7$], [$vec(10, 7)$],
      [14],
      [$vec(16, 15)$],
      [$cAR(0.4)(18) + cAR(0.2)(14) = 10$],
      [$cAR(0.2)(18) + cAR(0.4)(14) = 9.2$],
      [$vec(6, 5.8)$],

      [15],
      [$vec(13, 13)$],
      [$cAR(0.4)(16) + cAR(0.2)(15) = 9.4$],
      [$cAR(0.2)(16) + cAR(0.4)(15) = 9.2$],
      [$vec(3.6, 3.8)$],

      [16],
      [$vec(17, 12)$],
      [$cAR(0.4)(13) + cAR(0.2)(13) = 7.8$],
      [$cAR(0.2)(13) + cAR(0.4)(13) = 7.8$],
      [$vec(9.2, 4.2)$],

      [17], [—], [$cAR(0.4)(17) + cAR(0.2)(12) = 9.2$], [$cAR(0.2)(17) + cAR(0.4)(12) = 8.2$], [—],
    )
  ]
]
