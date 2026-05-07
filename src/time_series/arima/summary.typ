#import "/lib/imports.typ": *

// =============================================================
// ARIMA family — 11 models in operator (backshift) notation
// Color scheme: AR / MA / differencing
// =============================================================

// ----- Setup -----
#let ar-color = rgb("#E65100")  // orange
#let ma-color = rgb("#00838F")  // teal
#let partial-color = rgb("#6A1B9A")  // purple

#let cAR(body) = text(fill: ar-color, body)
#let cMA(body) = text(fill: ma-color, body)
#let cDiff(body) = text(fill: partial-color, body)

#let arima-legend = box(inset: 4pt)[
  #cAR[■ AR $phi(B)$] #h(1em)
  #cMA[■ MA $theta(B)$] #h(1em)
  #cDiff[■ differencing $(1-B)^d$]
]

#let arima-cell(title, subtitle, definition, equations, footer) = block(
  width: 100%,
  inset: 8pt,
  stroke: 0.5pt + luma(180),
  radius: 4pt,
  breakable: false,
  {
    align(center)[
      #text(weight: "bold", size: 9pt)[#title] \
      #text(size: 8pt, style: "italic", fill: luma(100))[#subtitle]
    ]
    v(3pt)
    line(length: 100%, stroke: 0.3pt + luma(200))
    v(2pt)
    set text(size: 8pt)
    set block(spacing: 4pt)
    set math.equation(numbering: none)
    definition
    v(2pt)
    align(center, line(length: 50%, stroke: 0.3pt + luma(220)))
    v(2pt)
    equations
    v(4pt)
    align(center, line(length: 50%, stroke: 0.3pt + luma(220)))
    v(2pt)
    text(size: 7pt, fill: luma(80), footer)
  },
)


// =============================================================
// SECTION
// =============================================================

= ARIMA family (Box-Jenkins models)

#arima-legend

Each model is written using the _backshift operator_ $B$, where
$B x_t = x_(t-1)$ and $B^k x_t = x_(t-k)$. The compact form
$ phi(B) (1-B)^d x_t = c + theta(B) epsilon_t $
expresses ARIMA as a product of three operators acting on the series:
the AR polynomial, the differencing operator, and the MA polynomial.
$epsilon_t$ is white noise with mean zero and variance $sigma^2$.

For multivariate models, $bold(x)_t in RR^K$ is a vector of $K$ time series,
and operator coefficients become $K times K$ matrices.


== Univariate models

