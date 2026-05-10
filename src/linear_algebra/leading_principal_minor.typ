#import "/lib/imports.typ": *

#set math.mat(delim: "[")

A *leading principal minor* of order $k$ is the #link(<linear-algebra-determinant>)[determinant] of the *top-left* $k times k$ submatrix of $A$.

That is, take rows and columns indexed $1, 2, dots, k$ — no other choices.

For a $3 times 3$ matrix, the three leading principal minors are:

#align(center)[
  #grid(
    columns: 3,
    gutter: 2em,
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (0, 0)), red),
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (1, 1)), red),
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (2, 2)), red),
          )
        )
      $
    ],
  )
]

Order 1: $a_(1 1)$. Order 2: $det mat(a_(1 1), a_(1 2); a_(2 1), a_(2 2))$. Order 3: $det(A)$ itself.

== Sylvester's criterion (positive-definiteness)

A symmetric matrix $A$ is *positive definite* iff *all* leading principal minors are strictly positive:

$
  Delta_1 > 0, #h(0.5em) Delta_2 > 0, #h(0.5em) dots, #h(0.5em) Delta_n > 0
$

where $Delta_k$ is the order-$k$ leading principal minor.

For *negative definite*: signs alternate — $Delta_1 < 0, Delta_2 > 0, Delta_3 < 0, dots$ (i.e. $(-1)^k Delta_k > 0$).

#example[
  $
    A = mat(2, -1; -1, 3)
  $

  $Delta_1 = 2 > 0$, $Delta_2 = 2 dot 3 - (-1)(-1) = 5 > 0$. So $A$ is positive definite.
]

== See also

- *#link(<linear-algebra-principal-minor>)[Principal Minor]* — general principal minors (any subset of indices)
- *#link(<linear-algebra-minor>)[Minor]* — general (cofactor) minors
- *#link(<linear-algebra-determinant>)[Determinant]*
