#import "/lib/imports.typ": *

#set math.vec(delim: "[")

The #link(<linear-algebra-dot-product>)[dot product] and #link(<linear-algebra-cross-product>)[cross product] are the two fundamental products of vectors. They give complementary geometric information.

== Side-by-side

#table(
  columns: (auto, 1fr, 1fr),
  align: (left, left, left),
  stroke: none,
  table.header([], [*Dot product* $accent(a, arrow) dot accent(b, arrow)$], [*Cross product* $accent(a, arrow) times accent(b, arrow)$]),
  [Result type], [scalar], [vector (in $RR^3$ only)],
  [Formula], $accent(a, arrow) dot accent(b, arrow) = sum a_i b_i$, $vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1)$,
  [Geometric formula], $|accent(a, arrow)| |accent(b, arrow)| cos theta$, $|accent(a, arrow)| |accent(b, arrow)| sin theta #h(0.5em) hat(n)$,
  [Geometric meaning], [length of projection of $accent(a, arrow)$ onto $accent(b, arrow)$, scaled by $|accent(b, arrow)|$], [vector perpendicular to both, magnitude = parallelogram area],
  [Zero when], [vectors are perpendicular], [vectors are parallel],
  [Maximum when], [vectors are parallel], [vectors are perpendicular],
  [Commutative?], [yes: $a dot b = b dot a$], [no: $a times b = -(b times a)$],
)

== Recovering the angle

Combining the two formulas:

$
  cos theta = (accent(a, arrow) dot accent(b, arrow)) / (||accent(a, arrow)|| ||accent(b, arrow)||) #h(2em) sin theta = (||accent(a, arrow) times accent(b, arrow)||) / (||accent(a, arrow)|| ||accent(b, arrow)||)
$

$
  theta = arctan(||accent(a, arrow) times accent(b, arrow)|| / (accent(a, arrow) dot accent(b, arrow)))
$

(This `atan2`-style form is numerically more stable than $arccos$ alone, especially near $theta = 0$ or $pi$.)

== Pythagorean identity

$
  ||accent(a, arrow) times accent(b, arrow)||^2 + (accent(a, arrow) dot accent(b, arrow))^2 = ||accent(a, arrow)||^2 #h(0.2em) ||accent(b, arrow)||^2
$

(Direct from $sin^2 + cos^2 = 1$.)

== Connections

- *#link(<linear-algebra-dot-product>)[Dot Product]*
- *#link(<linear-algebra-cross-product>)[Cross Product]* + *#link(<linear-algebra-cross-product-magnitude>)[Cross Product Magnitude]*
- *#link(<linear-algebra-angles-between-vectors>)[Angles Between Vectors]*
