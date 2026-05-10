#import "/lib/imports.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")

For #link(<linear-algebra-linear-transformation>)[linear transformations] $T, S: RR^n -> RR^m$, define the sum $T + S: RR^n -> RR^m$ pointwise:

$
  (T + S)(accent(x, arrow)) = T(accent(x, arrow)) + S(accent(x, arrow))
$

The sum is itself linear.

== Matrix correspondence

If $T$ has matrix $A$ and $S$ has matrix $B$ (so $T(accent(x, arrow)) = A accent(x, arrow)$ and $S(accent(x, arrow)) = B accent(x, arrow)$), then $T + S$ has matrix $A + B$:

Let $A = mat(accent(a, arrow)_1, accent(a, arrow)_2, dots, accent(a, arrow)_n)$ and $B = mat(accent(b, arrow)_1, accent(b, arrow)_2, dots, accent(b, arrow)_n)$ (column-wise).

$
  (T + S)(accent(x, arrow))
  &= T(accent(x, arrow)) + S(accent(x, arrow)) \
  &= A accent(x, arrow) + B accent(x, arrow) \
  &= sum_(i=1)^n x_i accent(a, arrow)_i + sum_(i=1)^n x_i accent(b, arrow)_i \
  &= sum_(i=1)^n x_i (accent(a, arrow)_i + accent(b, arrow)_i) \
  &= (A + B) accent(x, arrow)
$

So in matrix terms: *transformation addition = matrix addition*, performed entrywise.

== Connections

- *#link(<linear-algebra-transformation-scalar-multiplication>)[Scalar multiplication of transformations]* — companion operation
- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]* — the underlying object
- *#link(<linear-algebra-matrix-multiplication>)[Matrix Multiplication]* — composition is the multiplicative analog (composition ↔ product, sum ↔ sum)
