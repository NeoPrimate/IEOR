#import "/lib/imports.typ": *
#show: formatting


The *identity matrix* $I_n$ is the $n times n$ #link(<linear-algebra-diagonal-matrix>)[diagonal matrix] with $1$ on every diagonal entry and $0$ elsewhere.

$
  I_2 = mat(1, 0; 0, 1) #h(2em)
  I_3 = mat(1, 0, 0; 0, 1, 0; 0, 0, 1) #h(2em)
  I_n = mat(1, 0, dots, 0; 0, 1, dots, 0; dots.v, dots.v, dots.down, dots.v; 0, 0, dots, 1)
$

In index notation: $(I_n)_(i j) = delta_(i j)$ (the *Kronecker delta*).

== Why it's "the identity"

It's the *multiplicative identity* for #link(<linear-algebra-matrix-multiplication>)[matrix multiplication]:

$
  I_n A = A I_n = A
$

(provided shapes are compatible).

Equivalently, the identity #link(<linear-algebra-linear-transformation>)[linear transformation] $I: RR^n -> RR^n$, $accent(x, arrow) arrow.bar accent(x, arrow)$, has matrix $I_n$.

== Key properties

- *#link(<linear-algebra-determinant>)[Determinant]*: $det(I_n) = 1$
- *#link(<linear-algebra-trace>)[Trace]*: $"tr"(I_n) = n$
- *#link(<linear-algebra-rank>)[Rank]*: $"rank"(I_n) = n$ (full)
- *#link(<linear-algebra-matrix-inverse>)[Inverse]*: $I_n^(-1) = I_n$
- *#link(<linear-algebra-transpose>)[Transpose]*: $I_n^T = I_n$
- *Eigenvalues*: $1$ with multiplicity $n$
- *Powers*: $I_n^k = I_n$ for all $k$

== Where it shows up

- Defining the #link(<linear-algebra-matrix-inverse>)[matrix inverse]: $A A^(-1) = A^(-1) A = I$
- Eigenvalue equation: $det(A - lambda I) = 0$ (#link(<linear-algebra-eigenvectors-eigenvalues>)[eigenvalues])
- Block-matrix algebra
- Characterization of #link(<linear-algebra-orthogonal-matrix>)[orthogonal matrices]: $Q^T Q = I$
