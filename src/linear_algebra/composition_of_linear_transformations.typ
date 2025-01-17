#import "../utils/code.typ": code
#import "../utils/examples.typ": eg
#import "../utils/result.typ": result
#import "../utils/blob.typ": draw-blob
#import "../utils/color_math.typ": colorMath

#import "@preview/cetz:0.3.1"

#set math.vec(delim: "[")
#set math.mat(delim: "[")


== Composition of Linear Transformations

$
  S: colorMath(X, #purple) arrow colorMath(Y, #green) quad quad T: colorMath(Y, #green) arrow colorMath(Z, #red)
$

$
  T compose S: colorMath(X, #purple) arrow colorMath(Z, #red)
$

$
  S(arrow(x)) = underbrace(A, m times n) arrow(x) quad quad T(arrow(x)) = underbrace(B, l times m) arrow(x)
$

#align(center)[
  #cetz.canvas({
    draw-blob(
      2, (0, 0), 1.5,
      stroke: purple,
      name: "blob1"
    )
    draw-blob(
      8, (6, 0), 1.5,
      n-pts: 10,
      stroke: green,
      name: "blob2"
    )
    draw-blob(
      8, (12, 0), 1.5,
      n-pts: 8,
      stroke: red,
      name: "blob3"
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
    cetz.draw.circle(
      "blob3.center",
      radius: .05,
      fill: black,
      stroke: none,
      name: "z"
    )
    cetz.draw.content(
      "x", [$arrow(x)$],
      anchor: "east",
      padding: 3pt
    )
    cetz.draw.content(
      "y", [$arrow(y)$],
      anchor: "north",
      padding: 3pt
    )
    cetz.draw.content(
      "z", [$arrow(z)$],
      anchor: "north",
      padding: 3pt
    )
    cetz.draw.content(
      (-1., 1.5), text(fill: purple)[$X subset.eq RR^n$]
    )
    cetz.draw.content(
      (7, 1.5), text(fill: green)[$Y subset.eq RR^m$]
    )
    cetz.draw.content(
      (12.2, 1.5), text(fill: red)[$Z subset.eq RR^l$]
    )
    
    let mid = (3, .5)
    cetz.draw.bezier-through(
      "x.north-east", mid, "y.north-west",
      stroke: black + .5pt,
      mark: (end: ">", fill: black),
      name: "arrow"
    )
    cetz.draw.content(
      mid, 
      [$S: RR^n -> RR^m$],
      anchor: "south",
      padding: 3pt
    )

    let mid = (9, .5)
    cetz.draw.bezier-through(
      "y.north-east", mid, "z.north-west",
      stroke: black + .5pt,
      mark: (end: ">", fill: black),
      name: "arrow"
    )
    cetz.draw.content(
      mid, 
      [$T: RR^m -> RR^l$],
      anchor: "south",
      padding: 3pt
    )
  
    let mid = (6, -2)
    cetz.draw.bezier-through(
      "x.south-east", mid, "z.south-west",
      stroke: black + .5pt,
      mark: (end: ">", fill: black),
      name: "arrow"
    )
    cetz.draw.content(
      mid, 
      [$
        T compose S&: RR^n arrow RR^l \
        T compose S (arrow(x)) 
        &= T(S(arrow(x))) \
        &= A(B(arrow(x))) \
        &= A B arrow(x) \
      $],
      anchor: "north",
      padding: 3pt
    )
  })
]

Consider two linear transformations $T$ and $S$, where:

- $T$ maps $RR^m arrow RR^l$

- $S$ maps $RR^n arrow RR^m$

The composition $T compose S$ is a nre transformation mapping $RR^n arrow RR^l$ defined by:

$
  T compose S(arrow(x)) = T(S(arrow(x)))
$

*Key Properties of $T compose S$*

1. Additivity

$
  T compose S(arrow(x) + arrow(y))
  &= T(S(arrow(x) + arrow(y))) \
  &= T(S(arrow(x)) + S(arrow(y))) \ 
  &= T(S(arrow(x))) + T(S(arrow(y))) \
  &= T compose S(arrow(x)) + T compose S(arrow(y))
$

2. Homogeneity

