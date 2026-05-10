#import "/lib/imports.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")

The *image* (or *range*) of a #link(<linear-algebra-linear-transformation>)[linear transformation] $T: RR^n -> RR^m$ is the set of all possible outputs:

$
  im(T) = T(RR^n) = { T(accent(x, arrow)) | accent(x, arrow) in RR^n }
$

This is a generalization of the #link(<linear-algebra-image-of-subset>)[image of a subset] applied to the entire domain.

== Matrix representation

If $T$ is represented by an $m times n$ matrix $A$ with columns $accent(a, arrow)_1, dots, accent(a, arrow)_n$, then for any input $accent(x, arrow) = (x_1, dots, x_n)$:

$
  T(accent(x, arrow)) = A accent(x, arrow) = x_1 accent(a, arrow)_1 + x_2 accent(a, arrow)_2 + dots + x_n accent(a, arrow)_n
$

— a #link(<linear-algebra-linear-combination>)[linear combination] of $A$'s columns.

== Image = Column space

The image of $T$ equals the #link(<linear-algebra-column-space>)[column space] of $A$:

$
  im(T) = "Col"(A) = "span"(accent(a, arrow)_1, accent(a, arrow)_2, dots, accent(a, arrow)_n)
$

#example[
  $
    A = mat(2, 1; 1, 3)
  $

  $T(vec(1, 0)) = vec(2, 1)$, $T(vec(0, 1)) = vec(1, 3)$.

  $
    im(T) = "span"(vec(2, 1), vec(1, 3)) = RR^2
  $

  (The two columns are linearly independent, so they span $RR^2$.)
]

#align(center)[
  #frame(cetz.canvas({
    draw-blob(2, (0, 0), 1.5, stroke: green, name: "blob1")
    draw-blob(8, (5, 0), 2, n-pts: 10, stroke: orange, name: "blob2")
    draw-blob(1, (5, 0), 1, n-pts: 10, stroke: blue, name: "blob3")
    cetz.draw.circle("blob1.center", radius: .05, fill: black, stroke: none, name: "x")
    cetz.draw.circle("blob3.center", radius: .05, fill: black, stroke: none, name: "y")
    cetz.draw.content("x", [$arrow(x)$], anchor: "east", padding: 3pt)
    cetz.draw.content("y", [$arrow(y)$], anchor: "west", padding: 3pt)
    cetz.draw.content((-1.2, .8), text(fill: green)[$RR^n$])
    cetz.draw.content((4.6, 2), text(fill: orange)[$RR^m$])
    cetz.draw.content((5, 0.5), text(fill: blue)[$T(RR^n)$])
    cetz.draw.content((5, -0.4), text(fill: blue)[$"im"(T)$])
    let mid = (2.5, .5)
    cetz.draw.bezier-through(
      "x.north-east", mid, "y.north-west",
      stroke: blue + .5pt, mark: (end: ">", fill: blue),
    )
    cetz.draw.content(mid, [$T$], anchor: "south", padding: 3pt)
  }))
]

== Properties

- $im(T)$ is a #link(<linear-algebra-subspace>)[subspace] of the codomain $RR^m$
- $dim(im(T)) = "rank"(A) = $ #link(<linear-algebra-rank>)[rank] of the matrix
- *#link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity]*: $dim(im(T)) + dim(ker(T)) = n$
- $T$ is *surjective* iff $im(T) = RR^m$ iff $A$ has full row rank

== Three names for the same thing

- *Image* of $T$ — emphasis on the linear-map perspective
- *Range* of $T$ — same, common in analysis
- *#link(<linear-algebra-column-space>)[Column space]* of $A$ — same, matrix-algebra perspective
