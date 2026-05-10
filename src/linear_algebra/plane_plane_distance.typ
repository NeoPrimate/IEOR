#import "/lib/imports.typ": *

Two #link(<linear-algebra-planes>)[planes] in $RR^3$ are either:
- *Identical* — distance $0$
- *Parallel* — separated by a constant perpendicular distance
- *Intersecting* — they cross along a line, distance $0$ at the intersection

== Distance between parallel planes

Two planes are parallel iff their normal vectors are parallel:

$
  P_1: A_1 x + B_1 y + C_1 z = D_1 \
  P_2: A_2 x + B_2 y + C_2 z = D_2
$

are parallel iff $(A_1, B_1, C_1) = k (A_2, B_2, C_2)$ for some $k eq.not 0$.

Rewriting both with the *same* normal vector $accent(n, arrow) = (A, B, C)$:

$
  P_1: accent(n, arrow) dot accent(x, arrow) = D_1 \
  P_2: accent(n, arrow) dot accent(x, arrow) = D_2
$

The perpendicular distance between them is:

$
  d = (|D_1 - D_2|) / sqrt(A^2 + B^2 + C^2) = (|D_1 - D_2|) / ||accent(n, arrow)||
$

#example[
  $
    P_1: x + 2 y + 2 z = 5 \
    P_2: x + 2 y + 2 z = 14
  $

  Same normal $(1, 2, 2)$, $||accent(n, arrow)|| = sqrt(1 + 4 + 4) = 3$.

  $
    d = (|5 - 14|) / 3 = 9 / 3 = 3
  $
]

== Strategy: pick a point on $P_1$, measure to $P_2$

Equivalent computation: any point $accent(x, arrow)_0$ on $P_1$ has #link(<linear-algebra-point-plane-distance>)[point–plane distance] to $P_2$ equal to the inter-plane distance.

== Non-parallel planes

If the normal vectors are not parallel, the planes intersect along a *line* in $RR^3$ — distance $0$. Any pair of non-parallel planes intersects (in 3-D).

The intersection line's direction is $accent(n, arrow)_1 times accent(n, arrow)_2$ (a vector orthogonal to both normals — see #link(<linear-algebra-cross-product>)[Cross Product]).

== Connections

- *#link(<linear-algebra-planes>)[Planes]*
- *#link(<linear-algebra-point-plane-distance>)[Point–Plane Distance]*
- *#link(<linear-algebra-cross-product>)[Cross Product]* — direction of intersection line
