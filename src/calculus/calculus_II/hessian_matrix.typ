#import "/src/imports.typ": *

== Hessian Matrix <hessian_matrix>

#prerequisites(
  prereqs: (),
  dependents: (
    // link(<newton_method>)[Newton's Method],
  ),
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
    (partial^2 f) / (partial x_1^2), (partial^2 f) / (partial x_1 partial x_2), dots, (partial^2 f) / (partial x_1 partial x_n);
    (partial^2 f) / (partial x_2 partial x_1), (partial^2 f) / (partial x_2^2), dots, (partial^2 f) / (partial x_2 partial x_n);
    dots.v, dots.v, dots.down, dots.v;
    (partial^2 f) / (partial x_n partial x_1), (partial^2 f) / (partial x_n^2 partial x_2), dots, (partial^2 f) / (partial x_n^2);
  )
$

*Diagonal entries: $(partial^2 f) / (partial x_i^2)$*

Second derivative of $f$ with respect to a single variable twice

How the slope of $f$ changes as you move along the $x_1$ direction

*Off-diagonal entries: $(partial^2 f) / (partial x_i partial x_j)$ where $i eq.not j$*

How the slope in one direction changes when you move in a different direction

$(partial^2 f) / (partial x_1 partial x_2)$: How the rate of change of $f$ along $x_1$ changes as you move in the $x_2$ direction

*Symmetric* (Clairaut-Schwarz theorem):

$
  (partial^2 f) / (partial x_i partial x_j) = (partial^2 f) / (partial x_j partial x_i)
$

$
  H_f (x) = H_f (x)^T
$



#example[
  $
    f(x, y) = x^3 y + y^2
  $

  - Symbolic Hessian

  $
    gradient^2 f(x, y) = mat(
      (partial^2 f) / (partial x^2), (partial^2 f) / (partial x partial y);
      (partial^2 f) / (partial y partial x), (partial^2 f) / (partial y^2);
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
