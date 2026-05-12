#import "/lib/imports.typ": *
#show: formatting

*Set Covering Location Problem (LSCP)*: minimize the *number* of facilities needed to cover every customer at least once. "Cover" = customer is within an acceptable distance $d_("max")$ of some facility.

== Formulation

Let $N_i = {j : c_(i j) <= d_("max")}$ — candidate facilities that can cover customer $i$.

$
  min sum_j y_j
$

s.t.:

$
  sum_(j in N_i) y_j >= 1, #h(1em) forall i #h(2em) "(each customer covered by ≥ 1 facility)"
$

$
  y_j in {0, 1}
$

== The general Set Cover problem

LSCP is a special case of *Set Cover*: given a collection of subsets covering a universe, find the minimum number to use.

Set Cover is one of *Karp's 21 NP-complete problems* — a foundational hard problem in complexity theory.

== Greedy approximation

The natural greedy algorithm:

```
At each step: pick the facility that covers the most uncovered customers
Stop when all customers are covered
```

Achieves an $H_n$-approximation (where $H_n approx ln n$ is the harmonic sum). And this is *optimal* — no polynomial algorithm achieves better than $(1 - o(1)) ln n$ unless P = NP.

== Linear programming relaxation

Drop $y_j in {0, 1}$ to $y_j in [0, 1]$. Solve the LP:

- LP gives a lower bound on integer optimum
- LP value can be a fractional cover (some $y_j$ partially selected)
- *Randomized rounding* converts LP solution to integer solution with $O(log n)$-factor approximation

== Variants

- *Weighted set cover*: each facility $j$ has cost $w_j$. Minimize $sum_j w_j y_j$
- *Maximum coverage* (#link(<operations-research-optimization-max-covering>)[here]): inverted — fix facility count $p$, *maximize* coverage
- *Partial cover*: cover at least $k$ of $n$ customers

== Where it shows up

- *Fire / EMS placement* — every household within $d_("max")$ minutes
- *Cell tower placement* — every demand area covered
- *Sensor placement* — every region monitored
- *Scheduling / shift staffing* — every hour staffed (set-cover on time intervals)
- *Vaccine distribution* — every village within reach

== See also

- *#link(<operations-research-optimization-max-covering>)[Max Covering]* — inverted variant
- *#link(<operations-research-optimization-p-center>)[$p$-center]* — uses set covering as feasibility subroutine
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
