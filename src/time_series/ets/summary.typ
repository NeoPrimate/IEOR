#import "/lib/imports.typ": *

#set list(marker: [·])

// =============================================================
// ETS taxonomy — all 30 models, INNOVATIONS STATE SPACE form
// Color scheme: level / trend / seasonality (3 components)
// Notation: Hyndman (l, b, s, m). Error epsilon_t in black.
// =============================================================

// ----- Setup (place once near the top of your document) -----
#let level-color = rgb("#2E7D32")
#let trend-color = rgb("#1565C0")
#let season-color = rgb("#C62828")

#let cL(body) = text(fill: level-color, body)
#let cT(body) = text(fill: trend-color, body)
#let cS(body) = text(fill: season-color, body)

#let component-legend = box(inset: 4pt)[
  #cL[■ level $l_t$] #h(1em)
  #cT[■ trend $b_t$] #h(1em)
  #cS[■ seasonality $s_t$]
]

#let ets-cell(title, subtitle, observation, equations) = block(
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
    observation
    v(2pt)
    align(center, line(length: 50%, stroke: 0.3pt + luma(220)))
    v(2pt)
    equations
  },
)


// =============================================================
// SECTION
// =============================================================

= ETS taxonomy (state space form)

#component-legend


Each model has an _observation equation_ (top, separated by a line) and
_state equations_ for each component plus a point-forecast formula.
$epsilon_t$ is the one-step-ahead innovation, assumed mean zero.
$m$ is the seasonal period.
$m_h^+ = ((h-1) mod m) + 1$ picks the appropriate seasonal index for an
$h$-step-ahead forecast.
Damped models use $phi in (0, 1)$. Smoothing parameters
$alpha, beta, gamma in (0, 1)$.

Every one of the 30 cells gives you the same two-step pattern:
1. Compute the innovation from the observation equation, solving for $epsilon_t$:
- Additive errors: $epsilon_t = x_t - mu_t$
- Multiplicative errors: $epsilon_t = (x_t - mu_t) / mu_t$
where $mu_t$ is whatever the observation equation says $x_t$ equals when $epsilon_t = 0$ (i.e., the conditional mean).
2. Update the states by plugging $epsilon_t$ into the state equations.

That's it. The same loop works for all 30 models — only the specific formulas for $mu_t$ and the state updates change.

- *Error (E)*:
  - Additive (A)
  - Multiplicative (M)
- *Trend (T)*:
  - None (N)
  - Additive (A)
  - Additive damped (Ad)
  - Multiplicative (M)
  - Multiplicative damped (Md)
- *Seasonal (S)*:
  - None (N)
  - Additive (A)
  - Multiplicative (M)


== Trend = N (no trend)

#grid(
  columns: 2,
  gutter: 8pt,

  ets-cell([ETS(A,N,N)], [Simple exponential smoothing], $ x_t = cL(l_(t-1)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t $
    $ hat(x)_(t+h | t) = cL(l_t) $
  ]),

  ets-cell([ETS(M,N,N)], [SES, multiplicative errors], $ x_t = cL(l_(t-1)) (1 + epsilon_t) $, [
    $ cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t) $
    $ hat(x)_(t+h | t) = cL(l_t) $
  ]),

  ets-cell([ETS(A,N,A)], [SES + additive seasonality], $ x_t = cL(l_(t-1)) + cS(s_(t-m)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t $
    $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
    $ hat(x)_(t+h | t) = cL(l_t) + cS(s_(t+h-m_h^+)) $
  ]),

  ets-cell(
    [ETS(M,N,A)],
    [SES + add. seasonality, mult. errors],
    $ x_t = (cL(l_(t-1)) + cS(s_(t-m))) (1 + epsilon_t) $,
    [
      $ cL(l_t) = cL(l_(t-1)) + alpha (cL(l_(t-1)) + cS(s_(t-m))) epsilon_t $
      $ cS(s_t) = cS(s_(t-m)) + gamma (cL(l_(t-1)) + cS(s_(t-m))) epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) + cS(s_(t+h-m_h^+)) $
    ],
  ),

  ets-cell([ETS(A,N,M)], [SES + multiplicative seasonality], $ x_t = cL(l_(t-1)) cS(s_(t-m)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + alpha epsilon_t \/ cS(s_(t-m)) $
    $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ cL(l_(t-1)) $
    $ hat(x)_(t+h | t) = cL(l_t) cS(s_(t+h-m_h^+)) $
  ]),

  ets-cell([ETS(M,N,M)], [SES + mult. seasonality and errors], $ x_t = cL(l_(t-1)) cS(s_(t-m)) (1 + epsilon_t) $, [
    $ cL(l_t) = cL(l_(t-1)) (1 + alpha epsilon_t) $
    $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
    $ hat(x)_(t+h | t) = cL(l_t) cS(s_(t+h-m_h^+)) $
  ]),
)


