#import "/lib/imports.typ": *
#import "@local/tystats:0.1.0": norm, poisson, expon

#import "@preview/tiptoe:0.4.0"
#import "@preview/komet:0.2.0"

#show table: it => align(center, it)

#let obar(x) = math.accent(x, math.macron)

#set heading(numbering: "1.1.")

= Math Review

== Functions

$
  f: &X &arrow &Y \
  &x &arrow &f(x) \
$

independent $arrow$ dependent

=== Linear Functions

$
  y = a x + b
$

Where:
- $a$: slope
- $b$: intercept
$
  "Profit" 
  &= "Revenue" - "Cost" \
  &= (p) dot V - (F + c dot V) \
  &= (p - c) dot V - F \
$

=== Asymptotes

+ Horizontal
  - $y = a$
+ Oblique
  - $y = a x + b$
+ Vertical
  - $x = C$

#let f(x) = calc.sin(x) / x
#let x = lq.linspace(-25, 25, num: 100)

#lq.diagram(
  xlim: (-25, 25),
  lq.plot(x, f, mark: none, stroke: blue),
  lq.hlines(0)
)

Hotizontal and Oblique Asymptotes

$
  f(x) = A + B x + theta (x)
$

Where:
- $lim_(x arrow infinity) theta (x) = 0$

$
  f(x) / x 
  &= (A + B x + theta (x)) / x \
  &= A / x + B + (theta (x)) / x \ 
  &= 0 + B + 0 \
  &= B
$

Since $x = infinity$

+ If the limit exists and it is a real number then $exists$ asymptote 
  - If $B = 0$ aymptote is horizontal
  - If $B eq.not 0$ aymptote is oblique
+ If limit is $infinity$ or $-infinity$ asymptote does not exist

Then

$
  f(x) - B x 
  &= A + cancel(B x) + theta (x) - cancel(B x) \
  &= A + theta (x) arrow.long_(x arrow infinity) A
$

Horizontal & Oblique

$
  f(x) = A x + B + theta(x), quad "where" lim_(x arrow infinity) theta(x) = 0
$

- Computation of $A$

$
  f(x) / x = A + B / x + theta(x) / x
$
$
  A = lim_(x arrow infinity) f(x) / x
$

- Computation of $B$
$
  f(x) - A x = B + theta(x)
$
$
  B = lim_(x arrow infinity) (f(x) - A x)
$

- Asymptote: $y = A x + B$

=== Sandwich rule

$
  (-1) / f(x) < ... < 1 / f(x)
$

=== Veritcal Asymptotes

$
  x = C
$

Find $x = C$ such that $lim_(x arrow C) f(x) = infinity$

*Exercise*

1. Horizontal & Oblique

$
  f(x) = (2 x^2 + x + 7) / (x - 6) + (-x^2 + 5x + 5) / (x + 3)
$

$
  lim_(x arrow infinity) f(x) 
  &= lim_(x arrow infinity) ((2 x^2 + x + 7) / (x - 6) + (-x^2 + 5x + 5) / (x + 3)) / x \
  &= lim_(x arrow infinity) (2 x^2 + x + 7) / (x (x - 6)) + (-x^2 + 5x + 5) / (x (x + 3)) \
  &= lim_(x arrow infinity) underbrace((2 x^2 + x + 7) / (x^2 - 6 x), 2) + underbrace((-x^2 + 5x + 5) / (x^2 + 3 x), -1) \
  &= 2 - 1 \
  &= 1 \
  & = A in RR
$

$
  
$

$
  A = 1 eq.not 0 arrow.double "oblique asymptote"
$

D d R q (table)

$
  B 
  &= lim_(x arrow infinity) (f(x) - A x) \
  &= lim_(x arrow infinity) underbrace((2x^2 + x + 7) / (x - 6), 2x + 13 + 85 / (x - 6)) + underbrace((-x^2 + 5x + 5) / (x + 3), -x + 8 - 19 / (x + 3)) - x \
  &= lim_(x arrow infinity) cancel(2x) + 13 + underbrace(86 / (x - 6), 0) cancel(- x) + underbrace(8 - 19 / (x + 3), 0) cancel(- x) = 21 \
