#import "/lib/imports.typ": *

The simplest *limits-to-growth* model. A population (or any quantity) grows exponentially when small, then saturates as it approaches a *carrying capacity* $K$.

== Model

$
  dot N = r N (1 - N/K)
$

- $r$: intrinsic growth rate (per unit time)
- $K$: carrying capacity (max sustainable level)
- $N$: current level

== Closed-form solution

$
  N(t) = K / (1 + A e^(-r t)), #h(1em) A = (K - N_0) / N_0
$

S-curve from $N_0$ asymptoting to $K$.

== Phases

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Phase], [Behavior], [Where you are]),
  [Exponential], [$dot N approx r N$], [$N << K$, factor $(1 - N/K) approx 1$],
  [Inflection], [$dot N$ peaks], [$N = K/2$, maximum growth rate],
  [Saturation], [$dot N$ decays], [$N -> K$, growth tapers off],
)

== Structurally

Reinforcing growth ($dot N = r N$) plus balancing limit ($1 - N/K$). The R+B = S-curve archetype.

== Where it shows up

- *Population biology*: limited food supply, predation
- *Bacterial growth*: nutrient depletion
- *Market penetration*: saturating consumer base
- *Technology adoption*: total addressable market
- *Renewable resources* under harvest: $dot R = r R (1 - R/K) - h R$ (logistic + harvest)
- *Tumor growth* (Gompertz model is a variant)

== Limitations

- *Symmetric*: growth and saturation phases are mirror images — real systems often asymmetric
- *Static $K$*: real carrying capacities change (technology, environment)
- *No overshoot*: real systems often overshoot $K$ then collapse — see #link(<system-dynamics-feedback-loops>)[oscillation / collapse archetypes]

== Compared to Bass diffusion

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Logistic*], [*#link(<system-dynamics-bass-diffusion>)[Bass]*]),
  [Initial growth], [Exponential ($r N$)], [Innovation rate ($p N$, constant)],
  [Driver], [Word-of-mouth only ($r$ effectively combines)], [Innovation + imitation separately],
  [Use case], [Pure peer-driven growth], [New product with external + internal drivers],
)

Bass is logistic-like but separates the two drivers — better for marketing analysis.

== Parameter estimation

Given time-series data $(t_i, N_i)$:

1. Plot $N(t)$ — confirm S-shape
2. Estimate $K$ from asymptote (or as a parameter to fit)
3. Linearize: $ln(K - N) - ln N = ln A - r t$, fit a line; slope $= -r$, intercept $= ln A$

Or just nonlinear-least-squares fit the closed form.

== See also

- *#link(<system-dynamics-bass-diffusion>)[Bass Diffusion]* — refinement
- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]* — the R+B archetype
- *#link(<calculus-differential-equations>)[Differential Equations]* — the parent topic
