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



