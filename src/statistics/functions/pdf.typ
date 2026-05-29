#import "/lib/imports.typ": *
#show: formatting

== PDF (Probability Density Function)

Function that describes the likelihood of a continuous random variable taking on a particular value

#align(center)[
  #frame(cetz.canvas({
    import draw: *

    set-style(
      axes: (
        x: (stroke: 0pt),
        y: (stroke: 0pt, tick: (label: (offset: 1em))),
        shared-zero: false
      )
    )

    let mu = 0
    let sigma = 1
    
    plot.plot(
      size: (10, 3),
      axis-style: "school-book",
      x-tick-step: none,
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-min: -4., 
      x-max: 4.,
      y-min: 0., 
      y-max: 0.4,
      legend: "inner-north-west",
      {
        plot.add(
          x => gaussian_pdf(x, mu, sigma), 
          domain: (-5, 5), 
          style: (stroke: black),
        )
        plot.add(
          x => gaussian_pdf(x, mu, sigma), 
          domain: (-5, 5), 
          style: (stroke: (thickness: 10pt, paint: red.transparentize(75%)))
        )
      })
  }))
]

Properties:
- The area under the curve of a PDF over the entire range of possible values equals 1
- The PDF itself is non-negative everywhere
- The probability that the variable falls within a certain range is given by the integral of the PDF over that range

=== Relationship to the CDF

The PDF is the derivative of the CDF; integrating the PDF back recovers the CDF:

$
  f(x) = dif / (dif x) F(x) quad <==> quad F(x) = integral_(-infinity)^x f(t) dif t
$

