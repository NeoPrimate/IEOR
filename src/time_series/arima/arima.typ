#import "/lib/imports.typ": *
#show: formatting

#import "./summary.typ": cAR, cDiff, cMA
#import "../_data.typ" as data

Autoregressive integrated moving average

$
  "ARIMA"(p,d,q)
$

$ cAR(phi(B)) cDiff((1-B)^d) x_t = c + cMA(theta(B)) epsilon_t $
$ cAR(phi(B)) = 1 - cAR(phi_1) B - dots - cAR(phi_p) B^p $
$ cMA(theta(B)) = 1 + cMA(theta_1) B + dots + cMA(theta_q) B^q $

Differencing operator $cDiff((1-B)) y_t = y_t - y_(t-1)$ removes trend. \
Apply $cDiff(d)$ times to make non-stationary series stationary.


*Parameters:* #cAR[$phi_1, ..., phi_p$], #cMA[$theta_1, ..., theta_q$], $c$, $sigma^2$ \
*Orders:* #cAR[$p$], #cDiff[$d$], #cMA[$q$]


#example(title: $"ARIMA"(1, 1, 1)$)[
  *Given*
  - Orders: #cAR[$p = 1$], #cDiff[$d = 1$], #cMA[$q = 1$]
  - Parameters: #cAR[$phi_1 = 0.5$], #cMA[$theta_1 = 0.5$], $c = 0$
  - Initial conditions: #cDiff[$d_1 = 0$], $epsilon_1 = 0$
  - Data:

  #data.show-table(data.x)

  *Step 1 — formula*

  Substitute #cAR[$p = 1$], #cDiff[$d = 1$], #cMA[$q = 1$] into the ARIMA recursion:
  $ cAR((1 - phi_1 B)) cDiff((1 - B)) x_t = c + cMA((1 + theta_1 B)) epsilon_t $

  *Difference* — apply #cDiff[$(1-B)$] to convert $x_t$ to a stationary series:
  $ cDiff(d_t) := cDiff((1-B) x_t) = x_t - x_(t-1) $

  In the differenced space, the model is ARMA$(1, 1)$:
  $ cDiff(d_t) = c + cAR(phi_1) cDiff(d_(t-1)) + epsilon_t + cMA(theta_1) epsilon_(t-1) $

  Forecast the difference (set $epsilon_t = 0$):
  $ hat(cDiff(d))_t = c + cAR(phi_1) cDiff(d_(t-1)) + cMA(theta_1) epsilon_(t-1) $

  *Undifference* — convert the difference forecast back to a forecast for $x_t$:
  $ hat(x)_t = x_(t-1) + hat(cDiff(d))_t $

  Innovation:
  $ epsilon_t = cDiff(d_t) - hat(cDiff(d))_t = x_t - hat(x)_t $

  *Step 2 — apply at $t = 2$*

  First difference: #cDiff[$d_2 = x_2 - x_1 = 10 - 12 = -2$].

  Plug in #cAR[$phi_1 = 0.5$], #cMA[$theta_1 = 0.5$], #cDiff[$d_1 = 0$], $epsilon_1 = 0$:
  $ hat(cDiff(d))_2 = 0 + cAR(0.5) dot cDiff(0) + cMA(0.5) dot 0 = 0 $
  $ hat(x)_2 = x_1 + hat(cDiff(d))_2 = 12 + 0 = 12 $
  $ epsilon_2 = x_2 - hat(x)_2 = 10 - 12 = -2 $

  *Step 3 — iterate*

  Two-stage pipeline at each $t$: difference $arrow.r$ ARMA-forecast the difference $arrow.r$ undifference. Values rounded to 4 decimal places.

  #align(center)[
    #table(
      columns: 6,
      inset: 0.45em,
      align: center,
      [$t$],
      [$x_t$],
      [$cDiff(d_t) = x_t - x_(t-1)$],
      [$hat(cDiff(d))_t = cAR(0.5) cDiff(d_(t-1)) + cMA(0.5) epsilon_(t-1)$],
      [$hat(x)_t = x_(t-1) + hat(cDiff(d))_t$],
      [$epsilon_t = x_t - hat(x)_t$],

      [2], [10], [$cDiff(-2)$], [$0.5(cDiff(0)) + 0.5(0) = 0$], [$12 + 0 = 12$], [$-2$],
      [3], [8], [$cDiff(-2)$], [$0.5(cDiff(-2)) + 0.5(-2) = -2$], [$10 + (-2) = 8$], [$0$],
      [4], [11], [$cDiff(3)$], [$0.5(cDiff(-2)) + 0.5(0) = -1$], [$8 + (-1) = 7$], [$4$],
      [5], [14], [$cDiff(3)$], [$0.5(cDiff(3)) + 0.5(4) = 3.5$], [$11 + 3.5 = 14.5$], [$-0.5$],
      [6], [12], [$cDiff(-2)$], [$0.5(cDiff(3)) + 0.5(-0.5) = 1.25$], [$14 + 1.25 = 15.25$], [$-3.25$],
      [7], [9], [$cDiff(-3)$], [$0.5(cDiff(-2)) + 0.5(-3.25) = -2.625$], [$12 + (-2.625) = 9.375$], [$-0.375$],
      [8], [13], [$cDiff(4)$], [$0.5(cDiff(-3)) + 0.5(-0.375) = -1.6875$], [$9 + (-1.6875) = 7.3125$], [$5.6875$],
      [9], [16], [$cDiff(3)$], [$0.5(cDiff(4)) + 0.5(5.6875) = 4.8438$], [$13 + 4.8438 = 17.8438$], [$-1.8438$],
      [10], [14], [$cDiff(-2)$], [$0.5(cDiff(3)) + 0.5(-1.8438) = 0.5781$], [$16 + 0.5781 = 16.5781$], [$-2.5781$],
      [11], [11], [$cDiff(-3)$], [$0.5(cDiff(-2)) + 0.5(-2.5781) = -2.2891$], [$14 + (-2.2891) = 11.7109$], [$-0.7109$],
      [12], [15], [$cDiff(4)$], [$0.5(cDiff(-3)) + 0.5(-0.7109) = -1.8555$], [$11 + (-1.8555) = 9.1445$], [$5.8555$],
      [13], [18], [$cDiff(3)$], [$0.5(cDiff(4)) + 0.5(5.8555) = 4.9277$], [$15 + 4.9277 = 19.9277$], [$-1.9277$],
      [14], [16], [$cDiff(-2)$], [$0.5(cDiff(3)) + 0.5(-1.9277) = 0.5361$], [$18 + 0.5361 = 18.5361$], [$-2.5361$],
      [15], [13], [$cDiff(-3)$], [$0.5(cDiff(-2)) + 0.5(-2.5361) = -2.2681$], [$16 + (-2.2681) = 13.7319$], [$-0.7319$],
      [16], [17], [$cDiff(4)$], [$0.5(cDiff(-3)) + 0.5(-0.7319) = -1.8660$], [$13 + (-1.8660) = 11.1340$], [$5.8660$],
      [17], [—], [—], [$0.5(cDiff(4)) + 0.5(5.8660) = 4.9330$], [$17 + 4.9330 = 21.9330$], [—],
    )
  ]
]
