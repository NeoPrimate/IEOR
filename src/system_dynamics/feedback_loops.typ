#import "/lib/imports.typ": *

Closed causal chains where an effect comes back to influence its cause. The engine of dynamic behavior in #link(<system-dynamics-system-dynamics>)[system dynamics].

== Two types

*Reinforcing loops* (R, positive feedback): the loop *amplifies* changes. Math: $dot x = k x$ with $k > 0$. Solution: exponential growth $x(t) = x_0 e^(k t)$.

*Balancing loops* (B, negative feedback): the loop *resists* changes. Math: $dot x = -k x + k x^*$ with $k > 0$. Solution: exponential approach to target $x^*$ with time constant $1/k$.

== Behavior patterns

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Loop structure], [Behavior], [Example]),
  [Pure reinforcing], [Exponential growth/collapse], [Compound interest, viral spread],
  [Pure balancing], [Goal-seeking to steady state], [Thermostat, predator-prey equilibrium],
  [R + B (limit)], [S-curve (logistic)], [Market penetration, learning curves],
  [Two B with delay], [Oscillation (damped or sustained)], [Inventory cycles, beer game],
  [R + B unstable], [Overshoot and collapse], [Resource depletion],
)

== First-order behavior

*Reinforcing* ($dot x = g x$):
$
  x(t) = x_0 e^(g t)
$
- Doubling time: $T_2 = ln(2) / g approx 0.69 / g$
- Halving time (if $g < 0$): same formula, opposite sign

*Balancing* ($dot x = (x^* - x) / tau$):
$
  x(t) = x^* + (x_0 - x^*) e^(-t/tau)
$
- Time constant $tau$: time to reach $63%$ of the way to $x^*$
- Settling time (within 5%): $approx 3 tau$
- Settling time (within 1%): $approx 5 tau$

== Combined loops: limits to growth

Reinforcing growth ($dot x = g x$) plus balancing loop tied to capacity $K$:

$
  dot x = r x (1 - x/K) #h(1em) "(logistic growth)"
$

Initially R dominates → exponential growth. As $x → K$, the balancing factor $(1 - x/K)$ shrinks $dot x$. Asymptote: $x → K$. S-curve.

See #link(<system-dynamics-logistic-growth>)[Logistic Growth].

== Second-order: oscillation

A loop with *delays* produces oscillation. Simple example: $dot dot x + 2 zeta omega dot x + omega^2 x = 0$ (damped harmonic oscillator).

#table(
  columns: 3,
  align: (center, center, left),
  stroke: none,
  table.header([Damping $zeta$], [Behavior], [Pattern]),
  [$0$], [Sustained oscillation], [sine wave],
  [$0 < zeta < 1$], [Damped oscillation], [decaying sine],
  [$zeta = 1$], [Critical damping], [smoothest approach],
  [$zeta > 1$], [Over-damped], [no oscillation, slow approach],
)

== Why feedback loops matter

Most "surprising" system behavior comes from feedback:

- *Bullwhip in supply chains*: balancing loops with delays amplify variance
- *Boom-and-bust cycles*: capacity adjustment delays
- *Population dynamics*: birth/death feedbacks
- *Climate*: ice-albedo, methane release reinforcing loops; weathering balancing loops

Without feedback, a system can't generate dynamic patterns; it's just open-loop input → output.

== Identifying loops in a system

1. List variables and how they affect each other
2. Trace cycles in the diagram
3. Compute polarity of each cycle (R or B)
4. Identify dominant loops in each behavior phase

The same model can have R-dominant phase (early growth) and B-dominant phase (saturation).

== See also

- *#link(<system-dynamics-causal-loop-diagrams>)[Causal Loop Diagrams]*
- *#link(<system-dynamics-stocks-flows>)[Stocks and Flows]*
- *#link(<system-dynamics-logistic-growth>)[Logistic Growth]*
- *#link(<system-dynamics-system-dynamics>)[System Dynamics]*
