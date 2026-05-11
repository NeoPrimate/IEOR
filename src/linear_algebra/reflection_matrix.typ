#import "/lib/imports.typ": *



A reflection matrix maps each point to its *mirror image* across a fixed line (in 2D), plane (in 3D), or #link(<linear-algebra-hyperplane>)[hyperplane] (in $RR^n$).

== Reflection across a line through the origin (2D)

Line making angle $theta$ with the $x$-axis:

$
  R_theta = mat(cos 2 theta, sin 2 theta; sin 2 theta, -cos 2 theta)
$

Special cases:

#table(
  columns: 2,
  align: (left, center),
  stroke: none,
  table.header([*Axis*], [*Matrix*]),
  [$x$-axis ($theta = 0$)], $mat(1, 0; 0, -1)$,
  [$y$-axis ($theta = pi/2$)], $mat(-1, 0; 0, 1)$,
  [Line $y = x$ ($theta = pi/4$)], $mat(0, 1; 1, 0)$,
  [Line $y = -x$ ($theta = -pi/4$)], $mat(0, -1; -1, 0)$,
)

== Reflection across a hyperplane (general)

For a #link(<linear-algebra-hyperplane>)[hyperplane] through the origin with unit normal $hat(n)$, the reflection is the *Householder matrix*:

$
  R = I - 2 hat(n) hat(n)^T
$

This subtracts twice the projection onto $hat(n)$ from each input.

#example[
  Reflect across the plane $z = 0$ in $RR^3$. Normal: $hat(n) = (0, 0, 1)$.

  $
    R = I - 2 vec(0, 0, 1) (0, 0, 1) = mat(1, 0, 0; 0, 1, 0; 0, 0, 1) - 2 mat(0, 0, 0; 0, 0, 0; 0, 0, 1) = mat(1, 0, 0; 0, 1, 0; 0, 0, -1)
  $

  $z$ flips sign, $x$ and $y$ preserved. ✓
]

== Properties

- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal]*: $R^T R = I$, so $R^(-1) = R^T = R$ (reflections are self-inverse — reflecting twice is the identity)
- *#link(<linear-algebra-determinant>)[Determinant]*: $det(R) = -1$ — orientation-reversing
- *Eigenvalues*: $-1$ (for the direction perpendicular to the mirror) and $+1$ with multiplicity $n - 1$ (for directions parallel to the mirror)
- *Preserves lengths and angles* (it's orthogonal)
- *Involution*: $R^2 = I$

== Rotations vs reflections

#table(
  columns: 3,
  align: (left, center, center),
  stroke: none,
  table.header([], [*#link(<linear-algebra-rotation-matrix>)[Rotation]*], [*Reflection*]),
  [$det$], $+1$, $-1$,
  [Orientation], [preserved], [reversed],
  [Self-inverse?], [no (unless $0$ or $pi$)], [yes],
  [Symmetric?], [no], [yes],
)

Composition: two reflections produce a rotation (by $2 theta$, where $theta$ is the angle between the mirrors).

== Householder transformations

Reflections of the form $R = I - 2 accent(v, arrow) accent(v, arrow)^T / (accent(v, arrow)^T accent(v, arrow))$ (Householder transformations) are the building blocks of stable numerical algorithms for:

- *#link(<linear-algebra-qr-decomposition>)[QR decomposition]* — alternative to Gram–Schmidt, much more stable
- *Tridiagonalization* of symmetric matrices (preprocessing step for eigenvalue computation)

== See also

- *#link(<linear-algebra-rotation-matrix>)[Rotation Matrix]*
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
- *#link(<linear-algebra-scaling-matrix>)[Scaling Matrix]*
- *#link(<linear-algebra-shear-matrix>)[Shear Matrix]*
- *#link(<linear-algebra-projection>)[Projection]* — related but $det = 0$ (collapses dimension)
