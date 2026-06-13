#import "/lib/imports.typ": *
#show: formatting

== PDF (Probability Density Function)

Function that describes the likelihood of a continuous random variable taking on a particular value

#align(center)[
  #let xs = lq.linspace(-5, 5, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.plot(xs, x => norm.pdf(x), mark: none, stroke: (thickness: 10pt, paint: red.transparentize(75%))),
    lq.plot(xs, x => norm.pdf(x), mark: none, stroke: black),
  )
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

