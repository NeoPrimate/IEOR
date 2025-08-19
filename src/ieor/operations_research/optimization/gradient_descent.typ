#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

#import "@preview/plotsy-3d:0.2.0": plot-3d-surface, plot-3d-parametric-curve


#set math.vec(delim: "[")
#set math.mat(delim: "[")

#let fuchsia = fuchsia.lighten(40%)

== Gradient Descent

=== Gradient

The gradient tells us the direction of steepest increase

For a function

$
  f(x_1, x_2, dots, x_n)
$

the gradient of $f$, written $gradient f$, is:

$
  gradient f(x) = ((partial f) / (partial x_1), (partial f) / (partial x_2), dots, (partial f) / (partial x_n))
$

- The *magnitude* of the gradient vector tells you how fast the function is increasing (steepness)
- The *direction* of the gradient vector points to where the function increases most rapidly (direction)

#eg[
  
  #text(size: 16pt, weight: "semibold")[Function]

  $
    f(x_1, x_2) = x_1^2 + x_2^2
  $

  #text(size: 16pt, weight: "semibold")[Compute $(partial d) / (partial x_1)$]

  - Differentiate $f$ w.r.t. $x_1$ (treat $x_2$ as constant):

  $
    partial / (partial x_1) (x_1^2 + x_2^2) = partial / (partial x_1) (x_1^2) + partial / (partial x_1) (x_2^2)
  $

  - Since $x_2^2$ is constant w.r.t. $x_1$, its derivative is 0:

  $
    partial / (partial x_1) (x_2^2) = 0
  $

  - The derivative of $x_1^2$ w.r.t. $x_1$ is:

  $
    partial / (partial x_1) (x_1^2) = 2 x_1
  $

  - So,

  $
    (partial f) / (partial x_1) = 2 x_1
  $

  #text(size: 16pt, weight: "semibold")[Compute $(partial f) / (partial x_2)$]

  - Differentiate $f$ w.r.t. $x_2$ (treat $x_2$ as constant):

  $
    partial / (partial x_2) (x_1^2 + x_2^2) = partial / (partial x_2) (x_1^2) + partial / (partial x_2) (x_2^2)
  $

  - Since $x_1^2$ is constant w.r.t. $x_2$, its derivative is 0:

  $
    partial / (partial x_2) (x_1^2) = 0
  $

  - The derivative of $x_2^2$ w.r.t. $x_2$ is:

  $
    partial / (partial x_2) (x_2^2) = 2x_2
  $

  So,

  $
    (partial f) / (partial x_2) = 2x_2
  $

  #text(size: 16pt, weight: "semibold")[Combine to form gradient]

  $
    gradient f(x_1, x_2) = (2x_1, 2x_2)
  $

  #text(size: 16pt, weight: "semibold")[Evaluate at a point]
  
  $
    x = (1, 2)
  $

  $
    gradient f(1, 2) = (2 times 1, 2 times 2) = (2, 4)
  $

  #text(size: 16pt, weight: "semibold")[Interpretation]

  - The gradient vector $(2, 4)$ at $(1, 2)$ points in the *direction* where the function $f$ *increases most rapidly*
  - Its *magnitude* $sqrt(2^2 + 4^2) = sqrt(20) approx 4.47$ measures the *steepness* of that increase


  - *Moving one unit along the $x_1$*	axis alone would *increase the function by the partial derivative with respect to $x_1$*, which is 2
  - *Moving one unit along the $x_2$* axis alone would *increase the function by the partial derivative with respect to $x_2$*, which is 4
  - *Moving from $(1, 2)$ in the direction of $(2, 4)$*, the function value will rise fastest and at a rate roughly proportional to *$4.47$ per unit distance moved*
]

=== Algorithm

Find the minimum of a function

In *gradient descent*, we move in the *opposite direction* of the gradient to minimize a function

Direction of *maximum increase*:

$
  gradient f(x)
$

Direction of *maximum decrease*:

$
  - gradient f(x)
$

