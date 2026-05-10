#import "/lib/imports.typ": *

#set math.vec(delim: "[")

== Vector Addition

$
  vec(x_1, x_2, x_3) + vec(y_1, y_2, y_3) = vec(x_1 + y_1, x_2 + y_2, x_3 + y_3)
$

#example[

  $
    accent(a, arrow) = #text(red)[$vec(6, -2)$]
    quad quad quad quad
    accent(b, arrow) = #text(blue)[$vec(-4, 4)$]
  $

  $
    accent(a, arrow) + accent(b, arrow) = vec(#text(red)[$6$] + #text(blue)[$-4$], #text(red)[$-2$] + #text(blue)[$4$]) = #text(green)[$vec(2, 2)$]
  $

  #align(center)[
    #frame(cetz.canvas(length: 5cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -7,
        y-min: -7,
        x-max: 7,
        y-max: 7,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("a", (0, 0))
          plot.add-anchor("b", (6, -2))
          plot.add-anchor("c", (0, 0))
          plot.add-anchor("d", (-4, 4))
          plot.add-anchor("e", (0, 0))
          plot.add-anchor("f", (2, 2))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red))
      cetz.draw.line("plot.c", "plot.d", stroke: blue, mark: (fill: blue))
      cetz.draw.line("plot.e", "plot.f", stroke: green, mark: (fill: green))
    }))
  ]

  #align(center)[
    #frame(cetz.canvas(length: 5cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -7,
        y-min: -7,
        x-max: 7,
        y-max: 7,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("a", (0, 0))
          plot.add-anchor("b", (6, -2))
          plot.add-anchor("c", (6, -2))
          plot.add-anchor("d", (2, 2))
          plot.add-anchor("e", (0, 0))
          plot.add-anchor("f", (2, 2))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red))
      cetz.draw.line("plot.c", "plot.d", stroke: blue, mark: (fill: blue))
      cetz.draw.line("plot.e", "plot.f", stroke: green, mark: (fill: green))
    }))
  ]
]

== Vector Subtraction

$
  vec(x_1, x_2, x_3) - vec(y_1, y_2, y_3) = vec(x_1 - y_1, x_2 - y_2, x_3 - y_3)
$

#example[

  #let (ax, ay) = (1, 5)
  #let (bx, by) = (5, 1)
  #let (cx, cy) = (ax - bx, ay - by)

  $
    accent(u, arrow) = vec(#str(ax), #str(ay)) quad quad quad accent(v, arrow) = vec(#str(bx), #str(by)) \
    accent(u, arrow) - accent(v, arrow) = vec(#str(ax) - #str(bx), #str(ay) - #str(by)) = vec(#str(ax - bx), #str(ay - by))
  $

  #align(center)[

    #frame(cetz.canvas(length: 6cm, {
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(
        x-tick-step: 5,
        y-tick-step: 5,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -7,
        y-min: -7,
        x-max: 7,
        y-max: 7,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("o", (0, 0))
          plot.add-anchor("a", (ax, ay))
          plot.add-anchor("b", (bx, by))
          plot.add-anchor("c", (cx, cy))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.end", text(red)[$accent(u, arrow)$], anchor: "south", padding: 0.025, angle: "a.end")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "a")
      cetz.draw.content("a.end", text(blue)[$accent(v, arrow)$], anchor: "south", padding: 0.025, angle: "a.end")

      cetz.draw.line("plot.o", "plot.c", stroke: purple, mark: (fill: purple), name: "a")
      cetz.draw.content(
        "a.end",
        text(purple)[$accent(u, arrow) - accent(v, arrow)$],
        anchor: "south",
        padding: 0.025,
        angle: "a.end",
      )
    }))
  ]
]

== Scalar Multiplication

$
  c times vec(x_1, x_2, x_3) = vec(c times x_1, c times x_2, c times x_3)
$

#example[

  $
    accent(a, arrow) = vec(2, 1)
    \
    \
    \
    3 accent(a, arrow) = #text(red)[$3$] vec(2, 1) = vec(#text(red)[$3$] dot 2, #text(red)[$3$] dot 1) = vec(6, 3)
  $

  #align(center)[
    #frame(cetz.canvas(length: 5cm, {
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -7,
        y-min: -7,
        x-max: 7,
        y-max: 7,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("a", (0, 0))
          plot.add-anchor("b", (2, 1))
          plot.add-anchor("c", (0, 0))
          plot.add-anchor("d", (6, 3))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.c", "plot.d", stroke: red, mark: (fill: red))
      cetz.draw.line("plot.a", "plot.b", stroke: green, mark: (fill: green))
    }))
  ]

  $
    accent(a, arrow) = vec(2, 1)
    \
    \
    \
    -1 accent(a, arrow) = #text(red)[$-1$] vec(2, 1) = vec(#text(red)[$-1$] dot 2, #text(red)[$-1$] dot 1) = vec(-2, -1)
  $

  #align(center)[
    #frame(cetz.canvas(length: 5cm, {
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -3,
        y-min: -3,
        x-max: 3,
        y-max: 3,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("a", (0, 0))
          plot.add-anchor("b", (2, 1))
          plot.add-anchor("c", (0, 0))
          plot.add-anchor("d", (-2, -1))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.c", "plot.d", stroke: red, mark: (fill: red))
      cetz.draw.line("plot.a", "plot.b", stroke: green, mark: (fill: green))
    }))
  ]
]
