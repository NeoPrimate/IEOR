#import "/lib/imports.typ": *

#set math.vec(delim: "[")

For a plane in $RR^3$ defined by $A x + B y + C z = D$ and a point $(x_0, y_0, z_0)$, the perpendicular distance from the point to the plane is:

$
  d = (|A x_0 + B y_0 + C z_0 - D|) / sqrt(A^2 + B^2 + C^2)
$

The denominator is the #link(<linear-algebra-norm>)[norm] of the plane's normal vector $accent(n, arrow) = (A, B, C)$.

The signed distance (drop the absolute value) tells you which side of the plane the point is on:

$
  d_("signed") = (A x_0 + B y_0 + C z_0 - D) / sqrt(A^2 + B^2 + C^2)
$

#example[
  Plane: $x - 2 y + 3 z = 5$. Point: $(2, 3, 1)$.

  $
    d & = (1 dot 2 - 2 dot 3 + 3 dot 1 - 5) / sqrt(1^2 + (-2)^2 + 3^2) \
      & = (2 - 6 + 3 - 5) / sqrt(1 + 4 + 9) \
      & = (-6) / sqrt(14) approx -1.60
  $

  The negative sign means the point lies on the opposite side of the plane from the normal direction.
]

== Generalization

The same formula generalizes to a #link(<linear-algebra-hyperplane>)[hyperplane] in $RR^n$ defined by $accent(a, arrow) dot accent(x, arrow) = b$:

$
  d = (|accent(a, arrow) dot accent(p, arrow) - b|) / ||accent(a, arrow)||
$

== Connections

- *#link(<linear-algebra-planes>)[Planes]* — definition and normal vector
- *#link(<linear-algebra-projection>)[Projection]* — same idea: project the displacement vector onto the unit normal
- *#link(<linear-algebra-hyperplane>)[Hyperplane]* — $n$-dimensional generalization