$

Therefore:

$
  A = 1 \ 
  B = 21 \
  y = x + 21
$

2. Vertical

$
  f(x) = (2 x^2 + x + 7) / (x - 6) + (-x^2 + 5x + 5) / (x + 3)
$

$
  lim_(x arrow 6) f(x) = infinity arrow.double x = 6 \
  lim_(x arrow -3) f(x) = infinity arrow.double x = -3 \
$

3 asymptotes
- $y = x + 21$
- $x = 6$
- $x = -3$

== Continuity

A function $f : D arrow RR$ is said to be *contnuous* as $x_0 in D$ if there exists $lim_(x arrow x_0) f(x) = f(x_0)$, that is, if $forall epsilon gt 0$ there exists $delta gt 0$ such that:

$
  forall x in D quad "with" quad ||x - x_0|| lt delta quad arrow.double quad ||f(x) - f(x_0)|| lt epsilon
$

- A function is continuous in an interval iff it is continuous in evert oint in that interval
- Sum perserves continuity
- Product perserves continuity
- Quotient perserves continuity (unless denominator is zero)
- Composition perserves continuity
- Polynomial, exponentials, sin, cos, odd roots are continuous
- Log and even roots are continuous in their domains

== Convexity

$
  f(lambda x + (1 - lambda) y) lt.eq lambda f(x) + (1 - lambda) f(y), quad 0 lt.eq lambda lt.eq 1, quad x, y in "Dom" f
$

Any local minima of a convex function is also a global minima

$
  min quad &f(x) \
  s.t. quad &g_i(x) lt.eq 0 quad i = 1, dots, m \
  &h_i(x) eq 0 quad i = 1, dots, n \
$

$
  max f(x) quad arrow.l.r quad min -f(x)
$

= Derivatives

$
  f: S arrow RR, quad (dif f) / (dif x) (x_0) = f'(x_0) = lim_(x arrow x_0) (f(x) - f(x_0)) / (x - x_0),quad x_0 in D
$

*Instintanous rate of change* at a given point

Slope of the tangent line at that point

Differentiation rules

$
  [x^a]' = a x^(a - 1)
$

$
  [alpha dot f(x) + beta dot g(x)]' = alpha dot f'(x) + beta dot g'(x)
$

$
  [f(x) dot g(x)]' = f'(x) dot g(x) + f(x) dot g'(x)
$

$
  [f(x) / g(x)]' = (f'(x) dot g(x) - f(x) dot g'(x)) / g(x)
$

$
  [f(g(x))]' = f'(g(x)) dot g'(x)
$

If $f'(x) gt.eq 0$ for all $x in (a, b)$, $f(x)$ is increasing in $(a, b)$

$
  f' gt.eq 0 arrow.double f "increasing" \
  f' lt.eq 0 arrow.double f "decreasing" \
$

== Optimization

$
  
  f("units") = 500000 + 75 dot "units" \
  D("price") = 20000 - 80 dot "price" \
$

$
  "profit" = "revenue" - "cost"
$

$
  C("price") = 500000 + 75 dot (20000 - 80 dot "price")
$

$
  P(p) 
  &= p dot D(p) - C(p) \ 
  &= p dot (20000 - 80 p) - [500000 _ 75 dot (20000 - 80p)] \
  &= -80p^2 + 26000p - 2000000 \
$

Solve: 

$
  max quad P(p) = -80p^2 + 26000p - 2000000
$

Local max / min in $x_0 in (a, b)$ is $f'(x) = 0$

$x_0$ is a *critical point*

