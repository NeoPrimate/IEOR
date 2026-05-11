#import "/lib/imports.typ": *



Given a #link(<linear-algebra-basis>)[basis] $B = {accent(v, arrow)_1, accent(v, arrow)_2, dots, accent(v, arrow)_n}$ of a vector space $V$, every $accent(x, arrow) in V$ has a *unique* representation as a #link(<linear-algebra-linear-combination>)[linear combination] of the basis vectors:

$
  accent(x, arrow) = c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 + dots + c_n accent(v, arrow)_n
$

The *coordinate vector* of $accent(x, arrow)$ with respect to $B$ collects those coefficients:

$
  [accent(x, arrow)]_B = vec(c_1, c_2, dots.v, c_n)
$

The bracket-subscript notation $[accent(x, arrow)]_B$ emphasizes that *the coordinates depend on the basis*.

== The standard basis is implicit

In $RR^n$, when we write $accent(x, arrow) = vec(3, -1, 5)$, we tacitly mean coordinates with respect to the *standard basis* $E = {accent(e, arrow)_1, dots, accent(e, arrow)_n}$:

$
  [accent(x, arrow)]_E = vec(3, -1, 5)
$

When you change to a different basis, the same vector gets different coordinates.

#example[
  Let $B = { vec(1, 1), vec(1, -1) }$ — a basis of $RR^2$.

  Express $accent(x, arrow) = vec(3, 1)$ in basis $B$. Solve:

  $
    c_1 vec(1, 1) + c_2 vec(1, -1) = vec(3, 1)
  $

  $
    c_1 + c_2 = 3 \
    c_1 - c_2 = 1
  $

  → $c_1 = 2$, $c_2 = 1$. So $[accent(x, arrow)]_B = vec(2, 1)$, while $[accent(x, arrow)]_E = vec(3, 1)$.
]

== Why coordinates matter

Coordinates make abstract vectors *computable*: once we fix a basis, every vector is a column of numbers and every linear transformation is a matrix.

Different bases reveal different aspects:
- *Standard basis*: most natural for $RR^n$
- *Eigenbasis*: makes the matrix of a linear transformation #link(<linear-algebra-diagonal-matrix>)[diagonal] (when one exists — see #link(<linear-algebra-diagonalization>)[Diagonalization])
- *Orthonormal basis*: distances and angles match the standard formulas
- *Adapted basis*: chosen to simplify a specific subspace structure

== Connection to change of basis

When you switch between two bases $B$ and $B'$, the coordinate vectors are related by an invertible matrix — see #link(<linear-algebra-change-of-basis>)[Change of Basis].

== See also

- *#link(<linear-algebra-basis>)[Basis]*
- *#link(<linear-algebra-change-of-basis>)[Change of Basis]*
- *#link(<linear-algebra-vector-space>)[Vector Space]*
- *#link(<linear-algebra-matrix-representation>)[Matrix Representation]* — coordinates of $T(accent(x, arrow))$ in terms of coordinates of $accent(x, arrow)$
