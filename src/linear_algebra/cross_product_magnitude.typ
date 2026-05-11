#import "/lib/imports.typ": *



The #link(<linear-algebra-norm>)[norm] of the #link(<linear-algebra-cross-product>)[cross product] is related to the angle between the two vectors:

$
  ||accent(a, arrow) times accent(b, arrow)|| = ||accent(a, arrow)|| #h(0.2em) ||accent(b, arrow)|| #h(0.2em) sin(theta)
$

where $theta in [0, pi]$ is the angle between $accent(a, arrow)$ and $accent(b, arrow)$.

This is the *signed area of the parallelogram* spanned by the two vectors:

$
  "Area" = ||accent(a, arrow)|| #h(0.2em) ||accent(b, arrow)|| #h(0.2em) sin(theta)
$

== Geometric meaning

- $sin(theta) = 0$ when $accent(a, arrow), accent(b, arrow)$ are *parallel* (or anti-parallel) — parallelogram degenerates to a line segment, area $0$
- $sin(theta) = 1$ when $accent(a, arrow), accent(b, arrow)$ are *perpendicular* — maximum area $||accent(a, arrow)|| #h(0.2em) ||accent(b, arrow)||$

== Connection to the determinant

The magnitude is the absolute value of the $3 times 3$ #link(<linear-algebra-determinant>)[determinant] with $accent(a, arrow), accent(b, arrow)$ as two columns and any orthonormal third column — equivalently the area of the projection of the parallelogram into the plane perpendicular to that third axis.

For a triple of vectors, the *triple product* $accent(a, arrow) dot (accent(b, arrow) times accent(c, arrow))$ gives the signed volume of the parallelepiped — the $3 times 3$ determinant with those vectors as columns.

== Connections

- *#link(<linear-algebra-cross-product>)[Cross Product]* — the operation itself
- *#link(<linear-algebra-dot-vs-cross-product>)[Dot vs Cross]* — $cos$ side-by-side
- *#link(<linear-algebra-determinant>)[Determinant]* — signed parallelogram / parallelepiped volume
- *#link(<linear-algebra-angles-between-vectors>)[Angles Between Vectors]* — recovering $theta$ from the formula
