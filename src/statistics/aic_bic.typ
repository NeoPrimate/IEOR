#import "/lib/imports.typ": *
#show: formatting

Picking between competing models

Maximized likelihood

== AIC

$
  "AIC" = underbrace(2k, "penalty term") − underbrace(2 dot ln(hat(L)), "fit term")
$

- $k$: number of parameters in the model
- $n$: number of data points 

#lq.diagram(
  width: 4cm, height: 4cm,
  xlabel: $k$,
  ylabel: $hat(L)$,
  lq.colormesh(
    lq.linspace(0.001, 5, num: 60),
    lq.linspace(0.001, 5, num: 60),
    (k, L) => 2 * k - 2 * calc.ln(L),
    map: color.map.icefire,
    interpolation: "smooth"
  )
)

== BIC

$
  "BIC" = underbrace(k dot ln(n), "penalty term") − underbrace(2 dot ln(hat(L)), "fit term")
$

- $k$: number of parameters in the model
- $n$: number of data points 

#grid(
  columns: 2,
  inset: 1em,
  align: center + horizon,
  [
    #lq.diagram(
      width: 4cm, height: 4cm,
      xlabel: $k$,
      ylabel: $hat(L)$,
      lq.colormesh(
        lq.linspace(0.001, 5, num: 60),   // k
        lq.linspace(0.001, 5, num: 60),   // L
        (k, L) => k * calc.ln(100) - 2 * calc.ln(L),
        map: color.map.icefire,
        interpolation: "smooth"
      )
    )

    Fix $n$, plot over $k$ and $hat(L)$
  ],
  [
    #lq.diagram(
      width: 4cm, height: 4cm,
      xlabel: $k$,
      ylabel: $n$,
      lq.colormesh(
        lq.linspace(0.001, 5, num: 60),   // k
        lq.linspace(2, 200, num: 60),     // n
        (k, n) => k * calc.ln(n),         // pure penalty, since 2*ln(1)=0
        map: color.map.icefire,
        interpolation: "smooth"
      )
    )

    Fix $hat(L)$, plot over $k$ and $n$
  ]
)
)


Explanation: 
- The fit term, $−2 dot ln(L)$, is identical in both (Better fit $arrow$ bigger L̂ $arrow$ bigger ln(L̂) $arrow$ this term goes down $arrow$ criterion goes down
- The penalty term is the only difference:
  - AIC charges 2 per parameter
  - BIC charges ln(n) per parameter

#example[
  You have n = 100 data points and two candidate models for them:

  - Model A (simpler): k = 3 parameters, maximized log-likelihood ln(L̂) = −120
  - Model B (fancier): k = 6 parameters, maximized log-likelihood ln(L̂) = −116

  Model B fits better — its log-likelihood is higher (−116 > −120), which it should be, since it has more parameters to play with. The whole question is whether those 3 extra parameters are worth it.

  *AIC* $2k − 2·ln(hat(L))$

  - Model A:  2·3  − 2·(−120) =  6 + 240 = 246
  - Model B:  2·6  − 2·(−116) = 12 + 232 = 244

  AIC picks Model B (244 < 246)

  *BIC* $k dot ln(n) − 2·ln(hat(L))$

  - Model A:  3·4.6 − 2·(−120) = 13.8 + 240 = 253.8
  - Model B:  6·4.6 − 2·(−116) = 27.6 + 232 = 259.6

  BIC picks Model A (253.8 < 259.6)

  Same data, same two models, opposite verdicts. Here's the why, and it's exactly that per-parameter cost from before:
  Going from A to B, the fit term drops by 8 (from 240 to 232) — that's the reward for the better fit. The 3 extra parameters cost you:

  BIC charges more per parameter (because ln(100) > 2), so it demands a bigger fit improvement before it'll accept extra complexity.
  That's why it leans toward simpler models.
]

