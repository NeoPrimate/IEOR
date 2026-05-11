#import "/lib/imports.typ": *



For a #link(<linear-algebra-linear-transformation>)[linear transformation] $T: RR^n -> RR^m$ and a subset $V subset.eq RR^n$, the *image of $V$ under $T$* is:

$
  T(V) = { T(accent(x, arrow)) | accent(x, arrow) in V }
$

— the set of all outputs you get by applying $T$ to every input in $V$.

#example[
  #let x0 = (-2, -2)
  #let x1 = (-2, 2)
  #let x2 = (2, -2)

  $
    accent(x, arrow)_0 = nt.print(x0) quad quad accent(x, arrow)_1 = nt.print(x1) quad quad accent(x, arrow)_2 = nt.print(x2)
  $

  $
    L_0 = {accent(x, arrow)_0 + t (accent(x, arrow)_1 - accent(x, arrow)_0) | 0 lt.eq t lt.eq 1} \
    L_1 = {accent(x, arrow)_1 + t (accent(x, arrow)_2 - accent(x, arrow)_1) | 0 lt.eq t lt.eq 1} \
    L_2 = {accent(x, arrow)_2 + t (accent(x, arrow)_0 - accent(x, arrow)_2) | 0 lt.eq t lt.eq 1} \
  $

  Triangle: $S = {L_0, L_1, L_2}$.

  Apply transformation $T(accent(x, arrow)) = A accent(x, arrow)$ with $A = mat(1, -1; 2, 0)$:

  #let A = ((1, -1), (2, 0))
  #let transformation(x) = matvec_mult(A, x)
  #let Tx0 = transformation(x0)
  #let Tx1 = transformation(x1)
  #let Tx2 = transformation(x2)

  $
    T(accent(x, arrow)_0) = nt.print(Tx0) #h(2em)
    T(accent(x, arrow)_1) = nt.print(Tx1) #h(2em)
    T(accent(x, arrow)_2) = nt.print(Tx2)
  $

  By linearity, line segments map to line segments: $T(L_0)$ is the image of $L_0$, and $T(S)$ is the image of the whole triangle.

  #let triangle = frame(cetz.canvas(length: 6cm, {
    cetz-plot.plot.plot(
      x-tick-step: 5, y-tick-step: 5, x-minor-tick-step: 1, y-minor-tick-step: 1,
      x-min: -5, y-min: -5, x-max: 5, y-max: 5,
      axis-style: "school-book", x-label: $x$, y-label: $y$, x-grid: "both", y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", (0, 0))
        cetz-plot.plot.add-anchor("x0", x0)
        cetz-plot.plot.add-anchor("x1", x1)
        cetz-plot.plot.add-anchor("x2", x2)
      },
      name: "plot",
    )
    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
    cetz.draw.line("plot.o", "plot.x0", stroke: green, mark: (fill: green))
    cetz.draw.line("plot.o", "plot.x1", stroke: blue, mark: (fill: blue))
    cetz.draw.line("plot.o", "plot.x2", stroke: red, mark: (fill: red))
    cetz.draw.line("plot.x0", "plot.x1", stroke: purple, mark: none)
    cetz.draw.line("plot.x2", "plot.x1", stroke: purple, mark: none)
    cetz.draw.line("plot.x2", "plot.x0", stroke: purple, mark: none)
  }))

  #let transformed = frame(cetz.canvas(length: 6cm, {
    cetz-plot.plot.plot(
      x-tick-step: 5, y-tick-step: 5, x-minor-tick-step: 1, y-minor-tick-step: 1,
      x-min: -5, y-min: -5, x-max: 5, y-max: 5,
      axis-style: "school-book", x-label: $x$, y-label: $y$, x-grid: "both", y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", (0, 0))
        cetz-plot.plot.add-anchor("x0", Tx0)
        cetz-plot.plot.add-anchor("x1", Tx1)
        cetz-plot.plot.add-anchor("x2", Tx2)
      },
      name: "plot",
    )
    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
    cetz.draw.line("plot.o", "plot.x0", stroke: green, mark: (fill: green))
    cetz.draw.line("plot.o", "plot.x1", stroke: blue, mark: (fill: blue))
    cetz.draw.line("plot.o", "plot.x2", stroke: red, mark: (fill: red))
    cetz.draw.line("plot.x0", "plot.x1", stroke: purple, mark: none)
    cetz.draw.line("plot.x2", "plot.x1", stroke: purple, mark: none)
    cetz.draw.line("plot.x2", "plot.x0", stroke: purple, mark: none)
  }))

  #align(center)[
    #grid(columns: (1fr, 1fr), gutter: 3pt, triangle, transformed)
  ]
]

== Connections

- *#link(<linear-algebra-image>)[Image of a transformation]* — the case $V = RR^n$ (the whole domain)
- *#link(<linear-algebra-preimage>)[Preimage]* — the inverse direction (which inputs produce a given output set)
