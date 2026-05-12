#import "/lib/imports.typ": *
#show: formatting


A square matrix whose only non-zero entries lie on the *main diagonal*:

$
  D = mat(d_1, 0, dots, 0; 0, d_2, dots, 0; dots.v, dots.v, dots.down, dots.v; 0, 0, dots, d_n)
$

Often written as $"diag"(d_1, d_2, dots, d_n)$.

#example[
  $
    D = mat(3, 0, 0; 0, -1, 0; 0, 0, 5)
  $
]

== Why diagonal matrices are useful

Operations become trivial — they act componentwise:

- *Multiplication by vector*: $D #h(0.2em) accent(x, arrow) = (d_1 x_1, d_2 x_2, dots, d_n x_n)$
- *Powers*: $D^k = "diag"(d_1^k, dots, d_n^k)$
- *#link(<linear-algebra-matrix-inverse>)[Inverse]* (when each $d_i eq.not 0$): $D^(-1) = "diag"(1/d_1, dots, 1/d_n)$
- *#link(<linear-algebra-determinant>)[Determinant]*: $det(D) = d_1 d_2 dots d_n$
- *#link(<linear-algebra-trace>)[Trace]*: $"tr"(D) = d_1 + d_2 + dots + d_n$
- *Eigenvalues*: $d_1, d_2, dots, d_n$ themselves
- *Eigenvectors*: standard basis vectors $e_1, dots, e_n$

== Special cases

- *#link(<linear-algebra-identity-matrix>)[Identity matrix]*: all $d_i = 1$
- *#link(<linear-algebra-zero-matrix>)[Zero matrix]* (square): all $d_i = 0$
- *Scalar matrix*: all $d_i = c$ for the same scalar $c$ (i.e. $c #h(0.2em) I$)

== Where they show up

- *#link(<linear-algebra-diagonalization>)[Diagonalization]*: turning a general matrix into a diagonal one via change of basis
- *#link(<linear-algebra-svd>)[SVD]*: $A = U Sigma V^T$ where $Sigma$ is diagonal
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigen-decomposition]*: $A = P D P^(-1)$ where $D$ is diagonal of eigenvalues
