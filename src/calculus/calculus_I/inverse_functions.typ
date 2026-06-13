#import "/lib/imports.typ": *
#show: formatting

*1. Definition*

$
  colorMath(f(colorMath(f^(-1)(colorMath(x, #black)), #blue)), #red) = x \
  colorMath(f^(-1)(colorMath(f(colorMath(x, #black)), #red)), #blue) = x \
$

#align(center)[
  #frame(cetz.canvas({
    draw-blob(
      2, (0, 0), 1.5,
      stroke: green,
      name: "blob1"
    )
    draw-blob(
      8, (5, 0), 1.5,
      n-pts: 10,
      stroke: orange,
      name: "blob2"
    )
    cetz.draw.circle(
      "blob1.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "x"
    )
    cetz.draw.circle(
      "blob2.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "y"
    )
    cetz.draw.content(
      "x", [$x$],
      anchor: "east",
      padding: 3pt
    )
    cetz.draw.content(
      "y", [$f(x)$],
      anchor: "west",
      padding: 3pt
    )
    let mid = (2.5, .5)
    cetz.draw.bezier-through(
      "x.north-east", mid, "y.north-west",
      stroke: blue + .5pt,
      mark: (end: ">", fill: blue),
      name: "arrow"
    )
    cetz.draw.content(
      mid, [$f$],
      anchor: "south",
      padding: 3pt
    )
    let mid = (2.5, -.5)
    cetz.draw.bezier-through(
      "y.north-east", mid, "x.north-west",
      stroke: blue + .5pt,
      mark: (end: ">", fill: blue),
      name: "arrow"
    )
    cetz.draw.content(
      mid, [$f^(-1)$],
      anchor: "north",
      padding: 3pt
    )
  }))
]

A function $f: A arrow B$ has an inverse function $f^(-1)$ if and only if $f$ is *bijective* (i.e., both one-to-one and onto):

- *Injective (One-to-One)*: 
  
  $f(x_1) = f(x_2)$ implies $x_1 = x_2$

  No two inputs map to the same output 

- *Surjective (Onto)*:

  Every element in $B$ is mapped from some element in $A$

*2. Finding Inverse Function*

To determine $f^(-1)$:
- Express $y$ in terms of $x$: $y = f(x)$
- Solve for $x$ in terms of $y$
- Swap $x$ and $y$, remaining $y$ as $f^(-1)(x)$

*3. Graphical Representation*

The graph of $f^(-1)$ is a reflection of the graph of $f$ access the line $x = y$

#let lin(x) = x

#let f(x) = 2 * x + 3
#let f_inv(x) = (x - 3) / 2

#align(center)[
  #let xs = lq.linspace(-3, 3, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-3, 3),
    ylim: (-3, 3),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, f, mark: none, stroke: blue, label: $f(x) = 2x + 3$),
    lq.plot(xs, f_inv, mark: none, stroke: red, label: $f^(-1)(x) = (x - 3) / 2$),
    lq.plot(xs, lin, mark: none, stroke: gray, label: $x = y$),
  )
]

#let f(x) = calc.pow(x, 2)
#let f_inv(x) = calc.sqrt(x)

#align(center)[
  #let xs = lq.linspace(-3, 3, num: 200)
  #let xsp = lq.linspace(0, 3, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (0, 3),
    ylim: (0, 3),
    xaxis: (tick-args: (tick-distance: 1)),
    yaxis: (tick-args: (tick-distance: 1)),
    lq.plot(xs, f, mark: none, stroke: blue, label: $f(x) = x^2$),
    lq.plot(xsp, f_inv, mark: none, stroke: red, label: $f^(-1)(x) = sqrt(x)$),
    lq.plot(xsp, lin, mark: none, stroke: gray, label: $x = y$),
  )
]

#let f(x) = calc.pow(x, 3)
#let f_inv(x) = calc.root(x, 3)

#align(center)[
  #let xs = lq.linspace(-3, 3, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-3, 3),
    ylim: (-3, 3),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, f, mark: none, stroke: blue, label: $f(x) = x^3$),
    lq.plot(xs, f_inv, mark: none, stroke: red, label: $f^(-1)(x) = root(3, x)$),
    lq.plot(xs, lin, mark: none, stroke: gray, label: $x = y$),
  )
]

#align(center)[
  #let xs = lq.linspace(-1.5, 1.5, num: 200)
  #let xsi = lq.linspace(-1, 1, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-1.5, 1.5),
    ylim: (-1.5, 1.5),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, calc.sin, mark: none, stroke: blue, label: $sin(x)$),
    lq.plot(xsi, x => calc.asin(x).rad(), mark: none, stroke: red, label: $arcsin(x)$),
    lq.plot(xs, lin, mark: none, stroke: gray, label: $x = y$),
  )
]

#align(center)[
  #let xs = lq.linspace(-1.5, 1.5, num: 200)
  #let xsi = lq.linspace(-1, 1, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-1.5, 1.5),
    ylim: (-1.5, 1.5),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, calc.cos, mark: none, stroke: blue, label: $cos(x)$),
    lq.plot(xsi, x => calc.acos(x).rad(), mark: none, stroke: red, label: $arccos(x)$),
    lq.plot(xs, lin, mark: none, stroke: gray, label: $x = y$),
  )
]

#align(center)[
  #let xs = lq.linspace(-1.5, 1.5, num: 200)
  #let xsi = lq.linspace(-1, 1, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-1.5, 1.5),
    ylim: (-1.5, 1.5),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, calc.tan, mark: none, stroke: blue, label: $tan(x)$),
    lq.plot(xsi, x => calc.atan(x).rad(), mark: none, stroke: red, label: $arctan(x)$),
    lq.plot(xs, lin, mark: none, stroke: gray, label: $x = y$),
  )
]

2. Derivative of Inverse Functions

#align(center)[
  #let fc(x) = calc.pow(x, 3) + x
  #let dfdx(x) = 3 * calc.pow(x, 2) + 1
  #let fc_inv(y) = calc.root(y / 2 + calc.sqrt(calc.pow(y, 2) / 4 + 1 / 27), 3) + calc.root(y / 2 - calc.sqrt(calc.pow(y, 2) / 4 + 1 / 27), 3)
  #let x0 = 1
  #let y0 = fc(x0)
  #let slope_inv = 1 / dfdx(x0)
  #let xs = lq.linspace(-3, 5, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-1, 5),
    ylim: (-1, 5),
    xlabel: $x$,
    ylabel: $y$,
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, tick-args: (tick-distance: 1)),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, tick-args: (tick-distance: 1)),
    lq.plot(xs, fc, mark: none, stroke: black),
    lq.plot(xs, fc_inv, mark: none, stroke: blue),
    lq.plot(xs, x => x, mark: none, stroke: gray),
    lq.plot(xs, x => fc(x0) + dfdx(x0) * (x - x0), mark: none, stroke: red),
    lq.plot(xs, y => x0 + slope_inv * (y - y0), mark: none, stroke: red),
    lq.plot((x0, y0), (y0, x0), mark: "o", stroke: none, mark-color: red),
  )
]
