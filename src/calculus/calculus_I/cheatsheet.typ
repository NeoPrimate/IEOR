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
  lim_(x arrow x_0) f(x) arrow.l.r.double.long forall epsilon gt 0, exists delta gt 0 "s.t." 0 < abs(x - x_0) < delta arrow.double abs(f(x) - L) lt epsilon
$

#let f(x) = x * x

#let L = 12

#let x0 = calc.sqrt(L)

#let delta = 0.1
#let epsilon = 1

#let L_minus_epsilon = L - epsilon
#let L_plus_epsilon = L + epsilon

#let x0_minus_delta = calc.sqrt(L_minus_epsilon)
#let x0_plus_delta = calc.sqrt(L_plus_epsilon)

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
