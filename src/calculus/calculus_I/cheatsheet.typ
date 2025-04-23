#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.2.2"

= Cheatsheet

== Limits

Epsilon-Delta

For every distance $epsilon$ around $L$, there's a $delta$-range around $a$ that keeps $f(x)$ within $epsilon$ of $L$.

$
  lim_(x arrow x_0) f(x) = L arrow.l.r.double.long forall epsilon gt 0, exists delta gt 0 "s.t." 0 < abs(x - x_0) < delta arrow.double abs(f(x) - L) lt epsilon
$

The limit of $f(x)$ as $x$ approaches $x_0$ equals $L$ if and only if, for every $epsilon gt 0$, there exists a $delta gt 0$ such that, whenever $0 lt abs(x - x_0) lt delta$, implies that $abs(f(x) - L) lt epsilon$

#line(length: 100%)

Finite $arrow$ Finite

$
  lim_(x arrow colorMath(x_0, #red)) f(x) = colorMath(L, #red) arrow.l.r.double.long forall colorMath(epsilon, #red) gt 0, exists delta gt 0 "s.t." 0 < abs(x - x_0) < colorMath(delta, #red) arrow.double abs(f(x) - L) lt colorMath(epsilon, #red)
$

Finite $arrow$ Infinity

$+ infinity$

$
  lim_(x arrow colorMath(x_0, #red)) f(x) = colorMath(+ infinity, #red) arrow.l.r.double.long forall colorMath(M, #red) gt 0, exists colorMath(delta, #red) gt 0 "s.t." 0 < abs(x - x_0) < colorMath(delta, #red) arrow.double f(x) gt colorMath(M, #red)
$

$- infinity$

$
  lim_(x arrow colorMath(x_0, #red)) f(x) = colorMath(- infinity, #red) arrow.l.r.double.long forall colorMath(M, #red) gt 0, exists colorMath(delta, #red) gt 0 "s.t." 0 < abs(x - x_0) < colorMath(delta, #red) arrow.double f(x) lt colorMath(- M, #red)
$

Infinity $arrow$ Finite

$+ infinity$

$
  lim_(x arrow colorMath(+ infinity, #red)) f(x) = colorMath(L, #red) arrow.l.r.double.long forall colorMath(epsilon, #red) gt 0, exists colorMath(N, #red) gt 0 "s.t." x gt colorMath(N, #red) arrow.double abs(f(x) - L) lt colorMath(epsilon, #red)
$

$- infinity$

$
  lim_(x arrow colorMath(+ infinity, #red)) f(x) = colorMath(L, #red) arrow.l.r.double.long forall colorMath(epsilon, #red) gt 0, exists colorMath(N, #red) gt 0 "s.t." x lt colorMath(- N, #red) arrow.double abs(f(x) - L) lt colorMath(epsilon, #red)
$

Infinity $arrow$ Infinity

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
  f'(x) = lim_(h arrow 0) (f(x + h) - f(x)) / h 
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