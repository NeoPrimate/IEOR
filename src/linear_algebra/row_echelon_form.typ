#import "/lib/imports.typ": *
#show: formatting


A matrix is in *Row Echelon Form (REF)* if it satisfies all of:

1. *Pivot* — each non-zero row has a leading non-zero entry called a *pivot*
2. *Zeros below pivots* — each pivot has zeros below it in its column
3. *Rightward staircase* — each pivot is strictly to the right of the pivot in the row above
4. *Zero rows at bottom* — any all-zero rows appear at the bottom

$
  mat(
    augment: #4,
    1, a_(1 2), a_(1 3), a_(1 4), b_1;
    0, 1, a_(2 3), a_(2 4), b_2;
    0, 0, 1, a_(3 4), b_3;
    0, 0, 0, 0, 0;
  )
$

== Elementary row operations

The three operations that don't change the solution set of a system, used to drive a matrix toward REF:

1. *Row swap*: exchange two rows
2. *Row scale*: multiply a row by a non-zero scalar
3. *Row replacement*: add a multiple of one row to another

These are applied via #link(<linear-algebra-gaussian-elimination>)[Gaussian elimination].

#example[
  System:

  $
    2 x + y + z = 8 \
    -3 x - y + 2 z = -11 \
    -2 x + y + 2 z = -3
  $

  Augmented matrix:

  $
    mat(
      augment: #3,
      2, 1, 1, 8;
      -3, -1, 2, -11;
      -2, 1, 2, -3;
    )
  $

  *Step 1*: $R_1 arrow.r 1/2 R_1$:

  $
    mat(
      augment: #3,
      1, 0.5, 0.5, 4;
      -3, -1, 2, -11;
      -2, 1, 2, -3;
    )
  $

  *Step 2*: $R_2 arrow.r R_2 + 3 R_1$, $R_3 arrow.r R_3 + 2 R_1$:

  $
    mat(
      augment: #3,
      1, 0.5, 0.5, 4;
      0, 0.5, 3.5, 1;
      0, 2, 3, 5;
    )
  $

  *Step 3*: $R_2 arrow.r 2 R_2$:

  $
    mat(
      augment: #3,
      1, 0.5, 0.5, 4;
      0, 1, 7, 2;
      0, 2, 3, 5;
    )
  $

  *Step 4*: $R_3 arrow.r R_3 - 2 R_2$:

  $
    mat(
      augment: #3,
      1, 0.5, 0.5, 4;
      0, 1, 7, 2;
      0, 0, -11, 1;
    )
  $

  *Step 5*: $R_3 arrow.r -1/11 R_3$ (now in REF):

  $
    mat(
      augment: #3,
      1, 0.5, 0.5, 4;
      0, 1, 7, 2;
      0, 0, 1, -1/11;
    )
  $

  *Step 6*: back-substitute.

  $
    z = -1/11, quad y = 2 - 7 z = 29/11, quad x = 4 - 0.5 y - 0.5 z = 31/11
  $
]

== REF vs RREF

REF is not unique. The stronger #link(<linear-algebra-rref>)[RREF] (Reduced Row Echelon Form) — pivots equal $1$ and zeros above as well as below — *is* unique.

== See also

- *#link(<linear-algebra-rref>)[RREF]* — canonical reduced form
- *#link(<linear-algebra-linear-system-solutions>)[Linear System Solutions]* — unique / none / infinite
- *#link(<linear-algebra-linear-system-special-cases>)[Linear System Special Cases]* — when zero rows appear
- *#link(<linear-algebra-gaussian-elimination>)[Gaussian Elimination]* — the algorithm
