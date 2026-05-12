#import "/lib/imports.typ": *
#show: formatting



A vector that has a #link(<linear-algebra-norm>)[norm] (length) of exactly 1.

For a vector $accent(v, arrow)$ in $n$-dimensional space, the unit vector $hat(v)$ in the same direction is:

$
  hat(v) = accent(v, arrow) / (|| accent(v, arrow) ||)
$

*Key properties*:

- $||hat(v)|| = 1$
- $hat(v)$ points in the same direction as $accent(v, arrow)$

#example[
  Find the unit vector with the same direction as $accent(a, arrow) = vec(3, 4)$.

  $
    || accent(a, arrow) || = sqrt(3^2 + 4^2) = sqrt(25) = 5
  $

  $
    hat(u) = accent(a, arrow) / ||accent(a, arrow)|| = vec(3 / 5, 4 / 5)
  $

  $
    || hat(u) || = sqrt((3/5)^2 + (4/5)^2) = sqrt(9 / 25 + 16 / 25) = sqrt(1) = 1 #h(0.5em) checkmark
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
        x-min: 0,
        y-min: 0,
        x-max: 5,
        y-max: 5,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("a", (0, 0))
          plot.add-anchor("b", (3, 4))
          plot.add-anchor("c", (0, 0))
          plot.add-anchor("d", (3 / 5, 4 / 5))
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.05)
      cetz.draw.line("plot.c", "plot.d", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$hat(u)$], anchor: "south", padding: 0.05)
    }))
  ]
]
