#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "../../utils/prerequisites.typ": prerequisites

== Hessian Matrix <hessian_matrix>

#prerequisites(
  prereqs: (
    
  ),
  dependents: (
    // link(<newton_method>)[Newton's Method],
  )
)

Square matrix of second-order partial derivatives

Describes the local curvature of a multivariable function

$
  f: RR^n arrow RR
$

Input: $bold("x") = vec(x_1, x_2, dots.v, x_n)$

Output: Scalar

#set math.mat(gap: 1em)
$
  H_f (bold("x")) = mat(
    (diff^2 f) / (diff x_1^2), (diff^2 f) / (diff x_1 diff x_2), dots, (diff^2 f) / (diff x_1 diff x_n);
    (diff^2 f) / (diff x_2 diff x_1), (diff^2 f) / (diff x_2^2), dots, (diff^2 f) / (diff x_2 diff x_n);
    dots.v, dots.v, dots.down, dots.v;
    (diff^2 f) / (diff x_n diff x_1), (diff^2 f) / (diff x_n^2 diff x_2), dots, (diff^2 f) / (diff x_n^2);
  )
$

*Diagonal entries: $(diff^2 f) / (diff x_i^2)$*

Second derivative of $f$ with respect to a single variable twice

How the slope of $f$ changes as you move along the $x_1$ direction

*Off-diagonal entries: $(diff^2 f) / (diff x_i diff x_j)$ where $i eq.not j$*

How the slope in one direction changes when you move in a different direction

$(diff^2 f) / (diff x_1 diff x_2)$: How the rate of change of $f$ along $x_1$ changes as you move in the $x_2$ direction

*Symmetric* (Clairaut-Schwarz theorem):

$
  (diff^2 f) / (diff x_i diff x_j) = (diff^2 f) / (diff x_j diff x_i)
$

$
  H_f (x) = H_f (x)^T
$



#eg[
  $
      f(x, y) = x^3 y + y^2
    $

    - Symbolic Hessian

    $
      gradient^2 f(x, y) = mat(
        (diff^2 f) / (diff x^2), (diff^2 f) / (diff x diff y);
        (diff^2 f) / (diff y diff x), (diff^2 f) / (diff y^2);
      ) = mat(
        6x y, 3x^2;
        3x^2, 2;
      )
    $

    - Evaluate at $(x, y) = (1, 2)$

    $
      gradient^2 f(1, 2) = mat(
        6 dot 1 dot 2, 3 dot 1^2;
        3 dot 1^2, 2;
      ) = mat(
        12, 3;
        3, 2;
      )
    $

    Each entry is now a scalar, and the Hessian is numeric
]

== Positive definite / negative definite / indefinite

Let $z in RR^n$be any nonzero vector. Look at the quadratic form:

$
  bold("z")^T H bold("z")
$

1. Positive definite (PD)

$
  bold("z")^T H bold("z") gt 0 quad forall bold("z") eq.not bold(0)
$

- Function curves upwards in all directions
- The point is a local minimum

2. Negative definite (ND)

$
  bold("z")^T H bold("z") lt 0 quad forall bold("z") eq.not bold(0)
$

- Function curves downwards in all directions
- The point is a local maximum

3. Indefinite

$
  bold("z")^T H bold("z") "is positive for some" bold("z") "and negative for others"
$

- Function curves up in some directions, down in others.
- The point is a saddle point.

