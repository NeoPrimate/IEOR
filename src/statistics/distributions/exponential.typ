#import "/lib/imports.typ": *

== Exponential distribution

$
f(x bar lambda) = lambda e^(- lambda x)
$

#align(center)[
  #canvas({
    import draw: *

    set-style(
      axes: (
        x: (stroke: 0pt), 
        y: (stroke: 0pt),
        shared-zero: false
      )
    )

    let lambda = 3
    
    plot.plot(
      size: (5, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-min: 0., 
      x-max: 2.,
      y-min: 0., 
      y-max: 3,
      legend: "inner-north-west",
      {
        plot.add(
          x => exponential_pdf(x, lambda), 
          domain: (0, 5), 
          style: (stroke: black),
        )
      })
  })
]



