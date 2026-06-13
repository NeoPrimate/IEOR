#import "/lib/imports.typ": *
#show: formatting

Quantifies the spread or dispersion of a set of data points in a dataset

- Population

$
  sigma^2 = 1/N sum_(i=1)^n (x_i - mu)^2
$

- Sample

$
  s^2 = 1/(n - 1) sum_(i=1)^n (x_i - macron(x))^2
$

#example[

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
      calc.pow((y.at(0) - mean), 2) + calc.pow((y.at(1) - mean), 2) + calc.pow((y.at(2) - mean), 2) + calc.pow((y.at(3) - mean), 2) + calc.pow((y.at(4) - mean), 2) + calc.pow((y.at(5) - mean), 2)
    )
    /
    #(y.len() - 1)
    =
    #(
      (
        calc.pow((y.at(0) - mean), 2) + calc.pow((y.at(1) - mean), 2) + calc.pow((y.at(2) - mean), 2) + calc.pow((y.at(3) - mean), 2) + calc.pow((y.at(4) - mean), 2) + calc.pow((y.at(5) - mean), 2)
      ) / (y.len() - 1)
    )
  $

  #align(center)[
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (0, 7),
      ylim: (9, 25),
      xaxis: (ticks: none),
      yaxis: (tick-args: (tick-distance: 5)),
      ..data.map(p => lq.vlines(p.at(0), min: calc.min(mean, p.at(1)), max: calc.max(mean, p.at(1)), stroke: (paint: red, dash: "dashed"))),
      lq.hlines(mean, stroke: red),
      lq.plot(x, y, mark: "o", stroke: none, mark-color: black),
    )
  ]

]
