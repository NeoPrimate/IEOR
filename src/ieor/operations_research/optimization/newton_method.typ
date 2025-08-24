#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/prerequisites.typ": prerequisites
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition
#import "../../../utils/titles.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")
#set math.vec(gap: 1em)
#set math.mat(gap: 1em)

== Newton's Method <newton_method>

#prerequisites(
  prereqs: (
    // link(<hessian_matrix>)[Hessian Matrix],
    // link(<gradient>)[Gradient],
  ),
  dependents: (
    
  )
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



=== Newton's Method for Nonlinear Optimization

Used to find the *roots of the first derivative* $f'(x) = 0$, which correspond to the *local minima/maxima of the original function* $f(x)$.

Finding *stationary points* of a function $f(x)$, i.e., points where the gradient (derivative) is zero: 
- 1D: $f'(x) = 0$ 
- nD: $gradient f(bold("x")) = bold("0")$

It can be derived from either linear approximation of the gradient or quadratic approximation of the function

==== 1D Linear Approximation

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
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    let f(x) = calc.pow(x, 2)
    let dfdx(x) = 2*x
    
    let x_k = 3
    let y_k = f(x_k)
    let m = dfdx(x_k)

    let tangent(x) = m * (x - x_k) + y_k

    let x_intercept = x_k - y_k / m

    plot.plot(
      size: (8,8),
      axis-style: "scientific",
      x-tick-step: 1, 
      y-tick-step: 5, 
      x-label: [$x$],
      y-label: [$y$],
      x-min: 0, x-max: 3.5,
      y-min: -1, y-max: 10,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {

      plot.add-hline(0, style: (stroke: black))

      plot.add(
        domain: (0, 5),
        f,
        style: (stroke: (thickness: 1pt, paint: black)),
        label: [$f'(x)$]
      )
      
      plot.add-vline(3, min: 0, style: (stroke: red))

      plot.annotate({
        content((3, 0-0.3), [$x_k$])
      })

      plot.add(
        ((3, f(3)),),
        mark: "o",
        mark-size: 0.2,
        style: (fill: none, stroke: none),
        mark-style: (fill: red, stroke: red),
      )
      plot.annotate({
        content((3-0.25, f(3)+0.25), [$f(x_k)$])
      })

      plot.add(
        domain: (0, 5),
        tangent,
        style: (stroke: (thickness: 1pt, paint: blue)),
        label: [Linear approx of $f'(x)$]
      )

      plot.add(
        ((x_intercept, 0),),
        mark: "o",
        mark-size: 0.2,
        style: (fill: none, stroke: none),
        mark-style: (fill: green, stroke: green),
      )

      plot.add-vline(x_intercept, min: 0, style: (stroke: green))

      plot.annotate({
        content((x_intercept - 0.25, 0-0.3), [$x_(k+1)$])
      })

      plot.add(
        ((x_intercept, f(x_intercept)),),
        mark: "o",
        mark-size: 0.2,
        style: (fill: none, stroke: none),
        mark-style: (fill: green, stroke: green),
      )
      plot.annotate({
        content((x_intercept - 0.3, f(x_intercept)+0.3), [$f(x_(k+1))$])
      })

    }, name: "plot")
  })
]

==== nD Linear Approximation

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

