#import "/lib/imports.typ": *



A *shear matrix* shifts each point in one direction by an amount proportional to its coordinate in another. The result: parallelograms slide into other parallelograms, preserving area.

== 2D shears

*Horizontal shear* (each point shifts horizontally by a multiple of its $y$-coordinate):

$
  S_x (k) = mat(1, k; 0, 1)
$

$
  S_x (k) vec(x, y) = vec(x + k y, y)
$

*Vertical shear*:

$
  S_y (k) = mat(1, 0; k, 1)
$

$
  S_y (k) vec(x, y) = vec(x, y + k x)
$

#example[
  Horizontal shear with $k = 1$ applied to the unit square:

  $
    vec(0, 0) -> vec(0, 0) #h(1em) vec(1, 0) -> vec(1, 0) #h(1em) vec(1, 1) -> vec(2, 1) #h(1em) vec(0, 1) -> vec(1, 1)
  $

  Square becomes a parallelogram. Area $= 1$ — preserved.
]

== Properties

- *#link(<linear-algebra-determinant>)[Determinant]*: $det(S) = 1$ — *area / volume preserving*
- *#link(<linear-algebra-matrix-inverse>)[Inverse]*: shear by $-k$ in the same direction:
$
  S_x (k)^(-1) = S_x (-k) = mat(1, -k; 0, 1)
$
- *Eigenvalues*: $1$ (repeated) — both with the same eigenvector $vec(1, 0)$ for the horizontal shear; not #link(<linear-algebra-diagonalization>)[diagonalizable] when $k eq.not 0$
- *Fixed line*: the axis being sheared along (e.g., the $x$-axis stays put for horizontal shear)
- *Triangular*: shear matrices are #link(<linear-algebra-triangular-matrix>)[upper / lower triangular]

== Why $det = 1$

Geometrically: a parallelogram slides — its base is unchanged, and its height (perpendicular distance) is unchanged. Area $=$ base $times$ height stays the same. The same logic generalizes to $n$ dimensions.

== Composition of shears

The product of two shears (in the same direction) is another shear:

$
  S_x (k_1) S_x (k_2) = S_x (k_1 + k_2)
$

Two shears in *different* directions can produce non-shear results (composition need not be triangular).

== Application: graphics and italics

- *Italic typography*: italic letters are upright letters with a horizontal shear applied
- *Graphics transforms*: any 2D affine transformation can be decomposed into translate, rotate, scale, *shear*
- *Solving #link(<linear-algebra-linear-equations>)[linear systems]*: row operations are shears applied to the matrix — that's why row reduction preserves the row-space dimensions but reshapes the picture

== Shears in higher dimensions

A general shear in $RR^n$ adds a multiple of one coordinate to another. The matrix is the identity with a single off-diagonal non-zero entry:

$
  I + k #h(0.2em) e_i e_j^T, #h(1em) i eq.not j
$

== See also

- *#link(<linear-algebra-rotation-matrix>)[Rotation Matrix]*
- *#link(<linear-algebra-reflection-matrix>)[Reflection Matrix]*
- *#link(<linear-algebra-scaling-matrix>)[Scaling Matrix]*
- *#link(<linear-algebra-triangular-matrix>)[Triangular Matrix]*
- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]*
