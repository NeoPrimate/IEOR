#import "/lib/imports.typ": *
#show: formatting


#set math.vec(gap: 1em)
#set math.mat(gap: 1em)

#metadata(none) <newton_method>

#prerequisites(
  prereqs: (
    // link(<hessian_matrix>)[Hessian Matrix],
    // link(<gradient>)[Gradient],
  ),
  dependents: (),
)

Newton's method is an iterative numerical technique to find roots of a function (i.e., solutions to $f(x) = 0$).

*Step 1.* At each step, approximate $f(x)$ by its tangent line at the current guess $x_k$:

$
  f(x) approx f(x_k) + f'(x_k) (x - x_k)
$

*Step 2.* Set this approximation equal to 0:

$
  0 = f(x_k) + f'(x_k) (x - x_k)
$

*Step 3.* Solve for $x$:

$
  x = x_k - f(x_k) / (f'(x_k))
$

*Step 4.* This gives the update rule:

$
  x = x_k - f(x_k) / (f'(x_k))
$



== Newton's Method for Nonlinear Optimization

Used to find the *roots of the first derivative* $f'(x) = 0$, which correspond to the *local minima/maxima of the original function* $f(x)$.

Finding *stationary points* of a function $f(x)$, i.e., points where the gradient (derivative) is zero:
- 1D: $f'(x) = 0$
- nD: $gradient f(bold("x")) = bold("0")$

It can be derived from either linear approximation of the gradient or quadratic approximation of the function

=== 1D Linear Approximation

1. Start with the first-order (linear) Taylor expansion of the derivative around $x_k$:

$
  f'(x_(k+1)) approx f'(x_k) + f''(x_k)(x - x_k)
$

2. Stationary point condition: Set the derivative to zero to find a candidate minimum or maximum

$
  0 = f'(x_k) + f''(x_k)(x - x_k)
$

3. Solve for the next iterate $x_(k+1)$:

$
  x_(k+1) = x_k - (f'(x_k)) / (f''(x_k))
$

#align(center)[
  #let f(x) = calc.pow(x, 2)
  #let dfdx(x) = 2 * x
  #let x_k = 3
  #let y_k = f(x_k)
  #let m = dfdx(x_k)
  #let tangent(x) = m * (x - x_k) + y_k
  #let x_intercept = x_k - y_k / m
  #let xs = lq.linspace(0, 5, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 4cm,
    xlim: (0, 3.5),
    ylim: (-1, 10),
    xlabel: [$x$],
    ylabel: [$y$],
    xaxis: (tick-args: (tick-distance: 1)),
    yaxis: (tick-args: (tick-distance: 5)),
    lq.hlines(0, stroke: black),
    lq.plot(xs, f, mark: none, stroke: 1pt + black, label: [$f'(x)$]),
    lq.plot(xs, tangent, mark: none, stroke: 1pt + blue, label: [Linear approx of $f'(x)$]),
    lq.vlines(3, min: 0, stroke: red),
    lq.vlines(x_intercept, min: 0, stroke: green),
    lq.plot((3,), (f(3),), mark: "o", stroke: none, mark-color: red),
    lq.plot((x_intercept,), (0,), mark: "o", stroke: none, mark-color: green),
    lq.plot((x_intercept,), (f(x_intercept),), mark: "o", stroke: none, mark-color: green),
    lq.place(3, -0.3, [$x_k$]),
    lq.place(2.75, f(3) + 0.25, [$f(x_k)$]),
    lq.place(x_intercept - 0.25, -0.3, [$x_(k+1)$]),
    lq.place(x_intercept - 0.3, f(x_intercept) + 0.3, [$f(x_(k+1))$]),
  )
]

=== nD Linear Approximation

1. Start with the first-order (linear) Taylor expansion of the gradient around $x_k$:

$
  gradient f(bold("x")_(k+1)) approx gradient f(bold("x")_k) + H_k (bold("x")_(k+1) - bold("x")_k)
$

where $H_k = gradient^2 f(bold("x")_k)$ is the Hessian matrix

2. Stationary point condition: Set the gradient to zero to find a candidate minimum or maximum:

$
  bold(0) = gradient f(bold("x")_k) + H_k (bold("x")+(k+1) - bold("x")_k)
$

3. Solve for the next iterate $bold("x")_(k+1)$:

$
  bold("x")_(k+1) = bold("x")_k - H_k^(-1) gradient f(bold("x")_k)
$

=== 1D Quadratic Approximation

1. Start with the second-order (quadratic) Taylor expansion of the function around $x_k$:

$
  f_Q (x) = f(x_k) + f'(x_k) (x - x_k) + 1/2 f''(x_k)(x - x_k)^2
$

2. Minimize the quadratic approximation: Set the derivative of $f_Q (x)$ to zero:

$
  dif / (dif x) f_Q (x) = f'(x_k) + f''(x_k) (x - x_k) = 0
$

3. Solve for the next iterate $x_(k+1)$:

$
  x_(k+1) = x_k - (f'(x_k)) / (f''(x_k))
$

#align(center)[
  #let f(x) = calc.pow(x, 3) - 3 * x + 2
  #let dfdx(x) = 3 * calc.pow(x, 2) - 3
  #let d2fdx2(x) = 6 * x
  #let newton_step(x_k) = x_k - dfdx(x_k) / d2fdx2(x_k)
  #let x_k = 2
  #let x_k1 = newton_step(x_k)
  #let f_quad(x) = f(x_k) + dfdx(x_k) * (x - x_k) + 0.5 * d2fdx2(x_k) * calc.pow(x - x_k, 2)
  #let xs = lq.linspace(0, 2.5, num: 200)
  #lq.diagram(
    width: 6cm,
    height: 4cm,
    xlim: (0, 2.5),
    ylim: (-0.5, 5),
    xlabel: [$x$],
    ylabel: [$y$],
    xaxis: (tick-args: (tick-distance: 1)),
    yaxis: (tick-args: (tick-distance: 10)),
    lq.hlines(0, stroke: black),
    lq.plot(xs, f, mark: none, stroke: 1pt + black, label: [$f(x)$]),
    lq.plot(xs, x => f_quad(x), mark: none, stroke: 1pt + blue, label: [$f_Q (x)$ (quadratic approx)]),
    lq.vlines(x_k, min: 0, stroke: red),
    lq.vlines(x_k1, min: 0, stroke: green),
    lq.plot((x_k1,), (f_quad(x_k1),), mark: "o", stroke: none, mark-color: green),
    lq.plot((x_k1,), (f(x_k1),), mark: "o", stroke: none, mark-color: green),
    lq.plot((2,), (f(2),), mark: "o", stroke: none, mark-color: red),
    lq.place(x_k, -0.2, [$x_k$]),
    lq.place(x_k1, -0.2, [$x_(k+1)$]),
    lq.place(x_k1 + 0.3, f(x_k1), [$f(x_(k+1))$]),
    lq.place(2 + 0.25, f(2), [$f(x_k)$]),
  )
]

=== nD Quadratic Approximation

1. Start with the second-order (quadratic) Taylor expansion of the function around $x_k$:

$
  m_k (bold("p")) = f(bold("x")_k) + gradient f(bold("x")_k)^T bold("p") + 1/2 bold("p")^T H_k bold("p") \
  bold("p") = bold("x") - bold("x")_k
$

2. Minimize the quadratic approximation: Set the gradient of $m_k (bold("p"))$ with respect to $bold("p")$ to zero:

$
  gradient m_k (bold("p")) = gradient f(bold("x")_k) + H_k bold("p") = bold(0)
$

3. Solve for the step $bold("p")_k$ and next iterate $bold("x")_(k+1)$:

$
  bold("p")_k = -H_k^(-1) gradient f(bold("x")_k), quad quad
  bold("x")_(k+1) = bold("x")_k + bold("p")_k
$

#linebreak()

#align(center)[
  #let f(x) = calc.pow(x, 4) - 2 * calc.pow(x, 2) + 1
  #let dfdx(x) = 4 * calc.pow(x, 3) - 4 * x

  #grid(
    columns: (1fr, 1fr),
    [
      #figure(
        lq.diagram(
          width: 5cm,
          height: 5cm,
          xlim: (0, 2),
          ylim: (-0.5, 1.5),
          xaxis: (tick-args: (tick-distance: 1)),
          yaxis: (tick-args: (tick-distance: 1)),
          lq.plot(lq.linspace(-2, 2, num: 200), f, mark: none, stroke: 1pt + black),
          lq.hlines(0, stroke: black),
          lq.plot((1,), (0,), mark: "o", stroke: none, mark-color: black),
        ),
        caption: [$f(x)$],
        supplement: none,
      )
    ],
    [
      #figure(
        lq.diagram(
          width: 5cm,
          height: 5cm,
          xlim: (0, 2),
          ylim: (-2, 5),
          xaxis: (tick-args: (tick-distance: 1)),
          yaxis: (tick-args: (tick-distance: 2)),
          lq.plot(lq.linspace(-2, 2, num: 200), dfdx, mark: none, stroke: 1pt + black),
          lq.hlines(0, stroke: black),
          lq.plot((1,), (0,), mark: "o", stroke: none, mark-color: black),
        ),
        caption: [$f'(x)$],
        supplement: none,
      )
    ],
  )
]

=== Quadratic Approximation

$
  f_Q (x) = f(x_k) + f'(x_k) (x - x_k) + 1/2 f''(x_k) (x - x_k)^2
$

#align(center)[
  #let f(x) = calc.pow(x, 4) - 2 * calc.pow(x, 2) + 1
  #let dfdx(x) = 4 * calc.pow(x, 3) - 4 * x
  #let d2fdx2(x) = 12 * calc.pow(x, 2) - 4

  #let fQ(x) = f(x) + dfdx(x)

  #grid(
    columns: (1fr, 1fr),
    [
      #figure(
        lq.diagram(
          width: 5cm,
          height: 5cm,
          xlim: (0, 2),
          ylim: (-0.5, 1.5),
          xaxis: (tick-args: (tick-distance: 1)),
          yaxis: (tick-args: (tick-distance: 1)),
          lq.plot(lq.linspace(-2, 2, num: 200), f, mark: none, stroke: 1pt + black),
          lq.hlines(0, stroke: black),
          lq.plot((1,), (0,), mark: "o", stroke: none, mark-color: black),
        ),
        caption: [$f(x)$],
        supplement: none,
      )
    ],
    [
      #figure(
        lq.diagram(
          width: 5cm,
          height: 5cm,
          xlim: (0, 2),
          ylim: (-2, 5),
          xaxis: (tick-args: (tick-distance: 1)),
          yaxis: (tick-args: (tick-distance: 2)),
          lq.plot(lq.linspace(-2, 2, num: 200), dfdx, mark: none, stroke: 1pt + black),
          lq.hlines(0, stroke: black),
          lq.plot((1,), (0,), mark: "o", stroke: none, mark-color: black),
        ),
        caption: [$f'(x)$],
        supplement: none,
      )
    ],
  )
]


