#import "/lib/imports.typ": *



A *hyperplane* in $RR^n$ is an $(n-1)$-dimensional affine subspace — the natural generalization of a line in $RR^2$ or a #link(<linear-algebra-planes>)[plane] in $RR^3$.

Defined by a single linear equation:

$
  accent(a, arrow) dot accent(x, arrow) = b #h(2em) "or equivalently" #h(2em) a_1 x_1 + a_2 x_2 + dots + a_n x_n = b
$

where $accent(a, arrow) eq.not bold(0)$ is the *normal vector* and $b in RR$ is the *offset*.

== Dimension of a hyperplane

In $RR^n$, the equation $accent(a, arrow) dot accent(x, arrow) = b$ imposes one linear constraint. The solution set has dimension $n - 1$:

- $RR^2$: hyperplane = *line*
- $RR^3$: hyperplane = *plane*
- $RR^n$: hyperplane = $(n{-}1)$-dimensional flat

== Through the origin

If $b = 0$, the hyperplane passes through the origin and is a #link(<linear-algebra-subspace>)[linear subspace] (closed under addition and scalar multiplication). Otherwise it's an *affine* subspace — a translated subspace.

== Distance from a point to a hyperplane

Given hyperplane $accent(a, arrow) dot accent(x, arrow) = b$ and point $accent(p, arrow) in RR^n$:

$
  "dist"(accent(p, arrow), H) = (|accent(a, arrow) dot accent(p, arrow) - b|) / ||accent(a, arrow)||
$

(See #link(<linear-algebra-norm>)[Norm] for $||accent(a, arrow)||$.)

== Half-spaces

A hyperplane splits $RR^n$ into two *half-spaces*:

$
  H^+ = { accent(x, arrow) : accent(a, arrow) dot accent(x, arrow) >= b } \
  H^- = { accent(x, arrow) : accent(a, arrow) dot accent(x, arrow) <= b }
$

These are the building blocks of *polyhedra* (intersections of finitely many half-spaces).

== Where hyperplanes show up

- *Linear programming*: feasible regions are intersections of half-spaces (polyhedra)
- *Support vector machines*: the decision boundary is a hyperplane $accent(w, arrow) dot accent(x, arrow) + b = 0$
- *#link(<linear-algebra-planes>)[Planes]* in $RR^3$ — the $n=3$ case
- *Linear constraints* in optimization: each $accent(a, arrow)_i^T accent(x, arrow) <= b_i$ defines a half-space
