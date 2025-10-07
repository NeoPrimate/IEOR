#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/suiji:0.4.0": *

#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition
#import "../utils/distributions/gaussian.typ": gaussian_pdf

== Maximum Likelihood Estimation

$
  L(theta) = product_(i=1)^n f(x_i | theta)
$

Where:
- $f(x | theta)$: probability density (or mass) function for each observation

#let rng = gen-rng-f(10)

#let mu = 5
#let sigma = 2
#let n = 25

#let (rng, data) = normal(rng, loc: mu, scale: sigma, size: n)

#let xbar = data.sum() / data.len()
#let s = calc.sqrt(data.map(x => calc.pow(x - xbar, 2)).sum() / (data.len() - 1))

#let data_tup = data.zip(range(data.len()).map(_ => 0))

#let mus = range(mu - 3*sigma, mu + 4*sigma, step: 2)

#let likelihoods = mus.map(mu => {
  data.map(x => gaussian_pdf(x, mu, sigma)).product()
})

#let likelihoods_tup = mus.zip(likelihoods)

#align(center)[
  #grid(
    inset: 0em,
    gutter: 0.5em,
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
        set-style(
          axes: (
            y: (stroke: 0pt),
            x: (stroke: 0pt),
            shared-zero: false,
            tick: (stroke: 0pt),
            padding: 0pt,
          ),
          
        )

        plot.plot(
          size: (12,3),
          x-label: [$μ$],
          y-label: [$L(theta)$],
          x-tick-step: none, 
          y-tick-step: none,
          y-min: 0,
          y-max: calc.max(..likelihoods) + 1e-26,
          x-min: mu - 3*sigma,
          x-max: mu + 3*sigma,
          x-grid: none,
          y-grid: none,
          axis-style: "scientific",
          
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          name: "plot",
        {
          for mu_ in mus {
            plot.add-vline(mu_, style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)))
          }
          
          plot.add(
            domain: (mu - 3*sigma, mu + 3*sigma),
            samples: 200,
            mu => data.map(x => gaussian_pdf(x, mu, sigma)).product(),
            style: (stroke: (dash: none, paint: red, thickness: 1pt)),
          )
          
          plot.add(
            likelihoods_tup,
            mark: "o",
            mark-size: 0.25,
            mark-style: (fill: red, stroke: 2pt),
            style: (stroke: none),
          )
        }
      )
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
        set-style(
          axes: (
            y: (stroke: 0pt),
            x: (stroke: 0pt),
            shared-zero: false,
            tick: (stroke: 0pt),
            padding: 0pt,
          ),
          
        )

        plot.plot(
          size: (12,3),
          x-label: [$$],
          y-label: [$$],
          x-tick-step: none, 
          y-tick-step: none,
          y-min: 0,
          y-max: 0.25,
          x-min: mu - 3*sigma,
          x-max: mu + 3*sigma,
          x-grid: none,
          y-grid: none,
          axis-style: "scientific",
          
          axes: (
            stroke: black,
            tick: (stroke: black),
          ),
          name: "plot",
        {
          for mu_ in mus {
            plot.add(
              domain: (mu - 3*sigma, mu + 3*sigma),
              x => gaussian_pdf(x, mu_, sigma),
              style: (stroke: (dash: none, paint: red, thickness: 1pt)),
            )
            plot.add-vline(mu_, style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)))
          }
        }
      )
      })
    ],
    [
      #cetz.canvas({
        import cetz.draw: *
        import cetz-plot: *
        set-style(
          axes: (
            y: (stroke: 0pt),
            // x: (stroke: 0pt),
            shared-zero: false,
            tick: (stroke: 0pt),
            padding: 0pt,
          ),
          
        )

        plot.plot(
          size: (12,3),
          x-label: [$$],
          y-label: [$$],
          x-tick-step: none, 
          y-tick-step: none,
          y-min: 0,
          y-max: 0,
          x-min: mu - 3*sigma,
          x-max: mu + 3*sigma,
          x-grid: none,
          y-grid: none,
          axis-style: "scientific",
          
          name: "plot",
        {
          plot.add-hline(0, style: (stroke: (dash: none, paint: black, thickness: 1pt)))
          plot.add(
            data_tup,
            mark: "o",
            mark-size: 0.25,
            mark-style: (fill: red, stroke: 2pt),
            style: (stroke: none),
          )

          for mu_ in mus {
            plot.add-vline(mu_, style: (stroke: (dash: "dashed", paint: black, thickness: 1pt)))
          }
        }
      )
      })
    ]
  )
  
  
]

Log Likelihood

$
  cal(l) (theta) = log L(theta) = sum_(i=1)^n log f(x_i | theta)
$




