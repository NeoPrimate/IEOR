#import "/lib/imports.typ": *

#set math.mat(delim: "[")
#set math.vec(delim: "[")

The *Moore–Penrose pseudoinverse* $A^+$ generalizes the matrix #link(<linear-algebra-matrix-inverse>)[inverse] to *every* matrix — square, rectangular, full-rank, or rank-deficient.

For invertible square $A$, $A^+ = A^(-1)$. For other matrices, $A^+$ provides the "best possible inverse" in a precise least-squares sense.

== Definition via SVD

If $A = U Sigma V^T$ is the #link(<linear-algebra-svd>)[SVD] of $A$, then:

$
  A^+ = V Sigma^+ U^T
$

where $Sigma^+$ is the *transpose* of $Sigma$ with each non-zero singular value $sigma_i$ replaced by $1/sigma_i$ (zero singular values stay zero).

== Four defining properties

$A^+$ is uniquely characterized by the *Moore–Penrose conditions*:

1. $A A^+ A = A$
2. $A^+ A A^+ = A^+$
3. $(A A^+)^T = A A^+$ — symmetric
4. $(A^+ A)^T = A^+ A$ — symmetric

These force a unique $A^+$ for every matrix.

== Special cases

*Full column rank* ($m >= n$, $"rank"(A) = n$):

$
  A^+ = (A^T A)^(-1) A^T
$

*Full row rank* ($m <= n$, $"rank"(A) = m$):

$
  A^+ = A^T (A A^T)^(-1)
$

*Square invertible*: $A^+ = A^(-1)$.

== Least-squares solution

For the overdetermined system $A accent(x, arrow) = accent(b, arrow)$ (more equations than unknowns), the *minimum-norm least-squares solution* is:

$
  hat(accent(x, arrow)) = A^+ accent(b, arrow)
$

Properties:
- If a solution to $A accent(x, arrow) = accent(b, arrow)$ exists, $hat(accent(x, arrow))$ is one (the one with smallest #link(<linear-algebra-norm>)[norm])
- If no exact solution exists, $hat(accent(x, arrow))$ minimizes $||A accent(x, arrow) - accent(b, arrow)||$

This is the foundation of linear regression and least-squares fitting.

#example[
  $
    A = mat(1, 0; 0, 0; 0, 0) #h(2em) accent(b, arrow) = vec(3, 4, 5)
  $

  No exact solution (rows 2 and 3 are inconsistent with non-zero $b$ entries).

  SVD: $sigma_1 = 1$, $sigma_2 = 0$. So $Sigma^+ = mat(1, 0, 0; 0, 0, 0)$ (transpose of $Sigma$ with $sigma_2$ left zero).

  $
    A^+ = mat(1, 0, 0; 0, 0, 0) #h(2em) hat(accent(x, arrow)) = A^+ accent(b, arrow) = vec(3, 0)
  $

  This minimizes $||A accent(x, arrow) - accent(b, arrow)||$ and has minimum norm among minimizers.
]

== Why it generalizes the inverse

- Replaces "exact solution" with "best least-squares approximation"
- Handles rank-deficient systems (where standard inverse is undefined)
- Handles rectangular systems (where standard inverse is undefined)
- Reduces to ordinary inverse exactly when ordinary inverse exists

== See also

- *#link(<linear-algebra-svd>)[SVD]* — the construction
- *#link(<linear-algebra-matrix-inverse>)[Matrix Inverse]* — special case
- *#link(<linear-algebra-qr-decomposition>)[QR]* — used to compute the pseudoinverse in the full-rank case
- *#link(<statistics-regression-analysis-simple-linear-regression>)[Linear Regression]* — pseudoinverse gives OLS coefficients $hat(beta) = (X^T X)^(-1) X^T y = X^+ y$
