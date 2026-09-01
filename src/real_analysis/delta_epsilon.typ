#import "/lib/imports.typ": *
#import "@local/tystats:0.1.0": norm, poisson, expon

#import "@preview/tiptoe:0.4.0"
#import "@preview/komet:0.2.0"

= Delta Epsilon

== Continuous at a Point

A function $f : D subset.eq RR arrow RR$ is continuous at the point $a in D$ if:

$
  forall epsilon gt 0 quad exists delta gt 0 quad forall x in D : (abs(x - a) lt delta arrow.double abs(f(x) - f(a)) lt epsilon)
$

== Continous Function

If $f$ is coninuous at every point in the domain $D$, then we say that $f$ is continuous on $D$

```lean
def IsContinuousAt
  (D : Set RR) (f : D arrow RR) (a : D) : Prop :=
  forall epsilon gt 0, exists delta gt 0, forall x : D, 
  (|x.val - a.val| lt delta arrow |f x - f a| lt epsilon)

def IsContinuous
  (D : Set RR) (f : D arrow RR) : Prop :=
  forall a : D, IsContinuousAt D f a
```
=== Constant

Let $f : RR arrow RR$ be a function given by $f(x) := x$, where $c in RR$. That is, $f$ is a constant function. Then $f$ is continuous at every point $a in RR$.

#let c = 1
#let f_const(x) = {
  c
}
#let x = lq.linspace(0, 10, num: 200)
#let y = x.map(f_const)

#lq.diagram(
  xaxis: (subticks: none, ticks: none),
  yaxis: (subticks: none, ticks: none),
  lq.plot(x, y, mark: none, stroke: blue + 1.5pt, label: $x arrow.bar c$),
)

$
  forall epsilon gt 0 quad exists delta gt 0 quad forall x in D : \
  abs(x - a) lt delta arrow.double abs(f(x) - f(a)) lt epsilon
$

Let $a in RR$. Let $epsilon gt 0$.

We choose $delta := 1 gt 0$.

Let $x in RR$.

Then $abs(f(x) - f(a)) = abs(c - c) = abs(1 - 1) = abs(0) = 0 lt epsilon$

So, $abs(x - a) lt delta arrow.double abs(f(x) - f(a)) lt epsilon$

Therefore, $f$ is continuous at $a$

```lean
theorem constant_function_is_continuous_at_a_point
  (D : Set RR) (c : RR) (a : D) :
  IsContinuousAt D (fun _ imp c) a := by
    dsimp [IsContinuousAt]
    intro epsilon hepsilonbigger0
    exists 1
    simp only [one_pos, true_and]

    intro x _h_xdelta_criterion
    simp only [sub_self, abs_zero]
    exact hepsilonbigger0
```

=== Linear

#let a = 0.1
#let b = 1
#let f_lin(x) = {
  a * x + b
}
#let x = lq.linspace(0, 10, num: 200)
#let y = x.map(f_lin)

#lq.diagram(
  xaxis: (subticks: none, ticks: none),
  yaxis: (subticks: none, ticks: none),
  lq.plot(x, y, mark: none, stroke: blue + 1.5pt),
)



=== Parabola

#let f_lin(x) = {
  x * x
}
#let x = lq.linspace(-10, 10, num: 200)
#let y = x.map(f_lin)

#lq.diagram(
  xaxis: (subticks: none, ticks: none),
  yaxis: (subticks: none, ticks: none),
  lq.plot(x, y, mark: none, stroke: blue + 1.5pt),
)

=== Hyperbola

#let f(x) = 1 / x
#let eps = 0.1
#let x-neg = lq.linspace(-10, -eps, num: 200)
#let x-pos = lq.linspace(eps, 10, num: 200)

#lq.diagram(
  xaxis: (subticks: none, ticks: none),
  yaxis: (subticks: none, ticks: none),
  lq.plot(x-neg, x-neg.map(f), mark: none, stroke: blue + 1.5pt),
  lq.plot(x-pos, x-pos.map(f), mark: none, stroke: blue + 1.5pt),
)