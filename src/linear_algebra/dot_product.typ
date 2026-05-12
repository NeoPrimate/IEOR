#import "/lib/imports.typ": *
#show: formatting



The *dot product* (or *scalar product*) of two vectors of the same dimension returns a scalar — the sum of componentwise products.

$
  accent(a, arrow) dot accent(b, arrow) = vec(a_1, a_2, dots.v, a_n) dot vec(b_1, b_2, dots.v, b_n) = a_1 b_1 + a_2 b_2 + dots + a_n b_n = sum_(i=1)^n a_i b_i
$

#example[
  $accent(a, arrow) = vec(2, -1, 3)$, $accent(b, arrow) = vec(4, 5, -2)$:

  $
    accent(a, arrow) dot accent(b, arrow) = 2 dot 4 + (-1) dot 5 + 3 dot (-2) = 8 - 5 - 6 = -3
  $
]

== Geometric formula

$
  accent(a, arrow) dot accent(b, arrow) = ||accent(a, arrow)|| #h(0.2em) ||accent(b, arrow)|| #h(0.2em) cos theta
$

where $theta$ is the angle between $accent(a, arrow)$ and $accent(b, arrow)$ — and $||dot||$ is the #link(<linear-algebra-norm>)[norm].

This links the algebraic dot product to geometric intuition: the dot product measures how much the vectors point in the same direction.

== Connection to norm

The square of the norm is the dot product of a vector with itself:

$
  ||accent(a, arrow)||^2 = accent(a, arrow) dot accent(a, arrow)
$

See #link(<linear-algebra-norm>)[Norm] for the full story.

== Properties

*Commutative*:
$
  accent(v, arrow) dot accent(w, arrow) = accent(w, arrow) dot accent(v, arrow)
$

*Distributive over vector addition*:
$
  (accent(v, arrow) + accent(w, arrow)) dot accent(x, arrow) = accent(v, arrow) dot accent(x, arrow) + accent(w, arrow) dot accent(x, arrow)
$

*Compatible with scalar multiplication*:
$
  (c accent(v, arrow)) dot accent(w, arrow) = c (accent(v, arrow) dot accent(w, arrow))
$

*Bilinear*: linear in each argument separately (the three properties above combined).

== Matrix form

For column vectors, the dot product is just matrix multiplication of $accent(a, arrow)^T$ with $accent(b, arrow)$:

$
  accent(a, arrow) dot accent(b, arrow) = accent(a, arrow)^T accent(b, arrow)
$

(See #link(<linear-algebra-transpose>)[Transpose].)

== See also

- *#link(<linear-algebra-norm>)[Norm]* — $||accent(v, arrow)|| = sqrt(accent(v, arrow) dot accent(v, arrow))$
- *#link(<linear-algebra-angles-between-vectors>)[Angles Between Vectors]* — $cos theta = (accent(a, arrow) dot accent(b, arrow)) / (||accent(a, arrow)|| ||accent(b, arrow)||)$
- *#link(<linear-algebra-cauchy-schwarz-inequality>)[Cauchy–Schwarz Inequality]*
- *#link(<linear-algebra-triangle-inequality>)[Triangle Inequality]*
- *#link(<linear-algebra-orthogonality>)[Orthogonality]* — $accent(a, arrow) perp accent(b, arrow) arrow.l.r.double accent(a, arrow) dot accent(b, arrow) = 0$
- *#link(<linear-algebra-cross-product>)[Cross Product]* + *#link(<linear-algebra-dot-vs-cross-product>)[Dot vs Cross]*
- *#link(<linear-algebra-inner-product>)[Inner Product]* — generalization
