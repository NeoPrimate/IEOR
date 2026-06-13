#import "/lib/imports.typ": *
#show: formatting

$
f(x bar lambda) = lambda e^(- lambda x)
$

#align(center)[
  #let lambda = 3
  #let xs = lq.linspace(0, 5, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (0, 2),
    ylim: (0, 3),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.plot(xs, x => expon.pdf(x, rate: lambda), mark: none, stroke: black),
  )
]
