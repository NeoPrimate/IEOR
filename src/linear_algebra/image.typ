#import "../../../utils/examples.typ": eg
#import "../../../utils/result.typ": result
#import "../../../utils/matvec_mult.typ": matvec_mult
#import "../../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"
#import "@preview/numty:0.0.4" as nt

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Image of a subset under transformation

#let x0 = (-2, -2)
#let x1 = (-2, 2)
#let x2 = (2, -2)

$
  accent(x, arrow)_0 = nt.print(x0) quad quad accent(x, arrow)_1 = nt.print(x1) quad quad accent(x, arrow)_2 = nt.print(x2)
$

$
  L_0 = {accent(x, arrow)_0 + t (accent(x, arrow)_1 - accent(x, arrow)_0) | 0 lt.eq t lt.eq 1} \ 

  L_1 = {accent(x, arrow)_1 + t (accent(x, arrow)_2 - accent(x, arrow)_1) | 0 lt.eq t lt.eq 1} \ 

  L_2 = {accent(x, arrow)_2 + t (accent(x, arrow)_0 - accent(x, arrow)_2) | 0 lt.eq t lt.eq 1} \ 
$

The triangle $T$ can be defines as the set of these points:

$
  S = {L_0, L_1, L_2}
$

Let's define a transformation

$
  T: RR^2 arrow RR^2
$

#let A = (
  (1, -1),
  (2, 0),
)

#let transformation(x) = {
  matvec_mult(A, x)
}

#let Tx0 = transformation(x0)
#let Tx1 = transformation(x1)
#let Tx2 = transformation(x2)

$
  T(accent(x, arrow)) = #nt.print(A) vec(x_1, x_2)
$

$
  T(L_0) 
  &= {T(accent(x, arrow)_0 + t (accent(x, arrow)_1 - accent(x, arrow)_0)) | 0 lt.eq t lt.eq 1} \
  &= {T(accent(x, arrow)_0) + T(t (accent(x, arrow)_1 - accent(x, arrow)_0)) | 0 lt.eq t lt.eq 1} \
  &= {T(accent(x, arrow)_0) + t T(accent(x, arrow)_1 - accent(x, arrow)_0) | 0 lt.eq t lt.eq 1} \
  &= {T(accent(x, arrow)_0) + t T(accent(x, arrow)_1) - T(accent(x, arrow)_0) | 0 lt.eq t lt.eq 1} \
$

$
  T(accent(x, arrow)_0) = #nt.print(A) nt.print(x0) = nt.print(Tx0) \ 
  T(accent(x, arrow)_1) = #nt.print(A) nt.print(x1) = nt.print(Tx1) \
  T(accent(x, arrow)_2) = #nt.print(A) nt.print(x2) = nt.print(Tx2) \
$

#let triangle = cetz.canvas(length: 6cm, {
    cetz-plot.plot.plot(
      x-tick-step: 5,
      y-tick-step: 5,
      x-minor-tick-step: 1,
      y-minor-tick-step: 1,
      x-min: -5,
      y-min: -5,
      x-max: 5,
      y-max: 5,
      axis-style: "school-book",
      x-label: $x$,
      y-label: $y$,
      x-grid: "both",
      y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", (0,0))
        cetz-plot.plot.add-anchor("x0", x0)
        cetz-plot.plot.add-anchor("x1", x1)
        cetz-plot.plot.add-anchor("x2", x2)
      }, 
      name: "plot"
    )

    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

    cetz.draw.line("plot.o", "plot.x0", stroke: green, mark: (fill: green), name: "x0")
    cetz.draw.content("x0.end", text(green)[$accent(x, arrow)_0$], anchor: "north", padding: 0.05, angle: "x0.end")

    cetz.draw.line("plot.o", "plot.x1", stroke: blue, mark: (fill: blue), name: "x1")
    cetz.draw.content("x1.end", text(blue)[$accent(x, arrow)_1$], anchor: "south", padding: 0.05, angle: "x1.end")
    
    cetz.draw.line("plot.o", "plot.x2", stroke: red, mark: (fill: red), name: "x2")
    cetz.draw.content("x2.end", text(red)[$accent(x, arrow)_2$], anchor: "north", padding: 0.05, angle: "x2.end")
    
    cetz.draw.line("plot.x0", "plot.x1", stroke: purple, mark: none, name: "x1-x0")
    cetz.draw.content("x1-x0.mid", text(purple)[$L_0$], anchor: "south-east", padding: 0.05, angle: 0deg, size: 3pt)
    
    cetz.draw.line("plot.x2", "plot.x1", stroke: purple, mark: none, name: "x2-x1")
    cetz.draw.content("x2-x1.mid", text(purple)[$L_1$], anchor: "south-west", padding: 0.05, angle: 0deg, size: 3pt)
    
    cetz.draw.line("plot.x2", "plot.x0", stroke: purple, mark: none, name: "x2-x0")
    cetz.draw.content("x2-x0.mid", text(purple)[$L_2$], anchor: "north", padding: 0.05, angle: 0deg, size: 3pt)
  })