#example[
  $
    f(x) = x^5 quad quad quad f'(x) = 5x^4
  $

  #let f(x) = calc.pow(x, 5)
  #let dfdx(x) = 5 * calc.pow(x, 4)
  #let newton_update(x) = x - f(x) / dfdx(x)

  #let x_n = 2
  #let y_n = f(x_n)
  #let m = dfdx(x_n)

  #let tangent_line(x, x_k, y_k, m) = m * (x - x_k) + y_k

  #align(center)[

    #let xs = lq.linspace(0, 3, num: 200)
    #let tangents = {
      let xn = x_n
      let lines = ()
      for _ in range(3) {
        let yn = f(xn)
        let mm = dfdx(xn)
        lines.push((x: xn, y: yn, m: mm))
        xn = newton_update(xn)
      }
      lines
    }
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (0, 3),
      ylim: (-1, 40),
      xlabel: [$x_1$],
      ylabel: [$x_2$],
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
        tick-args: (tick-distance: 1),
      ),
      lq.plot(xs, x => calc.pow(x, 5), mark: none, stroke: 1pt + black),
      ..tangents.map(t => lq.plot(
        xs,
        x => tangent_line(x, t.x, t.y, t.m),
        mark: none,
        stroke: 1pt + red,
      )),
    )
  ]
]

