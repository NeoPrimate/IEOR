#import "/lib/imports.typ": *

The null space (or kernel) of a matrix $bold(A)$ is the set of all vectors $bold(x)$ that satisfy the equation:

$
  bold(A) accent(x, arrow) = bold(0)
$

Where:
- $bold(A)$: $m times n$ matrix
- $accent(x, arrow)$: $n$-dimansional vector
- $bold(0)$: zero vecor in $RR^m$

$
  N(bold(A)) = N("rref"(bold(A))) = "span"(accent(v, arrow)_1, accent(v, arrow)_2, accent(v, arrow)_3)
$

#example[
  $
    bold(A) = mat(
      1, 1, 1, 1;
      1, 2, 3, 4;
      4, 3, 2, 1;
    )
  $

  We want to find the null space of $A$, which consists of all vectors $x = vec(x_1, x_2, x_3, x_4)$ that satisfy:

  $
    bold(A) accent(x, arrow) = bold(0)
  $

  This expands to the following system of linear equations:

  $
    cases(
      1 x_1 + 1 x_2 + 1 x_3 + 1 x_4 = 0,
      1 x_1 + 2 x_2 + 3 x_3 + 4 x_4 = 0,
      4 x_1 + 3 x_2 + 2 x_3 + 1 x_4 = 0,
    )
  $

  This can be represented as the augmented matrix:

  $
    mat(
      augment: #4,
      1, 1, 1, 1, 0;
      1, 2, 3, 4, 0;
      4, 3, 2, 1, 0;
    )
  $

]

=== Nullity

*Dimension* of the *Null Space*

$
  dim(N(bold(A)))
$

The nullity of $A$: number of non-pivot columns (i.e., free variables) in the rref of A



== Matrix Multiplication

$m times n$ matrix:

$
  A = mat(
    a_(1 1), a_(1 2), ..., a_(1 m);
    a_(2 1), a_(2 2), ..., a_(2 m);
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), dots.h, a_(n m);
  )
$

$n times p$ matrix:

$
  B = mat(
    a_(1 1), a_(1 2), ..., a_(1 p);
    a_(2 1), a_(2 2), ..., a_(2 p);
    dots.v, dots.v, dots.down, dots.v;
    a_(n 1), a_(n 2), dots.h, a_(n p);
  )
$

Compute Each Element of Result Matrix $C$

$
  c_(i j) = sum_(k=1)^n = a_(i k) b_(k j)
$

#example[
  Let $A$ be an $n times m$ matrix:

  $
    A = mat(
      1, 2, 3;
      4, 5, 6;
    )
  $

  Let $B$ an $p times n$ matrix:

  $
    B = mat(
      7, 8;
      9, 10;
      11, 12;
    )
  $

  Calculate Each Element of $C$

  $
    c_(1 1) = (1 dot 7) + (2 dot 9) + (3 dot 11) = 58 \
    c_(1 2) = (1 dot 8) + (2 dot 10) + (3 dot 12) = 64 \
    c_(2 1) = (4 dot 7) + (5 dot 9) + (6 dot 11) = 138 \
    c_(2 2) = (4 dot 8) + (5 dot 10) + (6 dot 12) = 154 \
  $

  $C$ is a $m times p$ matrix

  $
    C = mat(
      58, 64;
      139, 154;
    )
  $
]
