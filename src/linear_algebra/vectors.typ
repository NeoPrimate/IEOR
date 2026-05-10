#import "/lib/imports.typ": *

#set math.vec(delim: "[")

$
  "Vector" = "Magnitude" + "Direction"
$

#example[
  A car is moving:

  #linebreak()

  $
    underbrace(underbrace("3 MPH", "Magnitude"\ "(Speed" arrow "Scalar)") quad quad underbrace("East", "Direction"), "Velocity (Vector)")
  $

  #linebreak()

  #align(center)[
    #frame(cetz.canvas(length: 5cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -2,
        y-min: -3,
        x-max: 5,
        y-max: 5,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("a", (0, 0))
          plot.add-anchor("b", (3, 0))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red))
    }))
  ]
]

$
  accent(v, arrow) = vec(x_1, x_2)
$
