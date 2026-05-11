#import "/lib/imports.typ": *

The classical *predator-prey* model. Two species:

$
  dot x = alpha x - beta x y #h(2em) "prey"
$

$
  dot y = delta x y - gamma y #h(2em) "predator"
$

where:
- $x$: prey population, $y$: predator population
- $alpha$: prey growth rate (unlimited food, no predator)
- $beta$: predation rate
- $delta$: predator growth per prey eaten
- $gamma$: predator death rate (no prey)

== Behavior: closed orbits in the phase plane

Equilibrium: $(x^*, y^*) = (gamma / delta, alpha / beta)$.

Around the equilibrium, the system *oscillates* in closed orbits (in $(x, y)$ space). Pre-mathematical solution by Lotka (1925) and Volterra (1926).

Energy-like invariant:
$
  H(x, y) = delta x + beta y - gamma ln x - alpha ln y = "const"
$

Trajectories follow contours of constant $H$.

== Oscillation dynamics

Cycle structure:

1. Prey abundant → predators thrive (predator pop rises)
2. Predators abundant → prey decline (prey pop falls)
3. Prey scarce → predators decline (predator pop falls)
4. Predators scarce → prey rebound (prey pop rises)
5. Cycle repeats

Lynx-hare population data (Hudson Bay records) shows this pattern beautifully.

== Limitations and extensions

The pure Lotka-Volterra has issues:

- *Closed orbits* (mathematically) → no damping. Real systems usually damp out or destabilize.
- *Unlimited prey* if no predator. Add a carrying capacity:

$
  dot x = alpha x (1 - x/K) - beta x y
$

This logistic version has *stable spiral* or *limit cycle* depending on parameters.

- *Functional response* (Holling Type II): predator becomes saturated:

$
  dot x = alpha x - (beta x y) / (1 + h x)
$

with $h$ = handling time. Can produce limit cycles or even chaos.

== Beyond two species

Generalizes to $n$-species:

$
  dot x_i = x_i (r_i + sum_j a_(i j) x_j)
$

with $a_(i j)$ = interaction matrix. Models food webs, ecological communities.

== Outside biology

The model is structurally fundamental — appears wherever two stocks interact with the "predator gains by consuming prey" pattern:

- *Sales force vs prospect pool*: salespeople convert prospects (prey) and decline without them
- *Consumer behavior*: cyclical fashion (predator) consumes available trends (prey)
- *Marketing budgets vs customer base*

== See also

- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]* — oscillation from coupled feedback
- *#link(<system-dynamics-phase-plane>)[Phase Plane]* — visualization of trajectories
- *#link(<system-dynamics-sir-seir>)[SIR/SEIR]* — related compartmental dynamics
