#import "/lib/imports.typ": *
#show: formatting

= Matrix Multiplication <linear_algebra_matrix_multiplication>

For matrices $A$ ($m times n$) and $B$ ($n times p$), the product $C = A B$ is the $m times p$ matrix with entries:

$
  c_(i j) = sum_(k=1)^n a_(i k) #h(0.2em) b_(k j)
$

Each entry $c_(i j)$ is the #link(<linear_algebra_dot_product>)[dot product] of *row $i$ of $A$* with *column $j$ of $B$*.

*Compatibility*: inner dimensions must match — $A$'s columns must equal $B$'s rows.

#example[
  $
    A = mat(1, 2; 3, 4) #h(2em) B = mat(5, 6; 7, 8)
  $

  $
    A B = mat(
      1 dot 5 + 2 dot 7, 1 dot 6 + 2 dot 8;
      3 dot 5 + 4 dot 7, 3 dot 6 + 4 dot 8;
    ) = mat(19, 22; 43, 50)
  $
]

== Properties

- *Associative*: $(A B) C = A (B C)$
- *Distributive*: $A(B + C) = A B + A C$ and $(A + B) C = A C + B C$
- *Not commutative*: in general $A B eq.not B A$
- *#link(<linear_algebra_identity_matrix>)[Identity]*: $I A = A I = A$
- *#link(<linear_algebra_transpose>)[Transpose]*: $(A B)^T = B^T A^T$
- *#link(<linear_algebra_matrix_inverse>)[Inverse]* (when defined): $(A B)^(-1) = B^(-1) A^(-1)$
- *#link(<linear_algebra_determinant>)[Determinant]*: $det(A B) = det(A) #h(0.2em) det(B)$
- *Zero product*: $A B = 0$ does *not* imply $A = 0$ or $B = 0$

== Geometric meaning

If $A$ and $B$ represent #link(<linear_algebra_linear_transformation>)[linear transformations], then $A B$ represents the *composition* — apply $B$ first, then $A$ (see #link(<linear_algebra_composition_of_linear_transformations>)[Composition of Linear Transformations]).

== Special cases

- $A B$ where $B$ is a single column → #link(<linear_algebra_matrix_vector_product>)[matrix–vector product]
- $A B$ where both are vectors → #link(<linear_algebra_dot_product>)[dot product] (1×1 result)
- *Outer product*: column vector × row vector = rank-1 matrix