Hello

== Multi-Dimensional

second-order iterative algorithm

uses both the
- first derivative (gradient)
- second derivative (Hessian)

Step 1. Start with initial guess $x_0$

Step 2. At each iteration $k$:
- Compute gradient $gradient f(x_k)$
- Compute Hessian $gradient^2 f(x_k)$
- Update:

$
  bold("x")_(k+1) = bold("x")_k - [gradient^2 f(bold("x")_k)]^(-1) gradient f(bold("x")_k)
$

$
  gradient f(bold("x")_k) = vec(
    (partial f) / (partial x_1) (bold("x")_k),
    (partial f) / (partial x_2) (bold("x")_k),
    dots.v,
    (partial f) / (partial x_n) (bold("x")_k),
  ) in RR^n
  quad quad quad quad
  gradient^2 f(bold("x")_k) = mat(
    (partial^2 f) / (partial x_1^2) (bold("x")_k), (partial^2 f) / (partial x_1 partial x_2) (bold("x")_k), dots, (partial^2 f) / (partial x_1 partial x_n) (bold("x")_k);
    (partial^2 f) / (partial x_2 partial x_1) (bold("x")_k), (partial^2 f) / (partial x_2^2) (bold("x")_k), dots, (partial^2 f) / (partial x_2 partial x_n) (bold("x")_k);
    dots.v, dots.v, dots.down, dots.v;
    (partial^2 f) / (partial x_n partial x_1) (bold("x")_k), (partial^2 f) / (partial x_n^2 partial x_2) (bold("x")_k), dots, (partial^2 f) / (partial x_n^2) (bold("x")_k);
  ) in RR^(n times n)
