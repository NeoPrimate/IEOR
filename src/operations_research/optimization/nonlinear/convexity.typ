#import "/lib/imports.typ": *
#show: formatting

= Convexity <operations_research_optimization_nonlinear_convexity>

Show $f(theta x + (1 - theta)y) ≤ theta f(x) + (1 - theta)f(y)$ for all $x$, $y$ in the domain and $theta ∈ [0,1]$

Let $D subset.eq RR^n$ be a convex set. A function $f: D → RR$ is convex if for all $x, y in D$ and all $θ in [0, 1]$,

$
  f(theta x + (1 - theta)y) ≤ theta f(x) + (1 - theta)f(y).
$

*Geometric reading*: For every pair of points on the graph, the chord joining them lies on or above the graph over the interval between them.

*Second-order condition* 

If $f$ is twice differentiable, $f$ is convex iff its Hessian is positive semidefinite everywhere on the domain.

*First-order condition* 

If $f$ is differentiable, $f$ is convex iff $f(y) gt.eq f(x) + nabla f(x)^T (y - x)$ for all $x$, $y$.

#set math.mat(gap: 1em)
#set math.vec(gap: 1em)

#grid(
  columns: (auto, auto),
  inset: 1em,
  [
    #{
      let g(x) = 2 * calc.exp(-0.9 * x * x)
      let r = calc.sqrt(1.1)
      let half(x) = 0.7 * calc.sqrt(calc.max(1.1 - x * x, 0))

      let xs = lq.linspace(-r, r, num: 300)
      let bx = xs + xs.rev()
      let by = xs.map(x => g(x) + half(x)) + xs.rev().map(x => g(x) - half(x))

      let p1 = (-0.75, 1)
      let p2 = (0.8, 0.9)

      lq.diagram(
        width: 5cm,
        height: 5cm,
        xlim: (-1.5, 1.5),
        ylim: (0, 3),
        xaxis: (ticks: none, subticks: none),
        yaxis: (ticks: none, subticks: none),

        lq.plot(bx, by, mark: none, stroke: (thickness: 1pt, paint: red)),
        // chord leaves the set
        lq.plot((p1.at(0), p2.at(0)), (p1.at(1), p2.at(1)), mark: none, stroke: black),
        lq.plot(
          (p1.at(0), p2.at(0)), (p1.at(1), p2.at(1)),
          stroke: none, mark: "o", mark-color: black, mark-size: 5pt,
        ),
      )
    }
  ],
  [
    #{
      let a = 2.5 / 3.5
      let b = 1.5 / 3.5

      let ts = lq.linspace(0, 2 * calc.pi, num: 300)
      let ex = ts.map(t => a * calc.cos(t))
      let ey = ts.map(t => b * calc.sin(t))

      let p1 = (-0.5, 0.1)
      let p2 = (0.5, -0.1)

      lq.diagram(
        width: 5cm,
        height: 5cm,
        xlim: (-1, 1),
        ylim: (-1, 1),
        xaxis: (ticks: none, subticks: none),
        yaxis: (ticks: none, subticks: none),

        lq.plot(ex, ey, mark: none, stroke: (thickness: 1pt, paint: red)),
        // chord stays inside
        lq.plot((p1.at(0), p2.at(0)), (p1.at(1), p2.at(1)), mark: none, stroke: black),
        lq.plot(
          (p1.at(0), p2.at(0)), (p1.at(1), p2.at(1)),
          stroke: none, mark: "o", mark-color: black, mark-size: 5pt,
        ),
      )
    }
  ],
  [
    #{
      let f(t) = t * t + 0.1
      let x = -0.75
      let y = 0.5
      let theta = 0.4                       // chosen so z lands on 0
      let z = theta * x + (1 - theta) * y
      let fx = f(x)
      let fy = f(y)
      let m = (fy - fx) / (y - x)
      let b = fx - m * x
      let chord(t) = m * t + b
      let ts = lq.linspace(-1, 1, num: 200)
      lq.diagram(
        width: 5cm,
        height: 5cm,
        xlim: (-1, 1),
        ylim: (0, 1),
        xaxis: (
          ticks: (
            (x, $#text(size: 10pt, [$x$])$), 
            (y, $#text(size: 10pt, [$y$])$), 
            (z, $#text(size: 10pt, [$theta x + (1 - theta) y$])$)
          )
        ),
        yaxis: (ticks: none),
        lq.plot(ts, f, mark: none, stroke: (thickness: 1pt, paint: red)),
        lq.vlines(x, max: fx, stroke: (paint: black, dash: "dashed")),
        lq.vlines(y, max: fy, stroke: (paint: black, dash: "dashed")),
        lq.vlines(z, max: calc.max(f(z), chord(z)), stroke: (paint: black, dash: "dashed")),
        lq.plot((x, y), (fx, fy), mark: none, stroke: black),   // secant chord
        lq.plot((x, y, z, z), (fx, fy, chord(z), f(z)),
                stroke: none, mark: "o", mark-color: black, mark-size: 5pt),
      )
    }
  ],
  [
    #{
      let f(t) = calc.pow(t, 4) - 2 * calc.pow(t, 2) + 1 + 0.1
      let x = -1.25
      let y = 1.45
      let theta = 0.5                       // midpoint
      let z = theta * x + (1 - theta) * y
      let fx = f(x)
      let fy = f(y)
      let m = (fy - fx) / (y - x)
      let b = fx - m * x
      let chord(t) = m * t + b
      let ts = lq.linspace(-2, 2, num: 200)
      lq.diagram(
        width: 5cm,
        height: 5cm,
        xlim: (-2, 2),
        ylim: (0, 2),
        xaxis: (ticks: ((x, $x$), (y, $y$), (z, $theta x + (1 - theta) y$))),
        yaxis: (ticks: none),
        lq.plot(ts, f, mark: none, stroke: (thickness: 1pt, paint: red)),
        lq.vlines(x, max: fx, stroke: (paint: black, dash: "dashed")),
        lq.vlines(y, max: fy, stroke: (paint: black, dash: "dashed")),
        lq.vlines(z, max: calc.max(f(z), chord(z)), stroke: (paint: black, dash: "dashed")),
        lq.plot((x, y), (fx, fy), mark: none, stroke: black),   // secant chord
        lq.plot((x, y, z, z), (fx, fy, chord(z), f(z)),
                stroke: none, mark: "o", mark-color: black, mark-size: 5pt),
      )
    }
  ]
)

$f(theta x + (1 - theta)y) ≤ theta f(x) + (1 - theta)f(y)$

Convex combination:

- Coefficients nonnegative
- Coefficients summing to 1


