#import "/lib/imports.typ": *
#show: formatting

*Dimension* of the column *space*

$
  "rank"(A) = "dim"(C(A))
$

=== Matrix Representation of Systems of Equations

$
  a_(1 1) x_1 + a_(1 2) x_2 + ... + a_(1 m) x_m = b_1 \
  a_(2 1) x_1 + a_(2 2) x_2 + ... + a_(2 m) x_m = b_2 \
  dots.v \
  a_(n 1) x_1 + a_(n 2) x_2 + ... + a_(n m) x_m = b_n \
$

Coefficient Matrix ($A$):

$
  A = mat(
    a_(1 1), a_(1 2), ..., a_(1 m);
    a_(2 1), a_(2 2), ..., a_(2 m);
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), dots.h, a_(n m);
  )
$

Variable Vector (x):

$
  " x " = vec(x_1, x_2, dots.v, x_m)
$

Constant Vector (b):

$
  " b " = vec(b_1, b_2, dots.v, b_n)
$


$
  "Ax" = b
$

#example[
  The system of equations:

  $
    2 x_1 + 3 x_2 + 5 x_3 = 100 \
    4 x_1 + 2 x_2 + 1 x_3 = 80 \
    1 x_1 + 5 x_2 + 2 x_3 = 60 \
  $

  Can be represented as a matrix equation:

  $
    mat(
      2, 3, 5;
      4, 2, 1;
      1, 5, 2;
    )
    vec(x_1, x_2, x_3)
    = vec(100, 80, 60)
  $
]