$

Instead of computing the inverse explicitly, we solve the linear system:

$
  gradient^2 f(bold("x")_k) bold("p")_k = gradient f(bold("x")_k)
$

$
  mat(
    (partial^2 f) / (partial x_1^2) (bold("x")_k), (partial^2 f) / (partial x_1 partial x_2) (bold("x")_k), dots, (partial^2 f) / (partial x_1 partial x_n) (bold("x")_k);
    (partial^2 f) / (partial x_2 partial x_1) (bold("x")_k), (partial^2 f) / (partial x_2^2) (bold("x")_k), dots, (partial^2 f) / (partial x_2 partial x_n) (bold("x")_k);
    dots.v, dots.v, dots.down, dots.v;
    (partial^2 f) / (partial x_n partial x_1) (bold("x")_k), (partial^2 f) / (partial x_n^2 partial x_2) (bold("x")_k), dots, (partial^2 f) / (partial x_n^2) (bold("x")_k);
  ) vec(
    p_1,
    p_2,
    dots.v,
    p_n,
  ) = vec(
    (partial f) / (partial x_1) (bold("x")_k),
    (partial f) / (partial x_2) (bold("x")_k),
    dots.v,
    (partial f) / (partial x_n) (bold("x")_k),
  )
$

$
  (partial^2 f) / (partial x_1^2) (bold("x")_k) p_1 + (partial^2 f) / (partial x_1 partial x_2) (bold("x")_k) p_2 + dots + (partial^2 f) / (partial x_1 partial x_n) (bold("x")_k) p_n = (partial f) / (partial x_1) (bold("x")_k) \
  (partial^2 f) / (partial x_2 partial x_1) (bold("x")_k) p_1 + (partial^2 f) / (partial x_2^2) (bold("x")_k) p_2 + dots + (partial^2 f) / (partial x_2 partial x_n) (bold("x")_k) p_n = (partial f) / (partial x_2) (bold("x")_k) \
  dots.v \
  (partial^2 f) / (partial x_n partial x_1) (bold("x")_k) p_1 + (partial^2 f) / (partial x_n^2 partial x_2) (bold("x")_k) p_2 + dots + (partial^2 f) / (partial x_n^2) (bold("x")_k) p_n = (partial f) / (partial x_n) (bold("x")_k)
$

Then update:

$
  bold("x")_(k+1) = bold("x")_k - bold("p")_k
$

#example[
  $
    f(x, y) = x^2 + x y + y^2
  $

  *Step 1.* Compute Gradient

  $
    gradient f(x, y) = vec(
      (partial f) / (partial x),
      (partial f) / (partial y),
    ) = vec(
      2x + y,
      x + 2y,
    )
  $

  *Step 2.* Compute Hessian

  $
    gradient^2 f(x, y) = mat(
      (partial^2 f) / (partial x^2), (partial^2 f) / (partial x partial y);
      (partial^2 f) / (partial y partial x), (partial^2 f) / (partial y^2);
    ) =
  $
]

*Step 0.* Setup

We want to minimize a function $f(x, y)$

At some iteration $k$, we compute:

- Gradient

$
  g = gradient f(x_k, y_k) = vec(g_1, g_2)
$

- Hessian

$
  H = gradient^2 f(x_k, y_k) = mat(
    a, b;
    b, c;
  )
$

We need the Newton step vector $p$ from:

$
  H p = g
$

so that the update is:

$
  vec(
    x_(k+1),
    y_(k+1),
  ) = vec(
    x_k,
    y_k,
  ) - p
$

*Step 1.* We need the Newton step $p$ from:

$
  mat(
    a, b;
    b, c;
  ) vec(
    p_1,
    p_2,
  ) = vec(
    g_1,
    g_2,
  )
$

Which is two equations:

$
  a p_1 + b p_2 = g_1 \
  b p_1 + c p_2 = g_2 \
$

*Step 2.* Solve without inversion

This is a simple linear system.

For example, solve the first equation for $p_1$:

$
  p_1 = (g_1 - b p_2) / a
$

Plug into the second:

$
  b ((g_1 - b p_2) / a) + c p_2 = g_2 \
  (b g_1) / a - b^2 / a p_2 + c p_2 = g_2 \
  (c = b^2 / a) p_2 = g_2 - (b g_1) / a \
  p_2 = (a g_2 - b g_1) / (a c - b^2)
$

Then substitute back for $p_1$:

$
  p_1 = (g_1 - b p_2) / a
$

*Step 3.* Newton update

$
  vec(
    x_(k+1),
    y_(k+1),
  ) = vec(
    x_k,
    y_k,
  ) - vec(
    p_1,
    p_2
  )
$
