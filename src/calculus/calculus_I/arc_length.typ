#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.3.2"
#import "@preview/cetz-plot:0.1.1"
#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *
})

== Arc Length

#let f(x) = 0.1*(x*x*x)+0.5
  
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *
      
      plot.plot(
        size: (5, 5),
        axis-style: "school-book",
        x-tick-step: none,
        x-min: -3.2, 
        x-max: 3.2,
        y-tick-step: none, 
        y-min: -3.2, 
        y-max: 3.2,
        legend: "inner-south-east",
        label: none,
        {
          plot.add(
            f,
            domain: (-3, 3), 
            style: (stroke: black),
          )

          plot.add-vline(-3, min: f(-3), max: 0, style: (stroke: (dash: "dotted", paint: black)))
          plot.annotate({
            content((-3, 0.3), [$a$])
          })

          plot.add-hline(f(-3), min: -3, max: 0, style: (stroke: (dash: "dotted", paint: black)))
          plot.annotate({
            content((0.3, f(-3)), [$c$])
          })

          plot.add-vline(3, min: 0, max: f(3), style: (stroke: (dash: "dotted", paint: black)))
          plot.annotate({
            content((3, -0.3), [$b$])
          })

          plot.add-hline(f(3), min: 0, max: 3, style: (stroke: (dash: "dotted", paint: black)))
          plot.annotate({
            content((-0.3, f(3)), [$d$])
          })

          plot.add(
            ((-3,f(-3)),),
            mark: "o",
            mark-size: 0.15,
            mark-style: (stroke: black, fill: black)
          )
          
          plot.add(
            ((3,f(3)),),
            mark: "o",
            mark-size: 0.15,
            mark-style: (stroke: black, fill: black),
          )

          plot.add-hline(f(1.1), min: 1.1, max: 1.1+1, style: (stroke: black))
          plot.annotate({
            content((1.6, 0.39), [$d x$])
          })

          plot.add-vline(1.1+1, min: f(1.1), max: f(1.1+1), style: (stroke: black))
          plot.annotate({
            content((2.4, 1), [$d y$])
          })

          plot.annotate({
            content((1.4, 1.3), [$d s$])
          })
        }
      )
    })
  ]

$
  d s = sqrt((d x)^2 + (d y)^2)
$

$
  s = integral d s = integral sqrt((d x)^2 + (d y)^2) 
$

$
  integral^b_a sqrt(1 + ((d y) / (d x))^2) quad d x
$

$
  integral^d_c sqrt(((d y) / (d x))^2 + 1) quad d y
$