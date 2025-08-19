#import "../utils/examples.typ": eg

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

== Cartesian & Polar Coordinates

#linebreak()

=== Cartesian

Describe a point's position using perpendicular axes

The coordinates are $(x, y)$, where:
- $x$: horizontal distance from the origin
- $y$: vertical distance from the origin

=== Polar

Describe a point's position using a distance from the origin and an angle from a reference direction

The coordinates are 
$(r, θ)$, where:
- $r$: distance from the origin θ
- $θ$: angle from the positive $x$-axis (in radians or degrees)


#linebreak()

#let create-gradient-colors(n, start-color: blue, end-color: red) = {
  let grad = gradient.linear(start-color, end-color)
  range(n).map(i => grad.sample(i / (n - 1) * 100%))
}

#let n = 6
#let n_points = 12

#let points = range(n, step: 1)
#let colors = create-gradient-colors(n)

#let points_colors = points.zip(colors)

#let cartesian = align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

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
                mark-style: (stroke: none, fill: color)
              )
            }
          }
        }
      )
    })
  ]

  #let polar = align(center)[
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
        
        plot.plot(
          size: (5, 5),
          axis-style: "school-book",
          x-tick-step: 1,
          x-min: 0,
          x-max: n - 1,
          y-tick-step: none,
          y-ticks: range(n).map(n => {
            if n >= 2 {
              (n*calc.pi, str(n) + $pi$)
            } else if n == 1 {
              (n*calc.pi, $pi$)
            } else {
              (n*calc.pi, 0)
            }
          }),
          y-min: 0,
          y-max: 2 * calc.pi,
          x-label: $rho$,
          y-label: $theta$,
          {
            
            
            for (radius, color) in points_colors {
              
              
              for i in range(n_points) {
                let angle = 2 * calc.pi * i / n_points
                // In polar coordinates: x-axis = rho, y-axis = theta
                let rho = radius
                let theta = angle
                
                plot.add(
                  ((rho, theta),),
                  mark: "o",
                  mark-size: 0.15,
                  mark-style: (stroke: none, fill: color)
                )
              }
            }
            
            // Add horizontal lines to show constant theta values
            for theta_val in (0, calc.pi/2, calc.pi, 3*calc.pi/2, 2*calc.pi) {
              plot.add(
                ((0, theta_val), (5, theta_val)),
                style: (stroke: gray + 0.5pt),
              )
            }
          }
        )
      })
    ]

#grid(
  columns: (1fr, 1fr),
  gutter: 3pt,
  cartesian,
  polar,
)