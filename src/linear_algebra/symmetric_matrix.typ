#import "/lib/imports.typ": *

#set math.mat(delim: "[")

A square matrix that equals its own #link(<linear-algebra-transpose>)[transpose]:

$
  A^T = A #h(2em) "i.e." #h(0.5em) A_(i j) = A_(j i) "for all" i, j
$

Symmetric matrices are mirror-images across the main diagonal.

#example[
  $
    A = mat(2, -1, 4; -1, 5, 0; 4, 0, 3) #h(2em) A^T = A #h(0.5em) checkmark
  $
]

== Skew-symmetric matrices

The mirror flips sign: $A^T = -A$, equivalently $A_(i j) = -A_(j i)$.

Diagonal entries must be zero (since $A_(i i) = -A_(i i)$).

$
  S = mat(0, 3, -2; -3, 0, 5; 2, -5, 0)
$

== Why symmetric matrices are special

- *Real eigenvalues*: every #link(<linear-algebra-eigenvectors-eigenvalues>)[eigenvalue] of a real symmetric matrix is real
- *Orthogonal eigenvectors*: eigenvectors corresponding to *distinct* eigenvalues are orthogonal
- *#link(<linear-algebra-spectral-theorem>)[Spectral theorem]*: every real symmetric matrix is *orthogonally diagonalizable*:
  $
    A = Q D Q^T
  $
  where $Q$ is orthogonal and $D$ is diagonal of eigenvalues
- Defines a *#link(<linear-algebra-quadratic-form>)[quadratic form]* $accent(x, arrow)^T A accent(x, arrow)$

== Decomposing any matrix

Any square matrix $M$ uniquely splits into a symmetric and skew-symmetric part:

$
  M = underbrace(1/2 (M + M^T), "symmetric") + underbrace(1/2 (M - M^T), "skew-symmetric")
$

== Where they show up

- *Covariance matrices* — always symmetric (and positive semi-definite)
- *#link(<linear-algebra-quadratic-form>)[Quadratic forms]* — only the symmetric part matters
- *Hessian matrices* — symmetric for $C^2$ functions (Schwarz's theorem)
- *Gram matrices* $X^T X$ — always symmetric and positive semi-definite
- *Adjacency matrices* of undirected graphs — symmetric
