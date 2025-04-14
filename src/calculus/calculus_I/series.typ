#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.2.2"

== Series

Given the series $(a_n) = a_1 + a_2 + ...$, then

$
  sum_(n=1)^infinity a_n = a_1 + a_2 + dots
$

We form a sequence associated with the series, the sequence $(s_n)$ of its *partial sums*:

$
  s_1 &= a_1 \
  s_2 &= a_1 + a_2 \
  s_3 &= a_1 + a_2 + a_3 \
  &dots.v \
  s_n &= a_1 + a_2 + dots + a_n \
  &dots.v

$


#eg[
  $
    sum_(n=1)^infinity 1 / n^2
  $

  #let series = range(1, 51).map(n => (n, range(1, n+1).map(n => (1 / calc.pow(n, 2))).sum()))

  #let convergence = calc.pow(calc.pi, 2) / 6


  #align(center)[
    #cetz.canvas(length: 6cm, {
      cetz.plot.plot(
        x-tick-step: 10, 
        y-tick-step: 0.1,
        y-min: 1,
        y-max: 1.7,
        x-min: 0,
        x-max: 50,
        mark-style: (fill: black, stroke: black),
        {
          cetz.plot.add(
            series,
            mark: "o",
            mark-size: 0.02,
            mark-style: (fill: white)
          )
          cetz.plot.add-hline(convergence)
        }
      )
    })
  ]

]

=== Alternating

#eg[

  $
    sum_(n=1)^infinity ((-1)^(n+1)) / n
  $
  
  #let series = range(1, 50).map(n => (n, range(1, n+1).map(n => (calc.pow(-1, n+1) / n)).sum()))

  #let convergence = calc.ln(2)

  #align(center)[
    #cetz.canvas(length: 6cm, {
      cetz.plot.plot(
        x-tick-step: 10, 
        y-tick-step: 0.1,
        y-min: 0.5,
        y-max: 1,
        x-min: 0,
        x-max: 50,
        mark-style: (fill: black, stroke: black),
        {
          cetz.plot.add(
            series,
            mark: "o",
            mark-size: 0.02,
            mark-style: (fill: white),
          )
          cetz.plot.add-hline(convergence)
        }
      )
    })
  ]
]

=== Non-Convergent

#eg[
  $
    sum_(n=1)^infinity 1 / n
  $

  #let series = range(1, 50).map(n => (n, range(1, n+1).map(n => (1 / n)).sum()))

  #align(center)[
    #cetz.canvas(length: 6cm, {
      cetz.plot.plot(
        x-tick-step: 10, 
        y-tick-step: 1,
        y-min: 1,
        y-max: 4.5,
        x-min: 0,
        x-max: 50,
        mark-style: (fill: black, stroke: black),
        {
          cetz.plot.add(
            series,
            mark: "o",
            mark-size: 0.02,
            mark-style: (fill: white)
          )
        }
      )
    })
  ]
]
  
]

