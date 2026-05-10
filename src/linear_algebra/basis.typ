#import "/lib/imports.typ": *

Non-redundant set of vectors that span $RR^n$

A basis of a vector space is a set of vectors that satisfies two conditions:

1. *#link(<linear-algebra-linear-independence>)[Linear Independence]*: no vector in the set can be written as a linear combination of the others — equivalently, the only solution to
  $
    c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 + dots + c_n accent(v, arrow)_n = bold(0)
  $
  is $c_1 = c_2 = dots = c_n = 0$.

2. *#link(<linear-algebra-span>)[Spanning]*: every vector $accent(v, arrow) in V$ can be expressed as a #link(<linear-algebra-linear-combination>)[linear combination] of the basis vectors:
  $
    accent(v, arrow) = c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 + dots + c_n accent(v, arrow)_n
  $

#example[
  Consider the vector space $RR^2$ (the 2-dimensional Euclidean space). A common basis for $RR^2$ is ${e_1, e_2}$, where:

  $
    e_1 = vec(1, 0) quad quad quad e_2 = vec(0, 1)
  $

  This set is a basis because:

  - Linear Independence: The only solution to $c_1 e_1 + c_2 e_2 = bold(0)$ is $c_1 = c_2 = 0$.
  - Spanning: Any vector $accent(v, arrow) = vec(x, y) in RR^2$ can be written as $accent(v, arrow) = x e_1 + x e_2$

  This means ${e_1, e_2}$ is a basis for $RR^2$, and the dimension of $RR^2$ is 2.

]
