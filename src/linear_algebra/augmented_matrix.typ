#import "/lib/imports.typ": *
#show: formatting



When solving the linear system $A accent(x, arrow) = accent(b, arrow)$, the *augmented matrix* $[A | accent(b, arrow)]$ stacks the coefficient matrix and the right-hand side into one $m times (n+1)$ matrix:

$
  [A | accent(b, arrow)] = mat(
    augment: #(-1),
    a_11, a_12, dots, a_(1 n), b_1;
    a_21, a_22, dots, a_(2 n), b_2;
    dots.v, dots.v, dots.down, dots.v, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n), b_m;
  )
$

The vertical bar separates the coefficients from the constants — purely visual; row operations treat it as one matrix.

#example[
  System:
  $
    2 x_1 + 3 x_2 = 7 \
    x_1 - x_2 = 1
  $

  Augmented form:
  $
    [A | accent(b, arrow)] = mat(augment: #(-1), 2, 3, 7; 1, -1, 1)
  $
]

== Why use it

Row-reducing $[A | accent(b, arrow)]$ to #link(<linear-algebra-row-echelon-form>)[REF] (via #link(<linear-algebra-gaussian-elimination>)[Gaussian elimination]) or #link(<linear-algebra-rref>)[RREF] (via Gauss–Jordan) reads off the solution directly — no need to substitute back manually if you go all the way to RREF.

== Reading solutions

After row reduction:
- *Unique solution*: $"rank"(A) = "rank"([A | accent(b, arrow)]) = n$
- *Infinite solutions*: $"rank"(A) = "rank"([A | accent(b, arrow)]) < n$ (free variables)
- *No solution*: $"rank"(A) < "rank"([A | accent(b, arrow)])$ — a row $[0, 0, dots, 0 | c]$ with $c eq.not 0$ appears

This is the *Rouché–Capelli theorem* expressed in terms of augmented-matrix ranks.

== Connections

- #link(<linear-algebra-gaussian-elimination>)[Gaussian Elimination] — the algorithm that operates on $[A | b]$
- #link(<linear-algebra-rref>)[RREF] — the canonical row-reduced form
- #link(<linear-algebra-homogeneous-system>)[Homogeneous System] — when $accent(b, arrow) = bold(0)$
- #link(<linear-algebra-linear-system-solutions>)[Linear System Solutions]
