#import "/lib/imports.typ": *
#show: formatting

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

Iterating from the centroid (dashed ring), the trail converges to the Weber point (diamond); spokes connect the optimum to each customer (sized by weight):

#let cust_color  = gray
#let trail_color = purple
#let opt_color   = maroon

// single source of truth: customer points (x, y, weight)
#let customers = (
  (1.2, 1.1, 1),
  (3.0, 0.9, 1),
  (5.2, 1.4, 5),
  (1.8, 3.3, 1),
  (4.7, 3.2, 1),
)

// Weiszfeld fixed-point iteration -> (start, trail, opt)
#let weiszfeld(pts) = {
  let sw = pts.fold(0.0, (a, p) => a + p.at(2))
  let cx = pts.fold(0.0, (a, p) => a + p.at(2) * p.at(0)) / sw
  let cy = pts.fold(0.0, (a, p) => a + p.at(2) * p.at(1)) / sw
  let trail = ((cx, cy),)
  let px = cx
  let py = cy
  for _ in range(40) {
    let nx = 0.0
    let ny = 0.0
    let den = 0.0
    for p in pts {
      let dx = px - p.at(0)
      let dy = py - p.at(1)
      let d = calc.max(calc.sqrt(dx * dx + dy * dy), 0.0001)
      let om = p.at(2) / d
      nx += om * p.at(0)
      ny += om * p.at(1)
      den += om
    }
    nx = nx / den
    ny = ny / den
    trail.push((nx, ny))
    if calc.abs(nx - px) < 0.002 and calc.abs(ny - py) < 0.002 {
      px = nx; py = ny; break
    }
    px = nx; py = ny
  }
  (start: (cx, cy), trail: trail, opt: (px, py))
}

#let r = weiszfeld(customers)

#frame(cetz.canvas(length: 1cm, {
  import draw: *

  // spokes from optimum to each customer
  for p in customers {
    line(r.opt, (p.at(0), p.at(1)), stroke: trail_color.lighten(40%) + 0.5pt)
  }

  // customers sized by weight
  for p in customers {
    circle((p.at(0), p.at(1)), radius: 0.08 + calc.sqrt(p.at(2)) * 0.04,
      fill: cust_color, stroke: cust_color.darken(20%) + 0.4pt)
  }

  // centroid start (dashed ring)
  circle(r.start, radius: 0.1, fill: none,
    stroke: (paint: cust_color, dash: "dashed", thickness: 0.6pt))

  // iteration trail, fading in toward the optimum
  for i in range(r.trail.len()) {
    let t = r.trail.at(i)
    let frac = i / calc.max(1, r.trail.len() - 1)
    if i > 0 {
      line(r.trail.at(i - 1), t, stroke: trail_color + 0.5pt)
    }
    circle(t, radius: 0.05,
      fill: trail_color.transparentize((1 - (0.3 + 0.6 * frac)) * 100%), stroke: none)
  }

  // optimal point (diamond)
  let o = r.opt
  line((o.at(0), o.at(1) + 0.13), (o.at(0) + 0.13, o.at(1)),
       (o.at(0), o.at(1) - 0.13), (o.at(0) - 0.13, o.at(1)), close: true,
       fill: opt_color, stroke: none)
}))

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
