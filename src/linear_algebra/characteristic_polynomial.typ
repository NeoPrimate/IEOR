#import "/lib/imports.typ": *

#set math.mat(delim: "[")

For an $n times n$ matrix $A$, the *characteristic polynomial* is:

$
  p_A(lambda) = det(A - lambda I)
$

where $I$ is the $n times n$ #link(<linear-algebra-identity-matrix>)[identity matrix].

$p_A(lambda)$ is a polynomial in $lambda$ of degree $n$. Its *roots* are the #link(<linear-algebra-eigenvectors-eigenvalues>)[eigenvalues] of $A$.

== Why the roots are the eigenvalues

By definition, $lambda$ is an eigenvalue of $A$ iff there exists a non-zero $accent(v, arrow)$ with $A accent(v, arrow) = lambda accent(v, arrow)$, i.e. $(A - lambda I) accent(v, arrow) = bold(0)$. A non-trivial solution exists iff $A - lambda I$ is singular iff $det(A - lambda I) = 0$. So the eigenvalues are exactly the roots of $p_A$.

#example[
  $
    A = mat(2, 1; 0, 3)
  $

  $
    A - lambda I = mat(2 - lambda, 1; 0, 3 - lambda)
  $

  $
    p_A (lambda) = (2 - lambda)(3 - lambda) - 0 = lambda^2 - 5 lambda + 6
  $

  Roots: $lambda^2 - 5 lambda + 6 = 0 #h(0.5em) arrow.r.double #h(0.5em) lambda in {2, 3}$.

  The eigenvalues of $A$ are $2$ and $3$ (the diagonal entries — a feature of triangular matrices).
]

== Structure of the polynomial

For $A$ an $n times n$ matrix, $p_A(lambda) = (-1)^n lambda^n + dots$ with:

- *Leading coefficient*: $(-1)^n$ (the sign depends on $n$; some conventions use $lambda^n - "tr"(A) lambda^(n-1) + dots$)
- *Coefficient of $lambda^(n-1)$*: $(-1)^(n-1) "tr"(A)$ — gives the #link(<linear-algebra-trace>)[trace]
- *Constant term*: $det(A)$ (set $lambda = 0$)

For $2 times 2$ matrices:

$
  p_A(lambda) = lambda^2 - "tr"(A) lambda + det(A)
$

== Multiplicity

- *Algebraic multiplicity* of $lambda_i$: its multiplicity as a root of $p_A$.
- *Geometric multiplicity* of $lambda_i$: $dim(ker(A - lambda_i I))$ — the number of linearly independent eigenvectors for $lambda_i$.

Always: geometric multiplicity $<=$ algebraic multiplicity. Equality everywhere is required for the matrix to be #link(<linear-algebra-diagonalization>)[diagonalizable].

== Cayley–Hamilton

Every square matrix satisfies its own characteristic polynomial:

$
  p_A(A) = 0
$

(substituting the matrix $A$ for $lambda$ — and interpreting the constant term as a multiple of $I$). This lets you express $A^k$ for any $k >= n$ in terms of lower powers $I, A, A^2, dots, A^(n-1)$.

== See also

- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors & Eigenvalues]*
- *#link(<linear-algebra-determinant>)[Determinant]*
- *#link(<linear-algebra-diagonalization>)[Diagonalization]*
- *#link(<linear-algebra-trace>)[Trace]*
