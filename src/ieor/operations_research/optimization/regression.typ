#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/suiji:0.4.0": *

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition
#import "../../../utils/distributions/gaussian.typ": gaussian_pdf

== Linear Regression

=== Simple Linear Regression

==== Data and Model

We observe a dataset of $n$ samples:

$
  (x_i, y_i) quad i = 1, dots, n
$

#let rng = gen-rng-f(20)

#let mu = 0
#let sigma = 3
#let n = 25

#let f(x) = 1 * x + 2

#let (rng, noise) = normal(rng, loc: mu, scale: sigma, size: n)

#let xs = range(0, 25)
#let ys = xs.map(x => f(x))
#let noisy_ys = ys.zip(noise).map(pt => pt.at(0) + pt.at(1))
#let noisy_data = xs.zip(noisy_ys)

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (8,8),
        axis-style: "scientific",
        x-tick-step: 5, 
        y-tick-step: 5, 
        x-grid: true,
        y-grid: true,
        x-label: [$x$],
        y-label: [$y$],
        x-min: calc.min(..xs) - 1, 
        x-max: calc.max(..xs) + 1,
        y-min: calc.min(..noisy_ys) - 1, 
        y-max: calc.max(..noisy_ys) + 1,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
    {
      plot.add(
        noisy_data,
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt),
        style: (stroke: none)
      )
    }, name: "plot")
  })
]

We assume a linear relationship between $x$ and $y$:

$
  y = alpha + beta x_i + epsilon_i
$

Where:
- $alpha$: *intercept*
- $beta$: *slope*
- $epsilon_i$: *error term* (noise)

==== Optimization Problem

The parameters $alpha$ and $beta$ are estimated by minimizing the *sum of square errors* (SSE)

$
  min_(alpha, beta) f(alpha, beta) = sum_(i=1)^n [y_i - (alpha + beta x_1)]^2
$

This is an *unconstrained convex optimization problem*

==== Gradient and Hessian

Compute the partial derivatives:

$
  (diff f) / (diff alpha) = -2 sum_(i=1)^n [y_i - (alpha + beta x_1)] \
  (diff f) / (diff beta) = -2 sum_(i=1)^n [y_i - (alpha + beta x_1)] x_i \
$

Thus, the *gradient* is:

$
  gradient f(alpha, beta) = vec(
    -2 sum_(i=1)^n [y_i - (alpha + beta x_1)],
    -2 sum_(i=1)^n [y_i - (alpha + beta x_1)] x_i,
  )
$

and the *Hessian matrix* is:

$
  gradient^2 f(alpha, beta) 
  &= mat(
    2n, 2 sum_(i=1)^n x_i;
    2 sum_(i=1)^n x_i, 2 sum_(i=1)^n x_i^2;
  ) \
  &= 2 mat(
    n, sum_(i=1)^n x_i;
    sum_(i=1)^n x_i, sum_(i=1)^n x_i^2;
  )
$

==== Convexity

The Hessian is constant (does not depend on $alpha$, $beta$) and symmetric. We check positive semidefiniteness via the determinant:

$
  det(gradient^2 f) 
  = 4 (n sum_(i=1)^n x_i^2 - (sum_(i=1)^n x_i)^2) 
  = 4 sum_(i lt j) (x_i - x_j)^2 gt.eq 0
$

Sincle this expression is nonnegative for all $x_i$, $f$ is *convex*

==== Optimality Conditions

Setting the gradient equal to zero gives the normal equaltions:

$
  cases(
    n alpha + (sum_(i=1)^n x_i) beta &= sum_(i=1)^n y_i,
    (sum_(i=1)^n x_i) alpha + (sum_(i=1)^n x_i^2) beta &= sum_(i=1)^n x_i y_i
  )
$

Solving this linear system yields the closed-form solution:

$
  hat(beta) &= (sum_i (x_i - overline(x))(y_i - overline(y))) / (sum_i (x_i - overline(x))^2) \
  hat(alpha) &= overline(y) - hat(beta) overline(x) \
$

where:

$
  overline(x) = 1/n sum_(i=1)^n x_i quad quad overline(y) = 1/n sum_(i=1)^n y_i
