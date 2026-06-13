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
  #let pts = {
    let acc = ()
    for (radius, color) in points_colors {
      for i in range(n_points) {
        let angle = 2 * calc.pi * i / n_points
        acc.push((radius * calc.cos(angle), radius * calc.sin(angle), color))
      }
    }
    acc
  }
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-n, n),
    ylim: (-n, n),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, subticks: none, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, subticks: none, ticks: none),
    ..pts.map(p => lq.plot(
      (p.at(0),),
      (p.at(1),),
      mark: "o",
      stroke: none,
      mark-color: p.at(2),
    )),
  )
]
