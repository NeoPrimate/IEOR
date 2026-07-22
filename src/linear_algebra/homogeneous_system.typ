#import "/lib/imports.typ": *
#show: formatting

= Homogeneous System <linear_algebra_homogeneous_system>

A linear system is *homogeneous* if its right-hand side is the zero vector:

$
  A accent(x, arrow) = bold(0)
$

Every homogeneous system is *consistent* — it always has at least the *trivial solution* $accent(x, arrow) = bold(0)$.

== When are there non-trivial solutions?

The non-trivial solutions form the #link(<linear_algebra_null_space>)[null space] of $A$ (equivalently, the #link(<linear_algebra_kernel>)[kernel] of the linear map $T(x) = A x$):

$
  "Sol"(A x = bold(0)) = "null"(A) = ker(T)
$

By the #link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem], for an $m times n$ matrix $A$:

$
  dim("null"(A)) = n - "rank"(A)
$

So:

#table(
  columns: 2,
  align: (left, left),
  stroke: none,
  table.header([*$"rank"(A)$*], [*Solution set*]),
  $= n$, [only the trivial solution $accent(x, arrow) = bold(0)$],
  $< n$, [a subspace of dimension $n - "rank"(A) > 0$ — *infinitely many* solutions],
)

Notably: an $n times n$ homogeneous system has a non-trivial solution *iff* $A$ is singular (i.e., $det(A) = 0$).

#example[
  Solve $A accent(x, arrow) = bold(0)$ for $A = mat(delim: "[", 1, 2, -1; 2, 4, -2)$.

  Row-reduce: $R_2 -> R_2 - 2 R_1 = (0, 0, 0)$. So $"rank" = 1$, nullity $= 3 - 1 = 2$.

  From row 1: $x_1 + 2 x_2 - x_3 = 0$, so $x_1 = -2 x_2 + x_3$. With $x_2, x_3$ free:

  $
    accent(x, arrow) = x_2 vec(-2, 1, 0) + x_3 vec(1, 0, 1)
  $

  Two-parameter family of solutions — a plane through the origin in $RR^3$.
]

== Connection to general systems

If $A accent(x, arrow) = accent(b, arrow)$ has solution $accent(x, arrow)_p$ (a particular solution), the *full* solution set is:

$
  accent(x, arrow)_p + "null"(A) = { accent(x, arrow)_p + accent(x, arrow)_h : accent(x, arrow)_h in "null"(A) }
$

— the particular solution plus any solution to the *associated homogeneous system*. This is why homogeneous systems are the "structural skeleton" of solution sets.

== See also

- *#link(<linear_algebra_null_space>)[Null Space]* / *#link(<linear_algebra_kernel>)[Kernel]*
- *#link(<linear_algebra_linear_system_solutions>)[Linear System Solutions]*
- *#link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem]*
- *#link(<linear_algebra_zero_matrix>)[Zero Vector]*
