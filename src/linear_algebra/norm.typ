#import "/lib/imports.typ": *

A scalar that measures the *length* (or *magnitude*) of a vector.

Notation: $||accent(v, arrow)||$.

== Euclidean norm ($ell_2$)

The default norm — Pythagoras applied componentwise.

For $accent(v, arrow) = vec(v_1, v_2, dots.v, v_n) in RR^n$:

$
  ||accent(v, arrow)|| = sqrt(v_1^2 + v_2^2 + dots + v_n^2)
$

#example[
  $
    accent(v, arrow) = vec(3, 4) #h(2em) ||accent(v, arrow)|| = sqrt(3^2 + 4^2) = sqrt(25) = 5
  $

  Geometrically, this is the distance from the origin to the point $(3, 4)$.
]

== From dot product

The Euclidean norm is the dot product of a vector with itself, square-rooted:

$
  ||accent(v, arrow)|| = sqrt(accent(v, arrow) dot accent(v, arrow))
$

(See #link(<linear-algebra-dot-product>)[Dot Product].)

This connection makes norms central to projections, angles between vectors, and least-squares regression.

== Properties (norm axioms)

For any vectors $accent(u, arrow), accent(v, arrow) in RR^n$ and scalar $c in RR$:

- *Non-negativity*: $||accent(v, arrow)|| >= 0$
- *Definiteness*: $||accent(v, arrow)|| = 0 quad arrow.l.r.double quad accent(v, arrow) = bold(0)$
- *Absolute homogeneity*: $||c #h(0.2em) accent(v, arrow)|| = |c| #h(0.2em) ||accent(v, arrow)||$
- *Triangle inequality*: $||accent(u, arrow) + accent(v, arrow)|| <= ||accent(u, arrow)|| + ||accent(v, arrow)||$ (see #link(<linear-algebra-triangle-inequality>)[Triangle Inequality])

Any function $RR^n -> RR$ satisfying these four axioms is a *norm*.

== Geometric interpretation

- $||accent(v, arrow)||$ = distance from the origin to the point $accent(v, arrow)$
- $||accent(u, arrow) - accent(v, arrow)||$ = distance between the two points $accent(u, arrow)$ and $accent(v, arrow)$
- The set ${ accent(x, arrow) : ||accent(x, arrow)|| = 1 }$ is the *unit sphere* (a circle in $RR^2$, sphere in $RR^3$)

== Other common norms ($ell_p$ family)

For $p >= 1$:

$
  ||accent(v, arrow)||_p = (sum_(i=1)^n |v_i|^p)^(1/p)
$

Special cases:

#table(
  columns: 3,
  align: (left, center, left),
  stroke: none,
  table.header([*Norm*], [*Formula*], [*Geometry of unit ball*]),
  [$ell_1$ (Manhattan / taxicab)], $sum_i |v_i|$, [diamond],
  [$ell_2$ (Euclidean — default)], $sqrt(sum_i v_i^2)$, [circle / sphere],
  [$ell_infinity$ (Chebyshev / max)], $max_i |v_i|$, [square / cube],
)

#example[
  $accent(v, arrow) = vec(3, -4)$:

  $
    ||accent(v, arrow)||_1 = |3| + |-4| = 7 \
    ||accent(v, arrow)||_2 = sqrt(9 + 16) = 5 \
    ||accent(v, arrow)||_oo = max(3, 4) = 4
  $
]

== Normalizing a vector

Dividing a vector by its norm gives a #link(<linear-algebra-unit-vector>)[unit vector] in the same direction:

$
  hat(v) = accent(v, arrow) / ||accent(v, arrow)||, quad ||hat(v)|| = 1
$

== Connections

- *#link(<linear-algebra-dot-product>)[Dot Product]* — $||accent(v, arrow)||^2 = accent(v, arrow) dot accent(v, arrow)$
- *#link(<linear-algebra-cauchy-schwarz-inequality>)[Cauchy–Schwarz Inequality]* — $|accent(u, arrow) dot accent(v, arrow)| <= ||accent(u, arrow)|| #h(0.2em) ||accent(v, arrow)||$
- *#link(<linear-algebra-triangle-inequality>)[Triangle Inequality]* — $||accent(u, arrow) + accent(v, arrow)|| <= ||accent(u, arrow)|| + ||accent(v, arrow)||$
- *#link(<linear-algebra-unit-vector>)[Unit Vector]* — vectors with $||accent(v, arrow)|| = 1$
- *#link(<linear-algebra-angles-between-vectors>)[Angles Between Vectors]* — $cos(theta) = (accent(u, arrow) dot accent(v, arrow)) / (||accent(u, arrow)|| #h(0.2em) ||accent(v, arrow)||)$
