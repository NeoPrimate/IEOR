#import "/lib/imports.typ": *

The *single-facility continuous-space* location problem: place *one* facility anywhere in the plane to minimize total weighted distance to customers.

The optimal location is the *Weber point* (also called the geometric median).

== Two flavors

*Weighted centroid* (squared Euclidean distance — easy):

$
  min sum_i d_i ||x - p_i||^2 #h(2em) arrow.r.double #h(0.5em) x^* = (sum_i d_i p_i) / (sum_i d_i)
$

— closed-form. The *weighted mean*. Used as a *quick first approximation* in network design.

*Weber point* (Euclidean distance — harder):

$
  min sum_i d_i ||x - p_i||
$

No closed form. Must iterate. The function is convex; standard methods converge.

== Weiszfeld's algorithm

For the Weber point, *Weiszfeld iteration*:

$
  x^((k+1)) = (sum_i d_i p_i / ||x^((k)) - p_i||) / (sum_i d_i / ||x^((k)) - p_i||)
$

— a weighted average where weights are *inverse distances*: closer points pull more strongly.

```
Initialize x⁽⁰⁾ at the centroid
Repeat:
    Compute weights w_i = d_i / ||x⁽ᵏ⁾ - p_i||
    x⁽ᵏ⁺¹⁾ ← (Σ w_i p_i) / Σ w_i
Until convergence
```

Converges linearly. Caveat: if any iterate lands *exactly* on a customer point, the formula breaks (denominator $= 0$). Mitigation: small perturbation or alternate update rule when this occurs.

== Geometric insight

The Weber point is *Pareto-optimal*: no infinitesimal move benefits any single weighted customer without harming the total. The gradient is zero — that's exactly the Weiszfeld fixed-point condition.

== Why use $L^1$ instead?

Sometimes *Manhattan distance* $sum_i d_i (|x_1 - p_(i, 1)| + |x_2 - p_(i, 2)|)$ is more appropriate (grid streets, axis-aligned travel). Then the optimum is the *coordinate-wise median*:

$
  x_1^* = "weighted median of" p_(i, 1), #h(1em) x_2^* = "weighted median of" p_(i, 2)
$

— much simpler to compute than the Euclidean Weber point.

== Where it shows up

- *Distribution-center placement* — first approximation before discrete refinement
- *Field service hubs*
- *Hospital emergency response*
- *Server placement* in computer networks

In practice, center of gravity gives a continuous-space starting point that's then snapped to the nearest feasible candidate (highway access, zoning, real estate availability).

== See also

- *#link(<operations-research-optimization-p-median>)[$p$-median]* — discrete, multi-facility
- *#link(<operations-research-optimization-facility-location>)[Facility Location overview]*
- *#link(<operations-research-optimization-daganzo-continuous>)[Daganzo Continuous Approximation]* — strategic-level
