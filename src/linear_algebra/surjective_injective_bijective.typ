#import "/lib/imports.typ": *
#show: formatting

= Surjective, Injective, Bijective <linear_algebra_surjective_injective_bijective>

Three properties a function $T: V -> W$ might (or might not) have, with clean characterizations for #link(<linear_algebra_linear_transformation>)[linear transformations].

== Injective (one-to-one)

Different inputs produce different outputs — no two distinct inputs collide:

$
  accent(x, arrow)_1 eq.not accent(x, arrow)_2 #h(0.5em) arrow.r.double #h(0.5em) T(accent(x, arrow)_1) eq.not T(accent(x, arrow)_2)
$

For a linear $T$, equivalently:
$
  ker(T) = {bold(0)}
$

(See #link(<linear_algebra_kernel>)[Kernel] — only the zero vector maps to zero.)

== Surjective (onto)

Every element of the codomain is hit by some input:

$
  forall accent(y, arrow) in W, #h(0.5em) exists accent(x, arrow) in V "with" T(accent(x, arrow)) = accent(y, arrow)
$

For a linear $T: RR^n -> RR^m$, equivalently:
$
  im(T) = RR^m, #h(1em) "i.e." #h(0.5em) "rank"(A) = m
$

(See #link(<linear_algebra_image>)[Image] / #link(<linear_algebra_rank>)[Rank].)

== Bijective (one-to-one *and* onto)

Both injective and surjective. Each output has *exactly one* preimage. Bijective linear transformations are *invertible*.

For a linear $T: RR^n -> RR^m$, bijective requires $m = n$ (square matrix) *and* $A$ is #link(<linear_algebra_matrix_inverse>)[invertible].

== Summary table for linear $T: RR^n -> RR^m$ given by matrix $A$

#table(
  columns: 4,
  align: (left, left, left, left),
  stroke: none,
  table.header([*Property*], [*Equivalent (rank)*], [*Equivalent (kernel/image)*], [*Possible only if*]),
  [Injective], [$"rank"(A) = n$], [$ker(T) = {bold(0)}$], [$m >= n$ (full column rank)],
  [Surjective], [$"rank"(A) = m$], [$im(T) = RR^m$], [$n >= m$ (full row rank)],
  [Bijective], [$"rank"(A) = m = n$], [both above], [$m = n$ and $A$ invertible],
)

#example[
  $A = mat(1, 0; 0, 1; 0, 0)$ — $T: RR^2 -> RR^3$.

  - $"rank" = 2 = n$ → injective
  - $"rank" = 2 < 3 = m$ → not surjective
  - Not bijective ($m eq.not n$)
]

== Connection to inverse

A linear $T$ has an inverse iff it's bijective iff $A$ is square and invertible.

When invertible, $T^(-1)$ corresponds to $A^(-1)$ (see #link(<linear_algebra_matrix_inverse>)[Matrix Inverse]).

== See also

- *#link(<linear_algebra_kernel>)[Kernel]* / *#link(<linear_algebra_image>)[Image]*
- *#link(<linear_algebra_rank>)[Rank]* / *#link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem]*
- *#link(<linear_algebra_matrix_inverse>)[Matrix Inverse]*