== Trend = A (additive trend)

#grid(
  columns: 2,
  gutter: 8pt,

  ets-cell([ETS(A,A,N)], [Holt's linear trend], $ x_t = cL(l_(t-1)) + cT(b_(t-1)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha epsilon_t $
    $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t $
    $ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) $
  ]),

  ets-cell(
    [ETS(M,A,N)],
    [Holt's linear, multiplicative errors],
    $ x_t = (cL(l_(t-1)) + cT(b_(t-1))) (1 + epsilon_t) $,
    [
      $ cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t) $
      $ cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) $
    ],
  ),

  ets-cell([ETS(A,A,A)], [Additive Holt-Winters], $ x_t = cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha epsilon_t $
    $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t $
    $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
    $ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) + cS(s_(t+h-m_h^+)) $
  ]),

  ets-cell(
    [ETS(M,A,A)],
    [Additive HW, multiplicative errors],
    $ x_t = (cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m))) (1 + epsilon_t) $,
    [
      $ cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha mu_t epsilon_t $
      $ cT(b_t) = cT(b_(t-1)) + beta mu_t epsilon_t $
      $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) + h cT(b_t) + cS(s_(t+h-m_h^+)) $
      $ "where " mu_t = cL(l_(t-1)) + cT(b_(t-1)) + cS(s_(t-m)) $
    ],
  ),

  ets-cell([ETS(A,A,M)], [HW with mult. seasonality], $ x_t = (cL(l_(t-1)) + cT(b_(t-1))) cS(s_(t-m)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + cT(b_(t-1)) + alpha epsilon_t \/ cS(s_(t-m)) $
    $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ cS(s_(t-m)) $
    $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) + cT(b_(t-1))) $
    $ hat(x)_(t+h | t) = (cL(l_t) + h cT(b_t)) cS(s_(t+h-m_h^+)) $
  ]),

  ets-cell(
    [ETS(M,A,M)],
    [Multiplicative Holt-Winters],
    $ x_t = (cL(l_(t-1)) + cT(b_(t-1))) cS(s_(t-m)) (1 + epsilon_t) $,
    [
      $ cL(l_t) = (cL(l_(t-1)) + cT(b_(t-1))) (1 + alpha epsilon_t) $
      $ cT(b_t) = cT(b_(t-1)) + beta (cL(l_(t-1)) + cT(b_(t-1))) epsilon_t $
      $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
      $ hat(x)_(t+h | t) = (cL(l_t) + h cT(b_t)) cS(s_(t+h-m_h^+)) $
    ],
  ),
)


== Trend = Ad (damped additive trend)

#grid(
  columns: 2,
  gutter: 8pt,

  ets-cell([ETS(A,Ad,N)], [Damped linear trend], $ x_t = cL(l_(t-1)) + cT(phi b_(t-1)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha epsilon_t $
    $ cT(b_t) = cT(phi b_(t-1)) + beta epsilon_t $
    $ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) $
  ]),

  ets-cell([ETS(M,Ad,N)], [Damped linear, mult. errors], $ x_t = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + epsilon_t) $, [
    $ cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t) $
    $ cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t $
    $ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) $
  ]),

  ets-cell(
    [ETS(A,Ad,A)],
    [Damped additive Holt-Winters],
    $ x_t = cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m)) + epsilon_t $,
    [
      $ cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha epsilon_t $
      $ cT(b_t) = cT(phi b_(t-1)) + beta epsilon_t $
      $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) + cS(s_(t+h-m_h^+)) $
    ],
  ),

  ets-cell(
    [ETS(M,Ad,A)],
    [Damped additive HW, mult. errors],
    $ x_t = (cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m))) (1 + epsilon_t) $,
    [
      $ cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha mu_t epsilon_t $
      $ cT(b_t) = cT(phi b_(t-1)) + beta mu_t epsilon_t $
      $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t) + cS(s_(t+h-m_h^+)) $
      $ "where " mu_t = cL(l_(t-1)) + cT(phi b_(t-1)) + cS(s_(t-m)) $
    ],
  ),

  ets-cell(
    [ETS(A,Ad,M)],
    [Damped HW, mult. seasonality],
    $ x_t = (cL(l_(t-1)) + cT(phi b_(t-1))) cS(s_(t-m)) + epsilon_t $,
    [
      $ cL(l_t) = cL(l_(t-1)) + cT(phi b_(t-1)) + alpha epsilon_t \/ cS(s_(t-m)) $
      $ cT(b_t) = cT(phi b_(t-1)) + beta epsilon_t \/ cS(s_(t-m)) $
      $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) + cT(phi b_(t-1))) $
      $ hat(x)_(t+h | t) = (cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t)) cS(s_(t+h-m_h^+)) $
    ],
  ),

  ets-cell(
    [ETS(M,Ad,M)],
    [Damped multiplicative Holt-Winters],
    $ x_t = (cL(l_(t-1)) + cT(phi b_(t-1))) cS(s_(t-m)) (1 + epsilon_t) $,
    [
      $ cL(l_t) = (cL(l_(t-1)) + cT(phi b_(t-1))) (1 + alpha epsilon_t) $
      $ cT(b_t) = cT(phi b_(t-1)) + beta (cL(l_(t-1)) + cT(phi b_(t-1))) epsilon_t $
      $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
      $ hat(x)_(t+h | t) = (cL(l_t) + cT((phi + phi^2 + dots + phi^h) b_t)) cS(s_(t+h-m_h^+)) $
    ],
  ),
)


