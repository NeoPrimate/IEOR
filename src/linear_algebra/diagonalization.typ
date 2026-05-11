#import "/lib/imports.typ": *


A square matrix $A$ is *diagonalizable* if it can be written as

$
  A = P D P^(-1)
$

where $D$ is a #link(<linear-algebra-diagonal-matrix>)[diagonal matrix] and $P$ is an invertible matrix.

The diagonal entries of $D$ are the #link(<linear-algebra-eigenvectors-eigenvalues>)[eigenvalues] of $A$, and the columns of $P$ are the corresponding eigenvectors.

== When is $A$ diagonalizable?

An $n times n$ matrix is diagonalizable iff it has $n$ linearly independent eigenvectors.

Equivalent conditions:
- $A$ has $n$ distinct eigenvalues → automatically diagonalizable
- Every eigenvalue's *geometric multiplicity* equals its *algebraic multiplicity* (see #link(<linear-algebra-characteristic-polynomial>)[Characteristic Polynomial])
- $RR^n$ has a basis consisting of eigenvectors of $A$ (an *eigenbasis*)

Some matrices are *not* diagonalizable — e.g., $mat(1, 1; 0, 1)$ has only one eigenvalue ($1$) of algebraic multiplicity $2$ but geometric multiplicity $1$. For non-diagonalizable matrices, see #link(<linear-algebra-jordan-canonical-form>)[Jordan Canonical Form].

== How to diagonalize

1. Find the eigenvalues $lambda_1, dots, lambda_n$ from $det(A - lambda I) = 0$.
2. For each $lambda_i$, find a basis for $ker(A - lambda_i I)$ — the eigenvectors.
3. Assemble eigenvectors into columns of $P$, eigenvalues into the diagonal of $D$ (in matching order).
4. Verify by computing $P D P^(-1)$.

#example[
  $A = mat(4, -2; 1, 1)$.

  Characteristic polynomial: $det(A - lambda I) = (4-lambda)(1-lambda) - (-2)(1) = lambda^2 - 5 lambda + 6 = (lambda - 2)(lambda - 3)$.

  Eigenvalues: $lambda_1 = 2, lambda_2 = 3$.

  Eigenvectors: solve $(A - 2 I) accent(v, arrow) = bold(0)$ → $accent(v, arrow)_1 = vec(1, 1)$. And $(A - 3 I) accent(v, arrow) = bold(0)$ → $accent(v, arrow)_2 = vec(2, 1)$.

  $
    P = mat(1, 2; 1, 1) #h(2em) D = mat(2, 0; 0, 3)
  $
]

== Why it matters: power and exponential

In diagonal form, matrix arithmetic is trivial:

$
  A^k = (P D P^(-1))^k = P D^k P^(-1)
$

with $D^k$ just powering each diagonal entry. This makes:
- $A^k$ for large $k$ tractable (Markov chains, dynamics)
- *Matrix exponential* $e^A = P e^D P^(-1)$ (linear ODE solutions)
- Solving linear recurrences in closed form

== Spectral decomposition (real symmetric case)

If $A$ is real and #link(<linear-algebra-symmetric-matrix>)[symmetric], then it's *always* diagonalizable and can be done with an #link(<linear-algebra-orthogonal-matrix>)[orthogonal] $P$:

$
  A = Q D Q^T, #h(0.5em) "where" #h(0.5em) Q^T Q = I
$

This is the #link(<linear-algebra-spectral-theorem>)[Spectral Theorem] — the gold standard of diagonalization.

== Failure: non-diagonalizable matrices

$
  A = mat(1, 1; 0, 1)
$

has only the eigenvalue $1$ (with algebraic multiplicity $2$) and only one independent eigenvector $vec(1, 0)$. Not diagonalizable — the best you can do is the Jordan form.

== See also

- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors & Eigenvalues]*
- *#link(<linear-algebra-characteristic-polynomial>)[Characteristic Polynomial]*
- *#link(<linear-algebra-spectral-theorem>)[Spectral Theorem]* — symmetric case
- *#link(<linear-algebra-jordan-canonical-form>)[Jordan Canonical Form]* — non-diagonalizable case
- *#link(<linear-algebra-change-of-basis>)[Change of Basis]* — what $P$ does geometrically
