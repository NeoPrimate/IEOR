#import "/lib/imports.typ": *
#show: formatting

= Dimension <linear_algebra_dimension>

The *dimension* of a #link(<linear_algebra_vector_space>)[vector space] $V$ is the number of vectors in any #link(<linear_algebra_basis>)[basis] of $V$.

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

For #link(<linear_algebra_subspace>)[subspaces] $U, W subset.eq V$:

- $dim(U) <= dim(V)$
- $dim(U) = dim(V)$ implies $U = V$ (no proper subspace of full dimension)
- $dim(U + W) = dim(U) + dim(W) - dim(U inter W)$ (*Grassmann formula*)
- For a #link(<linear_algebra_linear_transformation>)[linear transformation] $T: V -> W$:
  $
    dim(V) = dim(ker(T)) + dim(im(T))
  $
  This is the #link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem]

== Computing dimensions of common subspaces

For an $m times n$ matrix $A$:

- $dim(#link(<linear_algebra_column_space>)[Col(A)]) = "rank"(A)$
- $dim(#link(<linear_algebra_null_space>)[Null(A)]) = n - "rank"(A)$ (the *nullity*)
- $dim(#link(<linear_algebra_rank>)[Row(A)]) = "rank"(A)$ (column rank = row rank)

== See also

- *#link(<linear_algebra_basis>)[Basis]* — what dimension counts
- *#link(<linear_algebra_rank>)[Rank]* — dimension of column / row / image
- *#link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem]*