== Trend = M (multiplicative trend)

#grid(
  columns: 2,
  gutter: 8pt,

  ets-cell([ETS(A,M,N)], [Multiplicative trend], $ x_t = cL(l_(t-1)) cT(b_(t-1)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha epsilon_t $
    $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ cL(l_(t-1)) $
    $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) $
  ]),

  ets-cell([ETS(M,M,N)], [Mult. trend, mult. errors], $ x_t = cL(l_(t-1)) cT(b_(t-1)) (1 + epsilon_t) $, [
    $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) (1 + alpha epsilon_t) $
    $ cT(b_t) = cT(b_(t-1)) (1 + beta epsilon_t) $
    $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) $
  ]),

  ets-cell(
    [ETS(A,M,A)],
    [Mult. trend, additive seasonality],
    $ x_t = cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m)) + epsilon_t $,
    [
      $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha epsilon_t $
      $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ cL(l_(t-1)) $
      $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) + cS(s_(t+h-m_h^+)) $
    ],
  ),

  ets-cell(
    [ETS(M,M,A)],
    [Mult. trend + add. season., mult. errors],
    $ x_t = (cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m))) (1 + epsilon_t) $,
    [
      $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha mu_t epsilon_t $
      $ cT(b_t) = cT(b_(t-1)) + beta mu_t epsilon_t \/ cL(l_(t-1)) $
      $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) + cS(s_(t+h-m_h^+)) $
      $ "where " mu_t = cL(l_(t-1)) cT(b_(t-1)) + cS(s_(t-m)) $
    ],
  ),

  ets-cell([ETS(A,M,M)], [Mult. trend, mult. seasonality], $ x_t = cL(l_(t-1)) cT(b_(t-1)) cS(s_(t-m)) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) + alpha epsilon_t \/ cS(s_(t-m)) $
    $ cT(b_t) = cT(b_(t-1)) + beta epsilon_t \/ (cL(l_(t-1)) cS(s_(t-m))) $
    $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) cT(b_(t-1))) $
    $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) cS(s_(t+h-m_h^+)) $
  ]),

  ets-cell([ETS(M,M,M)], [Fully multiplicative], $ x_t = cL(l_(t-1)) cT(b_(t-1)) cS(s_(t-m)) (1 + epsilon_t) $, [
    $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)) (1 + alpha epsilon_t) $
    $ cT(b_t) = cT(b_(t-1)) (1 + beta epsilon_t) $
    $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
    $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^h) cS(s_(t+h-m_h^+)) $
  ]),
)


== Trend = Md (damped multiplicative trend)

