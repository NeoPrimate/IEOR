#import "/lib/imports.typ": *

A two-stock system with delay between input and output. The classic *oscillator* structure in #link(<system-dynamics-system-dynamics>)[system dynamics].

== Generic equation

$
  dot dot x + 2 zeta omega_n dot x + omega_n^2 x = omega_n^2 x^*
$

where:
- $omega_n$: *natural frequency* (radians/time)
- $zeta$: *damping ratio* (dimensionless)
- $x^*$: target / equilibrium

== Behavior by $zeta$

#table(
  columns: 3,
  align: (center, left, left),
  stroke: none,
  table.header([$zeta$], [Type], [Behavior]),
  [$0$], [Undamped], [Pure sinusoidal oscillation, no decay],
  [$0 < zeta < 1$], [Underdamped], [Decaying oscillation],
  [$zeta = 1$], [Critically damped], [Smoothest non-oscillatory approach],
  [$zeta > 1$], [Overdamped], [Slow non-oscillatory approach],
)

== Damped frequency and period

For underdamped systems:

$
  omega_d = omega_n sqrt(1 - zeta^2) #h(1em) ("damped frequency")
$

$
  T_d = 2 pi / omega_d #h(1em) ("period of oscillation")
$

== Where 2nd-order systems arise

Whenever a balancing loop has a *delay* equal to (or exceeding) the loop's time constant:

- *Inventory control with order delay*: targeting inventory level via delayed orders
- *Production-inventory*: production responds to inventory gap with lead time
- *Workforce*: hiring decisions based on delayed performance signals
- *Predator-prey*: population responds to delayed food availability

== Beer game equations as 2nd-order

In the Sterman beer game model, each echelon's order rate depends on:
- Current inventory gap
- *Delayed* perception of demand
- Delayed shipments from upstream

Combining gives a 2nd-order ODE in inventory and orders → oscillation visible in real beer-game data and field supply chains.

== Stability via Routh-Hurwitz

For a 2nd-order linear system $a dot dot x + b dot x + c x = 0$, stable iff $a, b, c$ all have the same sign (Routh-Hurwitz criterion). For SD systems, $a > 0$ typically; need $b > 0$ (damping) and $c > 0$ (restoring force) for stability.

Linearization around a fixed point gives this form locally; eigenvalues of the Jacobian determine stability.

== See also

- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]* — 1st-order foundations
- *#link(<system-dynamics-delays>)[Delays]* — what creates oscillation
- *#link(<system-dynamics-phase-plane>)[Phase Plane]* — visualization
- *#link(<system-dynamics-beer-game>)[Beer Game]* — application