$
  T compose S (c arrow(x)) 
  &= T(S(c arrow(x))) \
  &= T(c S(arrow(x))) \
  &= c T(S(arrow(x))) \
  &= c (T compose S)(arrow(x))
$

*Matrix Representation of $T compose S$*

Let $S$ be represented by the matrix $A$ ($m times n$), and let $T$ be respesented by the matrix $B$ ($l times m$)

For a vector $arrow(x) in RR^n$

$
  T compose S (arrow(x)) 
  &= T(S(arrow(x))) = T(A arrow(x)) \
  &= underbrace(B, l times m)(underbrace(A, m times n) arrow(x)) \
  &= underbrace(C, l times n) arrow(x)
$

The composition $T compose S$ is therefor represented by the matrix $C = A dot B$, where $C$ is of size $l times n$

*Column-Wise Interpretation*

The matrix $A$ can be decomposed comlumn-wise:

$
  A = mat(
    ;
    arrow(a)_1, arrow(a)_2, dots, arrow(a)_n;
    ;
  )
$

where $arrow(a)_i$ is the $i$-th column of $A$ and $I_n$ is the identity matrix in $RR^n$, and its columns are the standard basis vectors $arrow(e)_1, arrow(e)_2, dots, arrow(e)_n$.

$
  I_n = mat(
    1, 0, dots, 0;
    0, 1, dots, 0;
    dots.v, dots.v, dots.down, dots.v;
    underbrace(0, e_1), underbrace(0, e_2), dots, underbrace(1, e_n)
  )
$

To compute $C$:

1. For each $arrow(e)_i$ in the basis of $RR^n$, $A arrow(e)_i = arrow(a)_i$, the $i$-th column of $A$



$
  C 
  &= mat(
    ;
    B(A e_1), B(A e_2), dots, B(A e_n);
    ;
  ) \
  &= mat(
    ;
    B(A vec(1, 0, dots.v, 0)), B(A vec(0, 1, dots.v, 0)), dots, B(A vec(0, 0, dots.v, 1));
    ;
  ) \
  &= mat(
    ;
    B arrow(a)_1, B arrow(a)_2, dots, B arrow(a)_n;
    ;
  ) \
$

The composition $T compose S$ is the linear map respresented by *$C = B dot A$*

Each column of $C$ reflects how $T$ transforms the action of $S$ on a standard basis vector

== Matrix Product

$
  underbrace(A, m times n) 
  = mat(
    a_(11), a_(12), dots, a_(1n);
    a_(21), a_(22), dots, a_(2n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n)
  )
  quad quad
  underbrace(B, n times p) 
  = mat(
    b_(11), b_(12), dots, b_(1p);
    b_(21), b_(22), dots, b_(2p);
    dots.v, dots.v, dots.down, dots.v;
    b_(n 1), b_(n 2), dots, b_(n p)
  )
$

$
  c_(i j) = sum^n_(k=1) a_(i k) b_(k j)
$

#eg[
  $
    underbrace(A, colorMath(2, #red) times 3) 
    = mat(
      colorMath(1, #red), colorMath(2, #red), colorMath(3, #red);
      colorMath(4, #blue), colorMath(5, #blue), colorMath(6, #blue);
    )
    
    quad quad

    underbrace(B, 3 times colorMath(2, #red))
    = mat(
      colorMath(7, #green), colorMath(8, #purple);
      colorMath(9, #green), colorMath(10, #purple);
      colorMath(11, #green), colorMath(12, #purple);
    )
  $
  $
    A B 
    &= mat(
      A colorMath(vec(7, 9, 11), #green), A colorMath(vec(8, 10, 12), #purple);
    ) \
    &= mat(
      colorMath(vec(1, 2, 3), #red) colorMath(vec(7, 9, 11), #green),,,
      colorMath(vec(1, 2, 3), #red) colorMath(vec(8, 10, 12), #purple)
      ;;
      colorMath(vec(4, 5, 6), #blue) colorMath(vec(7, 9, 11), #green),,,
      colorMath(vec(4, 5, 6), #blue) colorMath(vec(8, 10, 12), #purple)
      ;
    )
  $

  $
    
  $
]

== Matrix Product Associativity



