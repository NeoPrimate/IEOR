#import "../utils/examples.typ": eg

#import "@preview/cetz:0.3.4"

#set math.vec(delim: "[")

=== Cross Product

Only defined in $RR^3$

Returns a vector orthogonal to the two vectors

$
accent(a, arrow) = vec(a_1, a_2, a_3) quad quad accent(b, arrow) = vec(b_1, b_2, b_3)
$

$
accent(c, arrow) = accent(a, arrow) times accent(b, arrow)
$

$
accent(c, arrow) = vec(
  a_2 b_3 - a_3 b_2,
  a_3 b_1 - a_1 b_3,
  a_1 b_2 - a_2 b_1,
)
$



#eg[
  $
  accent(a, arrow) = vec(1, -7, 1) quad quad accent(b, arrow) = vec(5, 2, 4)
  $

  $
  accent(c, arrow) = accent(a, arrow) times accent(b, arrow)
  $

  $
  accent(c, arrow) = vec(
    -7 dot 4 - 1 dot 2,
    1 dot 5 - 1 dot 4,
    1 dot 2 - (-7) dot 5,
  ) = vec(-30, 1, 37)
  $

  $accent(c, arrow)$ is orthogonal to both $accent(a, arrow)$ and $accent(b, arrow)$
]

Proof: $accent(c, arrow)$ is orthogonal to $accent(a, arrow)$ and $accent(b, arrow)$

When the dot product of two vectors is equal to 0, it means that the two vectors are perpendicular (or orthogonal) to each other

1. Orthogonal to Vector $accent(a, arrow)$

$
accent(c, arrow) = vec(
  a_2 b_3 - a_3 b_2,
  a_3 b_1 - a_1 b_3,
  a_1 b_2 - a_2 b_1,
) dot vec(a_1, a_2, a_3)
$

$
a_1 a_2 b_3 - a_1 a_3 b_2 + a_2 a_3 b_1 - a_2 a_1 b_3 + a_3 a_1 b_2 - a_3 a_2 b_1
$

$
cancel(a_1 a_2 b_3, stroke: #(paint: red,)) cancel(- a_1 a_3 b_2, stroke: #(paint: blue,)) + cancel(a_2 a_3 b_1, stroke: #(paint: green,)) cancel(- a_2 a_1 b_3, stroke: #(paint: red,)) + cancel(a_3 a_1 b_2, stroke: #(paint: blue,)) cancel(- a_3 a_2 b_1, stroke: #(paint: green,)) = 0
$

2. Orthogonal to Vector $accent(b, arrow)$

$
accent(c, arrow) = vec(
  a_2 b_3 - a_3 b_2,
  a_3 b_1 - a_1 b_3,
  a_1 b_2 - a_2 b_1,
) dot vec(b_1, b_2, b_3)
$

$
b_1 a_2 b_3 - b_1 a_3 b_2 + b_2 a_3 b_1 - b_2 a_1 b_3 + b_3 a_1 b_2 - b_3 a_2 b_1
$

$
cancel(b_1 a_2 b_3, stroke: #(paint: red,)) cancel(- b_1 a_3 b_2, stroke: #(paint: green,)) + cancel(b_2 a_3 b_1, stroke: #(paint: green,)) cancel(- b_2 a_1 b_3, stroke: #(paint: blue,)) + cancel(b_3 a_1 b_2, stroke: #(paint: blue,)) cancel(- b_3 a_2 b_1, stroke: #(paint: red,)) = 0
$

=== Proof: Relationship Between Cross Product and Sin of Angle

$
accent(a, arrow) = vec(a_1, a_2, a_3) quad quad accent(b, arrow) = vec(b_1, b_2, b_3)
$

$
accent(c, arrow) = accent(a, arrow) times accent(b, arrow)
$

$
accent(c, arrow) = vec(a_1, a_2, a_3) times vec(b_1, b_2, b_3) = vec(
  a_2 b_3 - a_3 b_2,
  a_3 b_1 - a_1 b_3,
  a_1 b_2 - a_2 b_1,
)
$

$
accent(a, arrow) dot accent(b, arrow) = ||accent(a, arrow)|| ||accent(b, arrow)|| cos(Theta)
$

$
||accent(a, arrow) times accent(b, arrow)|| = ||accent(a, arrow)|| ||accent(b, arrow)|| sin(Theta)
$

=== Dot and Cross Products

$
accent(a, arrow) dot accent(b, arrow) = ||accent(a, arrow)|| ||accent(b, arrow)|| cos(Theta) \ 
(accent(a, arrow) dot accent(b, arrow)) / (||accent(a, arrow)|| ||accent(b, arrow)||) = cos(Theta) \
Theta = arccos() \
$








