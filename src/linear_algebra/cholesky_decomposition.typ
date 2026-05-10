#import "/lib/imports.typ": *

#set math.mat(delim: "[")

Every *symmetric positive-definite* matrix $A$ has a unique factorization:

$
  A = L L^T
$

where $L$ is *lower #link(<linear-algebra-triangular-matrix>)[triangular]* with positive diagonal entries.

The Cholesky decomposition is the *symmetric square root* of a positive-definite matrix — like writing a positive number $a$ as $sqrt(a) dot sqrt(a)$.

== Existence and uniqueness

Cholesky exists iff $A$ is:
1. *#link(<linear-algebra-symmetric-matrix>)[Symmetric]*: $A^T = A$
2. *Positive definite*: $accent(x, arrow)^T A accent(x, arrow) > 0$ for all $accent(x, arrow) eq.not bold(0)$

If either fails, Cholesky fails. For positive *semi-definite* $A$ a related decomposition exists but is non-unique.

For symmetric *indefinite* $A$, use the $L D L^T$ variant ($D$ diagonal with arbitrary signs).

== Algorithm (forward construction)

Compute $L$ column by column, $j = 1, dots, n$:

$
  L_(j j) = sqrt(A_(j j) - sum_(k=1)^(j-1) L_(j k)^2)
$

$
  L_(i j) = 1/L_(j j) (A_(i j) - sum_(k=1)^(j-1) L_(i k) L_(j k)), #h(0.5em) "for" i > j
$

Cost: about $n^3 / 3$ — *half* of LU decomposition (we exploit symmetry).

#example[
  $
    A = mat(4, 12, -16; 12, 37, -43; -16, -43, 98)
  $

  $
    L = mat(2, 0, 0; 6, 1, 0; -8, 5, 3)
  $

  Verify: $L L^T = A$. ✓
]

== Why use Cholesky

1. *Solving $A accent(x, arrow) = accent(b, arrow)$*: split into $L accent(y, arrow) = accent(b, arrow)$ (forward substitution) then $L^T accent(x, arrow) = accent(y, arrow)$ (backward substitution). Twice as fast as LU for symmetric positive-definite $A$.

2. *Testing positive-definiteness*: an attempt to compute Cholesky fails (negative argument to $sqrt$, or division by zero) iff $A$ is not positive definite. Cheap test.

3. *Sampling from multivariate Gaussian*: if $Sigma = L L^T$ is the covariance matrix and $accent(z, arrow) ~ cal(N)(bold(0), I)$ (standard normal), then $accent(x, arrow) = L accent(z, arrow)$ is $cal(N)(bold(0), Sigma)$.

4. *Linear least squares* (alternative to #link(<linear-algebra-qr-decomposition>)[QR]): the normal equations $A^T A accent(x, arrow) = A^T accent(b, arrow)$ have a symmetric positive-definite system matrix $A^T A$; Cholesky solves it.

5. *Determinant*: $det(A) = product L_(i i)^2$ — much cheaper than expanding directly.

== Relation to LU and SVD

- #link(<linear-algebra-lu-decomposition>)[LU]: $A = L U$ — general matrices, $L$ lower-triangular, $U$ upper-triangular
- Cholesky: $A = L L^T$ — symmetric positive-definite case, $U = L^T$
- #link(<linear-algebra-svd>)[SVD]: $A = U Sigma V^T$ — completely general, gives singular values, more expensive

For symmetric positive-definite $A$, Cholesky is the fastest and most stable choice.

== See also

- *#link(<linear-algebra-symmetric-matrix>)[Symmetric Matrix]*
- *#link(<linear-algebra-quadratic-form>)[Quadratic Form]* — positive-definite condition
- *#link(<linear-algebra-triangular-matrix>)[Triangular Matrix]*
- *#link(<linear-algebra-lu-decomposition>)[LU]* / *#link(<linear-algebra-qr-decomposition>)[QR]* / *#link(<linear-algebra-svd>)[SVD]*
