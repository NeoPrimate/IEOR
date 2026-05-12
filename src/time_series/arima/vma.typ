#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cMA
#import "../_data.typ" as data

Vector moving average

$ "VMA"(q) $

$ bold(x)_t = bold(c) + cMA(bold(Theta)(B)) bold(epsilon)_t $

$ cMA(bold(Theta)(B)) = bold(I) + cMA(bold(Theta)_1) B + dots + cMA(bold(Theta)_q) B^q $

i.e.,

$
  bold(x)_t = bold(c) + bold(epsilon)_t + cMA(bold(Theta)_1) bold(epsilon)_(t-1) + dots + cMA(bold(Theta)_q) bold(epsilon)_(t-q)
$
Each component is a linear combination of past shocks across all series.

*Parameters:* #cMA[$bold(Theta)_1, ..., bold(Theta)_q$ ($K^2$ each)],
$bold(c)$ ($K$), $bold(Sigma)$ ($K(K+1)\/2$) \
*Orders:* #cMA[$q$], $K$ (series)


#example(title: $"VMA"(1) ", " K = 2$)[
  *Given*
  - Order: #cMA[$q = 1$], $K = 2$
  - Coefficient matrix:
    $ cMA(bold(Theta)_1) = mat(0.4, 0.2; 0.2, 0.4) $
  - Intercept: $bold(c) = vec(0, 0)$
  - Initial innovation: $bold(epsilon)_0 = vec(0, 0)$
  - Two series stacked into $bold(x)_t = vec(x_(1\,t), x_(2\,t))$:

  #data.show-table(data.x, name: "x_(1\,)")
  #data.show-table(data.y, name: "x_(2\,)")

  *Step 1 — formula*

  Substitute #cMA[$q = 1$] into the VMA$(q)$ recursion:
  $ bold(x)_t = bold(c) + bold(epsilon)_t + cMA(bold(Theta)_1) bold(epsilon)_(t-1) $

  Forecast (set $bold(epsilon)_t = bold(0)$):
  $ hat(bold(x))_t = bold(c) + cMA(bold(Theta)_1) bold(epsilon)_(t-1) $

  Componentwise:
  $ hat(x)_(1\,t) = c_1 + cMA(0.4) epsilon_(1\,t-1) + cMA(0.2) epsilon_(2\,t-1) $
  $ hat(x)_(2\,t) = c_2 + cMA(0.2) epsilon_(1\,t-1) + cMA(0.4) epsilon_(2\,t-1) $

  Innovation:
  $ bold(epsilon)_t = bold(x)_t - hat(bold(x))_t $

  *Step 2 — apply at $t = 1$*

  Plug in $bold(c) = bold(0)$, #cMA[$bold(Theta)_1$], $bold(epsilon)_0 = vec(0, 0)$:
  $ hat(bold(x))_1 = bold(0) + cMA(bold(Theta)_1) bold(0) = vec(0, 0) $
  $ bold(epsilon)_1 = bold(x)_1 - hat(bold(x))_1 = vec(12, 8) - vec(0, 0) = vec(12, 8) $

  *Step 3 — iterate*

  Each row uses the *previous* innovation $bold(epsilon)_(t-1)$. Values rounded to 4 decimal places at every step (computation continues from the rounded value).

  #align(center)[
    #table(
      columns: 5,
      inset: 0.45em,
      align: center,
      [$t$],
      [$bold(x)_t$],
      [$hat(x)_(1\,t) = cMA(0.4) epsilon_(1\,t-1) + cMA(0.2) epsilon_(2\,t-1)$],
      [$hat(x)_(2\,t) = cMA(0.2) epsilon_(1\,t-1) + cMA(0.4) epsilon_(2\,t-1)$],
      [$bold(epsilon)_t$],

      [1], [$vec(12, 8)$], [$cMA(0.4)(0) + cMA(0.2)(0) = 0$], [$cMA(0.2)(0) + cMA(0.4)(0) = 0$], [$vec(12, 8)$],
      [2],
      [$vec(10, 9)$],
      [$cMA(0.4)(12) + cMA(0.2)(8) = 6.4$],
      [$cMA(0.2)(12) + cMA(0.4)(8) = 5.6$],
      [$vec(3.6, 3.4)$],

      [3],
      [$vec(8, 7)$],
      [$cMA(0.4)(3.6) + cMA(0.2)(3.4) = 2.12$],
      [$cMA(0.2)(3.6) + cMA(0.4)(3.4) = 2.08$],
      [$vec(5.88, 4.92)$],

      [4],
      [$vec(11, 6)$],
      [$cMA(0.4)(5.88) + cMA(0.2)(4.92) = 3.336$],
      [$cMA(0.2)(5.88) + cMA(0.4)(4.92) = 3.144$],
      [$vec(7.664, 2.856)$],

      [5],
      [$vec(14, 10)$],
      [$cMA(0.4)(7.664) + cMA(0.2)(2.856) = 3.6368$],
      [$cMA(0.2)(7.664) + cMA(0.4)(2.856) = 2.6752$],
      [$vec(10.3632, 7.3248)$],

      [6],
      [$vec(12, 11)$],
      [$cMA(0.4)(10.3632) + cMA(0.2)(7.3248) = 5.6102$],
      [$cMA(0.2)(10.3632) + cMA(0.4)(7.3248) = 5.0026$],
      [$vec(6.3898, 5.9974)$],

      [7],
      [$vec(9, 9)$],
      [$cMA(0.4)(6.3898) + cMA(0.2)(5.9974) = 3.7554$],
      [$cMA(0.2)(6.3898) + cMA(0.4)(5.9974) = 3.6769$],
      [$vec(5.2446, 5.3231)$],

      [8],
      [$vec(13, 8)$],
      [$cMA(0.4)(5.2446) + cMA(0.2)(5.3231) = 3.1625$],
      [$cMA(0.2)(5.2446) + cMA(0.4)(5.3231) = 3.1781$],
      [$vec(9.8375, 4.8219)$],

      [9],
      [$vec(16, 12)$],
      [$cMA(0.4)(9.8375) + cMA(0.2)(4.8219) = 4.8994$],
      [$cMA(0.2)(9.8375) + cMA(0.4)(4.8219) = 3.8963$],
      [$vec(11.1006, 8.1037)$],

      [10],
      [$vec(14, 13)$],
      [$cMA(0.4)(11.1006) + cMA(0.2)(8.1037) = 6.061$],
      [$cMA(0.2)(11.1006) + cMA(0.4)(8.1037) = 5.4616$],
      [$vec(7.939, 7.5384)$],

      [11],
      [$vec(11, 11)$],
      [$cMA(0.4)(7.939) + cMA(0.2)(7.5384) = 4.6833$],
      [$cMA(0.2)(7.939) + cMA(0.4)(7.5384) = 4.6032$],
      [$vec(6.3167, 6.3968)$],

      [12],
      [$vec(15, 10)$],
      [$cMA(0.4)(6.3167) + cMA(0.2)(6.3968) = 3.806$],
      [$cMA(0.2)(6.3167) + cMA(0.4)(6.3968) = 3.822$],
      [$vec(11.194, 6.178)$],

      [13],
      [$vec(18, 14)$],
      [$cMA(0.4)(11.194) + cMA(0.2)(6.178) = 5.7132$],
      [$cMA(0.2)(11.194) + cMA(0.4)(6.178) = 4.71$],
      [$vec(12.2868, 9.29)$],

      [14],
      [$vec(16, 15)$],
      [$cMA(0.4)(12.2868) + cMA(0.2)(9.29) = 6.7727$],
      [$cMA(0.2)(12.2868) + cMA(0.4)(9.29) = 6.1734$],
      [$vec(9.2273, 8.8266)$],

      [15],
      [$vec(13, 13)$],
      [$cMA(0.4)(9.2273) + cMA(0.2)(8.8266) = 5.4562$],
      [$cMA(0.2)(9.2273) + cMA(0.4)(8.8266) = 5.3761$],
      [$vec(7.5438, 7.6239)$],

      [16],
      [$vec(17, 12)$],
      [$cMA(0.4)(7.5438) + cMA(0.2)(7.6239) = 4.5423$],
      [$cMA(0.2)(7.5438) + cMA(0.4)(7.6239) = 4.5584$],
      [$vec(12.4577, 7.4416)$],
    )
  ]
]
