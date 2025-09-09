#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/result.typ": result
#import "../utils/blob.typ": draw-blob
#import "../utils/prerequisites.typ": prerequisites

#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot

#import "@preview/cetz:0.3.1"

== Bias Variance Tradoff

#prerequisites(
  dependents: (),
  prereqs: (
    // link("../statistics/dispersion/variance.typ")[Variance],
    // link("../statistics/dispersion/bias.typ")[Bias],
  )
)

We have:

- $f(x)$: True function
- $y = f(x) + epsilon, "where" epsilon tilde cal(N)(0, sigma^2)$: Observation with noise
- $hat(f)(x)$: Model

*Bias (systematic error)*

$
  "Bias"(x) = EE[hat(f)(x)] - f(x)
$

- Train the same model on many different training sets
- Plot all the fitted curves together
- Compute the average of those fitted curves
- Compare that average curve to the true function $f(x)$.
The difference is the bias

Consistently accross datasets

*Variance (random error)*

$
  "Variance"(x) = EE[(hat(f)(x) - EE[hat(f)(x)])^2]
$

- Train the same model on many different training sets.
- Plot all the fitted curves together
The spread of those curves around their average prediction at each $x$ is the variance
- Low variance on training set
- High variance on test set

Inconsistent across different data

#eg[

  *True Function*: 
  
  $
    x^2
  $

  *Observations*:

  Observations differ due to noise.

  #align(center)[
    #table(
      columns: (auto, auto, auto),
      inset: 1em,
      align: center + horizon,
      [Dataset 1], [Dataset 2], [Dataset 3],
      [1.1], [0.5], [1.2],
      [-0.2], [0.3], [-0.1],
      [1.05], [1.2], [0.7],
    )
  ]

  #let f_true(x) = calc.pow(x, 2)

  #let data_true = (
    (-1, f_true(-1)),
    (0, f_true(0)),
    (1, f_true(1)),
  )
  #let dataset_1 = (
    (-1, 1.1),
    (0, -0.2),
    (1, 1.05),
  )
  #let dataset_2 = (
    (-1, 0.5),
    (0, 0.3),
    (1, 1.2),
  )
  #let dataset_3 = (
    (-1, 1.2),
    (0, -0.1),
    (1, 0.7),
  )

#grid(
  columns: (auto, auto, auto),
  align: horizon + center,
  row-gutter: 1em,
  [Dataset 1], [Dataset 2], [Dataset 3],
  [
    #canvas({
      import draw: *

      plot.plot(
        size: (5, 5),
        axis-style: "scientific",
        x-tick-step: 1,
        y-tick-step: 1,
        x-label: [],
        y-label: [],
        x-min: -2., 
        x-max: 2.,
        y-min: -0.25, 
        y-max: 1.25,
        legend: "north-east",
        {
          plot.add(
            domain: (-2, 2),
            f_true, 
            style: (stroke: black), 
            mark: "none"
          )
          plot.add(
            dataset_1,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: red, stroke: none),
            style: (stroke: none),
          )
          for ((x, y), (x1, y1))in dataset_1.zip(data_true) {
            plot.add-vline(
              x,
              min: y,
              max: y1,
              style: (stroke: (paint: red))
            )
          }
          plot.add(
            data_true,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
            style: (stroke: none),
          )
        }
      )
    })
  ], 
  [
    #canvas({
      import draw: *

      plot.plot(
        size: (5, 5),
        axis-style: "scientific",
        x-tick-step: 1,
        y-tick-step: 1,
        x-label: [],
        y-label: [],
        x-min: -2., 
        x-max: 2.,
        y-min: -0.25, 
        y-max: 1.25,
        legend: "north-east",
        {
          plot.add(
            domain: (-2, 2),
            f_true, 
            style: (stroke: black), 
            mark: "none"
          )
          plot.add(
            dataset_2,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: blue, stroke: none),
            style: (stroke: none),
          )
          for ((x, y), (x1, y1))in dataset_2.zip(data_true) {
            plot.add-vline(
              x,
              min: y,
              max: y1,
              style: (stroke: (paint: blue))
            )
          }
          plot.add(
            data_true,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
            style: (stroke: none),
          )
        }
      )
    })
  ], 
  [
    #canvas({
      import draw: *

      plot.plot(
        size: (5, 5),
        axis-style: "scientific",
        x-tick-step: 1,
        y-tick-step: 1,
        x-label: [],
        y-label: [],
        x-min: -2., 
        x-max: 2.,
        y-min: -0.25, 
        y-max: 1.25,
        legend: "north-east",
        {
          plot.add(
            domain: (-2, 2),
            f_true, 
            style: (stroke: black), 
            mark: "none"
          )
          plot.add(
            dataset_3,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: green, stroke: none),
            style: (stroke: none),
          )
          for ((x, y), (x1, y1))in dataset_3.zip(data_true) {
            plot.add-vline(
              x,
              min: y,
              max: y1,
              style: (stroke: (paint: green))
            )
          }
          plot.add(
            data_true,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
            style: (stroke: none),
          )
        }
      )
    })
  ],
  [
    #table(
      columns: (auto, auto),
      inset: 1em,
      align: (left, right),
      [$epsilon(-1)$], [0.1],
      [$epsilon(0)$], [-0.2],
      [$epsilon(1)$], [0.05],
    )
  ], [
    #table(
      columns: (auto, auto),
      inset: 1em,
      align: (left, right),
      [$epsilon(-1)$], [-0.5],
      [$epsilon(0)$], [0.3],
      [$epsilon(1)$], [0.2],
    )
  ], [
    #table(
      columns: (auto, auto),
      inset: 1em,
      align: (left, right),
      [$epsilon(-1)$], [0.2],
      [$epsilon(0)$], [-0.1],
      [$epsilon(1)$], [-0.3],
    )
  ]
)

