#import "/lib/imports.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")

Every #link(<linear-algebra-linear-transformation>)[linear transformation] $T: RR^n -> RR^m$ can be uniquely represented by an $m times n$ matrix $A$ such that:

$
  T(accent(x, arrow)) = A accent(x, arrow)
$

Conversely, every $m times n$ matrix gives a linear transformation. So *linear transformations $RR^n -> RR^m$ are the same as $m times n$ matrices*.

== How to find the matrix

Apply $T$ to each #link(<linear-algebra-vector-space>)[standard basis vector] $accent(e, arrow)_1, dots, accent(e, arrow)_n$. The results become the columns of $A$:

$
  A = mat(T(accent(e, arrow)_1), T(accent(e, arrow)_2), dots, T(accent(e, arrow)_n))
$

== Why this works (sketch)

Any input $accent(x, arrow) in RR^n$ is a #link(<linear-algebra-linear-combination>)[linear combination] of standard basis vectors:

$
  accent(x, arrow) = x_1 accent(e, arrow)_1 + x_2 accent(e, arrow)_2 + dots + x_n accent(e, arrow)_n
$

Applying $T$ and using linearity:

$
  T(accent(x, arrow)) &= T(x_1 accent(e, arrow)_1 + dots + x_n accent(e, arrow)_n) \
                      &= x_1 T(accent(e, arrow)_1) + dots + x_n T(accent(e, arrow)_n) \
                      &= mat(T(accent(e, arrow)_1), dots, T(accent(e, arrow)_n)) accent(x, arrow) \
                      &= A accent(x, arrow)
$

The columns of $A$ are *exactly* the images of the standard basis under $T$.

#example[
  $T: RR^2 -> RR^2$ rotates by 90° counterclockwise.

  $T(accent(e, arrow)_1) = T(vec(1, 0)) = vec(0, 1)$, $#h(0.5em) T(accent(e, arrow)_2) = T(vec(0, 1)) = vec(-1, 0)$.

  $
    A = mat(0, -1; 1, 0)
  $

  Verify: $A vec(2, 3) = vec(-3, 2)$ — rotating $(2, 3)$ by 90°.
]

== Identity transformation

The identity $I: RR^n -> RR^n$, $I(accent(x, arrow)) = accent(x, arrow)$, has matrix #link(<linear-algebra-identity-matrix>)[$I_n$] (the identity matrix), since $I(accent(e, arrow)_i) = accent(e, arrow)_i$ for each standard basis vector.

== See also

- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]* — definition
- *#link(<linear-algebra-matrix-vector-product>)[Matrix–Vector Product]* — the operation that makes a matrix into a transformation
- *#link(<linear-algebra-change-of-basis>)[Change of Basis]* — what happens to the matrix when you switch bases
- *#link(<linear-algebra-rotation-matrix>)[Rotation Matrix]*, *#link(<linear-algebra-reflection-matrix>)[Reflection Matrix]*, *#link(<linear-algebra-scaling-matrix>)[Scaling Matrix]*, *#link(<linear-algebra-shear-matrix>)[Shear Matrix]* — common examples