1. *Initialize*: Start with an initial guess for the parameters
2. *Compute Gradient*: Find the gradient of the function at the current parameters
3. *Update Parameters*: Adjust the parameters by moving in the opposite direction of the gradient, scaled by the learning rate
4. *Repeat*: Continue the process until the parameters converge to a minimum or the changes are minimal

*Update Rule*:

$
x^(k+1) arrow.l x^k - alpha_k gradient f(x^k)
$

Where:
- $x^k$: current iterate (point in domain of $f$)
- $alpha_k$: *step size* or *learning rate* at iteration $k$
- $gradient f(x^k)$: *gradient* of the funtion $f$ with respect to $theta$
- $x^(k+1)$: next iterate (point in domain of $f$)


#code(
  "gradient_descent.py",
  ```py
  import numpy as np

  def gradient_descent(
    f,              # Function to minimize, f(x)
    grad_f,         # Gradient of f, grad_f(x)
    x0,             # Initial guess for x
    alpha=0.01,     # Learning rate
    max_iter=1000,  # Maximum number of iterations
    tol=1e-6        # Tolerance for stopping
  ):
      x = x0.copy()
      for _ in range(max_iter):
          grad = grad_f(x)
          if np.linalg.norm(grad) < tol:
              break
          x -= alpha * grad
      return x

  def f(x):
    """Example: minimize f(x) = x^2 + 2x + 1"""
    return x**2 + 2*x + 1

  def grad_f(x):
      """Gradient of f(x) = x^2 + 2x + 1 is f'(x) = 2x + 2"""
      return 2*x + 2

  gradient_descent(
      f, 
      grad_f, 
      x_initial, 
      alpha=0.1, 
      max_iter=100
  )
  ```
)

#eg[

  #text(size: 16pt, weight: "semibold")[Function] 
  
  $
    x^2_1 + x^2_2
  $

  #align(center)[
    #let f(x1, x2) = calc.pow(x1, 2) + calc.pow(x2, 2)

    #let size = 5
    #let scale-factor = 0.15
    #let (xscale,yscale,zscale) = (0.7,0.3,0.05)
    #let scale-dim = (xscale*scale-factor,yscale*scale-factor, zscale*scale-factor)  
    #let func(x,y) = x*x + y*y
    #let color-func(x, y, z, x-lo,x-hi,y-lo,y-hi,z-lo,z-hi) = {
      return blue.transparentize(20%).darken((y/(y-hi - y-lo))*100%).lighten((x/(x-hi - x-lo)) * 50%)
    }

    #plot-3d-surface(
      f,
      color-func: color-func,
      subdivisions: 1,
      subdivision-mode: "decrease",
      scale-dim: scale-dim,
      xdomain: (-size,size),
      ydomain:  (-size,size),
      pad-high: (0,0,0),
      pad-low: (0,0,0),
      axis-step: (2,2,10),
      dot-thickness: 0.05em,
      front-axis-thickness: 0.05em,
      front-axis-dot-scale: (0.05,0.05),
      rear-axis-dot-scale: (0.08,0.08),
      rear-axis-text-size: 0.5em,
      axis-label-size: 1em,
      xyz-colors: (black,black,black),
      axis-labels: ($x_1$, $x_2$, $y$),
      
    )
  ]

  #text(size: 16pt, weight: "semibold")[Gradient] 
  
  $
    gradient f(x) = ((partial f) / (partial x_1), (partial f) / (partial x_2)) = (2 x_1, 2 x_2)
  $

  #text(size: 16pt, weight: "semibold")[Learning Rate] 

  $
    alpha = 0.1
  $

  #line(length: 100%)

  #text(size: 16pt, weight: "semibold")[Iteration 1] 

  - Initial Parameter Values:

  $
  x_1 = 1 quad quad x_2 = 2
  $

  - Gradient Calculation

  $
    gradient f(x) = (2 times 1, 2 times 2) = (2, 4)
  $

  - Parameter Update:
 
  $
    x arrow.l x - alpha gradient f(x)
  $

  $
    x_1 arrow.l 1 - 0.1 times 2 = 0.8 \

    x_2 arrow.l 2 - 0.1 times 4 = 1.6 \
  $

  - Updated Parameter Values:

  $
    x_1 = 0.8 quad quad x_2 = 1.6
  $

  #text(size: 16pt, weight: "semibold")[Iteration 2] 

  - Current Parameter Values

  $
    x_1 = 0.8 quad quad x_2 = 1.6
  $

  - Gradient Calculation:

  $
    gradient f(x) = (2 times 0.8, 2 times 1.6) = (1.6, 3.2)
  $

  - Parameter Update:

  $
    x arrow.l x - alpha gradient f(x)
  $

  $
    x_1 arrow.l 0.8 - 0.1 times 1.6 = 0.64 \

    x_2 arrow.l 1.6 - 0.1 times 3.2 = 1.28 \
  $

  - Updated Parameter Values:

  $
    x_1 = 0.64 quad quad x_2 = 1.28
  $

  #text(size: 16pt, weight: "semibold")[Iteration 3] 

  - Current Values

  $
    x_1 = 0.64 quad quad x_2 = 1.28
  $

  - Gradient Calculation:

  $
    gradient f(x) = (2 times 0.64, 2 times 1.28) = (1.28, 2.56)
  $

  - Parameter Update:

  $
    x arrow.l x - alpha gradient f(x)
  $

  $
    x_1 arrow.l 0.64 - 0.1 times 1.28 = 0.512 \

    x_2 arrow.l 1.28 - 0.1 times 2.56 = 1.024 
  $

  - Updated Parameter Values:

  $
    x_1 = 0.512 quad quad x_2 = 1.024
  $
]


