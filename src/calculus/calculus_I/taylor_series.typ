#import "/lib/imports.typ": *
#show: formatting

#title_1[Taylor Series (Expansion)]

Taylor polynomial

Approximate a complicated function near a point $a$ by a polynomial made from the function's derivatives at that point

$
  f(x) = sum_(n=0)^infinity (f^((n))(a)) / n! (x - a)^n
$

$
  f(x) =
  underbrace(
    underbrace(
      underbrace(
        f(x_0),
        *
      )
      + f'(x_0) (x - x_0),
      **
    )
    + 1/2! f''(a) (x - a),
    ***
  )
  + dots
  + 1/n! f^((n))(x_0) (x - a),
$

Where:

- $*$: Ensures value of the polynomial matches with the value of $f$ when $x = a$
- $**$: Ensures slope of the polynomial matches with the slope of $f$ when $x = a$
- $***$: Ensures rate of change of the polynomial matches with the rate of change of $f$ when $x = a$

Where:
- $f^((n))(a)$: $n$-th derivative of $f$ evaluated at $a$

#example[

  Setup

  $
    f(x) = x^2
  $

  Expand it around the point $a = 1$

  *Step 1*: Compute Derivatives

  - $f(x) = x^2$

  - $f'(x) = 2x$

  - $f''(x) = 2$

  *Step 2*: Evaluate at $x = 1$

  - $f(1) = 1^2 = 1$

  - $f'(1) = 2 dot 1 = 2$

  - $f''(1) = 2$

  *Step 3*: Write the Taylor expansion

  $
    f(x) & = f(1) + f'(1)(x - 1) + (f''(1))/2! (x - 1)^2 \
         & = 1 + 2(x - 1) + 2/2 (x - 1)^2 \
         & = 1 + 2(x - 1) + (x - 1)^2
  $

  *Step 3*: Expand

  $
    1 + 2(x - 1) + (x - 1)^2 = 1 + 2x - 2 + x^2 + 1 = x^2
  $

  It gives back the original function exactly
]

#example[

  #align(center)[

    #let xs = lq.linspace(-5, 5, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (-5, 5),
      ylim: (-5, 5),
      xlabel: $x$,
      ylabel: $f(x)$,
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, ticks: none),
      yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
      lq.plot(xs, x => x, mark: none, stroke: black),
      lq.plot(xs, x => x - calc.pow(x, 3) / calc.fact(3), mark: none, stroke: yellow, label: $x - x^3 / 3!$),
      lq.plot(xs, x => x - calc.pow(x, 3) / calc.fact(3) + calc.pow(x, 5) / calc.fact(5), mark: none, stroke: orange, label: $x - x^3 / 3! + x^5 / 5!$),
      lq.plot(xs, x => x - calc.pow(x, 3) / calc.fact(3) + calc.pow(x, 5) / calc.fact(5) - calc.pow(x, 7) / calc.fact(7), mark: none, stroke: green, label: $x - x^3 / 3! + x^5 / 5! - x^7 / 7!$),
      lq.plot(xs, x => calc.sin(x), mark: none, stroke: 2pt + red, label: $sin(x)$),
    )
  ]

  #align(center)[
    #let xs = lq.linspace(-5, 5, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (-5, 5),
      ylim: (-5, 5),
      xlabel: $x$,
      ylabel: $f(x)$,
      xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, ticks: none),
      yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
      lq.plot(xs, x => calc.sin(x), mark: none, stroke: 2pt + red, label: $sin(x)$),
      lq.plot(xs, x => 1, mark: none, stroke: yellow, label: $1$),
      lq.plot(xs, x => 1 - calc.pow(x - calc.pi / 2, 2) / 2, mark: none, stroke: orange, label: $1 - ((x - pi/2)^2) / 2$),
      lq.plot(xs, x => 1 - calc.pow(x - calc.pi / 2, 2) / 2 + calc.pow(x - calc.pi / 2, 4) / 24, mark: none, stroke: green, label: $1 - ((x - pi/2)^2) / 2 + ((x - pi/2)^4 / 4!$),
    )
  ]


]

#resources[
  - #link("https://www.youtube.com/watch?v=3d6DsjIBzJ4&t=1s")[Tyler Series (3B1B)]

]