If $x_0$ is a critical point of $f(x)$ ($f'(x_0) = 0$), then:
- $f$ has a local min at $x_0$ with a value if $f''(x_0) lt 0$
- $f$ has a local max at $x_0$ with a value if $f''(x_0) gt 0$

If $f''(x_0) = 0$: undertermined (recursively / iteratively derive until positive or negative)

Extreme points can be:
- Non differentiable points (absolute function)
- Bundaries (end of the interval) of the function

Weierstrass Theorem

Is a function is continuous on an interval $[a, b]$, then $f$ must attain a maximum and minium, each at least once. That is, there exists $c$ and $d$ in $[a, b]$ such that:

$
  f(c) gt.eq f(x) gt.eq f(d) forall x in [a, b]
$

3 possibilities:
- f is not differentiable in $x_0$
- $f'(x_0) = 0$
- $x_0$ is an end of interval $[a, b]$ ($x_0 = a$ or $x_0 = b$)

$
  max quad P(p) = -80p^2 + 26000p - 2000000
$

#let f(x) = -80 * calc.pow(x, 2) + 26000 * x - 200000
#let crit = 162.5
#let x = lq.linspace(crit - 200, crit + 200, num: 100)

#let df(x) = -160 * x + 26000

#let ddf(x) = -160

#grid(
  columns: 1,
  gutter: 1em,
  [
    #lq.diagram(
      xaxis: (
        subticks: none,
        ticks: ((crit, box(inset: (top: 0em), text(size: 0.7em)[$crit$])),),
      ),
      yaxis: (subticks: none, ticks: none),
      lq.plot(x, f, mark: none, stroke: blue),
      lq.vlines(crit, stroke: red)
    )
  ],
  [
    #lq.diagram(
      xaxis: (
        subticks: none,
        ticks: ((crit, box(inset: (top: 0em), text(size: 0.7em)[$crit$])),),
      ),
      yaxis: (subticks: none, ticks: none),
      lq.plot(x, df, mark: none, stroke: blue),
      lq.hlines(0, stroke: black),
      lq.vlines(crit, stroke: red),
    )
  ],
  [
    #lq.diagram(
      xaxis: (subticks: none, ticks: none),
      yaxis: (
        subticks: none,
        ticks: ((-160, box(inset: (top: 0em), text(size: 0.7em)[$-160$])),),
      ),
      lq.plot(x, ddf, mark: none, stroke: blue),
    )
  ]
)

== EOQ

- $D$: Constant demand rate (units per unit time)
- $K$: Fixed Ordering cost (\$ per order)
- $h$: holding cost (\$ per inventory unit per unit time)
- $Q = x / D$: ordering cycle of the pattern

How much to order?

Total cost per unit time

$
  "TCU" 
  &= ("total holding cost per cycle" + "total ordering cost per cycle") / Q \
  &= (h dot x / 2 dot Q + K) / Q \
  &= (h dot x / 2 cancel(dot Q)) / cancel(Q) + K / Q \
$

$
  Q = x / D
$

$
  "TCU"(x) 
  &= h dot x / 2 + K / (x / D) \
  &= h dot x / 2 + (D k) / x \ 
$

$
  min quad "TCU"(x) = h dot x / 2 + (D k) / x
$

Solve:

$
  "TCU"'(x) = h / 2 - (D dot K) / x^2 = 0
$

$
  (D dot K) / x^2 = h / 2 \
  x^2 = (2 D K) / h \
  x^* = plus.minus sqrt((2 D K) / h)
$

$
  "TCU"''(x) = 2 dot (D dot K) / x^3 \
  "TCU"''(x^*) gt 0 \
$

$
  Q^* = x^* / D = sqrt((2 K) / (D h))
$

Global minimum for $"TCU"(x)$ when $x gt.eq 0$

= Lagrange Multipliers

Cobb-Douglas function

$
  f(x, y) = 200 dot x^(2/3) y^(1/3)
$

Use Largangian to find extremum points

= Integrals

- Definite
- Indefinite

$
  dif / (dif x) integral^x_a f(t) dif t = f(x) 
$

Indefinite integral:

$
  integral f(x) dif x = F(x) + C
$

with $F'(x) = f(x)$


Barrow's rule:

$
  integral^b_a f(x) dif x = F(a) - F(b)
$

== Integration Rules

Immediate integral rules (tables)

Integration by *parts*

$
  integral u dot dif v = u dot v - integral v dot dif u
$

Integration by *change*

$
  integral f(x) dif x
$

Chnage of variables:

$
  x = x(u) \
  dif x = x'(u) dif u
$

$
  integral f(x(u)) dot x'(u) dif u
$

