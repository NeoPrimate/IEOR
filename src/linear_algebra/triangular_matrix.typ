#import "/lib/imports.typ": *
#show: formatting


A square matrix in which all entries on one side of the main diagonal are zero.

== Upper triangular ($U$)

All entries *below* the main diagonal are zero: $U_(i j) = 0$ for $i > j$.

$
  U = mat(u_11, u_12, u_13; 0, u_22, u_23; 0, 0, u_33)
$

== Lower triangular ($L$)

All entries *above* the main diagonal are zero: $L_(i j) = 0$ for $i < j$.

$
  L = mat(l_11, 0, 0; l_21, l_22, 0; l_31, l_32, l_33)
$

== Properties (apply to both upper and lower)

- *#link(<linear-algebra-determinant>)[Determinant]*: product of diagonal entries
$
  det(L) = product_(i=1)^n l_(i i)
$
- *#link(<linear-algebra-trace>)[Trace]*: sum of diagonal entries
- *Eigenvalues*: the diagonal entries themselves
- *Sum / product / inverse* of triangular matrices is triangular (same orientation)
- *#link(<linear-algebra-transpose>)[Transpose]* flips orientation: $L^T$ is upper triangular

== Why they matter

Triangular systems are easy to solve by *back substitution* (upper) or *forward substitution* (lower):

$
  mat(2, 3, 1; 0, 1, -1; 0, 0, 4) accent(x, arrow) = vec(7, 2, 8) #h(2em)
  arrow.r.double #h(2em) x_3 = 2, x_2 = 4, x_1 = -2
$

Solve from the bottom row up — each row has one new unknown.

== Where they show up

- *#link(<linear-algebra-row-echelon-form>)[Row Echelon Form]*: upper triangular (after Gaussian elimination)
- *#link(<linear-algebra-lu-decomposition>)[LU Decomposition]*: $A = L U$ — lower × upper triangular
- *#link(<linear-algebra-cholesky-decomposition>)[Cholesky Decomposition]*: $A = L L^T$ for symmetric positive-definite $A$
- *#link(<linear-algebra-qr-decomposition>)[QR Decomposition]*: $A = Q R$ where $R$ is upper triangular