#grid(
  columns: 2,
  gutter: 8pt,

  ets-cell([ETS(A,Md,N)], [Damped multiplicative trend], $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) + epsilon_t $, [
    $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t $
    $ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1)) $
    $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) $
  ]),

  ets-cell([ETS(M,Md,N)], [Damped mult. trend, mult. errors], $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + epsilon_t) $, [
    $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + alpha epsilon_t) $
    $ cT(b_t) = cT(b_(t-1)^phi) (1 + beta epsilon_t) $
    $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) $
  ]),

  ets-cell(
    [ETS(A,Md,A)],
    [Damped mult. trend, add. seasonality],
    $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) + epsilon_t $,
    [
      $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t $
      $ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ cL(l_(t-1)) $
      $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) + cS(s_(t+h-m_h^+)) $
    ],
  ),

  ets-cell(
    [ETS(M,Md,A)],
    [Damped mult. trend + add. season., mult. errors],
    $ x_t = (cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m))) (1 + epsilon_t) $,
    [
      $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha mu_t epsilon_t $
      $ cT(b_t) = cT(b_(t-1)^phi) + beta mu_t epsilon_t \/ cL(l_(t-1)) $
      $ cS(s_t) = cS(s_(t-m)) + gamma mu_t epsilon_t $
      $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) + cS(s_(t+h-m_h^+)) $
      $ "where " mu_t = cL(l_(t-1)) cT(b_(t-1)^phi) + cS(s_(t-m)) $
    ],
  ),

  ets-cell(
    [ETS(A,Md,M)],
    [Damped mult. trend, mult. seasonality],
    $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) cS(s_(t-m)) + epsilon_t $,
    [
      $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) + alpha epsilon_t \/ cS(s_(t-m)) $
      $ cT(b_t) = cT(b_(t-1)^phi) + beta epsilon_t \/ (cL(l_(t-1)) cS(s_(t-m))) $
      $ cS(s_t) = cS(s_(t-m)) + gamma epsilon_t \/ (cL(l_(t-1)) cT(b_(t-1)^phi)) $
      $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) cS(s_(t+h-m_h^+)) $
    ],
  ),

  ets-cell(
    [ETS(M,Md,M)],
    [Fully multiplicative with damped trend],
    $ x_t = cL(l_(t-1)) cT(b_(t-1)^phi) cS(s_(t-m)) (1 + epsilon_t) $,
    [
      $ cL(l_t) = cL(l_(t-1)) cT(b_(t-1)^phi) (1 + alpha epsilon_t) $
      $ cT(b_t) = cT(b_(t-1)^phi) (1 + beta epsilon_t) $
      $ cS(s_t) = cS(s_(t-m)) (1 + gamma epsilon_t) $
      $ hat(x)_(t+h | t) = cL(l_t) cT(b_t^(phi + phi^2 + dots + phi^h)) cS(s_(t+h-m_h^+)) $
    ],
  ),
)


