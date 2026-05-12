#import "/lib/imports.typ": *
#show: formatting


An extension of #link(<linear-algebra-gaussian-elimination>)[Gaussian elimination] that takes the matrix all the way to *Reduced Row Echelon Form* (#link(<linear-algebra-rref>)[RREF]) — not just to upper-triangular #link(<linear-algebra-row-echelon-form>)[REF].

== Two phases

1. *Forward elimination* (same as Gaussian elimination): pivot to get zeros *below* each pivot, achieve REF (upper-triangular form).
2. *Back-substitution turned into elimination*: pivot upward to also clear *above* each pivot, and scale each pivot row so the pivot equals $1$.

Result: each pivot is $1$, with all-zero columns above and below it — the canonical RREF.

== Why bother going past REF?

After full Gauss–Jordan, the solution to $A accent(x, arrow) = accent(b, arrow)$ can be *read directly* off the right-hand side of the #link(<linear-algebra-augmented-matrix>)[augmented matrix] $[A | accent(b, arrow)]$ — no back substitution needed.

Also useful for:
- Computing the inverse: row-reduce $[A | I]$ to $[I | A^(-1)]$
- Finding a basis for the #link(<linear-algebra-null-space>)[null space]
- Reading off #link(<linear-algebra-rank>)[rank] (number of pivots) and #link(<linear-algebra-linear-independence>)[linearly independent] columns (the pivot columns)

#example[
  Apply Gauss–Jordan to:
  $
    mat(
      augment: #2,
      1, 2, 5;
      3, 7, 16;
    )
  $

  Forward: $R_2 -> R_2 - 3 R_1$ gives
  $
    mat(
      augment: #2,
      1, 2, 5;
      0, 1, 1;
    )
  $

  Backward: $R_1 -> R_1 - 2 R_2$ gives
  $
    mat(
      augment: #2,
      1, 0, 3;
      0, 1, 1;
    )
  $

  Read the solution off: $x_1 = 3, #h(0.5em) x_2 = 1$.
]

== Inverse via Gauss–Jordan

To compute $A^(-1)$ for an $n times n$ invertible matrix, form $[A | I_n]$ and row-reduce until the left half is the identity:

$
  [A | I_n] #h(0.5em) arrow.r.long #h(0.5em) [I_n | A^(-1)]
$

#example[
  $A = mat(2, 1; 5, 3)$. Augment with $I_2$:

  $
    mat(
      augment: #2,
      2, 1, 1, 0;
      5, 3, 0, 1;
    )
  $

  Row-reduce to $[I | A^(-1)]$:

  $
    mat(
      augment: #2,
      1, 0, 3, -1;
      0, 1, -5, 2;
    )
  $

  $
    A^(-1) = mat(3, -1; -5, 2)
  $
]

== Cost

Gauss–Jordan is $O(n^3)$ — same asymptotic complexity as Gaussian elimination + back substitution, but with a slightly larger constant. For solving a single system, plain Gaussian elimination with back-substitution is marginally faster; for the inverse or RREF directly, Gauss–Jordan is the natural choice.

== See also

- *#link(<linear-algebra-gaussian-elimination>)[Gaussian Elimination]* — the forward phase only
- *#link(<linear-algebra-row-echelon-form>)[REF]* / *#link(<linear-algebra-rref>)[RREF]*
- *#link(<linear-algebra-matrix-inverse>)[Matrix Inverse]*
