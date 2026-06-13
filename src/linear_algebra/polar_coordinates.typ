#import "/lib/imports.typ": *
#show: formatting

Describe a point's position using a distance from the origin and an angle from a reference direction.

The coordinates are $(r, theta)$, where:
- $r$: distance from the origin
- $theta$: angle from the positive $x$-axis (in radians or degrees)

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
        acc.push((radius, angle, color))
      }
    }
    acc
  }
  #let theta_lines = (0, calc.pi / 2, calc.pi, 3 * calc.pi / 2, 2 * calc.pi)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (0, n - 1),
    ylim: (0, 2 * calc.pi),
    xlabel: $rho$,
    ylabel: $theta$,
    xaxis: (tick-args: (tick-distance: 1)),
    yaxis: (ticks: (
      (0, $0$),
      (calc.pi, $pi$),
      (2 * calc.pi, $2 pi$),
    )),
    ..theta_lines.map(theta_val => lq.plot(
      (0, 5),
      (theta_val, theta_val),
      mark: none,
      stroke: gray + 0.5pt,
    )),
    ..pts.map(p => lq.plot(
      (p.at(0),),
      (p.at(1),),
      mark: "o",
      stroke: none,
      mark-color: p.at(2),
    )),
  )
]