#table(
  columns: 2,
  [*Model*], [*Name*],

  // Additive errors, no trend
  [ETS(A,N,N)], [Simple exponential smoothing],
  [ETS(A,N,A)], [SES with additive seasonality],
  [ETS(A,N,M)], [SES with multiplicative seasonality],

  // Additive errors, additive trend
  [ETS(A,A,N)], [Holt's linear trend],
  [ETS(A,A,A)], [Additive Holt-Winters],
  [ETS(A,A,M)], [Holt-Winters with multiplicative seasonality],

  // Additive errors, damped additive trend
  [ETS(A,Ad,N)], [Damped linear trend],
  [ETS(A,Ad,A)], [Damped additive Holt-Winters],
  [ETS(A,Ad,M)], [Damped Holt-Winters with multiplicative seasonality],

  // Additive errors, multiplicative trend
  [ETS(A,M,N)], [Multiplicative trend],
  [ETS(A,M,A)], [Multiplicative trend with additive seasonality],
  [ETS(A,M,M)], [Multiplicative trend and seasonality],

  // Additive errors, damped multiplicative trend
  [ETS(A,Md,N)], [Damped multiplicative trend],
  [ETS(A,Md,A)], [Damped multiplicative trend with additive seasonality],
  [ETS(A,Md,M)], [Damped multiplicative trend and seasonality],

  // Multiplicative errors, no trend
  [ETS(M,N,N)], [SES with multiplicative errors],
  [ETS(M,N,A)], [SES with additive seasonality, multiplicative errors],
  [ETS(M,N,M)], [SES with multiplicative seasonality and errors],

  // Multiplicative errors, additive trend
  [ETS(M,A,N)], [Holt's linear trend with multiplicative errors],
  [ETS(M,A,A)], [Additive Holt-Winters with multiplicative errors],
  [ETS(M,A,M)], [Multiplicative Holt-Winters],

  // Multiplicative errors, damped additive trend
  [ETS(M,Ad,N)], [Damped linear trend with multiplicative errors],
  [ETS(M,Ad,A)], [Damped additive Holt-Winters with multiplicative errors],
  [ETS(M,Ad,M)], [Damped multiplicative Holt-Winters],

  // Multiplicative errors, multiplicative trend
  [ETS(M,M,N)], [Multiplicative trend with multiplicative errors],
  [ETS(M,M,A)], [Multiplicative trend, additive seasonality, multiplicative errors],
  [ETS(M,M,M)], [Fully multiplicative],

  // Multiplicative errors, damped multiplicative trend
  [ETS(M,Md,N)], [Damped multiplicative trend with multiplicative errors],
  [ETS(M,Md,A)], [Damped multiplicative trend, additive seasonality, mult. errors],
  [ETS(M,Md,M)], [Fully multiplicative with damped trend],
)




// ============ Component colours ============
// Each ETS component (Level, Trend, additive Seasonality, multiplicative Seasonality) has its
// own colour. When a model adds a new component on top of a previous one, the new pieces are
// highlighted in that component's colour so the build-up is visible at a glance.
#let Lc = rgb("#6F5AC9")  // Level — purple
#let Tc = rgb("#1D9E75")  // Trend — green
#let Sac = rgb("#D4537E") // Seasonality (additive) — pink
#let Smc = rgb("#D85A30") // Seasonality (multiplicative) — orange

#let Lbg = Lc.lighten(88%)
#let Tbg = Tc.lighten(88%)
#let Sabg = Sac.lighten(88%)
#let Smbg = Smc.lighten(88%)

// Inline highlights — wrap a token in a pale-coloured box.
#let hL(body) = box(fill: Lbg, outset: (y: 2pt), inset: (x: 2pt), radius: 2pt, body)
#let hT(body) = box(fill: Tbg, outset: (y: 2pt), inset: (x: 2pt), radius: 2pt, body)
#let hSa(body) = box(fill: Sabg, outset: (y: 2pt), inset: (x: 2pt), radius: 2pt, body)
#let hSm(body) = box(fill: Smbg, outset: (y: 2pt), inset: (x: 2pt), radius: 2pt, body)

// Whole-equation wrappers — colour the entire equation as belonging to one component.
#let eqL(body) = block(fill: Lbg, inset: 5pt, radius: 3pt, width: 100%, body)
#let eqT(body) = block(fill: Tbg, inset: 5pt, radius: 3pt, width: 100%, body)
#let eqSa(body) = block(fill: Sabg, inset: 5pt, radius: 3pt, width: 100%, body)
#let eqSm(body) = block(fill: Smbg, inset: 5pt, radius: 3pt, width: 100%, body)

// Edge-label and blob helpers for the build-up diagram.
#let elabel(body) = box(fill: white, inset: (x: 3pt, y: 1pt), text(size: 8pt, body))
#let assumes(body) = align(center)[
  #text(size: 7pt, fill: luma(40%))[_Assumes:_ #body, $e_t tilde "iid"(0, sigma^2)$]
]
#let blob(pos, label, ..args) = node(
  pos,
  box(width: 78mm, label),
  fill: white,
  stroke: 0.75pt + luma(50%),
  corner-radius: 5pt,
  inset: 8pt,
  ..args,
)

== ETS (Exponential Smoothing)

ETS stands for *Error, Trend, Seasonality* — a family of forecasting models that decomposes a time series into up to three components and updates each one recursively from new observations.

=== The weighting-scheme axis

Before exponential smoothing, ask: *how much should past observations count?* Two extremes and two interpolators:

#align(center)[
  #block(
    stroke: 0.5pt + luma(60%),
    radius: 4pt,
    inset: 10pt,
    width: 95%,
  )[
    #set text(size: 9pt)
    #grid(
      columns: 4,
      inset: 7.5pt,
      align: center + horizon,

      [*Naïve*], [*Moving average*], [*SES*], [*Cumulative*],

      [_Only the last point matters_],
      [_Last $M$ points, equal weight_],
      [_All history, geometric decay_],
      [_All history, equal weight_],

      [$ hat(x)_(t, t+1) = x_t $],
      [$ hat(x)_(t, t+1) = 1/M sum_(i=t-M+1)^t x_i $],
      [$ hat(x)_(t, t+1) = alpha sum_(i=0)^t (1-alpha)^i x_(t-i) $],
      [$ hat(x)_(t, t+1) = 1/t sum_(i=1)^t x_i $],

      [#text(size: 7pt)[Weights: $(1, 0, 0, ..., 0)$]],
      [#text(size: 7pt)[Weights: $(1/M, ..., 1/M, 0, ..., 0)$]],
      [#text(size: 7pt)[Weights: $alpha, alpha(1-alpha), alpha(1-alpha)^2, ...$]],
      [#text(size: 7pt)[Weights: $(1/t, 1/t, ..., 1/t)$]],
    )

    #v(0.3em)
    #text(size: 8pt)[
      Naïve ($M = 1$) and Cumulative ($M = t$) are the two extremes of a single "how much history counts" axis. MA sits between them with a finite equal-weight window; SES sits between them with infinite geometrically-decaying weights. *The rest of this section builds on SES.*
    ]
  ]
]

