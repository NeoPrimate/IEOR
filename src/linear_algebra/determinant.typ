#import "/lib/imports.typ": *
#show: formatting

A scalar attached to every *square* matrix that measures the *signed scale factor* the matrix applies to areas / volumes when used as a linear map.

Notation: $det(A)$, or $|A|$.

== From first principles: the $2 times 2$ case

Take two vectors $accent(a, arrow), accent(b, arrow) in RR^2$:

$
  accent(a, arrow) = vec(a_1, a_2) quad quad accent(b, arrow) = vec(b_1, b_2)
$

They span a parallelogram. Its *signed area* is:

$
  "Area" = a_1 b_2 - a_2 b_1
$

That signed area is exactly the determinant of the matrix whose columns are $accent(a, arrow), accent(b, arrow)$:

$
  det mat(a_1, b_1; a_2, b_2) = a_1 b_2 - a_2 b_1
$

Sign:
- $+$ if $accent(b, arrow)$ is counterclockwise from $accent(a, arrow)$ (preserved orientation)
- $-$ if clockwise (orientation flipped)
- $0$ if $accent(a, arrow)$ and $accent(b, arrow)$ are collinear (parallelogram degenerates)

#example[
  $
    A = mat(3, 1; 0, 2) #h(2em) det(A) = 3 dot 2 - 1 dot 0 = 6
  $

  The unit square $[0,1]^2$ maps to a parallelogram of area $6$ — six times bigger.

  $
    B = mat(1, 2; 2, 4) #h(2em) det(B) = 1 dot 4 - 2 dot 2 = 0
  $

  The columns are parallel (one is twice the other) — image collapses to a line, area $0$.
]

== $3 times 3$: signed volume of the parallelepiped

Three column vectors $accent(a, arrow), accent(b, arrow), accent(c, arrow) in RR^3$ span a parallelepiped. Its signed volume is:

$
  det mat(
    a_1, b_1, c_1;
    a_2, b_2, c_2;
    a_3, b_3, c_3;
  ) = a_1 (b_2 c_3 - b_3 c_2) - a_2 (b_1 c_3 - b_3 c_1) + a_3 (b_1 c_2 - b_2 c_1)
$

This is the *cofactor expansion* along the first column — three $2 times 2$ determinants, alternating sign.

== General $n times n$: cofactor expansion

For an $n times n$ matrix $A$, expand along *any* row $i$ (or any column $j$):

$
  det(A) = sum_(j=1)^n (-1)^(i+j) a_(i j) #h(0.3em) M_(i j)
$

where $M_(i j)$ is the *minor* — the determinant of the $(n-1) times (n-1)$ submatrix obtained by deleting row $i$ and column $j$ of $A$ (see #link(<linear-algebra-minor>)[Minor]).

The factor $(-1)^(i+j)$ produces the *checkerboard sign pattern*:

$
  mat(
    +, -, +, dots;
    -, +, -, dots;
    +, -, +, dots;
    dots.v, dots.v, dots.v, dots.down;
  )
$

The recursion bottoms out at the $1 times 1$ case: $det([a]) = a$.

== Key properties

- *Identity*: $det(I_n) = 1$
- *Multiplicativity*: $det(A B) = det(A) #h(0.2em) det(B)$
- *Transpose*: $det(A^T) = det(A)$
- *Inverse*: $det(A^(-1)) = 1 / det(A)$ (when defined)
- *Scalar multiple*: $det(c #h(0.2em) A) = c^n #h(0.2em) det(A)$ for an $n times n$ matrix
- *Triangular matrix*: $det = $ product of diagonal entries
- *Row swap*: flips the sign
- *Row scaled by $c$*: multiplies $det$ by $c$
- *Row $+$ multiple of another row*: leaves $det$ unchanged (basis of Gaussian-elimination computation)

== What $det(A)$ tells you about $A$

#table(
  columns: 2,
  align: (left, left),
  stroke: none,
  table.header([*$det(A)$*], [*Implication*]),
  $eq.not 0$, [$A$ is invertible (see #link(<linear-algebra-matrix-inverse>)[Matrix Inverse]); columns are linearly independent (see #link(<linear-algebra-linear-independence>)[Linear Independence]); columns span $RR^n$; $A$ has full rank (see #link(<linear-algebra-rank>)[Rank]); $A x = b$ has a unique solution for every $b$.],
  $= 0$, [$A$ is *singular* — non-invertible; columns are linearly dependent; image is a strict subspace; $A x = 0$ has non-trivial solutions; the linear map collapses dimension.],
  [], [],
)

== Geometric interpretation

For a linear map $T: RR^n -> RR^n$ given by matrix $A$:

- $|det(A)|$ = factor by which $T$ scales $n$-dimensional volume
- $"sign"(det(A))$ = whether $T$ preserves $(+)$ or reverses $(-)$ orientation

#example[
  Reflection across the $y$-axis:

  $
    R = mat(-1, 0; 0, 1) #h(2em) det(R) = -1
  $

  Areas preserved (factor $|-1| = 1$); orientation reversed (sign).
]

== Computing $det$ in practice

- *$2 times 2$ / $3 times 3$*: direct formula above.
- *Larger matrices*: cofactor expansion is $O(n!)$ — impractical past $n approx 10$.
- *Standard method*: row-reduce to triangular form, multiply diagonal entries, track row-operation effects on $det$ (see #link(<linear-algebra-gaussian-elimination>)[Gaussian Elimination]). This is $O(n^3)$.
- *LU decomposition* (see #link(<linear-algebra-lu-decomposition>)[LU Decomposition]): $det(A) = det(L) #h(0.2em) det(U) = product$ of $U$'s diagonal entries (since $L$ has unit diagonal).

== Connection to other concepts

- *#link(<linear-algebra-minor>)[Minor]* — building block for cofactor expansion
- *#link(<linear-algebra-adjugate>)[Adjugate]* — matrix of cofactors, used in $A^(-1) = "adj"(A) / det(A)$
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors & Eigenvalues]* — eigenvalues are roots of $det(A - lambda I) = 0$
- *#link(<linear-algebra-unimodularity>)[Unimodularity]* — matrices with $det = plus.minus 1$