==== 1D Quadratic Approximation

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
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    let f(x) = calc.pow(x, 3) - 3*x + 2
    let dfdx(x) = 3*calc.pow(x, 2) - 3
    let d2fdx2(x) = 6*x

    let newton_step(x_k) = x_k - dfdx(x_k) / d2fdx2(x_k)
    let x_k = 2
    let x_k1 = newton_step(x_k)
    
    let y_k = f(x_k)
    let m = dfdx(x_k)

    let f_quad(x) = f(x_k) + dfdx(x_k) * (x - x_k) + 0.5 * d2fdx2(x_k) * calc.pow(x - x_k, 2)

    // let fQ_vals = f_quad(x_vals, x_k)

    let tangent(x) = m * (x - x_k) + y_k

    let x_intercept = x_k - y_k / m

    plot.plot(
      size: (8,8),
      axis-style: "scientific",
      x-tick-step: 1, 
      y-tick-step: 10, 
      x-label: [$x$],
      y-label: [$y$],
      x-min: 0, x-max: 2.5,
      y-min: -0.5, y-max: 5,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {

      plot.add-hline(0, style: (stroke: black))

      plot.add(
        domain: (0, 2.5),
        f,
        style: (stroke: (thickness: 1pt, paint: black)),
        label: [$f(x)$]
      )

      plot.add-vline(x_k, min: 0, style: (stroke: red))

      plot.add(
        ((x_k1, f_quad(x_k1)),),
        mark: "o",
        mark-size: 0.2,
        style: (fill: none, stroke: none),
        mark-style: (fill: green, stroke: green),
      )

      plot.annotate({
        content((x_k, 0-0.2), [$x_k$])
      })
      
      plot.add(
        domain: (0, 2.5),
        x => f_quad(x),
        style: (stroke: (thickness: 1pt, paint: blue)),
        label: [$f_Q (x)$ (quadratic approx)]
      )
      
      plot.annotate({
        content((x_k1, 0-0.2), [$x_(k+1)$])
      })

      plot.add-vline(x_k1, min: 0, style: (stroke: green))

      plot.add(
        ((x_k1, f(x_k1)),),
        mark: "o",
        mark-size: 0.2,
        style: (fill: none, stroke: none),
        mark-style: (fill: green, stroke: green),
      )

      plot.annotate({
        content((x_k1+0.3, f(x_k1)), [$f(x_(k+1))$])
      })

      plot.add(
        ((2, f(2)),),
        mark: "o",
        mark-size: 0.2,
        style: (fill: none, stroke: none),
        mark-style: (fill: red, stroke: red),
      )
      plot.annotate({
        content((2+0.25, f(2)), [$f(x_k)$])
      })

      // plot.add(
      //   domain: (0, 5),
      //   tangent,
      //   style: (stroke: (thickness: 1pt, paint: blue)),
      //   label: [Linear approx of $f'(x)$]
      // )

      // plot.add(
      //   ((x_intercept, 0),),
      //   mark: "o",
      //   mark-size: 0.2,
      //   style: (fill: none, stroke: none),
      //   mark-style: (fill: green, stroke: green),
      // )

      // plot.add-vline(x_intercept, min: 0, max: f(x_intercept), style: (stroke: green))

      // plot.annotate({
      //   content((x_intercept - 0.25, 0-0.3), [$x_(k+1)$])
      // })

      // plot.add(
      //   ((x_intercept, f(x_intercept)),),
      //   mark: "o",
      //   mark-size: 0.2,
      //   style: (fill: none, stroke: none),
      //   mark-style: (fill: green, stroke: green),
      // )
      // plot.annotate({
      //   content((x_intercept - 0.3, f(x_intercept)+0.3), [$f(x_(k+1))$])
      // })

      // plot.annotate({
      //   line((x_k, 1), (x_intercept - 0.05, 1), stroke: (thickness: 1pt, paint: purple, dash: none), mark: (fill: purple, start: none, end: ">", scale: 0.5))
      // })

      // plot.annotate({
      //   content((x_k - x_intercept / 2, 1+0.5), [$x_(k+1) - x_k$])
      // })

    }, name: "plot")
  })
]

