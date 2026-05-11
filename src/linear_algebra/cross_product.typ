#import "/lib/imports.typ": *



Only defined in $RR^3$. Returns a vector orthogonal to the two inputs.

$
  accent(a, arrow) = vec(a_1, a_2, a_3) quad quad accent(b, arrow) = vec(b_1, b_2, b_3)
$

$
  accent(c, arrow) = accent(a, arrow) times accent(b, arrow) = vec(
    a_2 b_3 - a_3 b_2,
    a_3 b_1 - a_1 b_3,
    a_1 b_2 - a_2 b_1,
  )
$

#example[
  $
    accent(a, arrow) = vec(1, -7, 1) quad accent(b, arrow) = vec(5, 2, 4)
  $

  $
    accent(c, arrow) = accent(a, arrow) times accent(b, arrow) = vec(
      -7 dot 4 - 1 dot 2,
      1 dot 5 - 1 dot 4,
      1 dot 2 - (-7) dot 5,
    ) = vec(-30, 1, 37)
  $
]

== Proof: $accent(c, arrow)$ is orthogonal to both $accent(a, arrow)$ and $accent(b, arrow)$

Two vectors are #link(<linear-algebra-orthogonality>)[orthogonal] when their #link(<linear-algebra-dot-product>)[dot product] is zero.

*Orthogonal to $accent(a, arrow)$*:

$
  accent(c, arrow) dot accent(a, arrow) = vec(
    a_2 b_3 - a_3 b_2,
    a_3 b_1 - a_1 b_3,
    a_1 b_2 - a_2 b_1,
  ) dot vec(a_1, a_2, a_3)
$

$
  = a_1 a_2 b_3 - a_1 a_3 b_2 + a_2 a_3 b_1 - a_2 a_1 b_3 + a_3 a_1 b_2 - a_3 a_2 b_1
$

$
  = cancel(a_1 a_2 b_3, stroke: #(paint: red)) cancel(- a_1 a_3 b_2, stroke: #(paint: blue)) + cancel(a_2 a_3 b_1, stroke: #(paint: green)) cancel(- a_2 a_1 b_3, stroke: #(paint: red)) + cancel(a_3 a_1 b_2, stroke: #(paint: blue)) cancel(- a_3 a_2 b_1, stroke: #(paint: green)) = 0
$

*Orthogonal to $accent(b, arrow)$*: same argument with the roles of $accent(a, arrow), accent(b, arrow)$ swapped.

$
  accent(c, arrow) dot accent(b, arrow) = b_1 a_2 b_3 - b_1 a_3 b_2 + b_2 a_3 b_1 - b_2 a_1 b_3 + b_3 a_1 b_2 - b_3 a_2 b_1
$

$
  = cancel(b_1 a_2 b_3, stroke: #(paint: red)) cancel(- b_1 a_3 b_2, stroke: #(paint: green)) + cancel(b_2 a_3 b_1, stroke: #(paint: green)) cancel(- b_2 a_1 b_3, stroke: #(paint: blue)) + cancel(b_3 a_1 b_2, stroke: #(paint: blue)) cancel(- b_3 a_2 b_1, stroke: #(paint: red)) = 0
$

== See also

- *#link(<linear-algebra-cross-product-magnitude>)[Cross Product Magnitude]* — $||accent(a, arrow) times accent(b, arrow)|| = ||accent(a, arrow)|| ||accent(b, arrow)|| sin theta$
- *#link(<linear-algebra-dot-vs-cross-product>)[Dot vs Cross]* — side-by-side comparison
