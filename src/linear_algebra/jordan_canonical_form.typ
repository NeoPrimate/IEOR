#import "/lib/imports.typ": *
#show: formatting


When a matrix is *not* #link(<linear-algebra-diagonalization>)[diagonalizable] (geometric multiplicity $<$ algebraic multiplicity for some eigenvalue), the Jordan canonical form is the next-best thing — *almost* diagonal, with $1$'s just above the diagonal in certain blocks.

Every square matrix $A$ over $bb(C)$ (or over $RR$ if all eigenvalues are real) is *similar* to its Jordan form $J$:

$
  A = P J P^(-1)
$

where $J$ is *block diagonal*:

$
  J = mat(
    J_(lambda_1, k_1), 0, dots, 0;
    0, J_(lambda_2, k_2), dots, 0;
    dots.v, dots.v, dots.down, dots.v;
    0, 0, dots, J_(lambda_r, k_r);
  )
$

== Jordan blocks

A *Jordan block* $J_(lambda, k)$ is a $k times k$ upper triangular matrix with $lambda$ on the diagonal and $1$ on the superdiagonal:

$
  J_(lambda, 1) = mat(lambda)
$

$
  J_(lambda, 2) = mat(lambda, 1; 0, lambda)
$

$
  J_(lambda, 3) = mat(lambda, 1, 0; 0, lambda, 1; 0, 0, lambda)
$

If $A$ has $k$ linearly independent eigenvectors for eigenvalue $lambda$ (geometric multiplicity $k$) and total multiplicity $m$ (algebraic multiplicity), the corresponding Jordan structure has $k$ blocks for $lambda$, whose sizes sum to $m$.

== Diagonalizable as a special case

If $A$ is diagonalizable, every Jordan block is $1 times 1$ — i.e., $J = D$ is just diagonal. The Jordan form generalizes diagonalization to handle "missing eigenvectors."

#example[
  $
    A = mat(5, 1; 0, 5)
  $

  Eigenvalue $lambda = 5$ with algebraic multiplicity $2$, geometric multiplicity $1$ (only eigenvector $vec(1, 0)$). Not diagonalizable.

  Jordan form: $J = mat(5, 1; 0, 5) = A$ (already in Jordan form).
]

#example[
  $
    A = mat(2, 1, 0; 0, 2, 0; 0, 0, 3)
  $

  Eigenvalues: $2$ (algebraic mult $2$, geometric mult $1$) and $3$ (mult $1$).

  Jordan form has one $2 times 2$ block for $lambda = 2$ and one $1 times 1$ block for $lambda = 3$:

  $
    J = mat(2, 1, 0; 0, 2, 0; 0, 0, 3) = A
  $
]

== Why it matters

- *Matrix exponential* $e^A = P e^J P^(-1)$, and $e^J$ on Jordan blocks has a known closed form (involving polynomial factors $t^k$ alongside $e^(lambda t)$ in the time evolution of linear ODEs)
- *Solving linear systems of ODEs* $accent(x, arrow)'(t) = A accent(x, arrow)(t)$ with repeated eigenvalues produces polynomial-times-exponential terms — directly traceable to non-trivial Jordan blocks
- *Generalized eigenvectors* — the "missing" basis vectors live in $ker((A - lambda I)^k)$ for $k > 1$

== Computation note

Computing the Jordan form numerically is *unstable* — small perturbations can turn a non-trivial Jordan block into a tight cluster of distinct eigenvalues. For numerical work, prefer the #link(<linear-algebra-svd>)[SVD] or the Schur form (always available, real or complex, and stable).

== See also

- *#link(<linear-algebra-diagonalization>)[Diagonalization]*
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors & Eigenvalues]*
- *#link(<linear-algebra-characteristic-polynomial>)[Characteristic Polynomial]* — algebraic multiplicity
- *#link(<linear-algebra-spectral-theorem>)[Spectral Theorem]* — when Jordan blocks are all $1 times 1$ (symmetric / Hermitian case)
