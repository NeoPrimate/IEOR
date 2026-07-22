#import "/lib/imports.typ": *
#show: formatting

= Rank–Nullity Theorem <linear_algebra_rank_nullity_theorem>

For a #link(<linear_algebra_linear_transformation>)[linear transformation] $T: V -> W$ between finite-dimensional vector spaces:

$
  underbrace(dim(V), n) = underbrace(dim(ker(T)), "nullity") + underbrace(dim(im(T)), "rank")
$

In matrix form, for an $m times n$ matrix $A$:

$
  n = dim(#link(<linear_algebra_null_space>)[null(A)]) + #link(<linear_algebra_rank>)[rank(A)]
$

(See #link(<linear_algebra_dimension>)[Dimension], #link(<linear_algebra_null_space>)[Null Space], and #link(<linear_algebra_rank>)[Rank].)

The dimension of the input space splits *exactly* into the part that gets sent to zero (the kernel) and the part that survives as the image.

== Why it's true (sketch)

Pick a basis ${k_1, dots, k_p}$ for $ker(T)$, then extend it to a basis ${k_1, dots, k_p, v_1, dots, v_q}$ for $V$ (so $n = p + q$).

Then ${T(v_1), dots, T(v_q)}$ is a basis for $im(T)$ — they span (because the $k$'s map to $0$) and are linearly independent (a non-trivial dependency would land back in $ker(T)$, contradicting linear independence of the $v$'s with the $k$'s).

So $dim(im(T)) = q$, and $dim(ker(T)) + dim(im(T)) = p + q = n$. ∎

== Why it matters

It's the bookkeeping identity for linear maps. Lots of immediate consequences:

- *Injectivity from dimensions*: if $T: RR^n -> RR^m$ has $n > m$, then $dim(ker(T)) >= n - m > 0$ — *not injective*.
- *Surjectivity from dimensions*: if $T: RR^n -> RR^m$ with $n < m$, then $dim(im(T)) <= n < m$ — *not surjective*.
- *Square invertibility*: a square matrix $A$ is #link(<linear_algebra_matrix_inverse>)[invertible] iff $ker(A) = {bold(0)}$ iff $im(A) = RR^n$ — by rank–nullity these are equivalent for square $A$.
- *Solution space dimension*: the solution set of $A accent(x, arrow) = accent(b, arrow)$ (when consistent) has dimension $n - "rank"(A)$ — see #link(<linear_algebra_linear_system_solutions>)[Linear System Solutions].

#example[
  $A = mat(1, 2, 3; 2, 4, 6)$. The two rows are dependent → $"rank"(A) = 1$.

  $n = 3$ → nullity $= 3 - 1 = 2$.

  $A accent(x, arrow) = bold(0)$ has a 2-dimensional solution space (a plane through the origin in $RR^3$).
]

== Equivalent statements

For an $m times n$ matrix $A$:

- $"rank"(A) + "nullity"(A) = n$ (number of columns)
- $"rank"(A) = "rank"(A^T)$ — *row rank = column rank*
- $"nullity"(A^T) = m - "rank"(A)$ — gives the dimension of the *left* null space

== See also

- *#link(<linear_algebra_rank>)[Rank]*
- *#link(<linear_algebra_null_space>)[Null Space]* / *#link(<linear_algebra_kernel>)[Kernel]*
- *#link(<linear_algebra_image>)[Image]* / *#link(<linear_algebra_column_space>)[Column Space]*
- *#link(<linear_algebra_surjective_injective_bijective>)[Surjective / Injective / Bijective]*
