#import "/lib/imports.typ": *



The gradient $gradient f(x, y)$ is a vector of expressions (equations)

If

$
  f: RR^n arrow RR
$

The gradient is always *a vector in the same space as the input variables*

$
  gradient f(x) = vec(
    (partial f) / (partial x_1),
    (partial f) / (partial x_2),
    dots.v,
    (partial f) / (partial x_n),
  ) in RR^n
$

#example[
  $
    f(x, y) = x^2 + x y + y^2 \
    gradient f(x, y) = vec(
      (partial f) / (partial x),
      (partial f) / (partial y),
    )
    =
    mat(
      2x + y;
      x + 2y;
    )
  $

  Evaluating at a point

  If you plug in numbers for $x$ and $y$, each component becomes a scalar:

  $
    (x, y) = (1, 2)
    quad
    arrow.double
    quad
    gradient f(1, 2) = mat(
      2 dot 1 + 2;
      1 + 2 dot 2;
    ) = vec(
      4,
      5,
    )
  $

]
