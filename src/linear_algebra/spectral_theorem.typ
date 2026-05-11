#import "/lib/imports.typ": *


The *Spectral Theorem* says that every real #link(<linear-algebra-symmetric-matrix>)[symmetric matrix] is *orthogonally diagonalizable*:

$
  A = Q D Q^T
$

where:

- $D$ is a #link(<linear-algebra-diagonal-matrix>)[diagonal matrix] whose entries are the (always *real*) eigenvalues of $A$
- $Q$ is an #link(<linear-algebra-orthogonal-matrix>)[orthogonal matrix] whose columns are an *orthonormal* basis of eigenvectors of $A$

Equivalently, $Q^T Q = I$, and the columns of $Q$ are orthonormal eigenvectors.

== What it guarantees

For a real symmetric matrix $A$:

1. *All eigenvalues are real* (no complex eigenvalues, even if $A$'s entries don't suggest it)
2. *Eigenvectors for distinct eigenvalues are orthogonal* (automatic)
3. *Eigenvectors for repeated eigenvalues can be chosen orthonormal* (within that eigenspace, via #link(<linear-algebra-gram-schmidt>)[Gram–Schmidt])
4. The full set of $n$ orthonormal eigenvectors forms a basis of $RR^n$

The trio (1)+(2)+(3) is what makes the theorem work. No real symmetric matrix is missing eigenvectors.

== Spectral expansion

Write $Q = mat(q_1, q_2, dots, q_n)$ and $D = "diag"(lambda_1, dots, lambda_n)$. Then:

$
  A = sum_(i=1)^n lambda_i #h(0.2em) q_i q_i^T
$

The matrix decomposes into a sum of rank-1 *spectral projectors* $q_i q_i^T$, each scaled by an eigenvalue. This is the *spectral decomposition*.

#example[
  $
    A = mat(2, 1; 1, 2)
  $

  Eigenvalues: $lambda_1 = 3, lambda_2 = 1$.

  Orthonormal eigenvectors: $q_1 = 1/sqrt(2) vec(1, 1)$, $q_2 = 1/sqrt(2) vec(1, -1)$.

  $
    Q = 1/sqrt(2) mat(1, 1; 1, -1) #h(2em) D = mat(3, 0; 0, 1) #h(2em) A = Q D Q^T
  $

  Spectral expansion: $A = 3 q_1 q_1^T + 1 q_2 q_2^T = 3/2 mat(1, 1; 1, 1) + 1/2 mat(1, -1; -1, 1)$.
]

== Generalizations

- *Complex Hermitian matrices* ($A^* = A$, where $A^*$ is the conjugate transpose): same theorem, with $Q$ replaced by a *unitary* matrix $U$ ($U^* U = I$).
- *Normal matrices* ($A^* A = A A^*$): same theorem in $bb(C)^n$ — unitarily diagonalizable.

== Why it matters

- *#link(<linear-algebra-quadratic-form>)[Quadratic forms]*: $accent(x, arrow)^T A accent(x, arrow)$ simplifies to $sum lambda_i y_i^2$ in the eigenbasis $y = Q^T x$. Definiteness is read off the signs of eigenvalues.
- *PCA / dimensionality reduction*: the covariance matrix is symmetric → orthogonal eigenbasis = principal components.
- *Optimization*: the Hessian is symmetric → its spectrum classifies critical points.
- *Quantum mechanics*: observables are Hermitian operators; their eigenvalues are the possible measured values.
- *#link(<linear-algebra-svd>)[SVD]* extends the idea to non-square / non-symmetric matrices.

== See also

- *#link(<linear-algebra-symmetric-matrix>)[Symmetric Matrix]*
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
- *#link(<linear-algebra-diagonalization>)[Diagonalization]*
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors & Eigenvalues]*
- *#link(<linear-algebra-svd>)[SVD]*
