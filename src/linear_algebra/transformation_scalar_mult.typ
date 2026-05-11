#import "/lib/imports.typ": *



For a #link(<linear-algebra-linear-transformation>)[linear transformation] $T: RR^n -> RR^m$ and a scalar $c in RR$, define the scaled transformation $c T: RR^n -> RR^m$ pointwise:

$
  (c T)(accent(x, arrow)) = c #h(0.2em) T(accent(x, arrow))
$

The scaled transformation is itself linear.

== Matrix correspondence

If $T$ has matrix $A = mat(accent(a, arrow)_1, accent(a, arrow)_2, dots, accent(a, arrow)_n)$, then $c T$ has matrix $c A$:

$
  (c T)(accent(x, arrow))
  &= c (T(accent(x, arrow))) \
  &= c (sum_(i=1)^n x_i accent(a, arrow)_i) \
  &= sum_(i=1)^n x_i (c accent(a, arrow)_i) \
  &= (c A) accent(x, arrow)
$

So *scaling a transformation = scaling its matrix entrywise*.

== Combined with sum: vector space of transformations

Together with #link(<linear-algebra-transformation-sum>)[sum], scalar multiplication makes the set of linear transformations $RR^n -> RR^m$ into a #link(<linear-algebra-vector-space>)[vector space] of dimension $m n$ — isomorphic to the space of $m times n$ matrices.

== Connections

- *#link(<linear-algebra-transformation-sum>)[Transformation Sum]* — companion operation
- *#link(<linear-algebra-vector-operations>)[Vector Operations]* — same structure (scaling distributes over sum) at the vector level
- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]* — the underlying object