#let tranformation = cetz.canvas(length: 6cm, {
    cetz-plot.plot.plot(
      x-tick-step: 5,
      y-tick-step: 5,
      x-minor-tick-step: 1,
      y-minor-tick-step: 1,
      x-min: -5,
      y-min: -5,
      x-max: 5,
      y-max: 5,
      axis-style: "school-book",
      x-label: $x$,
      y-label: $y$,
      x-grid: "both",
      y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", (0,0))
        cetz-plot.plot.add-anchor("x0", Tx0)
        cetz-plot.plot.add-anchor("x1", Tx1)
        cetz-plot.plot.add-anchor("x2", Tx2)
      }, 
      name: "plot"
    )

    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

    cetz.draw.line("plot.o", "plot.x0", stroke: green, mark: (fill: green), name: "x0")
    cetz.draw.content("x0.end", text(green)[$T(accent(x, arrow)_0)$], anchor: "north-west", padding: 0.05, angle: "x0.end")

    cetz.draw.line("plot.o", "plot.x1", stroke: blue, mark: (fill: blue), name: "x1")
    cetz.draw.content("x1.end", text(blue)[$T(accent(x, arrow)_1)$], anchor: "north", padding: 0.05, angle: "x1.end")
    
    cetz.draw.line("plot.o", "plot.x2", stroke: red, mark: (fill: red), name: "x2")
    cetz.draw.content("x2.end", text(red)[$T(accent(x, arrow)_2)$], anchor: "south", padding: 0.05, angle: "x2.end")
    
    cetz.draw.line("plot.x0", "plot.x1", stroke: purple, mark: none, name: "x1-x0")
    cetz.draw.content("x1-x0.mid", text(purple)[$T(L_0)$], anchor: "north", padding: 0.05, angle: 0deg, size: 3pt)
    
    cetz.draw.line("plot.x2", "plot.x1", stroke: purple, mark: none, name: "x2-x1")
    cetz.draw.content("x2-x1.mid", text(purple)[$T(L_1)$], anchor: "south-east", padding: 0.05, angle: 0deg, size: 3pt)
    
    cetz.draw.line("plot.x2", "plot.x0", stroke: purple, mark: none, name: "x2-x0")
    cetz.draw.content("x2-x0.mid", text(purple)[$T(L_2)$], anchor: "north-west", padding: 0.05, angle: 0deg, size: 3pt)
  })

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    rows: (auto, auto),
    gutter: 3pt,
    triangle,
    tranformation,
  )
]

$T(L_0)$ is the image of $L_0$ under $T$

$T(S)$ is the image of $S$ under $T$

== Image of a transformation

The *image* of a transformation $T$ is defined as:

$
  im(T) = { T(accent(x, arrow)) | accent(x, arrow) in RR^n }
$

or, equivalently,

$
  T(RR^n)
$

$T(RR^n)$ is the image of $RR^2$ under $T$

This is the set of all possible outputs when $T$ is applied to vectors in $RR^n$

