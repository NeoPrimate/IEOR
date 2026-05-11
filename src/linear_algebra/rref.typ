#import "/lib/imports.typ": *


A matrix is in *Reduced Row Echelon Form* (RREF) if it satisfies all of the following:

1. *Echelon form* — see #link(<linear-algebra-row-echelon-form>)[REF]:
   - Any all-zero rows are at the bottom
   - Leading entries (*pivots*) move strictly right as you go down
2. *Each pivot is $1$* (the leading entry of every non-zero row)
3. *Each pivot is the only non-zero entry in its column* (zeros above and below)

#example[
  RREF:
  $
    mat(1, 0, 0, 4; 0, 1, 0, -2; 0, 0, 1, 7; 0, 0, 0, 0)
  $

  Not RREF (the pivot in column 2 is $3$, not $1$, and column 1 has a non-zero above the pivot):
  $
    mat(1, 5, 2; 0, 3, 4; 0, 0, 0)
  $
]

== RREF vs REF

| Form | Pivots | Above pivots |
|---|---|---|
| #link(<linear-algebra-row-echelon-form>)[REF] | non-zero | unrestricted |
| RREF | exactly $1$ | all $0$ |

REF comes from #link(<linear-algebra-gaussian-elimination>)[Gaussian elimination]; RREF is what #link(<linear-algebra-gauss-jordan-elimination>)[Gauss–Jordan elimination] produces.

== Uniqueness

Given a matrix $A$, its REF is *not* unique (depends on row operations chosen), but its *RREF is unique*. So RREF is a canonical form — useful for:

- Reading off the #link(<linear-algebra-rank>)[rank]: number of non-zero rows
- Reading off the solution to $A x = b$ directly from $[A | b]$ in RREF
- Identifying #link(<linear-algebra-linear-independence>)[linearly independent] columns: the *pivot columns*
- Computing the #link(<linear-algebra-null-space>)[null space] basis from free variables

== Reading the solution

After reducing #link(<linear-algebra-augmented-matrix>)[augmented matrix] $[A | accent(b, arrow)]$ to RREF:

#example[
  $
    mat(augment: #(-1), 1, 0, 3, 0, 5, 4; 0, 1, -2, 0, 1, 7; 0, 0, 0, 1, 6, 2)
  $

  *Pivot columns*: 1, 2, 4 → pivot variables $x_1, x_2, x_4$.
  *Free columns*: 3, 5 → free variables $x_3, x_5$.

  Solution (parametric):
  $
    x_1 = 4 - 3 x_3 - 5 x_5 \
    x_2 = 7 + 2 x_3 - x_5 \
    x_4 = 2 - 6 x_5 \
    x_3, x_5 #h(0.5em) "free"
  $
]
