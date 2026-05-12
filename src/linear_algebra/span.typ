#import "/lib/imports.typ": *
#show: formatting

Represents the subspace of the vector space that is "covered" by these vectors through their linear combinations

If you have a set of vectors $v_1, v_2, dots, v_n$, the span of these vectors is the set of all vectors that can be written as:

$
  "Span"(v_1, v_2, dots, v_n) = {c_1 v_1 + c_2 v_2 + dots + c_n v_n | c_1, c_2, dots, c_n in RR}
$

Any vector in $RR^2$ can be represented by a linear combination with some combination of these vectors

#example[

  *1. Spanning $RR^2$*

  $
    "Span"(accent(a, arrow), accent(b, arrow)) = RR^2
  $

  $
    accent(a, arrow) = vec(1, 2)
    quad quad quad quad
    accent(b, arrow) = vec(0, 3)
  $

  $
    #text(red)[$3$] accent(a, arrow) + #text(red)[$(-2)$] accent(b, arrow) = vec(3 - 0, 6 - 6) = vec(3, 0)
  $

  #align(center)[
    #frame(cetz.canvas(length: 10cm, {
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
          plot.add-anchor("o", (0, 0))
          plot.add-anchor("a", (1, 2))
          plot.add-anchor("b", (0, 3))

          plot.add-anchor("c", (3, 6))
          plot.add-anchor("d", (0, -6))

          plot.add-anchor("e", (3, 0))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.025)

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$hat(u)$], anchor: "east", padding: 0.025)

      cetz.draw.line("plot.o", "plot.c", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$3 accent(a, arrow)$], anchor: "south", padding: 0.025)

      cetz.draw.line("plot.o", "plot.d", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$-2 accent(b, arrow)$], anchor: "west", padding: 0.025)

      cetz.draw.line("plot.c", "plot.e", stroke: purple, mark: (fill: purple), name: "line")
      cetz.draw.content(
        "line.end",
        text(purple)[$3 accent(a, arrow) + (-2) accent(b, arrow)$],
        anchor: "south-west",
        padding: 0.025,
      )
    }))
  ]

  Any point $accent(x, arrow)$ can be represented as a linear combination of $accent(a, arrow)$ and $accent(b, arrow)$

  1. Define the vectors

  $
    accent(a, arrow) = vec(1, 2)
    quad quad quad quad
    accent(b, arrow) = vec(0, 3)
    quad quad quad quad
    accent(x, arrow) = vec(x_1, x_2)
  $

  2. Express $accent(x, arrow)$ as a linear combinations

  $
    c_1 accent(a, arrow) + c_2 accent(b, arrow) = accent(x, arrow)
  $

  #h(1em) Which expands to

  $
    c_1 vec(1, 2) + c_2 vec(0, 3) = vec(x_1, x_2)
  $

  3. Set up the system of equations

  $
    1 c_1 + 0 c_2 & = x_1 quad quad (1) \
    2 c_1 + 3 c_2 & = x_2 quad quad (2) \
  $

  4. Express $c_1$: From equation (1), we can directly express $c_1$

  $
    c_1 = x_1
  $

  5. Substitute $c_1$ into equation (2)

  $
    2 x_1 + 3 c_2 = x_2
  $

  #h(1em) Rearranging gives:

  $
    3 c_2 = x_2 - 2 x_1
  $

  6. Solve for $c_2$ : Dividing both sides by 3 yields

  $
    c_2 = (x_2 - 2 x_1) / 3
  $

  7. Example with specific values: Let's say we want to find $c_1$ and $c_2$ when $accent(x, arrow) = vec(2, 2)$

  #h(1em) Substitute $x_1 = 2$ and $x_2 = 2$

  $
    c_1 = x_1 = 2 \
    c_2 = (2 - 2 dot 2) / 3 = - 2 / 3
  $

  8. Final linear combination: Now, substituting $c_1$ and $c_2$ back into the linear combination

  $
    2 accent(a, arrow) - 2 / 3 accent(b, arrow) = vec(2, 2)
  $

  #h(1em) Verifying

  $
    2 vec(1, 2) + 1 / 3 vec(0, 3) = vec(2, 2)
  $

  9. This shows that

  $
    2 accent(a, arrow) - 2 / 3 accent(b, arrow) = accent(x, arrow)
  $

  *2. Spanning Line in $RR^2$*

  Any linear combination of $accent(a, arrow)$ and $accent(b, arrow)$ will produce vectors that lie along the same line. This is the line through the origin in the direction of $accent(a, arrow)$ (or $accent(b, arrow)$), with all points on the line being scalar multiples of $accent(a, arrow)$

  $
    accent(a, arrow) = vec(2, 2)
    quad quad quad quad
    accent(b, arrow) = vec(-2, -2)
  $

  $
    #text(red)[$3$] accent(a, arrow) + #text(red)[$(-2)$] accent(b, arrow) = vec(6 - 4, 6 - 4) = vec(2, 2)
  $

  #align(center)[
    #frame(cetz.canvas(length: 10cm, {
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
          plot.add-anchor("o", (0, 0))
          plot.add-anchor("a", (2, 2))
          plot.add-anchor("b", (-2, -2))

          plot.add-anchor("c", (6, 6))
          plot.add-anchor("d", (4, 4))

          plot.add-anchor("e", (2, 2))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south-east", padding: 0.025)

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$hat(u)$], anchor: "east", padding: 0.025)

      cetz.draw.line("plot.o", "plot.c", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$3 accent(a, arrow)$], anchor: "south", padding: 0.025)

      cetz.draw.line("plot.o", "plot.d", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$-2 accent(b, arrow)$], anchor: "west", padding: 0.025)

      cetz.draw.line("plot.c", "plot.e", stroke: purple, mark: (fill: purple), name: "line")
      cetz.draw.content(
        "line.end",
        text(purple)[$3 accent(a, arrow) + (-2) accent(b, arrow)$],
        anchor: "north-west",
        padding: 0.025,
      )
    }))
  ]
]