$

==== Convexity by Decomposition

Alternatively, decompose $f(alpha, beta)$ as:

$
  f(alpha, beta) = sum_(i=1)^n [y_i - (alpha + beta x_i)]^2 = sum_(i=1)^n f_i (alpha, beta)
$

$
  f_i (alpha, beta) = [y_i - (alpha + beta x_i)]^2
$

Expanding $f_i$:

$
  f_i (alpha, beta) = y_i^2 + alpha^2 + beta^2 x_i^2 - 2 alpha y_i - 2 beta x_i y_i + 2 alpha beta x_i
$

Each $f_i$ is a quadratic function in ($alpha$, $beta$)

Each $f_i$ has Hessian:

$
  gradient^2 f_i (alpha, beta) 
  = mat(
    2, 2x_i;
    2x_i, 2x_i^2
  ) 
  = 2 mat(
    1, x_i;
    x_i, x_i^2;
  )
$

Since each $gradient^2 f_i$ is positive semidefinite, and sums of convex functions are convex, $f$ is convex

#eg[

]

=== Muliple Linear Regression

==== Data and Model

For $n$ samples and $p$ predictors:

$
  (x_1^((i)), x_2^((i)), dots, x_p^((i)), y_i) quad i = 1, dots, n
$

The model is:

$
  y_i 
  &= alpha + beta_1 x_1^((i)) + dots + beta_p x_p^((i)) + epsilon_i \
  &= alpha + bold(beta)^T bold("x")^((i)) + epsilon_i
$

==== Optimization Problem

$
  min_(alpha, beta) f(alpha, beta)
$

where

$
  f(alpha, beta)
  &=  sum_(i=1)^n [y_i - (alpha + sum_(j=1)^p beta_j x_j^i)]^2 \
  &= sum_(i=1)^n [y_i - (alpha + bold(beta)^T bold("x")^((i)))]^2 \
$

In matrix form, letting $X in RR^(n times p)$ be the data matrix, $bold(y) in RR^n$, and $bold(1)$ the column of ones:

$
  min_(alpha, beta) quad ||bold(y) - alpha bold(1) - X beta||_2^2
$

// where for a vector $bold("v") = (v_1, v_2, dots, v_n)^T in RR^n$:

// $
//   ||bold(v)||_2 = sqrt(v_1^2 + v_2^2 + dots + v_n^2)
// $

// is the Euclidean norm (L2 norm) --- the the length (magnitude of the vector)

// Then

// $
//   ||bold("v")||_2^2 = (||bold("v")||_2)^2 = v_1^2 + v_2^2 + dots + v_n^2
// $

The closed-form solution is:

$
  hat(beta) &= (X^T X)^(-1) X^T (bold("y") - overline(y) bold(1)) \
  hat(alpha) &= overline(y) - hat(beta)^T overline(bold("x"))
$

provided $X^T X$ is invertible

=== Regularization

Regularization penalizes large coefficients to prevent overfitting and improve numerical stability.

Let $lambda gt 0$ be a regularization parameter.

==== Ridge Regression (L2 Regularization)

$
  min_(alpha, beta) sum_(i=1)^n [y_i - (alpha + bold(beta)^T bold("x")^i)]^2 colorMath(+ lambda sum_(j=1)^p beta_j^2, #red)
$

In matrix form:

$
  min_beta quad ||bold("y") - X bold(beta)||_2^2 + lambda ||bold(beta)||_2^2
$

Closed-form solution (for centered data):

$
  bold(hat(beta)) = (X^T X + lambda I_p)^(-1) X^T bold("y")
$

Ridge regression shrinks coefficients toward zero but does not set them exactly to zero.

==== LASSO Regression (L1 Regularization)

$
  min_(alpha, beta) sum_(i=1)^n [y_i - (alpha + beta^T x^i)]^2 colorMath(+ lambda sum_(j=1)^p abs(beta_j), #red)
$

LASSO performs feature selection because some coefficients can become exactly zero.

This problem is still convex but non-differentiable due to the absolute value term.

#eg[
  
]