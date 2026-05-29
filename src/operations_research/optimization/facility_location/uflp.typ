#import "/lib/imports.typ": *
#show: formatting

*Uncapacitated Facility Location Problem*: open a subset of candidate facilities and assign each customer to one open facility, minimizing fixed + transport costs. No capacity limits.

== Formulation

Sets: customers $I$, candidate facilities $J$. Costs: $f_j$ (open facility $j$), $c_(i j)$ (assign customer $i$ to facility $j$).

Decision variables:
- $y_j in {0, 1}$ — open facility $j$?
- $x_(i j) in [0, 1]$ — fraction of customer $i$'s demand served by $j$ (or $x in {0, 1}$ for single-sourcing)

$
  min sum_j f_j y_j + sum_i sum_j c_(i j) x_(i j)
$

s.t.:

$
  sum_j x_(i j) = 1, #h(1em) forall i #h(2em) "(every customer fully assigned)"
$

$
  x_(i j) <= y_j, #h(1em) forall i, j #h(2em) "(can only assign to open facilities)"
$

$
  y_j in {0, 1}, #h(0.5em) x_(i j) >= 0
$

== Picture

#let f1_color = blue
#let f2_color = green

#let customer = (x, y, name, w: 1, r: 5pt, col: gray.lighten(50%), bd: black) => node(
  (x, y), none,
  shape: circle, radius: (3 + w * 0.9) * 1pt,
  fill: col, stroke: bd + 0.4pt,
  name: name,
)

#let facility = (x, y, col, label, name) => node(
  (x, y),
  text(fill: col.darken(25%))[#label],
  shape: rect,
  width: 16pt,
  height: 16pt,
  corner-radius: 0.25em,
  fill: col.lighten(70%),
  stroke: col + 0.5pt,
  inset: 1pt,
  name: name
)

#frame(fletcher.diagram(spacing: 8pt,
  edge(<f1>,<c1>, stroke: f1_color),
  edge(<f1>,<c2>, stroke: f1_color),
  edge(<f1>,<c3>, stroke: f1_color),
  edge(<f1>,<c4>, stroke: f1_color),
  edge(<f1>,<c5>, stroke: f1_color),
  edge(<f2>,<c6>, stroke: f2_color),
  edge(<f2>,<c7>, stroke: f2_color),
  edge(<f2>,<c8>, stroke: f2_color),
  edge(<f2>,<c9>, stroke: f2_color),

  customer(0.9,0.0, <c1>),
  customer(0.5,2.0, <c2>),
  customer(2.3,0.0, <c3>),
  customer(2.5,2., <c4>),
  customer(1.8,3.2, <c5>),
  customer(4.5,1.1, <c6>),
  customer(5.9,1.0, <c7>),
  customer(6.1,2.5, <c8>),
  customer(4.6,3.1, <c9>),

  facility(1.7,1.6, f1_color, "F1", <f1>),
  facility(5.2,2.0, f2_color, "F2", <f2>),

  node((3.4,5.0), none, shape: rect, width: 14pt, height: 14pt,
    fill: none, stroke: (paint: rgb("#888780"), dash: "dashed", thickness: 0.5pt)),
  node((3.4,5.6), text(size: 8pt, fill: gray)[closed]),
  node((1.7,3.9), text(size: 8pt, fill: f1_color)[open · serves 5]),
  node((5.2,3.9), text(size: 8pt, fill: f2_color)[open · serves 4]),
))

== Structure

Once $y$ is fixed (which facilities are open), the assignment is trivial — each customer chooses its cheapest open facility. So UFLP reduces to choosing a subset of facilities.

For $|J| = n$ candidates: $2^n$ subsets — NP-hard in general, but tractable up to ~1000 facilities with MIP solvers.

== Erlenkotter's dual ascent

A classical specialized algorithm (Erlenkotter 1978):

1. Start with weak dual solution
2. Iteratively raise dual variables while maintaining feasibility
3. At each step, dual values determine which facilities *must* be open
4. Heuristic primal construction from dual

Often achieves provably-optimal solutions on instances with 1000+ candidates. Predates modern MIP solvers but still competitive.

== LP relaxation

The LP relaxation (drop $y in {0, 1}$ to $y in [0, 1]$) is a *strong* relaxation — gap typically under 5%. Good starting point for branch-and-cut.

== Approximation algorithms

UFLP admits constant-factor approximations (the problem is APX-hard but admits PTAS in some special cases):

- *Greedy* (Mahdian, Markakis, Saberi, Vazirani 2003): $1.61$-approximation
- *LP-rounding* / *primal-dual*: $1.5$-approximation for *metric* UFLP (Byrka 2007)
- *Open-source*: $1.488$-approximation (Li 2013) — current best

For metric UFLP (costs satisfy triangle inequality), $1.46$ is the lower bound on what's achievable (Sviridenko-Vyacheslav 2010).

== See also

- *#link(<operations-research-optimization-cflp>)[CFLP]* — with capacities
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
- *#link(<operations-research-optimization-p-median>)[$p$-median]* — fixed number of facilities, no fixed cost
- *#link(<operations-research-optimization-lagrange-relaxation>)[Lagrange relaxation]* — bounds for branch-and-bound