#eg[

  #text(size: 16pt, weight: "semibold")[Problem Setup]

  Minimize the quadratic function:

  $
    min_(x in RR^2) quad f(x) = 4x^2_1 - 4 x_1 x_2 + 2x^2_2  
    quad 
    "where" 
    quad
    x = vec(x_1, x_2)
  $

  #let f(x1, x2) = 4 * calc.pow(x1, 2) - 4 * x1 * x2 + 2 * calc.pow(x2, 2)

  #align(center)[
    #let size = 5
    #let scale-factor = 0.15
    #let (xscale,yscale,zscale) = (0.7,0.3,0.01)
    #let scale-dim = (xscale*scale-factor,yscale*scale-factor, zscale*scale-factor)  
    #let func(x,y) = x*x + y*y
    #let color-func(x, y, z, x-lo,x-hi,y-lo,y-hi,z-lo,z-hi) = {
      return blue.transparentize(20%).darken((y/(y-hi - y-lo))*100%).lighten((x/(x-hi - x-lo)) * 50%)
    }

    #plot-3d-surface(
      f,
      color-func: color-func,
      subdivisions: 1,
      subdivision-mode: "decrease",
      scale-dim: scale-dim,
      xdomain: (-size,size),
      ydomain:  (-size,size),
      pad-high: (0,0,0),
      pad-low: (0,0,0),
      axis-step: (2,2,50),
      dot-thickness: 0.05em,
      front-axis-thickness: 0.05em,
      front-axis-dot-scale: (0.05,0.05),
      rear-axis-dot-scale: (0.08,0.08),
      rear-axis-text-size: 0.5em,
      axis-label-size: 1em,
      xyz-colors: (black,black,black),
      axis-labels: ($x_1$, $x_2$, $y$),
      
    )
  ]

  #text(size: 16pt, weight: "semibold")[Gradient of $f(x)$]

  The gradient is:

  $
    gradient f(x) = vec((partial f)/(partial x_1), (partial f) / (partial x_2)) \
  $

  *Step 1*: Compute $(partial f)/(partial x_1)$

  Take the derivative of each term with respect to $x_1$ (treat $x_2$ as a constant):
  
  - $(partial)/(partial x_1) (4 x_1^2) = 8x_1$

  - $(partial)/(partial x_1) (-4 x_1 x_2) = -4x_2$

  - $(partial)/(partial x_1) (2 x_2^2) = 0$
  
  So: 
  
  $
    (partial f)/(partial x_1) = 8x_1 - 4x_2
  $ 

  *Step 2*: Find $(partial f)/(partial x_2)$

  Take the derivative of each term with respect to $x_2$ (treat $x_1$ as a constant):

  - $(partial)/(partial x_2) (4 x_1^2) = 0$
  
  - $(partial)/(partial x_2) (-4 x_1 x_2) = -4x_1$
  
  - $(partial)/(partial x_2) (2 x_2^2) = 4x_2$

  So: 
  
  $
    (partial f)/(partial x_2) = -4x_1 + 4x_2
  $

  So the gradient of $f(x)$ is:

  $
    gradient f(x) = vec(8 x_1 - 4 x_2, -4 x_1 + 4 x_2) \
  $

  #text(size: 16pt, weight: "semibold")[Optimal Solution]

  $
    x^* = vec(0, 0) \
    f(x^*) = 0
  $

  #text(size: 16pt, weight: "semibold")[Gradient Descent Iterations]
  
  #text(size: 14pt, weight: "semibold")[Iteration 1]

  - Initial guess:

  $
    colorMath(x^0, #blue) = colorMath(vec(2, 3), #blue) 
    quad
    arrow.double
    quad
    f(x^0) = 4(2^2) - 4(2)(3) + 2(3^2) = 10
  $

  - Gradient at $x^0$:

  $
    colorMath(gradient f(x^0), #red)
    = vec(8(2) - 4(3), -4(2) + 4(3))
    = colorMath(vec(4, 4), #red)
  $

  - Line Search:

  $
    x(alpha_0) = colorMath(x^0, #blue) - alpha_0 colorMath(gradient f(x^0), #red) 
    &= colorMath(vec(2, 3), #blue) - alpha_0 colorMath(vec(4, 4), #red) \
    &= vec(colorMath(2 - 4 alpha_0, #olive), colorMath(3 - 4 alpha_0, #orange)) \
  $
  
  $
    f(x(alpha_0)) 
    &= 4 colorMath(x_1, #olive)^2 - 4 colorMath(x_1, #olive) colorMath(x_2, #orange) + 2 colorMath(x_2, #orange)^2 \
    &= 4(colorMath(2 - 4 alpha_0, #olive))^2 - 4(colorMath(2 - 4 alpha_0, #olive))(colorMath(3 - 4 alpha_0, #orange)) + 2(colorMath(3 - 4 alpha_0, #orange))^2 \
    &= colorMath(32 alpha_0^2 - 32 alpha_0 + 10, #purple)
  $

  - Minimizing:

  $
    alpha_0 = "argmin" f(x(alpha))
  $
  
  $
    partial / (partial alpha) f(x(alpha_0)) 
    &= partial / (partial alpha) (colorMath(32 alpha_0^2 - 32 alpha_0 + 10, #purple)) = 0 \ \
    &= 64 alpha_0 - 32 = 0 \ \
  $

  $
    alpha_0 = colorMath(1/2, #fuchsia)
  $

  - Update Step:

  $
    x^1 = colorMath(x^0, #blue) - a_0 colorMath(gradient f(x^0), #red)
    = colorMath(vec(2, 3), #blue) - colorMath(1/2, #fuchsia) colorMath(vec(4, 4), #red)
    = vec(0, 1)
  $

  - Check Progress:

  1. New point:

  $
    colorMath(x^1, #blue) = colorMath(vec(0, 1), #blue)
  $

  2. Function value decreases $f(x^(k+1)) < f(x^k)$
  
  $
    f(x^1) = 2 < f(x^0) = 10
  $

  3. Gradient at new point:
  
  $
    colorMath(gradient f(x^1), #red) = vec(
      8(0) - 4(1), 
      -4(0) + 4(1),
    ) = colorMath(vec(-4, 4), #red)
  $
  
  4. Gradient magnitude $||gradient f(x^(k+1))|| < ||gradient f(x^k)||$
    
  $
    ||gradient f(x^1)|| = 4 sqrt(2) = ||gradient f(x^0)||
  $

  _Note: Gradient magnitude stays the same in this iteration due to the specific structure of this quadratic function_

  #text(size: 16pt, weight: "semibold")[Iteration 2]

  - New Point:

  $
    colorMath(x^1, #blue) = colorMath(vec(0, 1), #blue)
  $

  - Gradient at $x_1$:

  $
    colorMath(gradient f(x^1), #red) 
    = vec(8(0) - 4(1), -4(0) + 4(1))
    = colorMath(vec(-4, 4), #red)
  $

  $
    a_1 = "argmin" f(x(alpha_1))
  $

  - Line search:

  $
    x(alpha_1) 
    &= colorMath(x^1, #blue) - alpha_1 colorMath(gradient f(x^1), #red)
    &= colorMath(vec(0, 1), #blue) - alpha_1 colorMath(vec(-4, 4), #red) \
    &= vec(colorMath(4 alpha_1, #olive), colorMath(1 - 4 alpha_1, #orange))
  $

  $
    f(x(alpha_1))
    &= 4 colorMath(x_1, #olive)^2 - 4 colorMath(x_1, #olive) colorMath(x_2, #orange) + 2 colorMath(x_2, #orange)^2 \
    &= 4(colorMath(4 alpha_1, #olive))^2 - 4(colorMath(4 alpha_1, #olive))(colorMath(1 - 4 alpha_1, #orange)) + 2(colorMath(1 - 4 alpha_1, #orange))^2 \
    &= colorMath(160 alpha_1^2 - 32 alpha_1 + 2, #purple)
  $

  - Minimize:

  $
    alpha_1 = "argmin" f(x(alpha_1)) = 1/10
  $

  $
    partial / (partial alpha) f(x(alpha_1)) 
    &= partial / (partial alpha) (colorMath(160 alpha_1^2 - 32 alpha_1 + 2, #purple)) = 0 \ \
    &= 320 alpha_1 - 32 = 0 \ \
  $

  $
    alpha_1 = colorMath(1/10, #fuchsia)
  $

  - Update Step:

  $
    x^2 = colorMath(x^1, #blue) - alpha_1 colorMath(gradient f(x^1), #red)
    = colorMath(vec(0, 1), #blue) - colorMath(1/10, #fuchsia) colorMath(vec(-4, 4), #red)
    = vec(0.4, 0.6)
  $

  - Improvement:

  1. New point:

  $
    colorMath(x_2, #blue) = colorMath(vec(0.4, 0.6), #blue)
  $

  2. Function value decreases $f(x^(k+1)) < f(x^k)$
  
  $
    f(x^2) = 0.4 < f(x^1) = 2
  $

  3. Gradient at new point:

  $
    colorMath(gradient f(x_2), #red) = vec(8 (0.4) - 4 (0.6), -4 (0.4) + 4 (0.6)) = colorMath(vec(0.8, 0.8), #red)
  $

  4. Gradient magnitude $||gradient f(x^(k+1))|| < ||gradient f(x^k)||$
    
  $
    ||gradient f(x^2)|| = ||(0.8, 0.8)|| = (4 sqrt(2))/5 
  $
]

#eg[
  #text(size: 16pt, weight: "semibold")[Problem Setup]

  Minimize the quadratic function:

  $
    min_(x in RR^2) quad f(x) = x^2_1 - 2 x_1 x_2 + 2x^2_2 + 2x_1  
    quad 
    "where" 
    quad
    x = vec(x_1, x_2)
  $

  #let f(x1, x2) = calc.pow(x1, 2) - 2 * x1 * x2 + 2 * calc.pow(x2, 2) + 2*x1

  #align(center)[
    #let size = 5
    #let scale-factor = 0.15
    #let (xscale,yscale,zscale) = (0.7,0.3,0.02)
    #let scale-dim = (xscale*scale-factor,yscale*scale-factor, zscale*scale-factor)  
    #let func(x,y) = x*x + y*y
    #let color-func(x, y, z, x-lo,x-hi,y-lo,y-hi,z-lo,z-hi) = {
      return blue.transparentize(20%).darken((y/(y-hi - y-lo))*100%).lighten((x/(x-hi - x-lo)) * 50%)
    }

    #plot-3d-surface(
      f,
      color-func: color-func,
      subdivisions: 1,
      subdivision-mode: "decrease",
      scale-dim: scale-dim,
      xdomain: (-size,size),
      ydomain:  (-size,size),
      pad-high: (0,0,0),
      pad-low: (0,0,0),
      axis-step: (2,2,50),
      dot-thickness: 0.05em,
      front-axis-thickness: 0.05em,
      front-axis-dot-scale: (0.05,0.05),
      rear-axis-dot-scale: (0.08,0.08),
      rear-axis-text-size: 0.5em,
      axis-label-size: 1em,
      xyz-colors: (black,black,black),
      axis-labels: ($x_1$, $x_2$, $y$),
      
    )
  ]

  #text(size: 16pt, weight: "semibold")[Gradient of $f(x)$]

  $
    gradient f(x_1, x_2) = vec(colorMath(2x_1 - 2x_2 + 2, #purple), colorMath(-2x_1 + 4x_2, #blue))
  $

  #align(center)[

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (8,8),
        axis-style: "school-book",
        x-tick-step: 1, 
        y-tick-step: 1, 
        x-label: [$x_1$],
        y-label: [$x_2$],
        x-min: -2.3, x-max: 0.1,
        y-min: -1.5, y-max: 0.5,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {

        let f_x1(x) = (2*x + 2) / 2
        let f_x2(x) = (2 * x) / 4

        plot.add(
          domain: (-3, 1),
          f_x1,
          style: (stroke: (thickness: 1pt, paint: purple)),
        )
        plot.annotate({
          content((-1.3, 0.35), [$colorMath(2x_1 - 2x_2 + 2 = 0, #purple)$])
        })

        plot.add(
          domain: (-3, 1),
          f_x2,
          style: (stroke: (thickness: 1pt, paint: blue)),
        )

        plot.annotate({
          content((-0.75, -0.8), [$colorMath(-2x_1 + 4x_2 = 0, #blue)$])
        })

        plot.add(
          ((0, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        plot.annotate({
          content((0 - 0.1, 0 + 0.1), [$x^0$])
        })

        plot.annotate({
          line((0, 0), (-1.1, 0), stroke: (thickness: 4pt, paint: red, dash: "dashed"), mark: (fill: red, end: ">", scale: 0.25))
        })

        plot.add(
          ((-1, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        plot.annotate({
          content((-1 - 0.1, 0 + 0.1), [$x^1$])
        })

        plot.annotate({
          line((-1, 0), (-1, -0.6), stroke: (thickness: 3pt, paint: red, dash: "dashed"), mark: (fill: red, end: ">", scale: 0.25))
        })

        plot.add(
          ((-1, -0.5),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        plot.annotate({
          content((-1 + 0.1, -0.5 - 0.1), [$x^2$])
        })

        plot.annotate({
          line((-1, -0.5), (-1.57, -0.5), stroke: (thickness: 3pt, paint: red, dash: "dashed"), mark: (fill: red, end: ">", scale: 0.25))
        })

        plot.add(
          ((-1.5, -0.5),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        plot.annotate({
          content((-1.5 - 0.1, -0.5 + 0.1), [$x^3$])
        })

        plot.annotate({
          line((-1.5, -0.5), (-1.5, -0.85), stroke: (thickness: 3pt, paint: red, dash: "dashed"), mark: (fill: red, end: ">", scale: 0.25))
        })

        plot.add(
          ((-1.5, -0.75),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        plot.annotate({
          content((-1.5, -0.75 - 0.15), [$x^4$])
        })
        plot.add(
          ((-2, -1),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        plot.annotate({
          content((-2 - 0.1, -1 + 0.1), [$x^n$])
        })

        

      }, name: "plot")
    })
  ]
]