==== nD Quadratic Approximation

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
        cetz.canvas({
          import cetz.draw: *
          import cetz-plot: *

          plot.plot(
            size: (7,7),
            axis-style: "scientific",
            x-tick-step: 1, 
            y-tick-step: 1, 
            x-label: [],
            y-label: [],
            x-min: 0, x-max: 2,
            y-min: -0.5, y-max: 1.5,
            x-grid: "both",
            y-grid: "both",
            y-minor-tick-step: 0.5,
            x-minor-tick-step: 0.5,
            axes: (
              stroke: black,
              tick: (stroke: black),
            ),
          {

            plot.add(
              domain: (-2, 2),
              f,
              style: (stroke: (thickness: 1pt, paint: black)),
            )
            plot.add-hline(0, style: (stroke: black))

            plot.add(
                ((1, 0),),
                mark: "o",
                mark-size: 0.15,
                mark-style: (fill: black, stroke: black)
              )
          }, name: "plot")
        }),
        caption: [$f(x)$],
        supplement: none,
      )
    ], [
      #figure(
        cetz.canvas({
          import cetz.draw: *
          import cetz-plot: *

          plot.plot(
            size: (7,7),
            axis-style: "scientific",
            x-tick-step: 1, 
            y-tick-step: 2, 
            x-label: [],
            y-label: [],
            x-min: 0, x-max: 2,
            y-min: -2, y-max: 5,
            x-grid: "both",
            y-grid: "both",
            y-minor-tick-step: 5,
            x-minor-tick-step: 5,
            axes: (
              stroke: black,
              tick: (stroke: black),
            ),
          {
            plot.add(
              domain: (-2, 2),
              dfdx,
              style: (stroke: (thickness: 1pt, paint: black)),
            )
            plot.add-hline(0, style: (stroke: black))

            plot.add(
              ((1, 0),),
              mark: "o",
              mark-size: 0.15,
              mark-style: (fill: black, stroke: black)
            )
          }, name: "plot")
        }),
        caption: [$f'(x)$],
        supplement: none,
      )
      ], 
    )
  ]

==== Quadratic Approximation

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
        cetz.canvas({
          import cetz.draw: *
          import cetz-plot: *

          plot.plot(
            size: (7,7),
            axis-style: "scientific",
            x-tick-step: 1, 
            y-tick-step: 1, 
            x-label: [],
            y-label: [],
            x-min: 0, x-max: 2,
            y-min: -0.5, y-max: 1.5,
            x-grid: "both",
            y-grid: "both",
            y-minor-tick-step: 0.5,
            x-minor-tick-step: 0.5,
            axes: (
              stroke: black,
              tick: (stroke: black),
            ),
          {

            plot.add(
              domain: (-2, 2),
              f,
              style: (stroke: (thickness: 1pt, paint: black)),
            )
            plot.add-hline(0, style: (stroke: black))

            plot.add(
                ((1, 0),),
                mark: "o",
                mark-size: 0.15,
                mark-style: (fill: black, stroke: black)
              )
          }, name: "plot")
        }),
        caption: [$f(x)$],
        supplement: none,
      )
    ], [
      #figure(
        cetz.canvas({
          import cetz.draw: *
          import cetz-plot: *

          plot.plot(
            size: (7,7),
            axis-style: "scientific",
            x-tick-step: 1, 
            y-tick-step: 2, 
            x-label: [],
            y-label: [],
            x-min: 0, x-max: 2,
            y-min: -2, y-max: 5,
            x-grid: "both",
            y-grid: "both",
            y-minor-tick-step: 5,
            x-minor-tick-step: 5,
            axes: (
              stroke: black,
              tick: (stroke: black),
            ),
          {
            plot.add(
              domain: (-2, 2),
              dfdx,
              style: (stroke: (thickness: 1pt, paint: black)),
            )
            plot.add-hline(0, style: (stroke: black))

            plot.add(
              ((1, 0),),
              mark: "o",
              mark-size: 0.15,
              mark-style: (fill: black, stroke: black)
            )
          }, name: "plot")
        }),
        caption: [$f'(x)$],
        supplement: none,
      )
      ], 
    )
  ]


#eg[
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

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (8,8),
        axis-style: "school-book",
        x-tick-step: 1, 
        y-tick-step: 5, 
        x-label: [$x_1$],
        y-label: [$x_2$],
        x-min: 0, x-max: 3,
        y-min: -1, y-max: 40,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add(
          domain: (0, 3),
          x => calc.pow(x, 5),
          style: (stroke: (thickness: 1pt, paint: black)),
        )

        for _ in range(3) {
          y_n = f(x_n)
          m = dfdx(x_n)
          

          plot.add(
            domain: (0, 3),
            x => tangent_line(x, x_n, y_n, m),
            style: (stroke: (thickness: 1pt, paint: red)),
          )

          x_n = newton_update(x_n)
        }

      }, name: "plot")
    })
  ]
]

Hello

