#import "/lib/imports.typ": *
#show: formatting

Methods for *numerically integrating* the ODEs of a #link(<system-dynamics-system-dynamics>)[system-dynamics] model. Critical for simulation accuracy.

== Euler method (default for SD)

$
  S_(t + Delta t) = S_t + Delta t dot (text("net flow"_t))
$

Forward Euler. Simple, fast, error per step $O(Delta t^2)$, total error $O(Delta t)$.

For SD models, Euler with a small enough $Delta t$ is usually good enough.

== Time step ($Delta t$) selection rule

$
  Delta t <= min(tau_i) / 4
$

where $tau_i$ are the time constants of the system. Rule of thumb: divide the *fastest* time constant by 4-10.

Why? At $Delta t = tau / 4$, Euler captures the dominant time scale; faster than that, all time scales are well-resolved.

== Runge-Kutta 2 (RK2 / midpoint)

$
  k_1 = f(S_t, t)
$

$
  k_2 = f(S_t + (Delta t / 2) k_1, t + Delta t / 2)
$

$
  S_(t + Delta t) = S_t + Delta t dot k_2
$

Error per step $O(Delta t^3)$, total $O(Delta t^2)$. Twice the work of Euler per step, better accuracy.

== Runge-Kutta 4 (RK4)

The "classical" RK4:

$
  k_1 = f(S_t, t)
$

$
  k_2 = f(S_t + (Delta t / 2) k_1, t + Delta t / 2)
$

$
  k_3 = f(S_t + (Delta t / 2) k_2, t + Delta t / 2)
$

$
  k_4 = f(S_t + Delta t dot k_3, t + Delta t)
$

$
  S_(t + Delta t) = S_t + (Delta t / 6) (k_1 + 2 k_2 + 2 k_3 + k_4)
$

Error per step $O(Delta t^5)$, total $O(Delta t^4)$. Four times the work per step, much higher accuracy.

== Which to use?

#table(
  columns: 4,
  align: (left, center, center, left),
  stroke: none,
  table.header([Method], [Per-step cost], [Per-step error], [Best for]),
  [Euler], [1 eval], [$O(Delta t^2)$], [Most SD models, small $Delta t$],
  [RK2], [2 evals], [$O(Delta t^3)$], [Moderate accuracy needs],
  [RK4], [4 evals], [$O(Delta t^5)$], [High-accuracy / oscillatory systems],
)

For smooth SD models with $Delta t = tau_("min")/4$: Euler is fine. For *oscillatory* or *stiff* systems: RK4 or adaptive methods.

== Stiff systems

When time constants span orders of magnitude (e.g., $tau_1 = 1$, $tau_2 = 1000$), explicit methods (Euler, RK) need tiny $Delta t$ to stay stable on the fast time scale, wasting effort on the slow.

*Implicit methods* (backward Euler, BDF) trade per-step cost for stability — large $Delta t$ allowed.

In SD, stiff systems are rare; explicit methods are usually sufficient.

== Initialization in equilibrium

Common SD practice: set initial stocks so that *all flows balance* at $t = 0$ (system at steady state). Then study the response to a perturbation.

This isolates the *dynamic* response from initial-condition transients.

== See also

- *#link(<system-dynamics-stocks-flows>)[Stocks and Flows]* — the equations being integrated
- *#link(<system-dynamics-system-dynamics>)[System Dynamics overview]*
- *#link(<calculus-differential-equations>)[Differential Equations]*
