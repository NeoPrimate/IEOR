#import "/lib/imports.typ": *

#set math.mat(delim: "[")

Every $m times n$ matrix $A$ with $m >= n$ can be factored as:

$
  A = Q R
$

where:

- $Q$ is $m times n$ with *orthonormal columns* (so $Q^T Q = I_n$)
- $R$ is $n times n$ *upper #link(<linear-algebra-triangular-matrix>)[triangular]*

If $A$ is full column rank, the decomposition is unique up to signs on the diagonal of $R$.

For square $A$ (full rank), $Q$ is a full #link(<linear-algebra-orthogonal-matrix>)[orthogonal matrix] and $R$ is square upper triangular.

== Construction via Gram–Schmidt

The columns of $Q$ are the result of applying #link(<linear-algebra-gram-schmidt>)[Gram–Schmidt orthogonalization] to the columns of $A$:

- $a_1, a_2, dots, a_n$ are the columns of $A$
- $q_1, q_2, dots, q_n$ are orthonormalized versions
- $R$ records the coefficients of each $a_j$ in terms of $q_1, dots, q_j$

Explicitly, $R_(i j) = q_i^T a_j$ for $i <= j$ and $0$ for $i > j$.

#example[
  $
    A = mat(1, 0; 1, 1; 0, 1)
  $

  Apply Gram–Schmidt to columns:
  - $q_1 = a_1 / ||a_1|| = 1/sqrt(2) vec(1, 1, 0)$
  - Project $a_2$ off $q_1$: $a_2 - (q_1^T a_2) q_1 = vec(0, 1, 1) - 1/sqrt(2) dot 1/sqrt(2) vec(1, 1, 0) = vec(-1/2, 1/2, 1)$
  - $q_2 = $ that, normalized: $1/sqrt(6) vec(-1, 1, 2)$

  $
    Q = mat(1/sqrt(2), -1/sqrt(6); 1/sqrt(2), 1/sqrt(6); 0, 2/sqrt(6))
  $

  $
    R = Q^T A = mat(sqrt(2), 1/sqrt(2); 0, sqrt(3/2))
  $
]

== Why it matters

QR is the workhorse for *least-squares problems*:

Given $A accent(x, arrow) = accent(b, arrow)$ overdetermined (more equations than unknowns), the least-squares solution

$
  hat(accent(x, arrow)) = arg min_(accent(x, arrow)) ||A accent(x, arrow) - accent(b, arrow)||^2
$

solves the *normal equations* $A^T A accent(x, arrow) = A^T accent(b, arrow)$. Using $A = Q R$:

$
  R accent(x, arrow) = Q^T accent(b, arrow)
$

Then back-substitute on the upper-triangular $R$ — much more numerically stable than forming $A^T A$ directly.

Other uses:
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvalue]* computation via the QR algorithm — iteratively factor $A_k = Q_k R_k$ and update $A_(k+1) = R_k Q_k$; converges to a triangular matrix whose diagonal gives the eigenvalues
- *Orthonormalizing a basis* numerically (Gram–Schmidt is unstable in floating point; Householder QR is much more reliable)
- *Solving square systems* as an alternative to #link(<linear-algebra-lu-decomposition>)[LU]

== Computation methods

- *Classical Gram–Schmidt* — conceptually clean but numerically unstable
- *Modified Gram–Schmidt* — small variation, much more stable
- *Householder reflections* — uses orthogonal reflections, very stable, $O(m n^2)$
- *Givens rotations* — useful for sparse / structured matrices

== See also

- *#link(<linear-algebra-gram-schmidt>)[Gram–Schmidt Process]* — the orthogonalization underlying QR
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
- *#link(<linear-algebra-triangular-matrix>)[Triangular Matrix]*
- *#link(<linear-algebra-lu-decomposition>)[LU]* / *#link(<linear-algebra-cholesky-decomposition>)[Cholesky]* / *#link(<linear-algebra-svd>)[SVD]*
