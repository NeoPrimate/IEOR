#import "/lib/imports.typ": *
#show: formatting

$
  gradient f = lambda gradient g \
  g = 0
$

Constrained optimization problem:

$
   min & quad f(x) \
  s.t. & quad g_i (x) = 0 quad forall i = 1, dots, m \
       & quad h_j (x) = 0 quad forall j = 1, dots, p \
$

- $x in RR^n$: decision variables
- $f(x)$: objective function
- $g_i (x) = 0$: equality constraints
- $h_i (x) lt.eq 0$: inequality constraints

Lagrangian $cal(L) (x, lambda, mu)$:

$
  cal(L) (x, lambda, mu)
  =
  underbrace(f(x), "objective function")
  +
  underbrace(sum_(i=1)^m lambda_i g_i (x), "equality constraints")
  +
  underbrace(sum_(j=1)^p mu_j h_j (x), "inequality constraints")
$

- $lambda_i$: Lagrangian multipliers for equality constraints
- $mu_i$: Lagrangian multipliers for inequality constraints

#example[

]

#example[
  #let xs = lq.linspace(-1, 1, num: 200)
  #let y_up(x) = +calc.sqrt(calc.max(1 - x * x, 0))
  #let y_down(x) = -calc.sqrt(calc.max(1 - x * x, 0))
  #let cgrid = lq.linspace(-2, 2, num: 80)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-2, 2),
    ylim: (-2, 2),
    xlabel: [$x$],
    ylabel: [$y$],
    yaxis: (
      position: 0,
      tip: tiptoe.triangle,
      subticks: none,
      tick-args: (tick-distance: 5),
    ),
    xaxis: (
      position: 0,
      tip: tiptoe.triangle,
      filter: (value, distance) => value != 0,
      subticks: none,
      tick-args: (tick-distance: 5),
    ),
    lq.contour(
      cgrid,
      cgrid,
      (x, y) => x * y + 1,
      levels: (-3, -2, -1.5, -1, -0.5, 0, 0.5, 1.5, 2, 3, 4, 5),
      fill: true,
      map: (rgb("#8383c332"), rgb("#8383c332")),
    ),
    lq.plot(xs, y_up, mark: none, stroke: 1pt + black),
    lq.plot(xs, y_down, mark: none, stroke: 1pt + black),
  )

]
