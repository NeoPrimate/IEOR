#import "/lib/imports.typ": *



A special case of #link(<linear-algebra-matrix-multiplication>)[matrix multiplication]: a matrix times a single column vector.

For an $m times n$ matrix $A$ and a vector $accent(x, arrow) in RR^n$, the product $A accent(x, arrow) in RR^m$ has entries:

$
  (A accent(x, arrow))_i = sum_(j=1)^n a_(i j) #h(0.2em) x_j
$

#example[
  $
    A = mat(1, 2, 3; 4, 5, 6) #h(2em) accent(x, arrow) = vec(7, 8, 9)
  $

  $
    A accent(x, arrow) = vec(
      1 dot 7 + 2 dot 8 + 3 dot 9,
      4 dot 7 + 5 dot 8 + 6 dot 9,
    ) = vec(50, 122)
  $
]

== Two equivalent views

*1. Row view (dot products)*: each entry is a #link(<linear-algebra-dot-product>)[dot product] of a row of $A$ with $accent(x, arrow)$.

*2. Column view (linear combination)*: $A accent(x, arrow)$ is a #link(<linear-algebra-linear-combination>)[linear combination] of $A$'s columns, weighted by the entries of $accent(x, arrow)$:

$
  A accent(x, arrow) = x_1 accent(a, arrow)_1 + x_2 accent(a, arrow)_2 + dots + x_n accent(a, arrow)_n
$

where $accent(a, arrow)_j$ is the $j$-th column of $A$.

This view explains why $A accent(x, arrow) = accent(b, arrow)$ has a solution iff $accent(b, arrow)$ lies in the #link(<linear-algebra-column-space>)[column space] of $A$.

== Linear transformation view

Every matrix defines a #link(<linear-algebra-linear-transformation>)[linear transformation] $T_A: RR^n -> RR^m$:

$
  T_A (accent(x, arrow)) = A accent(x, arrow)
$

Conversely, every linear transformation between finite-dimensional spaces is a matrix–vector product (after fixing bases).

== Linearity

$
  A (accent(x, arrow) + accent(y, arrow)) = A accent(x, arrow) + A accent(y, arrow)
$

$
  A (c accent(x, arrow)) = c (A accent(x, arrow))
$

$A$ applied to the zero vector returns the zero vector.
