#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.3.4"

= Cheatsheet

== Limits

Epsilon-Delta

For every distance $epsilon$ around $L$, there's a $delta$-range around $a$ that keeps $f(x)$ within $epsilon$ of $L$.

$
  lim_(x arrow x_0) f(x) = L arrow.l.r.double.long forall epsilon gt 0, exists delta gt 0 "s.t." 0 < abs(x - x_0) < delta arrow.double abs(f(x) - L) lt epsilon
$

The limit of $f(x)$ as $x$ approaches $x_0$ equals $L$ if and only if, for every $epsilon gt 0$, there exists a $delta gt 0$ such that, whenever $0 lt abs(x - x_0) lt delta$, implies that $abs(f(x) - L) lt epsilon$

#line(length: 100%)

#align(center)[
  #table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Limit Type*], [*Name*], [*Quantifiers*],
      [$x arrow x_0, f(x) arrow L$], [Epsilon-Delta], [$forall epsilon, exists delta$],
      [$x arrow x_0, f(x) arrow infinity$], [M-Delta], [$forall M, exists delta$],
      [$x arrow infinity, f(x) arrow L$], [epsilon-N], [$forall epsilon, exists N$],
      [$x arrow infinity, f(x) arrow infinity$], [M-N], [$forall M, exists N$],
    ),
    
  )
]

Finite $arrow$ Finite (*Epsilon-Delta*)