*Undertanding $T(RR^n)$*

1. Whole space transformation

  The image of $RR^n$ under $T$ is the complete set of transformed vectors, often denoted as $im(T)$

2. Subset Transformation

  For any subset $V subset.eq RR^n$, the image of $V$ under $T$ is the set of transformed vectors from $V$

*Matrix representation of $T$*

If $T$ is represented by a $m times n$ matrix $A$, then:

$
  T(accent(x, arrow)) = {A accent(x, arrow) | accent(x, arrow) in RR^n}
$

where:
- $A$ is the matrix associated with $T$
- $accent(x, arrow) in RR^n$ represents a vector in the input space

*Transformation in therms of columns of $A$*

If 
$A = mat(
    ;
    accent(a, arrow)_1, accent(a, arrow)_2, dots, accent(a, arrow)_n;
    ;
  )
$, then for $accent(x, arrow) = vec(x_1, x_2, dots.v, x_n)$:

$
  A accent(x, arrow) = x_1 accent(a, arrow)_1 + x_2 accent(a, arrow)_2 + dots + x_n accent(a, arrow)_n
$

*Column Space of $A$*

The image of $T$ (or $im(T)$) is the column space of $A$:

$
  C(A) = "span"(accent(a, arrow)_1, accent(a, arrow)_2, dots, accent(a, arrow)_n)
$

This is the set of all possible linear combinations of the columns of $A$, and thus represents all possible outputs of the transformation $T$

#align(center)[
  #cetz.canvas({
    draw-blob(
      2, (0, 0), 1.5,
      stroke: green,
      name: "blob1"
    )
    draw-blob(
      8, (5, 0), 2,
      n-pts: 10,
      stroke: orange,
      name: "blob2"
    )
    
    draw-blob(
      1, (5, 0), 1,
      n-pts: 10,
      stroke: blue,
      name: "blob2"
    )
    cetz.draw.circle(
      "blob1.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "x"
    )
    cetz.draw.circle(
      "blob2.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "y"
    )
    cetz.draw.content(
      "x", [$arrow(x)$],
      anchor: "east",
      padding: 3pt
    )
    cetz.draw.content(
      "y", [$arrow(y)$],
      anchor: "west",
      padding: 3pt
    )
    cetz.draw.content(
      (-1.2, .8), text(fill: green)[$RR^n$]
    )
    cetz.draw.content(
      (4.6, 2), text(fill: orange)[$RR^m$]
    )
    cetz.draw.content(
      (5, 0.5), text(fill: blue)[$T(RR^n)$]
    )
    cetz.draw.content(
      (5, -0.4), text(fill: blue)[$"im"(T)$]
    )
    let mid = (2.5, .5)
    cetz.draw.bezier-through(
      "x.north-east", mid, "y.north-west",
      stroke: blue + .5pt,
      mark: (end: ">", fill: blue),
      name: "arrow"
    )
    cetz.draw.content(
      mid, [$f$],
      anchor: "south",
      padding: 3pt
    )
    cetz.draw.content(
      (2.5, -1), text(fill: black)[$f: RR^n -> RR^m$]
    )
  })
]

#eg[
  Supose we have a matrix $A$:

  $
    A = mat(
      2, 1;
      1, 3;
    )
  $

  Matrix $A$ defines the transformation $T: RR^2 arrow RR^2$ such that for any vector $accent(x, arrow) = vec(x_1, x_2) in RR^2$, the image under $T$ is:

  $
    T(accent(x, arrow)) = A accent(x, arrow) = mat(
      2, 1;
      1, 3;
    ) vec(x_1, x_2)
  $

  *Calculating Transformation*

  To see what $T$ does to vectors in $RR^2$, let's compute a few specific examples:

  1. for $accent(x, arrow) = vec(1, 0)$
  
  $
    T(vec(1, 0)) = A vec(1, 0) = vec(2, 1)
  $

  2. for $accent(x, arrow) = vec(0, 1)$
  
  $
    T(vec(0, 1)) = A vec(0, 1) = vec(1, 3)
  $

  *Image of $T$*

  The image of $T$, $im(T)$, is the set of all linear combinations of the vectors $vec(2, 1)$ and $vec(1, 3)$:

  $
    im(T) = "span"(vec(2, 1), vec(1, 3))
  $

  Thus, any vector in the image of $T$ can be written as:

  $
    y = x_1 vec(2, 1) + x_2 vec(1, 3) = vec(2 x_1 + x_2, x_1 + 3 x_2)
  $

  where $x_1, x_2 in RR$.

  *Column space interpretation*

  The image of $T$ is all the vectors in $RR^2$ that can be formed as linear combinations of $vec(2, 1)$ and $vec(1, 3)$.
]

