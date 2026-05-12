#import "/lib/imports.typ": *
#show: formatting



A plane in $RR^3$ is the set of points $(x, y, z)$ satisfying a single linear equation:

$
  A x + B y + C z = D
$

The vector $accent(n, arrow) = (A, B, C)$ is the *normal vector* — perpendicular to every vector lying in the plane.

== Point–normal form

If $accent(x, arrow)_0$ is a known point on the plane and $accent(n, arrow)$ is the normal, then any other point $accent(x, arrow)$ lies on the plane iff $accent(x, arrow) - accent(x, arrow)_0$ is perpendicular to $accent(n, arrow)$:

$
  accent(n, arrow) dot (accent(x, arrow) - accent(x, arrow)_0) = 0
$

#align(center)[
  #frame(cetz.canvas(length: 6cm, {
    import cetz.draw: *
    import cetz-plot: *
    plot.plot(
      x-tick-step: none, y-tick-step: none,
      x-min: -7, y-min: -7, x-max: 7, y-max: 7,
      axis-style: "school-book",
      x-label: $x$, y-label: $y$,
      x-grid: "both", y-grid: "both",
      {
        plot.add-anchor("o", (0, 0))
        plot.add-anchor("a", (-3, 3))
        plot.add-anchor("b", (3, 3))
        plot.add-anchor("p", (3, 7))
        plot.add-anchor("p1", (-8, 3))
        plot.add-anchor("p2", (8, 3))
      },
      name: "plot",
    )
    cetz.draw.line("plot.p1", "plot.p2", stroke: black, mark: (fill: black), name: "plane")
    cetz.draw.content("plane.end", text(black)[plane], anchor: "south", padding: 0.025)
    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
    cetz.draw.line("plot.o", "plot.a", stroke: green, mark: (fill: green), name: "x")
    cetz.draw.content("x.mid", text(green)[$accent(x, arrow)$], anchor: "north", padding: 0.025)
    cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "x0")
    cetz.draw.content("x0.mid", text(blue)[$accent(x, arrow)_0$], anchor: "north", padding: 0.025)
    cetz.draw.line("plot.b", "plot.a", stroke: red, mark: (fill: red), name: "diff")
    cetz.draw.content("diff.mid", text(red)[$accent(x, arrow) - accent(x, arrow)_0$], anchor: "south", padding: 0.025)
    cetz.draw.line("plot.b", "plot.p", stroke: purple, mark: (fill: purple), name: "n")
    cetz.draw.content("n.mid", text(purple)[$accent(n, arrow)$], anchor: "west", padding: 0.025)
    cetz.angle.right-angle("n.start", "diff.end", "n.end", radius: 0.05)
  }))
]

Expanding componentwise:

$
  n_1 (x - x_0) + n_2 (y - y_0) + n_3 (z - z_0) = 0
$

#example[
  Find the plane equation given $accent(n, arrow) = (1, 3, -2)$ and a point on the plane $accent(x, arrow)_0 = (1, 2, 3)$.

  $
    1 (x - 1) + 3 (y - 2) - 2 (z - 3) = 0
  $

  Simplify:

  $
    x - 1 + 3y - 6 - 2z + 6 = 0 #h(0.5em) arrow.r.double #h(0.5em) x + 3 y - 2 z = 1
  $
]

== Reading the normal off the equation

In the form $A x + B y + C z = D$, the coefficients are exactly the components of the normal vector:

$
  accent(n, arrow) = (A, B, C)
$

#example[
  $
    -3 x + sqrt(2) y + 7 z = pi #h(2em) arrow.r.double #h(2em) accent(n, arrow) = (-3, sqrt(2), 7)
  $
]

== See also

- *#link(<linear-algebra-point-plane-distance>)[Point–Plane Distance]* — formula and example
- *#link(<linear-algebra-plane-plane-distance>)[Distance Between Planes]* — parallel and non-parallel cases
- *#link(<linear-algebra-hyperplane>)[Hyperplane]* — $n$-dimensional generalization
- *#link(<linear-algebra-cross-product>)[Cross Product]* — building a normal from two in-plane vectors
