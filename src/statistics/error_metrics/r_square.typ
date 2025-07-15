#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/suiji:0.4.0"

#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath

== R-squared

Proportion of variance explained by the model

$
R^2 = 1 - (sum_(i=1)^n (y_i - hat(y)_i)^2) / (sum_(i=1)^n (y_i - overline(y)_i)^2)
$

- 1: model explains all the variance in the dependent variable

- 0: model explains none of the variance in the dependent variable


#eg[
  
  #let rng = suiji.gen-rng(4)
  #let n = 25
  #let mu = 0
  #let sigma = 20
  #let a = 3
  #let b = -3
  #let noise = suiji.normal(rng, loc: mu, scale: sigma, size: n).at(1)
  #let reg_line = range(n).map(x => a * x + b)
  #let d = reg_line.zip(noise).map(tup => tup.at(0) + tup.at(1))

  #let mean = d.sum() / d.len()
  
  #let data = range(n).zip(d)

  *Step 1*: Fit the Regression Model

  *Step 2*: Compute *Total Sum of Squares* (SST)

  $
  "SST" = sum_(i=1)^n (y_i - overline(y))^2
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      set-style(
        axes: (
          x: (stroke: 0pt), 
          y: (stroke: 0pt),
          shared-zero: false
        )
      )

      plot.plot(
        size: (10,5),
        axis-style: "school-book",
        x-label: none,
        y-label: none,
        y-tick-step: none,
        x-tick-step: none,
        x-min: - 1, x-max: data.len() + 1,
        y-min: d.sorted().at(0) - 5, y-max: d.sorted().at(-1) + 5,
      {
        plot.add(
          data,
          mark: "o",
          mark-size: 0.1,
          style: (fill: none, stroke: none),
          mark-style: (fill: black, stroke: black),
        )
        
        for (x, y) in data {
          plot.add-vline(
            x,
            min: y,
            max: mean,
            style: (fill: black, stroke: (dash: "dotted")),
          )
        }

        plot.add-hline(
          mean,
          style: (fill: none, stroke: green),
        )
      }
    )
    })
  ]

  *Step 3*: Compute *Regression Sum of Squares* (SSR)

  $
  "SSR" = sum_(i=1)^n = (hat(y)_i - overline(y))^2
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      set-style(
        axes: (
          x: (stroke: 0pt), 
          y: (stroke: 0pt),
          shared-zero: false
        )
      )

      plot.plot(
        size: (10,5),
        axis-style: "school-book",
        x-label: none,
        y-label: none,
        y-tick-step: none,
        x-tick-step: none,
        x-min: - 1, x-max: data.len() + 1,
        y-min: d.sorted().at(0) - 5, y-max: d.sorted().at(-1) + 5,
      {
        plot.add(
          data,
          mark: "o",
          mark-size: 0.1,
          style: (fill: none, stroke: none),
          mark-style: (fill: black, stroke: black),
        )
        
        plot.add(
          domain: (-1, 50),
          x => a * x + b,
          style: (stroke: red),
        )
        
        for (x, y) in data {
          plot.add-vline(
            x,
            min: mean,
            max: a*x + b,
            style: (fill: black, stroke: (dash: "dotted")),
          )
        }

        plot.add-hline(mean)
      }
    )
    })
  ]

  

  *Step 4*: Compute *Residual Sum of Squares* (SSE)

  $
  "SSE" = sum_(i=1)^n = (y_i - hat(y)_i)^2
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      set-style(
        axes: (
          x: (stroke: 0pt), 
          y: (stroke: 0pt),
          shared-zero: false
        )
      )

      plot.plot(
        size: (10,5),
        axis-style: "school-book",
        x-label: none,
        y-label: none,
        y-tick-step: none,
        x-tick-step: none,
        x-min: -1, x-max: data.len() + 1,
        y-min: d.sorted().at(0) - 5, y-max: d.sorted().at(-1) + 5,
      {
        plot.add(
          data,
          mark: "o",
          mark-size: 0.1,
          style: (fill: none, stroke: none),
          mark-style: (fill: black, stroke: black),
        )
        
        plot.add(
          domain: (-1, 50),
          x => a * x + b,
          style: (stroke: red),
        )
        
        for (x, y) in data {
          plot.add-vline(
            x,
            min: y,
            max: a * x + b,
            style: (fill: black, stroke: (dash: "dotted")),
          )
        }
      }
    )
    })
  ]

  *Step 5*: Calculate *$R^2$*

  $
  R^2 = "SSR" / "SST" = 1 - "SSE" / "SST"
  $
]

== Adj R-squared

Adjusts the  $R^2$  value based on the number of predictors (penalty for adding non-informative variables)

$
"Adj" R^2 = 1 - (1 - R^2) (n - 1) / (n - p - 1)
$


