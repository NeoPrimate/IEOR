#import "/lib/imports.typ": *
#show: formatting



A function $T: RR^n -> RR^m$ between vector spaces is a *linear transformation* if it preserves vector addition and scalar multiplication.

== The two axioms

For any vectors $accent(a, arrow), accent(b, arrow) in RR^n$ and scalar $c in RR$:

*1. Additivity*

$
  T(accent(a, arrow) + accent(b, arrow)) = T(accent(a, arrow)) + T(accent(b, arrow))
$

*2. Homogeneity (scalar multiplication)*

$
  T(c #h(0.2em) accent(a, arrow)) = c #h(0.2em) T(accent(a, arrow))
$

The two combine into a single condition: $T(c #h(0.2em) accent(a, arrow) + d #h(0.2em) accent(b, arrow)) = c #h(0.2em) T(accent(a, arrow)) + d #h(0.2em) T(accent(b, arrow))$ for all scalars and vectors.

#example[
  $T: RR^2 -> RR^2$ defined by $T(vec(x, y)) = vec(2 x, 3 y)$ is linear.

  *Check additivity*: $accent(a, arrow) = vec(1, 2)$, $accent(b, arrow) = vec(3, 1)$:

  $
    T(accent(a, arrow)) + T(accent(b, arrow)) = vec(2, 6) + vec(6, 3) = vec(8, 9) \
    T(accent(a, arrow) + accent(b, arrow)) = T(vec(4, 3)) = vec(8, 9) #h(0.5em) checkmark
  $

  *Check homogeneity*: $c = 3$, $accent(a, arrow) = vec(1, 2)$:

  $
    c #h(0.2em) T(accent(a, arrow)) = 3 #h(0.2em) vec(2, 6) = vec(6, 18) \
    T(c #h(0.2em) accent(a, arrow)) = T(vec(3, 6)) = vec(6, 18) #h(0.5em) checkmark
  $
]

== Consequences

Linearity forces $T$ to be very rigid. From the two axioms:

- $T(bold(0)) = bold(0)$ (apply homogeneity with $c = 0$)
- $T(- accent(a, arrow)) = -T(accent(a, arrow))$
- $T$ maps lines through the origin to lines through the origin (or to the origin itself)
- $T$ maps the origin to the origin
- $T$ maps parallelograms to parallelograms (or degenerate shapes)

== Equivalent definition: matrix–vector product

Every linear transformation can be written as $T(accent(x, arrow)) = A accent(x, arrow)$ for some matrix $A$ — see #link(<linear-algebra-matrix-representation>)[Matrix Representation]. This means *linear transformation $RR^n -> RR^m$ ⇔ $m times n$ matrix*.

== Non-examples

- $T(x) = x + 1$: not linear (translates the origin off itself)
- $T(vec(x, y)) = vec(x^2, y)$: not linear (squaring isn't homogeneous)
- $T(vec(x, y)) = vec(x y, 0)$: not linear (product of components)

== See also

- *#link(<linear-algebra-matrix-vector-product>)[Matrix–Vector Product]* — every matrix is a linear transformation
- *#link(<linear-algebra-matrix-representation>)[Matrix Representation]* — every linear transformation is a matrix
- *#link(<linear-algebra-image>)[Image]* / *#link(<linear-algebra-kernel>)[Kernel]* — output range / null space
- *#link(<linear-algebra-composition-of-linear-transformations>)[Composition]* — composing linear transformations
- *#link(<linear-algebra-rotation-matrix>)[Rotation]*, *#link(<linear-algebra-reflection-matrix>)[Reflection]*, *#link(<linear-algebra-scaling-matrix>)[Scaling]*, *#link(<linear-algebra-shear-matrix>)[Shear]*