$
  lim_(x arrow colorMath(x_0, #red)) f(x) = colorMath(L, #red) arrow.l.r.double.long forall colorMath(epsilon, #red) gt 0, exists delta gt 0 "s.t." 0 < abs(x - x_0) < colorMath(delta, #red) arrow.double abs(f(x) - L) lt colorMath(epsilon, #red)
$

Finite $arrow$ Infinity (*M-Delta*)

$+ infinity$

$
  lim_(x arrow colorMath(x_0, #red)) f(x) = colorMath(+ infinity, #red) arrow.l.r.double.long forall colorMath(M, #red) gt 0, exists colorMath(delta, #red) gt 0 "s.t." 0 < abs(x - x_0) < colorMath(delta, #red) arrow.double f(x) gt colorMath(M, #red)
$

$- infinity$

$
  lim_(x arrow colorMath(x_0, #red)) f(x) = colorMath(- infinity, #red) arrow.l.r.double.long forall colorMath(M, #red) gt 0, exists colorMath(delta, #red) gt 0 "s.t." 0 < abs(x - x_0) < colorMath(delta, #red) arrow.double f(x) lt colorMath(- M, #red)
$

Infinity $arrow$ Finite (*Epsilon-N*)

$+ infinity$

$
  lim_(x arrow colorMath(+ infinity, #red)) f(x) = colorMath(L, #red) arrow.l.r.double.long forall colorMath(epsilon, #red) gt 0, exists colorMath(N, #red) gt 0 "s.t." x gt colorMath(N, #red) arrow.double abs(f(x) - L) lt colorMath(epsilon, #red)
$

$- infinity$

$
  lim_(x arrow colorMath(+ infinity, #red)) f(x) = colorMath(L, #red) arrow.l.r.double.long forall colorMath(epsilon, #red) gt 0, exists colorMath(N, #red) gt 0 "s.t." x lt colorMath(- N, #red) arrow.double abs(f(x) - L) lt colorMath(epsilon, #red)
$

Infinity $arrow$ Infinity (*M-N*)

$
  lim_(x arrow colorMath(plus.minus infinity, #red)) f(x) = colorMath(plus.minus infinity, #red) arrow.l.r.double.long forall colorMath(M, #red) gt 0, exists colorMath(N, #red) gt 0 "s.t." x lt colorMath(N, #red) arrow.double f(x) gt colorMath(M, #red)
$

#line(length: 100%)

// #let f(x) = x * x

// #let L = 12

// #let x0 = calc.sqrt(L)

// #let delta = 0.1
// #let epsilon = 1

// #let L_minus_epsilon = L - epsilon
// #let L_plus_epsilon = L + epsilon

// #let x0_minus_delta = calc.sqrt(L_minus_epsilon)
// #let x0_plus_delta = calc.sqrt(L_plus_epsilon)

// #align(center)[
//   #cetz.canvas(length: 6cm, {
//     cetz.plot.plot(
//       x-tick-step: none, 
//       y-tick-step: none,
//       y-min: 0,
//       y-max: 16,
//       x-min: 0,
//       x-max: 4,
//       x-grid: true,
//       y-grid: true,
//       axis-style: "school-book",
//       {
//         cetz.plot.add(
//           f, 
//           domain: (0, 4), 
//           style: (stroke: black),
//           label: none
//         )

//         // cetz.plot.add-hline(
//         //   L,
//         //   style: (stroke: black),
//         // )
//         // cetz.plot.add-hline(
//         //   L - epsilon,
//         //   style: (stroke: red),
//         // )
//         // cetz.plot.add-hline(
//         //   L + epsilon,
//         //   style: (stroke: red),
//         // )

//         // cetz.plot.add-vline(
//         //   x0,
//         //   style: (stroke: black),
//         // )
//         // cetz.plot.add-vline(
//         //   x0 - delta,
//         //   style: (stroke: red),
//         // )
//         // cetz.plot.add-vline(
//         //   x0 + delta,
//         //   style: (stroke: red),
//         // )

//         // cetz.plot.annotate({
//         //   plot.content((calc.pi, 0), [Here])
//         // })

//         // cetz.plot.add-fill-between(
//         //   domain: (0, 2*calc.pi),
//         //   (1, 2, 3),
//         //   (-1, -2, -3),
//         // )
//       }
//     )
//   })
// ]




== Derivatives

$
  (d f) / (d x) (x) = f'(x) = lim_(h arrow 0) (f(x + h) - f(x)) / h 
$



#eg[
  Let $f(x) = x^2$

  _*a. Find $f'(x)$*_

  $
    f'(x) = #result[2x]
  $

  _*b. Prove a*_

  $
    f'(x) 
    &= lim_(h arrow 0) (f(x + h) - f(x)) / ((cancel(x) + h) - cancel(x)) \
    &= lim_(h arrow 0) (f(x + h) - f(x)) / h \
    &= lim_(h arrow 0) ((x + h)^2 - x^2) / h \
    &= lim_(h arrow 0) (cancel(x^2) + 2 x h + h^2 - cancel(x^2)) / h \
    &= lim_(h arrow 0) (cancel(h) (2x + h)) / cancel(h) \
    &= lim_(h arrow 0) (2x + h) \
    &= lim_(h arrow colorMath(0, #red)) (2x + colorMath(0, #red)) \
    &= #result[2x]
  $

  _*c. Prove b*_

  $
    lim_(x arrow x_0) f(x) = L arrow.l.r.double.long forall epsilon gt 0, exists delta gt 0 "s.t." 0 < abs(x - x_0) < delta arrow.double abs(f(x) - L) lt epsilon
  $

  p.f.: 
  
  Let $epsilon gt 0$

  Choose $delta = epsilon$

  Suppose $0 < abs(h - 0) lt delta$

  Check 
  
  $
  abs(((x + h)^2 - x^2) / h - 2x)
  $

  $
    &= abs((cancel(x^2) + 2 x h + h^2 - cancel(x^2)) / h - 2x) \
    &= abs((cancel(h) (2x + h)) / cancel(h) - 2x) \
    &= abs(cancel(2x) + h - cancel(2x)) \
    &= #result[$abs(h) lt delta = epsilon$]
  $


]

== Integrals

== Differential

If you have a function:

$
  y = f(x)
$

Then the differential $dif u$ is defined as:

$
  dif y = f'(x) dot dif x
$

This means:

- $f'(x) = (dif y) / (dif x)$ is the derivative

- $dif x$ is a small change in $x$

- $dif y$ is the corresponding small change in $y$

So:

$
  dif y = (dif y) / (dif x) dot dif x
$

#eg[
  Let's say"

  $
    y = x^2
  $

  Then:

  $
    (dif y) / (dif x) = 2x
  $
]

#pagebreak()

#set page(margin: 0.5cm)

#align(center)[
  $
    d / (dif x) (integral colorMath(f(x), #red) dif x) = colorMath(f(x), #red)
  $

  $
    integral (d / (dif x) colorMath(f(x), #red)) dif x = colorMath(f(x), #red)
  $
]

#linebreak()

#table(
  columns: (auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [Rule], [$d / (dif x)$ Rule], [$d / (dif x)$ Example], [$integral$ Rule], [$integral$ Example]
  ),
  [Constant], [
    $
      d / (dif x)[c] = 0
    $
  ], [
    $
      d / (dif x)[7] = 0
    $
  ], [
    $
      integral colorMath(c, #red) dif x = colorMath(c, #red) x + C
    $
  ], [
    $
      integral 7 dif x = 7x + C
    $
  ],

  [Power], [
    $
      d / (dif x)[x^n] = n x^(n-1)
    $
  ], [
    $
      d / (dif x) [x^4] = 4x^3
    $
  ], [
    $
      integral x^n dif x = (x^(n+1)) / (n+1) + C \ (n eq.not -1)
    $
  ], [
    $
      integral x^3 dif x = x^4 / 4 + C
    $
  ],
  
  [Constant Multiple], [
    $
      d / (dif x)[colorMath(c, #red) f] = colorMath(c, #red) f'
    $
  ], [
    $
      d / (dif x) [3x^2] 
      &= 3 dot 2x \
      &= 6x
    $
  ], [
    $
      integral colorMath(c, #red) f dif x = colorMath(c, #red) integral f dif x
    $
  ], [
    $
      integral 3x^2 dif x 
      &= 3 dot x^3 / 3 \
      &= x^3 + C
    $
  ],

  [Sum], 
  [
    $
      d / (d x) [colorMath(f, #red) + colorMath(g, #blue)] = colorMath(f', #red) + colorMath(g', #blue)
    $
  ], 
  [
    $
      &d / (dif x) (x^2 + x) \
      &= d / (dif x) (x^2) + d / (dif x) (x) \
      &= 2x + 1
    $
  ], [
    $
      integral (colorMath(f, #red) + colorMath(g, #blue)) dif x \ = integral colorMath(f, #red) dif x + integral colorMath(g, #blue) dif x
    $
  ], [
    $
      &integral (x^2 + x) dif x \
      &= integral x^2 dif x + integral x dif x \
      &= x^3 / 3 + 3^2 / 2 + C
    $
  ],
  
  [Difference], 
  [
    $
      d / (d x) [colorMath(f, #red) - colorMath(g, #blue)] = colorMath(f', #red) - colorMath(g', #blue)
    $
  ], 
  [
    $
     &d / (dif x) (x^2 - x) \
     &= d / (dif x) (x^2) - d / (dif x) (x) \
     &= 2x - 1
    $
  ], [
    $
      integral (colorMath(f, #red) - colorMath(g, #blue)) dif x \ = integral colorMath(f, #red) dif x - integral colorMath(g, #blue) dif x
    $
  ], [
    $
      &integral (x^2 - x) dif x \
      &= integral x^2 dif x - integral x dif x \
      &= x^3 / 3 - x^2 / 2 + C
    $
  ],
  
  [Product], 
  [
    $
      d / (d x) [colorMath(f, #blue) colorMath(g, #red)] = colorMath(f', #blue) colorMath(g, #red) + colorMath(f, #blue) colorMath(g', #red)
    $
  ], [
    $
      &d / (dif x) [x sin x] \
      &= 1 dot sin x + x dot cos x
    $
  ], [
    Integration by Parts

    $
      integral u dif v = u v - integral v dif u
    $
  ], [

  ],

  [Quotient], 
  [
    $
    d / (d x)[colorMath(f, #red) / colorMath(g, #blue)] = (colorMath(f', #red) colorMath(g, #blue) - colorMath(f, #red) colorMath(g', #blue)) / colorMath(g, #blue)^2
    $
  ], 
  [
    $
      &d / (dif x) [x^2 / (x + 1)] \
      &= (2x (x + 1) - x^2 (1)) / (x + 1)^2 \
      &= (x^2 + 2x) / (x + 1)^2
    $
  ],
  [
    Algebraic Manipulation / Substitution
  ],
  [

  ],

  [Chain], 
  [
    $
    &d / (d x)[colorMath(f(colorMath(g(x), #blue)), #red)] \
    &= colorMath(f'(colorMath(g(x), #blue)), #red) dot colorMath(g'(x), #blue)
    $],
  [
    $
     &d / (dif x) [sin(x^2)] \
     &= cos(x^2) dot 2x
    $
  ], [
    Integration by Subsitution

    $
  integral f(g(x)) g'(x) dif x \
  = integral f(u) dif u
$
  ], [

  ],
  
  [Exponential], [
    $
      d / (dif x) [colorMath(e^x, #red)] = e^x
    $
  ], [
    $
      d / (dif x) [colorMath(e^x, #red)] = e^x
    $
  ], [
    $
      integral colorMath(e^x, #red) dif x = e^x + C
    $
  ], [
    $
      integral colorMath(e^x, #red) dif x = e^x + C
    $
  ],
  
  [], [
    $
      d / (d x) [a^x] = a^x ln(a)
    $
  ], [
    $
      d / (dif x) [2^x] = 2^x ln 2
    $
  ], [
    $
      integral a^x d x = (a^x) / (ln a) + C
    $
  ], [
    $
      integral 2^x dif x = 2^x / (ln 2) + C
    $
  ],
  
  [Logarithmic], [
    $
      d / (d x) [colorMath(ln, #red)(x)] = 1 / x
    $
  ], [
    $
      d / (d x) [colorMath(ln, #red)(x)] = 1 / x
    $
  ], [
    $
      integral colorMath(ln, #red)(x) dif x \
      = x ln x - x + C
    $
  ], [
    $
      integral colorMath(ln, #red)(x) dif x \
      = x ln x - x + C
    $
  ],
  
  [], [
    $
      d / (d x) [colorMath(log, #red)_a (x)] = 1 / (x ln(a))
    $
  ], [
    $
      d / (dif x) colorMath(log, #red)_2 (x) = 1 / (x ln(2))
    $
  ], [
    $
      integral colorMath(log, #red)_a (x) dif x = \
      = (x ln x) / (ln a) - x / (ln a) + C
    $
  ], [
    $
      integral colorMath(log, #red)_(10) (x) dif x \
      = (x ln x) / (ln 10) - x / (ln 10) + C
    $
  ],

  [Sin], [
    $
      d / (d x) [colorMath(sin, #red)(x)] = cos(x)
    $
  ], [
    $
      d / (d x) [colorMath(sin, #red)(x)] = cos(x)
    $
  ], [
    $
      integral colorMath(sin, #red)(x) dif x \
      = -cos x + C
    $
  ], [
    $
      integral colorMath(sin, #red)(x) dif x \
      = -cos x + C
    $
  ],
  
  [Cos], [
    $
      d / (d x) [colorMath(cos, #red)(x)] = -sin(x)
    $
  ], [
    $
      d / (d x) [colorMath(cos, #red)(x)] = -sin(x)
    $
  ], [
    $
      integral colorMath(cos, #red)(x) dif x \
      = sin x + C
    $
  ], [
    $
      integral colorMath(cos, #red)(x) dif x \
      = sin x + C
    $
  ],

  [Tan], [
    $
      d / (d x) [colorMath(tan, #red)(x)] \
      = sec^2(x)
    $
  ], [
    $
      d / (d x) [colorMath(tan, #red)(x)] \
      = sec^2(x)
    $
  ], [
    $
      integral colorMath(tan, #red)(x) dif x \ 
      = -ln abs(cos x) + C
    $
  ], [
    $
      integral colorMath(tan, #red)(x) dif x \ 
      = -ln abs(cos x) + C
    $
  ],
  
)

#pagebreak()

== Product Rule $arrow.long$ Integration by Parts

$
  integral u dif v = u v - integral v dif u
$

#eg[
  Given a function:

  $
    f(x) = x dot e^x
  $

  Integrate (by parts):

  $
    integral x dot e^x dif x
  $

  #linebreak()

  *Step 1:* Choose $u$ and $dif v$

  We choose:

  - $u = x$ (easy to *differentiate*)

  - $dif v = e^x$ (easy to *integrate*)

  #linebreak()

  *Step 2:* Compute $dif u$ and $v$

  - $u = x arrow.long dif u = dif x$

  - $dif v = e^x dif x arrow.long v = integral e^x dif x = e^x$

  #linebreak()

  *Step 3:* Plug into formula

  $
    integral x dot e^x dif x 
    &= u dot v - integral v dot dif u \
    &= x dot e^x dif x - integral e^x dot dif x \
  $

  #linebreak()

  *Step 4:* Compute the remaining integral:

  $
    integral e^x dif x = e^x
  $

  #linebreak()

  *Step 5:* Finish the expression:

  $
    integral x dot e^x 
    &= x dot e^x - e^x + C \
    &= e^x (x - 1) + C \
  $

]

== Chain Rule $arrow.long$ $u$-Substitution

$
  integral f(g(x)) g'(x) dif x = integral f(u) dif u
$


== Quotient Rule $arrow.long$ Algebraic Manipulation / Substitution