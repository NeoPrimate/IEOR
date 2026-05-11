#import "/lib/imports.typ": *


The *transpose* $A^T$ of a matrix $A$ flips it across its main diagonal — rows become columns:

$
  (A^T)_(i j) = A_(j i)
$

If $A$ is $m times n$, then $A^T$ is $n times m$.

#example[
  $
    A = mat(1, 2, 3; 4, 5, 6) #h(2em) A^T = mat(1, 4; 2, 5; 3, 6)
  $
]

== Properties

- *Involution*: $(A^T)^T = A$
- *Sum*: $(A + B)^T = A^T + B^T$
- *Scalar*: $(c #h(0.2em) A)^T = c #h(0.2em) A^T$
- *Product* (order reversed): $(A B)^T = B^T A^T$
- *Inverse*: $(A^T)^(-1) = (A^(-1))^T$ (when $A$ is invertible)
- *#link(<linear-algebra-determinant>)[Determinant]*: $det(A^T) = det(A)$
- *#link(<linear-algebra-rank>)[Rank]*: $"rank"(A^T) = "rank"(A)$

== Special cases

- *#link(<linear-algebra-symmetric-matrix>)[Symmetric]*: $A^T = A$
- *Skew-symmetric*: $A^T = -A$
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal]*: $A^T = A^(-1)$, i.e. $A^T A = I$
- *Vector transpose*: a column vector becomes a row vector and vice-versa

== Connection to dot product

For column vectors $accent(u, arrow), accent(v, arrow) in RR^n$:

$
  accent(u, arrow) dot accent(v, arrow) = accent(u, arrow)^T accent(v, arrow)
$

(see #link(<linear-algebra-dot-product>)[Dot Product])
