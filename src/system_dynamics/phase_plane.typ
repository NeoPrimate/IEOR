#import "/lib/imports.typ": *

A graphical method for analyzing 2-state dynamical systems. Plot the two state variables on axes; the system's trajectory traces a curve in this plane.

== For a 2-state system

$
  dot x = f(x, y), #h(0.5em) dot y = g(x, y)
$

Each $(x, y)$ point has a *velocity vector* $(dot x, dot y)$. The phase portrait is the field of these vectors plus typical trajectories.

== Key features

- *Equilibria / fixed points*: $(x^*, y^*)$ where $f = g = 0$. The system rests there.
- *Nullclines*: curves where $dot x = 0$ (the $x$-nullcline) or $dot y = 0$ (the $y$-nullcline). Equilibria lie at intersections.
- *Trajectories*: integral curves of the vector field
- *Separatrices*: trajectories that divide the plane into regions of different long-term behavior

== Linearizing at an equilibrium

Near $(x^*, y^*)$, Taylor-expand $f, g$:

$
  vec(dot x, dot y) approx J #h(0.2em) vec(x - x^*, y - y^*)
$

where $J$ is the Jacobian:

$
  J = mat(delim: "[",
    (partial f) / (partial x), (partial f) / (partial y);
    (partial g) / (partial x), (partial g) / (partial y);
  )_(\(x^*, y^*\))
$

The *eigenvalues* of $J$ classify the equilibrium.

== Classification by eigenvalues

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Eigenvalues], [Type], [Behavior]),
  [Both real, both $< 0$], [Stable node], [Trajectories approach $(x^*, y^*)$ from all directions],
  [Both real, both $> 0$], [Unstable node], [Trajectories diverge from $(x^*, y^*)$],
  [Real, opposite signs], [Saddle], [Stable along one direction, unstable along other; separatrix],
  [Complex, real part $< 0$], [Stable spiral], [Trajectories spiral inward],
  [Complex, real part $> 0$], [Unstable spiral], [Trajectories spiral outward],
  [Pure imaginary], [Center], [Closed orbits around equilibrium (oscillation)],
)

The *trace-determinant plane* visualizes these regimes:

- $tau = "tr"(J), Delta = det(J)$
- $Delta > 0, tau < 0$: stable (node or spiral)
- $Delta > 0, tau > 0$: unstable (node or spiral)
- $Delta < 0$: saddle (always unstable)
- $Delta > 0, tau^2 < 4 Delta$: spiral; otherwise: node

== Lotka-Volterra as example

$
  dot x = alpha x - beta x y, #h(0.5em) dot y = delta x y - gamma y
$

Equilibrium at $(gamma/delta, alpha/beta)$.

Jacobian at equilibrium:

$
  J = mat(delim: "[",
    0, -beta gamma / delta;
    delta alpha / beta, 0;
  )
$

Trace $= 0$, $det > 0$. Pure imaginary eigenvalues → *center* → closed orbits. (Confirms #link(<system-dynamics-lotka-volterra>)[Lotka-Volterra]'s well-known oscillation.)

== Limit cycles and chaos

For *nonlinear* systems with appropriate structure, isolated closed orbits (*limit cycles*) appear. Examples:

- van der Pol oscillator
- Predator-prey with Holling functional response
- Belousov-Zhabotinsky chemical reaction

In dimension $>= 3$, chaos becomes possible (Lorenz attractor, etc.). 2-D systems can't be chaotic by Poincaré-Bendixson theorem.

== Routh-Hurwitz stability for higher dimensions

For 3+ states, eigenvalue computation generalizes. The *Routh-Hurwitz criterion* gives an algorithmic stability test from coefficient signs of the characteristic polynomial.

== See also

- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]*
- *#link(<system-dynamics-second-order>)[Second-Order Systems]*
- *#link(<system-dynamics-lotka-volterra>)[Lotka-Volterra]* — phase plane example
- *#link(<calculus-differential-equations>)[Differential Equations]*
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors / Eigenvalues]* — for the Jacobian