*Average accross datasets*

- $x = -1$

$
  hat(f)_"avg" (-1) = (1.1 + 0.5 + 1.2)  / 3 = 2.8 / 3 approx colorMath(0.933, #purple)
$

- $x = 0$

$
  hat(f)_"avg" (0) = (-0.2 + 0.3 - 0.1)  / 3 = colorMath(0, #purple)
$

- $x = 1$

$
  hat(f)_"avg" (1) = (1.05 + 1.2 + 0.7)  / 3 = 2.95 / 3 approx colorMath(0.983, #purple)
$

#text(size: 24pt, [Bias])

*Bias at each point*


- $x = -1$

$
  "Bias"(-1) = colorMath(0.933, #purple) - 1 = colorMath(-0.067, #orange)
$

- $x = 0$

$
  "Bias"(-0) = colorMath(0, #purple) - 0 = colorMath(0, #orange)
$

- $x = 1$

$
  "Bias"(1) = colorMath(0.983, #purple) - 1 = colorMath(-0.017, #orange)
$

*Overall Bias*

Mean Square Bias

$
  "Bias"^2 = 1/n sum^n_(i=1)(EE[hat(f)(x_i)] - f(x_i))^2
$

$
  "Bias"^2 approx ((colorMath(-0.067, #orange))^ 2 + colorMath(0, #orange)^2 + (colorMath(-0.017, #orange))^2) / 3 = 0.0016
$

#text(size: 24pt, [Variance])

*Deviations*

- $x = -1$

$
  d_1 &= 1.1 - colorMath(0.933, #purple) = 0.166 \
  d_2 &= 0.5 - colorMath(0.933, #purple) = -0.433 \
  d_3 &= 1.2 - colorMath(0.933, #purple) = 0.266 \
$

$
  d_1^2 &= 0.028 \
  d_2^2 &= 0.188 \
  d_3^2 &= 0.071 \
$

$
  "Var"(-1) = (0.028 + 0.188 + 0.071) / 3 = colorMath(0.096, #orange)
$

- $x = 0$

$
  d_1 &= -0.2 - colorMath(0, #purple) = -0.2 \
  d_2 &= 0.3 - colorMath(0, #purple) = 0.3 \
  d_3 &= 0.1 - colorMath(0, #purple) = -0.1 \
$

$
  d_1^2 &= 0.04 \
  d_2^2 &= 0.09 \
  d_3^2 &= 0.01 \
$

$
  "Var"(-1) = (0.04 + 0.09 + 0.01) / 3 = colorMath(0.047, #orange)
$

- $x = 1$

$
  d_1 &= 1.05 - colorMath(0.983, #purple) = 0.067 \
  d_2 &= 1.2 - colorMath(0.983, #purple) = 0.217 \
  d_3 &= 0.7 - colorMath(0.983, #purple) = -0.283 \
$

$
  d_1^2 &= 0.004 \
  d_2^2 &= 0.047 \
  d_3^2 &= 0.08 \
$

$
  "Var"(1) = (0.004 + 0.047 + 0.08) / 3 = colorMath(0.044, #orange)
$

*Overall Variance*

Average Variance

$
  (colorMath(0.096, #orange) + colorMath(0.047, #orange) +colorMath( 0.044, #orange)) / 3 approx 0.062
$

]


Overfitting

#align(center)[
  #table(
    columns: range(6).map(_ => auto),
    align: horizon,
    inset: 1em,
    [*Model\ Complexity*], [*Bias*], [*Variance*], [*Traning\ Error*], [*Test\ Error*], [*Situation*], 
    [Too Simple], [High], [Low], [High], [High], [Underfitting], 
    [Just Right], [Moderate], [Moderate], [Low], [Lowest], [Good\ Generalization], 
    [Too Complext], [Low], [High], [Very Low], [High], [Overfitting], 
  )
]

#let data = (
  (0.,         0.09934283),      
  (0.05263158, 0.29704661),
  (0.10526316, 0.74375042),
  (0.15789474, 1.14177245),
  (0.21052632, 0.92256959),
  (0.26315789, 0.9497571),
  (0.31578947, 1.23161589),
  (0.36842105, 0.88921086),
  (0.42105263, 0.38205252),
  (0.47368421, 0.2731066),
  (0.52631579, -0.25727813),
  (0.57894737, -0.56909334),
  (0.63157895, -0.68733146),
  (0.68421053, -1.29842938),
  (0.73684211, -1.34156806),
  (0.78947368, -1.08185777),
  (0.84210526, -1.0397327),
  (0.89473684, -0.55136325),
  (0.94736842, -0.50630428),
  (1.        , -0.28246074),
)

#let f1(x) = 0.968 + -2.005 * calc.pow(x, 1)

#let f2(x) = -0.068 + 12.134 * calc.pow(x, 1) + -36.060 * calc.pow(x, 2) + 23.951 * calc.pow(x, 3)

#let f3(x) = 0.099 + 560.092 * calc.pow(x, 1) + -30196.239 * calc.pow(x, 2) + 670093.820 * calc.pow(x, 3) + -8240509.686 * calc.pow(x, 4) + 63978288.580 * calc.pow(x, 5) + -336651398.666 * calc.pow(x, 6) + 1251770636.215 * calc.pow(x, 7) + -3369131367.041 * calc.pow(x, 8) + 6638391292.468 * calc.pow(x, 9) + -9577148937.546 * calc.pow(x, 10) + 9999060435.138 * calc.pow(x, 11) + -7350418827.953 * calc.pow(x, 12) + 3606448825.648 * calc.pow(x, 13) + -1059663131.190 * calc.pow(x, 14) + 140964235.978 * calc.pow(x, 15)

#grid(
  columns: (auto, auto, auto),
  column-gutter: 2em,
  row-gutter: 0em,
  align: horizon + center,
  [
    #canvas({
      import draw: *
      
      plot.plot(
        size: (5, 5),
        axis-style: "scientific",
        x-tick-step: none,
        y-tick-step: none,
        x-label: [],
        y-label: [],
        x-min: 0., 
        x-max: 1.,
        y-min: -2., 
        y-max: 2.,
        legend: "north-east",
        {
          plot.add(
            f1, 
            domain: (0, 2), 
            style: (stroke: red + 2pt),
          )
          
          plot.add(
            data,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
            style: (stroke: none),
          )
        })
    })
  ],
  [
    #canvas({
      import draw: *
      
      plot.plot(
        size: (5, 5),
        axis-style: "scientific",
        x-tick-step: none,
        y-tick-step: none,
        x-label: [],
        y-label: [],
        x-min: 0., 
        x-max: 1.,
        y-min: -2., 
        y-max: 2.,
        legend: "north-east",
        {
          plot.add(
            f2, 
            domain: (0, 2), 
            style: (stroke: red + 2pt),
          )
          
          plot.add(
            data,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
            style: (stroke: none),
          )
        })
    })
  ],
  [
    #canvas({
      import draw: *
      
      plot.plot(
        size: (5, 5),
        axis-style: "scientific",
        x-tick-step: none,
        y-tick-step: none,
        x-label: [],
        y-label: [],
        x-min: 0., 
        x-max: 1.,
        y-min: -2., 
        y-max: 2.,
        legend: "north-east",
        {
          plot.add(
            f3, 
            domain: (0, 2), 
            style: (stroke: red + 2pt),
          )
          
          plot.add(
            data,
            mark: "o",
            mark-size: 0.2,
            mark-style: (fill: black, stroke: none),
            style: (stroke: none),
          )
        })
    })
  ],
  [Underfit\ High Bias\ Low Variance], 
  [Fit\ Low Bias\ Low Variance], 
  [Overfit\ Low Bias\ High Variance]
)

Bias-Variance Tradoff

#align(center)[
  #canvas({
    import draw: *

    let bias_squared(x) = calc.pow((10 / (x + 1)), 2)
    let variance(x) = calc.pow((x / 3), 2)
    let total_error(x) = bias_squared(x) + variance(x)
    
    plot.plot(
      size: (12, 8),
      axis-style: "scientific",
      x-tick-step: none,
      y-tick-step: none,
      x-label: [Model Complexity],
      y-label: [Error],
      x-min: 0., 
      x-max: 15.,
      y-min: 0., 
      y-max: 25.,
      legend: "inner-north-east",
      {
        plot.add(
          bias_squared, 
          domain: (0, 20), 
          style: (stroke: blue + 2pt),
          label: $"Bias"^2$
        )
        plot.add(
          variance, 
          domain: (0, 20), 
          style: (stroke: red + 2pt),
          label: [Variance]
        )
        plot.add(
          total_error, 
          domain: (0, 20), 
          style: (stroke: green + 2pt),
          label: [Total Error]
        )
      })
  })
]