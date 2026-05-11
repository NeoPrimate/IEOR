#import "/lib/imports.typ": *

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
