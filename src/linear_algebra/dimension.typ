#import "/lib/imports.typ": *
#show: formatting

The *dimension* of a #link(<linear-algebra-vector-space>)[vector space] $V$ is the number of vectors in any #link(<linear-algebra-basis>)[basis] of $V$.

$
  dim(V) = "(number of vectors in a basis)"
$

This number doesn't depend on which basis you pick — every basis of the same vector space has the same size.

#example[
  - $dim(RR^n) = n$ (the standard basis $e_1, dots, e_n$ has $n$ vectors)
  - $dim$ of the $x y$-plane in $RR^3$ is $2$
  - $dim({bold(0)}) = 0$ (the trivial space has the empty basis)
  - $dim$ of the space of $m times n$ matrices is $m n$
]

== Properties

For #link(<linear-algebra-subspace>)[subspaces] $U, W subset.eq V$:

- $dim(U) <= dim(V)$
- $dim(U) = dim(V)$ implies $U = V$ (no proper subspace of full dimension)
- $dim(U + W) = dim(U) + dim(W) - dim(U inter W)$ (*Grassmann formula*)
- For a #link(<linear-algebra-linear-transformation>)[linear transformation] $T: V -> W$:
  $
    dim(V) = dim(ker(T)) + dim(im(T))
  $
  This is the #link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity Theorem]

== Computing dimensions of common subspaces

For an $m times n$ matrix $A$:

- $dim(#link(<linear-algebra-column-space>)[Col(A)]) = "rank"(A)$
- $dim(#link(<linear-algebra-null-space>)[Null(A)]) = n - "rank"(A)$ (the *nullity*)
- $dim(#link(<linear-algebra-rank>)[Row(A)]) = "rank"(A)$ (column rank = row rank)

== See also

- *#link(<linear-algebra-basis>)[Basis]* — what dimension counts
- *#link(<linear-algebra-rank>)[Rank]* — dimension of column / row / image
- *#link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity Theorem]*