== Preimage of a set

The preimage of a set $S$ under a function $T$, denoted $T^(-1) (S)$, is the set of all elements in the domain of $T$ the domain of $T$ that map to elements in $S$ under the transformation $T$.

If $T: RR^n arrow RR^m$ is a function from a set $RR^n$ to a set $RR^m$, and $S subset.eq RR^m$ is a subset of a target space, the the preimage of $S$ under $T$ is:

$
  T(-1) (S) = {accent(x, arrow) in RR^n | T(accent(x, arrow)) in S}
$

This means that $T(-1) (S)$ consists of all elements in $RR^n$ that, when transformed by $T$, end up in $S$.

For any subset $S subset.eq RR^m$, the preimage $T^(-1) (S)$ collects all points in the domain that end up in $S$ after applying $T$. If $S$ is a single point, the preimage will be the set of all points in the domain that map to that specific point (this could be empty, a single point, or even a set of points, depending on the function).

#eg[
  Consider the linear transformation $T: RR^2 arrow RR^2$ given by the matrix:

  $
    A = mat(
      2, 0;
      0, 3;
    )
  $

  This transformation $T$ maps any vector $accent(x, arrow) = vec(x_1, x_2)$ in $RR^2$ to:

  $
    T(accent(x, arrow)) = A accent(x, arrow) = mat(
      2, 0;
      0, 3;
    ) vec(x_1, x_2) = vec(2 x_1, 3 x_2)
  $

  Now, let's find the preimage of a subset $S subset.eq RR^2$. Suppose we want the preimage of the set $S = {vec(4, 6), vec(2, 3)}$

  The primage of $S$ under $T$, denoted $T^(-1) (S)$, consists of all vectors $accent(x, arrow) in RR^2$ such that $T(accent(x, arrow)) in {vec(4, 6), vec(2, 3)}$. To find this, we solve for $accent(x, arrow)$ in both cases: $T(accent(x, arrow)) = vec(4, 6)$ and $T(accent(x, arrow)) = vec(2, 3)$

  *Preimage of $vec(4, 6)$*

  $
    A accent(x, arrow) = vec(4, 6)
  $

  or 

  $
    mat(
      2, 0;
      0, 3;
    ) vec(x_1, x_2) = vec(4, 6)
  $

  Solving each component:

  1. $2 x_1 = 4 arrow.double x_1 = 2$
  2. $3 x_2 = 6 arrow.double x_2 = 2$

  Thus, the primage of $S$ is the single point:

  $
    T^(-1) (vec(4, 6)) = {vec(2, 2)}
  $

  *Preimage of $vec(2, 3)$*

  $
    A accent(x, arrow) = vec(2, 3)
  $

  or 

  $
    mat(
      2, 0;
      0, 3;
    ) vec(x_1, x_2) = vec(2, 3)
  $

  Solving each component:

  1. $2 x_1 = 2 arrow.double x_1 = 1$
  2. $3 x_2 = 3 arrow.double x_2 = 1$

  Thus, the primage of $S$ is the single point:

  $
    T^(-1) (vec(2, 3)) = {vec(1, 1)}
  $

  *Preimage of the set $S$*

  Since $S = {vec(4, 6), vec(2, 3)}$, the prrimage of $S$ is the union of the preimage of each vector in S:

  $
    T^(-1) (S) = {vec(2, 2), vec(1, 1)}
  $
]