#grid(
  columns: 2,
  gutter: 8pt,

  arima-cell(
    [$"AR"(p)$],
    [Autoregressive],

    $ cAR(phi(B)) x_t = c + epsilon_t $,

    [
      $ cAR(phi(B)) = 1 - cAR(phi_1) B - cAR(phi_2) B^2 - dots - cAR(phi_p) B^p $ \
      i.e., $x_t = c + cAR(phi_1) x_(t-1) + dots + cAR(phi_p) x_(t-p) + epsilon_t$ \
      Stationary if all roots of $cAR(phi(B)) = 0$ lie outside the unit circle.
    ],

    [
      *Parameters:* #cAR[$phi_1, ..., phi_p$], $c$, $sigma^2$ \
      *Orders:* #cAR[$p$]
    ],
  ),

  arima-cell(
    [$"MA"(q)$],
    [Moving average],

    $ x_t = c + cMA(theta(B)) epsilon_t $,

    [
      $
        cMA(theta(B)) = 1 + cMA(theta_1) B + cMA(theta_2) B^2 + dots + cMA(theta_q) B^q
      $
      i.e., $ x_t = c + epsilon_t + cMA(theta_1) epsilon_(t-1) + dots + cMA(theta_q) epsilon_(t-q) $ \
      Always stationary. Invertible if roots of $cMA(theta(B)) = 0$ lie outside the unit circle.
    ],

    [
      *Parameters:* #cMA[$theta_1, ..., theta_q$], $c$, $sigma^2$ \
      *Orders:* #cMA[$q$]
    ],
  ),

  arima-cell(
    [$"ARMA"(p,q)$],
    [Autoregressive moving average],

    $ cAR(phi(B)) x_t = c + cMA(theta(B)) epsilon_t $,

    [
      $ cAR(phi(B)) = 1 - cAR(phi_1) B - dots - cAR(phi_p) B^p $ \
      $ cMA(theta(B)) = 1 + cMA(theta_1) B + dots + cMA(theta_q) B^q $ \
      Combines AR and MA structure. Requires stationary input series.
    ],

    [
      *Parameters:* #cAR[$phi_1, ..., phi_p$], #cMA[$theta_1, ..., theta_q$], $c$, $sigma^2$ \
      *Orders:* #cAR[$p$], #cMA[$q$]
    ],
  ),

  arima-cell(
    [$"ARIMA"(p,d,q)$],
    [Autoregressive integrated moving average],

    $ cAR(phi(B)) cDiff((1-B)^d) x_t = c + cMA(theta(B)) epsilon_t $,

    [
      $ cAR(phi(B)) = 1 - cAR(phi_1) B - dots - cAR(phi_p) B^p $
      $ cMA(theta(B)) = 1 + cMA(theta_1) B + dots + cMA(theta_q) B^q $

      Differencing operator $cDiff((1-B)) y_t = y_t - y_(t-1)$ removes trend. \
      Apply $cDiff(d)$ times to make non-stationary series stationary.
    ],

    [
      *Parameters:* #cAR[$phi_1, ..., phi_p$], #cMA[$theta_1, ..., theta_q$], $c$, $sigma^2$ \
      *Orders:* #cAR[$p$], #cDiff[$d$], #cMA[$q$]
    ],
  ),

  arima-cell(
    [$"SARIMA"(p,d,q)(P,D,Q)_m$],
    [Seasonal ARIMA],

    $
      cAR(phi(B)) cAR(Phi(B^m)) cDiff((1-B)^d) cDiff((1-B^m)^D) x_t
      = c + cMA(theta(B)) cMA(Theta(B^m)) epsilon_t
    $,

    [
      $ cAR(Phi(B^m)) = 1 - cAR(Phi_1) B^m - dots - cAR(Phi_P) B^(P m) $
      $ cMA(Theta(B^m)) = 1 + cMA(Theta_1) B^m + dots + cMA(Theta_Q) B^(Q m) $

      Seasonal differencing $cDiff((1-B^m)) y_t = y_t - y_(t-m)$ removes annual/periodic patterns. Period $m$ (e.g., 12 for monthly).
    ],

    [
      *Parameters:*
      #cAR[$phi_1, ..., phi_p$, $Phi_1, ..., Phi_P$],
      #cMA[$theta_1, ..., theta_q$, $Theta_1, ..., Theta_Q$],
      $c$, $sigma^2$ \
      *Orders:* #cAR[$p$, $P$], #cDiff[$d$, $D$], #cMA[$q$, $Q$], $m$
    ],
  ),

  arima-cell(
    [$"SARIMAX"(p,d,q)(P,D,Q)_m$],
    [Seasonal ARIMA with exogenous regressors],

    $
      cAR(phi(B)) cAR(Phi(B^m)) cDiff((1-B)^d) cDiff((1-B^m)^D) y_t \
      = c + sum_(i=1)^k beta_i x_(i,t) + cMA(theta(B)) cMA(Theta(B^m)) epsilon_t
    $,

    [
      $y_t$ = endogenous (target) series
      $x_(i,t)$ = exogenous regressors, $i = 1, dots, k$
      $beta_i$ = regression coefficients on exogenous variables
      The $X$ adds linear regression on external predictors to SARIMA.
    ],

    [
      *Parameters:*
      #cAR[$phi_1, ..., phi_p$, $Phi_1, ..., Phi_P$],
      #cMA[$theta_1, ..., theta_q$, $Theta_1, ..., Theta_Q$],
      $beta_1, ..., beta_k$, $c$, $sigma^2$ \
      *Orders:* #cAR[$p$, $P$], #cDiff[$d$, $D$], #cMA[$q$, $Q$], $m$, $k$ (regressors)
    ],
  ),
)


== Multivariate (vector) models

For all models below, $bold(x)_t = (x_(1,t), ..., x_(K,t))^top in RR^K$
is a vector of $K$ jointly modeled time series. Operator coefficients
$bold(Phi)_i$ and $bold(Theta)_j$ are $K times K$ matrices, and
$bold(epsilon)_t$ is multivariate white noise with covariance matrix
$bold(Sigma) in RR^(K times K)$.

