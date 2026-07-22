#import "/lib/imports.typ": *
#show: formatting

= Null Space <linear_algebra_null_space>

The *null space* (or #link(<linear_algebra_kernel>)[kernel]) of a matrix $bold(A)$ is the set of all vectors $accent(x, arrow)$ that satisfy:

$
  bold(A) accent(x, arrow) = bold(0)
$

For an $m times n$ matrix $A$:
- $accent(x, arrow) in RR^n$
- $bold(0) in RR^m$

The null space is a #link(<linear_algebra_subspace>)[subspace] of $RR^n$. By the #link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem]:

$
  dim("Null"(A)) = n - "rank"(A)
$

== Computing the null space

Row-reduce $A$ to #link(<linear_algebra_rref>)[RREF]. The non-pivot columns correspond to *free variables*; the pivot columns are expressed in terms of those free variables. A basis for the null space is built from one vector per free variable.

#example[
  $
    bold(A) = mat(
      1, 1, 1, 1;
      1, 2, 3, 4;
      4, 3, 2, 1;
    )
  $

  Find $accent(x, arrow) = vec(x_1, x_2, x_3, x_4)$ with $bold(A) accent(x, arrow) = bold(0)$:

  $
    cases(
      1 x_1 + 1 x_2 + 1 x_3 + 1 x_4 = 0,
      1 x_1 + 2 x_2 + 3 x_3 + 4 x_4 = 0,
      4 x_1 + 3 x_2 + 2 x_3 + 1 x_4 = 0,
    )
  $

  Augmented matrix:

  $
    mat(
      augment: #4,
      1, 1, 1, 1, 0;
      1, 2, 3, 4, 0;
      4, 3, 2, 1, 0;
    )
  $

  Row-reduce to find the null space. (See #link(<linear_algebra_gaussian_elimination>)[Gaussian Elimination].)
]

== Nullity

The *nullity* of $A$ is the dimension of its null space:

$
  "nullity"(A) = dim("Null"(A))
$

After row-reducing $A$ to #link(<linear_algebra_rref>)[RREF], nullity equals the number of *non-pivot columns* (= number of free variables).

== Kernel vs null space

For a #link(<linear_algebra_linear_transformation>)[linear transformation] $T(accent(x, arrow)) = A accent(x, arrow)$:

$
  ker(T) = "Null"(A)
$

Same set, different names: *kernel* is the linear-map perspective, *null space* is the matrix perspective. See #link(<linear_algebra_kernel>)[Kernel].

== Left null space

The null space of $A^T$ is called the *left null space* of $A$:

$
  "Null"(A^T) = { accent(y, arrow) : accent(y, arrow)^T A = bold(0) }
$

It's orthogonal to the #link(<linear_algebra_column_space>)[column space] of $A$. Together with $"Null"(A)$ and $"Row"(A)$, these are the *four fundamental subspaces*.

== See also

- *#link(<linear_algebra_kernel>)[Kernel]* — same concept, transformation perspective
- *#link(<linear_algebra_rank_nullity_theorem>)[Rank–Nullity Theorem]*
- *#link(<linear_algebra_rank>)[Rank]*
- *#link(<linear_algebra_homogeneous_system>)[Homogeneous System]*
- *#link(<linear_algebra_column_space>)[Column Space]* — the "output side" counterpart