=== Kernel of a Transofrmation

The kernel of a transformation $T: RR^n arrow RR^m$, denoted 
$ker(T)$, is the set of all vectors in $RR^n$ that $T$ maps to the zero vector in 
$RR^m$. Formally, we define the kernel as:

$
  ker(T) = {accent(x, arrow) in RR^n | T(accent(x, arrow)) = accent(0, arrow)}
$

The consists of all vectors that are "annihilated" by 
$T$, resulting in the zero vector after applying $T$.

#eg[
  The transformation $T: RR^2 arrow RR^2$ defined by the matrix

  $
    A = mat(
      2, 0;
      0, 3;
    )
  $

  so that $T(accent(x, arrow)) = A accent(x, arrow) = vec(2 x_1, 3 x_2)$ for any $accent(x, arrow) = vec(x_1, x_2) in RR^2$

  To find the kernel of $T$, we need to find all the vectors $accent(x, arrow) in RR^2$ that satisfy:

  $
    T(accent(x, arrow)) = accent(0, arrow) arrow.double mat(
      2, 0;
      0, 3;
    ) vec(x_1, x_2) = vec(0, 0)
  $

  This leads to the system of equations:

  1. 3 x_1 = 0 arrow.double x_1 = 0

  2. 3 x_2 = 0 arrow.double x_2 = 0

  Thus, the only solution is $accent(x, arrow) = vec(0, 0)$
]

=== Kernel and Null Space

The kernel of $T$ 

$
  ker(T) = "Null"(A)
$

== Sum and Scalar Multiples of Linear Transformation

=== Sum

$
  T: RR^n arrow RR^m quad quad quad quad S: RR^n arrow RR^m \
  \
  (T + S): RR^n arrow RR^m
$

$
  A = mat(
    ;
    accent(a, arrow)_1, accent(a, arrow)_2, dots, accent(a, arrow)_n;
    ;
  )
  quad 
  B = mat(
    ;
    accent(b, arrow)_1, accent(b, arrow)_2, dots, accent(b, arrow)_n;
    ;
  )
$

$
  (T + S) (accent(x, arrow)) 
  &= T(accent(x, arrow)) + S(accent(x, arrow)) \
  &= A accent(x, arrow) + B accent(x, arrow) \ 
  &= x_1 accent(a, arrow)_1 + x_2 accent(a, arrow)_2 + dots + x_n accent(a, arrow)_n + x_1 accent(b, arrow)_1 + x_2 accent(b, arrow)_2 + dots + x_n accent(b, arrow)_n \
  &= x_1 (accent(a, arrow)_1 + accent(b, arrow)_1) +  x_2 (accent(a, arrow)_2 + accent(b, arrow)_2) + dots + x_n (accent(a, arrow)_n + accent(b, arrow)_n) \
  &= mat(
    ;
    accent(a, arrow)_1 + accent(b, arrow)_1, accent(a, arrow)_2 + accent(b, arrow)_2, dots, accent(a, arrow)_n + accent(b, arrow)_n;
    ;
  ) vec(x_1, x_2, dots.v, x_n) \
  &= #result[$(A + B) accent(x, arrow)$] \
$



=== Scalar Multiplication

$
  T: RR^n arrow RR^m \
  \
  c T: RR^n arrow RR^m \
$

$
  (c T)(accent(x, arrow)) 
  &= c (T(accent(x, arrow))) \
  &= c (x_1 accent(a, arrow)_1 + x_2 accent(a, arrow)_2 + dots + x_n accent(a, arrow)_n) \
  &= x_1 c accent(a, arrow)_1 + x_2 c accent(a, arrow)_2 + dots + x_n c accent(a, arrow)_n \
  &= mat(
    ;
    c accent(a, arrow)_1, c accent(a, arrow)_2, dots, c accent(a, arrow)_n;
    ;
  ) vec(x_1, x_2, dots.v, x_n) \
  &= #result[$c A accent(x, arrow)$] \
$



