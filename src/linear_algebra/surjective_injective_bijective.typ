#import "/lib/imports.typ": *

#set math.mat(delim: "[")

Three properties a function $T: V -> W$ might (or might not) have, with clean characterizations for #link(<linear-algebra-linear-transformation>)[linear transformations].

== Injective (one-to-one)

Different inputs produce different outputs — no two distinct inputs collide:

$
  accent(x, arrow)_1 eq.not accent(x, arrow)_2 #h(0.5em) arrow.r.double #h(0.5em) T(accent(x, arrow)_1) eq.not T(accent(x, arrow)_2)
$

For a linear $T$, equivalently:
$
  ker(T) = {bold(0)}
$

(See #link(<linear-algebra-kernel>)[Kernel] — only the zero vector maps to zero.)

== Surjective (onto)

Every element of the codomain is hit by some input:

$
  forall accent(y, arrow) in W, #h(0.5em) exists accent(x, arrow) in V "with" T(accent(x, arrow)) = accent(y, arrow)
$

For a linear $T: RR^n -> RR^m$, equivalently:
$
  im(T) = RR^m, #h(1em) "i.e." #h(0.5em) "rank"(A) = m
$

(See #link(<linear-algebra-image>)[Image] / #link(<linear-algebra-rank>)[Rank].)

== Bijective (one-to-one *and* onto)

Both injective and surjective. Each output has *exactly one* preimage. Bijective linear transformations are *invertible*.

For a linear $T: RR^n -> RR^m$, bijective requires $m = n$ (square matrix) *and* $A$ is #link(<linear-algebra-matrix-inverse>)[invertible].

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

When invertible, $T^(-1)$ corresponds to $A^(-1)$ (see #link(<linear-algebra-matrix-inverse>)[Matrix Inverse]).

== See also

- *#link(<linear-algebra-kernel>)[Kernel]* / *#link(<linear-algebra-image>)[Image]*
- *#link(<linear-algebra-rank>)[Rank]* / *#link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity Theorem]*
- *#link(<linear-algebra-matrix-inverse>)[Matrix Inverse]*
