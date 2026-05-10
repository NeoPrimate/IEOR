#import "/lib/imports.typ": *

#set math.mat(delim: "[")
#set math.vec(delim: "[")

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

And the *absorbing element* for #link(<linear-algebra-matrix-multiplication>)[matrix multiplication]:

$
  A dot 0 = 0 dot A = 0
$

(provided shapes are compatible — note the result $0$ may have different shape than the input $0$.)

== Key properties

- *#link(<linear-algebra-determinant>)[Determinant]*: $det(0_(n times n)) = 0$ — singular
- *#link(<linear-algebra-rank>)[Rank]*: $"rank"(0) = 0$
- *#link(<linear-algebra-trace>)[Trace]*: $"tr"(0_(n times n)) = 0$
- *#link(<linear-algebra-null-space>)[Null space]*: $"null"(0) = RR^n$ — every vector maps to zero

== Where the zero vector matters

- The zero vector is in *every* #link(<linear-algebra-subspace>)[subspace] (subspace axiom)
- *#link(<linear-algebra-linear-independence>)[Linear independence]* test: $sum c_i v_i = bold(0)$ has only the trivial solution
- *#link(<linear-algebra-kernel>)[Kernel]* of a linear map: vectors that map to $bold(0)$
- *Homogeneous systems*: $A x = bold(0)$ — always has at least the trivial solution $x = bold(0)$
