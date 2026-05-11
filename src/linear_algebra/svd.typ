#import "/lib/imports.typ": *


Every real matrix $A$ — square or rectangular, full-rank or rank-deficient — has a *Singular Value Decomposition*:

$
  A = U Sigma V^T
$

where, for an $m times n$ matrix $A$:

- $U$ is $m times m$ #link(<linear-algebra-orthogonal-matrix>)[orthogonal] — columns are the *left singular vectors*
- $Sigma$ is $m times n$ #link(<linear-algebra-diagonal-matrix>)[diagonal] with non-negative entries $sigma_1 >= sigma_2 >= dots >= 0$ — the *singular values*
- $V$ is $n times n$ orthogonal — columns are the *right singular vectors*

== Singular values

The singular values are the *square roots of the eigenvalues* of $A^T A$ (which is symmetric positive semi-definite):

$
  sigma_i = sqrt(lambda_i (A^T A))
$

Number of non-zero singular values = #link(<linear-algebra-rank>)[rank] of $A$.

== Geometric interpretation

Every linear transformation $A: RR^n -> RR^m$ decomposes into:

1. *Rotate / reflect* in the input space (multiply by $V^T$)
2. *Stretch* along the new axes by factors $sigma_1, sigma_2, dots$ (multiply by $Sigma$)
3. *Rotate / reflect* in the output space (multiply by $U$)

So every matrix is a *rotation–stretch–rotation*. The singular values measure how much $A$ stretches each direction.

#example[
  $
    A = mat(3, 0; 0, 1; 0, 0)
  $

  Already in SVD form: $U = I_3$, $Sigma = A$, $V = I_2$. Singular values: $sigma_1 = 3, sigma_2 = 1$.

  $A$ maps the unit circle in $RR^2$ to an ellipse in $RR^3$ with semi-axes $3$ and $1$.
]

== Compact / reduced SVD

For rank-$r$ matrix $A$, drop the zero singular values:

$
  A = U_r Sigma_r V_r^T
$

where $U_r$ is $m times r$, $Sigma_r$ is $r times r$ diagonal, $V_r$ is $n times r$. Same product, less storage.

== Best low-rank approximation

The truncated SVD (keeping the top $k$ singular values) is the *best rank-$k$ approximation* of $A$ in both Frobenius and spectral norms:

$
  A_k = sum_(i=1)^k sigma_i u_i v_i^T
$

This is the engine behind:

- *Image / signal compression*
- *Recommender systems* / matrix factorization
- *Noise reduction* — drop tiny singular values

== Connection to symmetric matrices

If $A$ is symmetric positive semi-definite, the SVD coincides with the eigendecomposition (#link(<linear-algebra-spectral-theorem>)[Spectral Theorem]): $U = V$ and $Sigma$ = eigenvalues.

For general $A$, $A^T A$ and $A A^T$ are both symmetric:
- *Right singular vectors* of $A$ = eigenvectors of $A^T A$ (with eigenvalues $sigma_i^2$)
- *Left singular vectors* of $A$ = eigenvectors of $A A^T$ (with same eigenvalues $sigma_i^2$)

== Connection to pseudoinverse

When $A$ is not square or not invertible, the *Moore–Penrose* #link(<linear-algebra-pseudoinverse>)[pseudoinverse] uses the SVD:

$
  A^+ = V Sigma^+ U^T
$

where $Sigma^+$ inverts the non-zero singular values and transposes the shape.

== See also

- *#link(<linear-algebra-spectral-theorem>)[Spectral Theorem]* — symmetric special case
- *#link(<linear-algebra-pseudoinverse>)[Pseudoinverse]*
- *#link(<linear-algebra-qr-decomposition>)[QR]* / *#link(<linear-algebra-cholesky-decomposition>)[Cholesky]* / *#link(<linear-algebra-lu-decomposition>)[LU]* — other matrix factorizations
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
