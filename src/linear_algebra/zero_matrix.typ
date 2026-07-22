#import "/lib/imports.typ": *
#show: formatting

= Zero Matrix <linear_algebra_zero_matrix>

The *zero matrix* $0_(m times n)$ is the $m times n$ matrix with every entry equal to $0$.

$
  0_(2 times 3) = mat(0, 0, 0; 0, 0, 0)
$

The *zero vector* is the $n times 1$ zero matrix:

$
  bold(0) = vec(0, 0, dots.v, 0)
$

== Why it's "the zero"

It's the *additive identity* for matrix addition:

$
  A + 0 = 0 + A = A
$

And the *absorbing element* for #link(<linear_algebra_matrix_multiplication>)[matrix multiplication]:

$
  A dot 0 = 0 dot A = 0
$

(provided shapes are compatible — note the result $0$ may have different shape than the input $0$.)

== Key properties

- *#link(<linear_algebra_determinant>)[Determinant]*: $det(0_(n times n)) = 0$ — singular
- *#link(<linear_algebra_rank>)[Rank]*: $"rank"(0) = 0$
- *#link(<linear_algebra_trace>)[Trace]*: $"tr"(0_(n times n)) = 0$
- *#link(<linear_algebra_null_space>)[Null space]*: $"null"(0) = RR^n$ — every vector maps to zero

== Where the zero vector matters

- The zero vector is in *every* #link(<linear_algebra_subspace>)[subspace] (subspace axiom)
- *#link(<linear_algebra_linear_independence>)[Linear independence]* test: $sum c_i v_i = bold(0)$ has only the trivial solution
- *#link(<linear_algebra_kernel>)[Kernel]* of a linear map: vectors that map to $bold(0)$
- *Homogeneous systems*: $A x = bold(0)$ — always has at least the trivial solution $x = bold(0)$
