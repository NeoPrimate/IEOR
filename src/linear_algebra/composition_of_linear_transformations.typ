#import "/lib/imports.typ": *



For two #link(<linear-algebra-linear-transformation>)[linear transformations] $S: X -> Y$ and $T: Y -> Z$, the *composition* $T compose S: X -> Z$ applies $S$ first, then $T$:

$
  (T compose S)(accent(x, arrow)) = T(S(accent(x, arrow)))
$

#align(center)[
  #frame(cetz.canvas({
    draw-blob(2, (0, 0), 1.5, stroke: purple, name: "blob1")
    draw-blob(8, (6, 0), 1.5, n-pts: 10, stroke: green, name: "blob2")
    draw-blob(8, (12, 0), 1.5, n-pts: 8, stroke: red, name: "blob3")
    cetz.draw.circle("blob1.center", radius: .05, fill: black, stroke: none, name: "x")
    cetz.draw.circle("blob2.center", radius: .05, fill: black, stroke: none, name: "y")
    cetz.draw.circle("blob3.center", radius: .05, fill: black, stroke: none, name: "z")
    cetz.draw.content("x", [$arrow(x)$], anchor: "east", padding: 3pt)
    cetz.draw.content("y", [$arrow(y)$], anchor: "north", padding: 3pt)
    cetz.draw.content("z", [$arrow(z)$], anchor: "north", padding: 3pt)
    cetz.draw.content((-1., 1.5), text(fill: purple)[$X subset.eq RR^n$])
    cetz.draw.content((7, 1.5), text(fill: green)[$Y subset.eq RR^m$])
    cetz.draw.content((12.2, 1.5), text(fill: red)[$Z subset.eq RR^l$])
    let mid = (3, .5)
    cetz.draw.bezier-through("x.north-east", mid, "y.north-west", stroke: black + .5pt, mark: (end: ">", fill: black))
    cetz.draw.content(mid, [$S$], anchor: "south", padding: 3pt)
    let mid2 = (9, .5)
    cetz.draw.bezier-through("y.north-east", mid2, "z.north-west", stroke: black + .5pt, mark: (end: ">", fill: black))
    cetz.draw.content(mid2, [$T$], anchor: "south", padding: 3pt)
    let mid3 = (6, -1.5)
    cetz.draw.bezier-through("x.south-east", mid3, "z.south-west", stroke: black + .5pt, mark: (end: ">", fill: black))
    cetz.draw.content(mid3, [$T compose S$], anchor: "north", padding: 3pt)
  }))
]

The composition of two linear transformations is itself linear:

*Additivity*:
$
  (T compose S)(accent(x, arrow) + accent(y, arrow)) = T(S(accent(x, arrow)) + S(accent(y, arrow))) = T(S(accent(x, arrow))) + T(S(accent(y, arrow))) = (T compose S)(accent(x, arrow)) + (T compose S)(accent(y, arrow))
$

*Homogeneity*: same argument with scalar pulled through.

== Composition ↔ matrix multiplication

If $S$ has matrix $A$ ($m times n$) and $T$ has matrix $B$ ($l times m$), then:

$
  (T compose S)(accent(x, arrow)) = T(A accent(x, arrow)) = B (A accent(x, arrow)) = (B A) accent(x, arrow)
$

So composition corresponds to *#link(<linear-algebra-matrix-multiplication>)[matrix multiplication]* — with the matrices in *reverse* order (the transformation applied first sits on the right):

$
  T compose S #h(0.5em) arrow.l.r #h(0.5em) B A
$

This single observation is the entire reason matrix multiplication is defined the way it is.

== Properties of composition

- *Associative*: $(R compose T) compose S = R compose (T compose S)$ — follows from matrix multiplication being associative
- *Not commutative*: in general $T compose S eq.not S compose T$ — different transformations don't commute (and matrices generally don't either)
- *Identity*: composing with $I$ (the #link(<linear-algebra-identity-matrix>)[identity transformation]) leaves any transformation unchanged
- *Inverse*: $(T compose S)^(-1) = S^(-1) compose T^(-1)$ (when defined) — peel off in reverse order

== See also

- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]*
- *#link(<linear-algebra-matrix-multiplication>)[Matrix Multiplication]*
- *#link(<linear-algebra-matrix-representation>)[Matrix Representation]* — how transformations become matrices
- *#link(<linear-algebra-matrix-inverse>)[Matrix Inverse]*
