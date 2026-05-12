#import "/lib/imports.typ": *
#show: formatting



The same vector or transformation gets different #link(<linear-algebra-coordinate-vector>)[coordinate representations] depending on which #link(<linear-algebra-basis>)[basis] you use. *Change of basis* converts between two such representations.

== Change of basis matrix

Given two bases $B = {accent(b, arrow)_1, dots, accent(b, arrow)_n}$ and $B' = {accent(b, arrow)'_1, dots, accent(b, arrow)'_n}$ of the same space, the *change-of-basis matrix from $B'$ to $B$* is

$
  P_(B' -> B) = mat(
    [accent(b, arrow)'_1]_B, [accent(b, arrow)'_2]_B, dots, [accent(b, arrow)'_n]_B
  )
$

— each column is the $B'$-basis vector expressed in $B$-coordinates.

It satisfies:

$
  [accent(x, arrow)]_B = P_(B' -> B) #h(0.2em) [accent(x, arrow)]_(B')
$

The reverse direction uses the inverse:

$
  [accent(x, arrow)]_(B') = P_(B' -> B)^(-1) #h(0.2em) [accent(x, arrow)]_B
$

== Standard basis as anchor

For a basis $B = {accent(b, arrow)_1, dots, accent(b, arrow)_n}$ of $RR^n$, write the basis vectors as columns of a matrix:

$
  P = mat(accent(b, arrow)_1, accent(b, arrow)_2, dots, accent(b, arrow)_n)
$

Then $[accent(x, arrow)]_E = P #h(0.2em) [accent(x, arrow)]_B$ (standard ↔ $B$ conversion via plain matrix–vector product).

#example[
  $B = { vec(1, 1), vec(1, -1) }$ in $RR^2$, $accent(x, arrow) = vec(3, 1)$ (standard coords).

  $
    P = mat(1, 1; 1, -1) #h(2em) P^(-1) = 1/2 mat(1, 1; 1, -1)
  $

  $
    [accent(x, arrow)]_B = P^(-1) accent(x, arrow) = 1/2 mat(1, 1; 1, -1) vec(3, 1) = vec(2, 1)
  $

  → $accent(x, arrow) = 2 accent(b, arrow)_1 + 1 accent(b, arrow)_2$.
]

== Change of basis for a linear transformation

If a #link(<linear-algebra-linear-transformation>)[linear transformation] has matrix $A$ in basis $B$ and matrix $A'$ in basis $B'$, with change-of-basis matrix $P$ (mapping $B'$ coords to $B$ coords):

$
  A' = P^(-1) A P
$

This is *similarity*. Two matrices related by $A' = P^(-1) A P$ for some invertible $P$ are *similar* — they represent the same linear transformation in different bases.

Similar matrices share:
- *#link(<linear-algebra-determinant>)[Determinant]*: $det(A') = det(A)$
- *#link(<linear-algebra-trace>)[Trace]*: $"tr"(A') = "tr"(A)$
- *Eigenvalues* (with the same multiplicities)
- *#link(<linear-algebra-rank>)[Rank]*

== Why it matters

- *#link(<linear-algebra-diagonalization>)[Diagonalization]* is exactly the search for a basis $P$ in which $A' = P^(-1) A P$ is #link(<linear-algebra-diagonal-matrix>)[diagonal] — making computation trivial.
- Many problems become easier in an *eigenbasis*, *orthonormal basis*, or specially-chosen adapted basis.


== See also

- *#link(<linear-algebra-coordinate-vector>)[Coordinate Vector]*
- *#link(<linear-algebra-basis>)[Basis]*
- *#link(<linear-algebra-diagonalization>)[Diagonalization]*
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Eigenvectors & Eigenvalues]*