=== Multi-Dimensional

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
    (diff f) / (diff x_1) (bold("x")_k),
    (diff f) / (diff x_2) (bold("x")_k),
    dots.v,
    (diff f) / (diff x_n) (bold("x")_k),
  ) in RR^n

  quad quad quad quad

  gradient^2 f(bold("x")_k) = mat(
    (diff^2 f) / (diff x_1^2) (bold("x")_k), (diff^2 f) / (diff x_1 diff x_2) (bold("x")_k), dots, (diff^2 f) / (diff x_1 diff x_n) (bold("x")_k);
    (diff^2 f) / (diff x_2 diff x_1) (bold("x")_k), (diff^2 f) / (diff x_2^2) (bold("x")_k), dots, (diff^2 f) / (diff x_2 diff x_n) (bold("x")_k);
    dots.v, dots.v, dots.down, dots.v;
    (diff^2 f) / (diff x_n diff x_1) (bold("x")_k), (diff^2 f) / (diff x_n^2 diff x_2) (bold("x")_k), dots, (diff^2 f) / (diff x_n^2) (bold("x")_k);
  ) in RR^(n times n)
$

Instead of computing the inverse explicitly, we solve the linear system:

$
  gradient^2 f(bold("x")_k) bold("p")_k = gradient f(bold("x")_k)
$

$
  mat(
    (diff^2 f) / (diff x_1^2) (bold("x")_k), (diff^2 f) / (diff x_1 diff x_2) (bold("x")_k), dots, (diff^2 f) / (diff x_1 diff x_n) (bold("x")_k);
    (diff^2 f) / (diff x_2 diff x_1) (bold("x")_k), (diff^2 f) / (diff x_2^2) (bold("x")_k), dots, (diff^2 f) / (diff x_2 diff x_n) (bold("x")_k);
    dots.v, dots.v, dots.down, dots.v;
    (diff^2 f) / (diff x_n diff x_1) (bold("x")_k), (diff^2 f) / (diff x_n^2 diff x_2) (bold("x")_k), dots, (diff^2 f) / (diff x_n^2) (bold("x")_k);
  ) vec(
    p_1,
    p_2,
    dots.v,
    p_n,
  ) = vec(
    (diff f) / (diff x_1) (bold("x")_k),
    (diff f) / (diff x_2) (bold("x")_k),
    dots.v,
    (diff f) / (diff x_n) (bold("x")_k),
  )
$

$
  (diff^2 f) / (diff x_1^2) (bold("x")_k) p_1 + (diff^2 f) / (diff x_1 diff x_2) (bold("x")_k) p_2 + dots + (diff^2 f) / (diff x_1 diff x_n) (bold("x")_k) p_n = (diff f) / (diff x_1) (bold("x")_k) \

  (diff^2 f) / (diff x_2 diff x_1) (bold("x")_k) p_1 + (diff^2 f) / (diff x_2^2) (bold("x")_k) p_2 + dots + (diff^2 f) / (diff x_2 diff x_n) (bold("x")_k) p_n = (diff f) / (diff x_2) (bold("x")_k) \
  
  dots.v \

  (diff^2 f) / (diff x_n diff x_1) (bold("x")_k) p_1 + (diff^2 f) / (diff x_n^2 diff x_2) (bold("x")_k) p_2 + dots + (diff^2 f) / (diff x_n^2) (bold("x")_k) p_n = (diff f) / (diff x_n) (bold("x")_k)
$

Then update:

$
  bold("x")_(k+1) = bold("x")_k - bold("p")_k
$

#eg[
  $
    f(x, y) = x^2 + x y + y^2
  $

  *Step 1.* Compute Gradient

  $
    gradient f(x, y) = vec(
      (diff f) / (diff x),
      (diff f) / (diff y),
    ) = vec(
      2x + y,
      x + 2y,
    )
  $

  *Step 2.* Compute Hessian

  $
    gradient^2 f(x, y) = mat(
      (diff^2 f) / (diff x^2), (diff^2 f) / (diff x diff y);
      (diff^2 f) / (diff y diff x), (diff^2 f) / (diff y^2);
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
