#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "../../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot

#import "@preview/cetz:0.3.1"

=== Variance

Quantifies the spread or dispersion of a set of data points in a dataset

- Population

$
sigma^2 = 1/N sum_(i=1)^n (x_i - mu)^2
$

- Sample

$
s^2 = 1/(n - 1) sum_(i=1)^n (x_i - macron(x))^2
$

#eg[

#let data = (
  (1, 10),
  (2, 12),
  (3, 13),
  (4, 17),
  (5, 20),
  (6, 24),
)

#let x = data.map(v => v.at(0))
#let y = data.map(v => v.at(1))

#let mean = y.sum() / y.len()

$
  [#y.map(str).join(", ")]
$

*Step 1*: Find mean

$
macron(x) = (#y.map(str).join(" + ")) / #y.len() = #y.sum() / #y.len() = #mean
$

*Step 2*: Subtract the Mean and Square the result

$
(#y.at(0) - #mean)^2 = #(y.at(0) - mean)^2 = #calc.pow((y.at(0) - mean), 2)
\
(#y.at(1) - #mean)^2 = #(y.at(1) - mean)^2 = #calc.pow((y.at(1) - mean), 2)
\
(#y.at(2) - #mean)^2 = #(y.at(2) - mean)^2 = #calc.pow((y.at(2) - mean), 2)
\
(#y.at(3) - #mean)^2 = #(y.at(3) - mean)^2 = #calc.pow((y.at(3) - mean), 2)
\
(#y.at(4) - #mean)^2 = #(y.at(4) - mean)^2 = #calc.pow((y.at(4) - mean), 2)
\
(#y.at(5) - #mean)^2 = #(y.at(5) - mean)^2 = #calc.pow((y.at(5) - mean), 2)
$

*Step 3*: Calculate variance

$
  s^2 = (
    #calc.pow((y.at(0) - mean), 2) + 
    #calc.pow((y.at(1) - mean), 2) + 
    #calc.pow((y.at(2) - mean), 2) + 
    #calc.pow((y.at(3) - mean), 2) + 
    #calc.pow((y.at(4) - mean), 2) + 
    #calc.pow((y.at(5) - mean), 2)
  )
  / 
  (#y.len() - 1) 
  = 
  #(
    calc.pow((y.at(0) - mean), 2) + 
    calc.pow((y.at(1) - mean), 2) + 
    calc.pow((y.at(2) - mean), 2) + 
    calc.pow((y.at(3) - mean), 2) + 
    calc.pow((y.at(4) - mean), 2) + 
    calc.pow((y.at(5) - mean), 2)
  )
  / 
  #(y.len() - 1) 
  = 
  #(
    (
      calc.pow((y.at(0) - mean), 2) + 
      calc.pow((y.at(1) - mean), 2) + 
      calc.pow((y.at(2) - mean), 2) + 
      calc.pow((y.at(3) - mean), 2) + 
      calc.pow((y.at(4) - mean), 2) + 
      calc.pow((y.at(5) - mean), 2)
    )
  / 
  (y.len() - 1)
  )
$

#align(center)[
  #canvas({
    import draw: *
    
    plot.plot(
      size: (5, 5),
      axis-style: "scientific",
      x-tick-step: none,
      y-tick-step: 5,
      x-label: [],
      y-label: [],
      x-min: 0., 
      x-max: 7.,
      y-min: 9., 
      y-max: 25.,
      legend: "north-east",
      {
        plot.add-hline(mean, style: (stroke: red))
        
        plot.add(
          data,
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: black, stroke: none),
          style: (stroke: none),
        )

        for (x, y) in data {
          plot.add-vline(
            x, 
            min: mean, 
            max: y,
            style: (stroke: (paint: red, dash: "dashed"))
          )
        }
      })
  })
]

]