#grid(
  columns: 2,
  gutter: 8pt,

  arima-cell(
    [$"VAR"(p)$],
    [Vector autoregression],

    $ cAR(bold(Phi)(B)) bold(x)_t = bold(c) + bold(epsilon)_t $,

    [
      $ cAR(bold(Phi)(B)) = bold(I) - cAR(bold(Phi)_1) B - dots - cAR(bold(Phi)_p) B^p $
      i.e.,
      $
        bold(x)_t = bold(c) + cAR(bold(Phi)_1) bold(x)_(t-1) + dots + cAR(bold(Phi)_p) bold(x)_(t-p) + bold(epsilon)_t
      $
      Each component depends on $p$ lags of all $K$ series.
    ],

    [
      *Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$ ($K^2$ each)],
      $bold(c)$ ($K$), $bold(Sigma)$ ($K(K+1)\/2$) \
      *Orders:* #cAR[$p$], $K$ (series)
    ],
  ),

  arima-cell(
    [$"VMA"(q)$],
    [Vector moving average],

    $ bold(x)_t = bold(c) + cMA(bold(Theta)(B)) bold(epsilon)_t $,

    [
      $ cMA(bold(Theta)(B)) = bold(I) + cMA(bold(Theta)_1) B + dots + cMA(bold(Theta)_q) B^q $
      $
        "i.e., " bold(x)_t = bold(c) + bold(epsilon)_t + cMA(bold(Theta)_1) bold(epsilon)_(t-1) + dots + cMA(bold(Theta)_q) bold(epsilon)_(t-q)
      $
      Each component is a linear combination of past shocks across all series.
    ],

    [
      *Parameters:* #cMA[$bold(Theta)_1, ..., bold(Theta)_q$ ($K^2$ each)],
      $bold(c)$ ($K$), $bold(Sigma)$ ($K(K+1)\/2$) \
      *Orders:* #cMA[$q$], $K$ (series)
    ],
  ),

  arima-cell(
    [$"VARMA"(p,q)$],
    [Vector autoregressive moving average],

    $ cAR(bold(Phi)(B)) bold(x)_t = bold(c) + cMA(bold(Theta)(B)) bold(epsilon)_t $,

    [
      $ cAR(bold(Phi)(B)) = bold(I) - cAR(bold(Phi)_1) B - dots - cAR(bold(Phi)_p) B^p $
      $ cMA(bold(Theta)(B)) = bold(I) + cMA(bold(Theta)_1) B + dots + cMA(bold(Theta)_q) B^q $
      Vector analog of ARMA. Identifiability requires care (e.g., echelon forms).
    ],

    [
      *Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$], #cMA[$bold(Theta)_1, ..., bold(Theta)_q$],
      $bold(c)$, $bold(Sigma)$ \
      *Orders:* #cAR[$p$], #cMA[$q$], $K$
    ],
  ),

  arima-cell(
    [$"VARIMA"(p,d,q)$],
    [Vector ARIMA],

    $ cAR(bold(Phi)(B)) cDiff((1-B)^d) bold(x)_t = bold(c) + cMA(bold(Theta)(B)) bold(epsilon)_t $,

    [
      Differencing applied component-wise to each of the $K$ series. \
      In practice, cointegrated systems use VECM (Vector Error Correction) rather than VARIMA — VECM models the long-run equilibrium directly.
    ],

    [
      *Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$], #cMA[$bold(Theta)_1, ..., bold(Theta)_q$],
      $bold(c)$, $bold(Sigma)$ \
      *Orders:* #cAR[$p$], #cDiff[$d$], #cMA[$q$], $K$
    ],
  ),

  arima-cell(
    [$"VARIMAX"(p,d,q)$],
    [Vector ARIMA with exogenous regressors],

    $ cAR(bold(Phi)(B)) cDiff((1-B)^d) bold(y)_t = bold(c) + bold(B) bold(x)_t + cMA(bold(Theta)(B)) bold(epsilon)_t $,

    [
      $bold(y)_t in RR^K$ = endogenous vector series \
      $bold(x)_t in RR^k$ = exogenous regressor vector \
      $bold(B) in RR^(K times k)$ = matrix of regression coefficients \
      Each of the $K$ series can depend on the same set of $k$ exogenous variables.
    ],

    [
      *Parameters:* #cAR[$bold(Phi)_1, ..., bold(Phi)_p$], #cMA[$bold(Theta)_1, ..., bold(Theta)_q$],
      $bold(B)$ ($K times k$), $bold(c)$, $bold(Sigma)$ \
      *Orders:* #cAR[$p$], #cDiff[$d$], #cMA[$q$], $K$, $k$ (regressors)
    ],
  ),
)
