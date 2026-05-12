#import "/lib/imports.typ": *
#show: formatting

Describe a point's position using perpendicular axes.

The coordinates are $(x, y)$, where:
- $x$: horizontal distance from the origin
- $y$: vertical distance from the origin

#let create-gradient-colors(n, start-color: blue, end-color: red) = {
  let grad = gradient.linear(start-color, end-color)
  range(n).map(i => grad.sample(i / (n - 1) * 100%))
}

#let n = 6
#let n_points = 12

#let points = range(n, step: 1)
#let colors = create-gradient-colors(n)

#let points_colors = points.zip(colors)

#align(center)[
  #frame(cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(axes: (shared-zero: false))

    plot.plot(
      size: (5, 5),
      axis-style: "school-book",
      x-tick-step: none,
      x-min: -n,
      x-max: n,
      y-tick-step: none,
      y-min: -n,
      y-max: n,
      legend: "inner-south-east",
      label: none,
      {
        for (radius, color) in points_colors {
          for i in range(n_points) {
            let angle = 2 * calc.pi * i / n_points
            let x = radius * calc.cos(angle)
            let y = radius * calc.sin(angle)
            plot.add(
              ((x, y),),
              mark: "o",
              mark-size: 0.15,
              mark-style: (stroke: none, fill: color),
            )
          }
        }
      },
    )
  }))
]
