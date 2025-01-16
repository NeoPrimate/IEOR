#import "../../../utils/code.typ": code
#import "../../../utils/examples.typ": eg
#import "../../../utils/result.typ": result
#import "../../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Linear Transformation

=== Functions

A function $f$ that maps elements from a set $X$ (the domain) to a set $Y$ (the codomain):

$
  f: X arrow Y
$

- Domain: The set $X$ contains all possible inputs for the function $f$
- Codomain: The set $Y$ is the space where all possible outputs of $f$ reside, though not every element in $Y$ must be an output of $f$

#align(center)[
  #cetz.canvas({
    draw-blob(
      2, (0, 0), 1.5,
      stroke: green,
      name: "blob1"
    )
    draw-blob(
      8, (5, 0), 1.5,
      n-pts: 10,
      stroke: orange,
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
      (4.6, 1.4), text(fill: orange)[$RR^m$]
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
      (2.5, -1), text(fill: blue)[$f: RR^n -> RR^m$]
    )
  })
]

#eg[
  If 
  
  $
  f: RR arrow RR
  $ 
  
  is defined by 
  
  $
  f(x) = x^2 \
  f: x arrow.bar x^2 \
  $
  
  then:

  - *Domain*: $X = RR$, any real number ($(infinity, infinity)$)

  - *Codomain*: $Y = RR$, any real number ($(infinity, infinity)$) 

  - *Range*: the subset of the codomain ($RR$), $[0, infinity\)$
]

== Vector Transformation

A function $f$ that maps an $n$-dimensional vector in $RR^n$ to an $m$-dimensional vector in $RR^m$:

1. Function Definition

$
  f: RR^n arrow RR^m
$

This means $f$ takes as input a vector in $RR^n$ (an $n$-dimensional space of real numbers) and maps it to a vector in $RR^m$ (an $m$-dimensional space of real numbers).

2. Input Vector $accent(x, arrow)$

$
  accent(x, arrow) = vec(x_1, x_2, dots.v, x_n) quad "where" quad x_1, x_2, dots, x_n in RR
$

Here, $accent(x, arrow)$ is an $n$-dimensional vector, and each component $x_i$ is a real number

3. Input Vector $accent(y, arrow)$

$
  accent(y, arrow) = vec(y_1, y_2, dots.v, y_m) quad "where" quad y_1, y_2, dots, y_m in RR
$

The output $accent(y, arrow)$ is an $m$-dimensional vector, and each component $y_i$ is also a real number

*Summary*

The function $f$ takes an $n$-dimensional vector of real numbers as input and produces an $m$-dimensional vector of real numbers as output

#eg[
  $
  f(x_1, x_2, x_3) = (x_1 + 2 x_2, 3 x_3)
  $
  
  $
  f: RR^3 arrow RR^2
  $
  
  $
  f(vec(x_1, x_2, x_3)) = vec(x_1 + 2 x_2, 3 x_3)
  $
  
  $
  f(vec(1, 1, 1)) = vec(3, 3)
  $

  #align(center)[
    #grid(
      columns: (1fr, 1fr),
      rows: (auto),
      gutter: 0pt,
      cetz.canvas({
        import cetz.draw: *
        ortho(x: 25deg, y: 25deg, {
        line((0, 0), (x: 3), stroke: blue, name: "x", mark: (end: "straight", scale: 1))
        content((), $ x_2 $, anchor: "west", padding: 5pt)
        line((0, 0), (y: 3), stroke: blue, name: "y", mark: (end: "straight", scale: 1))
        content((), $ x_3 $, anchor: "north", padding: 5pt)
        line((0, 0), (z: 3), stroke: blue, name: "z", mark: (end: "straight", scale: 1))
        content((), $ x_1 $, anchor: "east", padding: 5pt)
        line((0, 0), (x: 2, y: 2, z: 2), stroke: red, name: "z", mark: (end: "straight", scale: 1))
        content((), $ vec(1, 1, 1) $, anchor: "north", padding: 5pt)
        })
      }),

      cetz.canvas({
        import cetz.draw: *
        line((0, 0), (x: 3), stroke: blue, name: "x", mark: (end: "straight", scale: 1))
        content((), $ x_1 $, anchor: "south", padding: 5pt)
        line((0, 0), (y: 3), stroke: blue, name: "y", mark: (end: "straight", scale: 1))
        content((), $ x_2 $, anchor: "south", padding: 5pt)
        line((0, 0), (x: 2, y: 2), stroke: red, name: "y", mark: (end: "straight", scale: 1))
        content((), $ vec(3, 3) $, anchor: "south", padding: 5pt)
      })
    )
  ]
]

== Linear Transformation

$
  T: RR^n arrow RR^m
$

$
  accent(a, arrow), accent(b, arrow) in RR^n
$

For a transformation *linear* it must satisfy two conditions:

1. Additivity (or linearity of addition)

#result[
  $
    T(accent(a, arrow) + accent(b, arrow)) = T(accent(a, arrow)) + T(accent(b, arrow))
  $
]

#eg[
  Let's consider a linear transformation $T: RR^2 arrow RR^2$
  
  $
    T(vec(x, y)) = vec(2x, 3y)
  $

  Now let's take two vectors in $RR^2$:

  $
    accent(a, arrow) = vec(1, 2) quad quad quad accent(b, arrow) = vec(3, 1)
  $

  Then the additivity property can be verified as follows:

  1. First, find $T(accent(a, arrow)) + T(accent(b, arrow))$ separately:

  $
    T(accent(a, arrow)) = T(vec(1, 2)) = vec(2 dot 1, 3 dot 2) = vec(2, 6) \
    T(accent(b, arrow)) = T(vec(3, 1)) = vec(2 dot 3, 3 dot 1) = vec(6, 3) \
    T(accent(a, arrow)) + T(accent(b, arrow)) = vec(2, 6) + vec(6, 3) = vec(2 + 6, 6 + 3) = #text(fill: red)[$vec(8, 9)$]
  $

  2. Next, find $T(accent(a, arrow) + accent(b, arrow))$:

  $
    accent(a, arrow) + accent(b, arrow) = vec(1, 2) + vec(3, 1) = vec(4, 3) \
    T(accent(a, arrow) + accent(b, arrow)) = T(vec(4, 3)) = vec(2 dot 4, 3 dot 3) = #text(fill: red)[$vec(8, 9)$]
  $

  Since $T(accent(a, arrow) + accent(b, arrow)) = T(accent(a, arrow)) + T(accent(b, arrow))$, this confirms the additivity (linearity of addition) property of the transformation $T$

]

2. Homogeneity (or linearity of scalar multiplication):

#result[
  $
    T(c accent(a, arrow)) = c T(accent(a, arrow))
  $
]

#eg[
  Let's consider a linear transformation $T: RR^2 arrow RR^2$
  
  $
    T(vec(x, y)) = vec(2x, 3y)
  $

  Now let's take one vectors in $RR^2$:

  $
    accent(a, arrow) = vec(1, 2)
  $

  and a scalar $c = 3$

  Then the homogeneity property can be verified as follows:

  1. First, find $c T(accent(a, arrow))$

  $
    T(accent(a, arrow)) = T(vec(1, 2)) = vec(2 dot 1, 3 dot 2) = vec(2, 6)
  $

  $
    c T(accent(a, arrow)) = 3 dot vec(2, 6) = vec(3 dot 2, 3 dot 6) = #text(fill: red)[$vec(6, 18)$]
  $

  2. Then, find $T(c accent(a, arrow))$ by $c$ to get $c accent(a, arrow)$

  $
    c accent(a, arrow) = 3 dot vec(1, 2) = vec(3 dot 1, 3 dot 2) = vec(3, 6)
  $

  $
    T(c accent(a, arrow)) = T(vec(3, 6)) = vec(2 dot 3, 3 dot 6) = #text(fill: red)[$vec(6, 18)$]
  $

  Since $T(c accent(a, arrow)) = c T(accent(a, arrow))$, this confirms the homogeneity (linearity of scalar multiplication) property of the transformation $T$

]

// #link("https://www.youtube.com/watch?v=5GaB5q_u6I0")[
//   Multiplication by 2 (3B1B)
// ]

// #link("https://www.youtube.com/watch?v=xnLx3aZOpCE")[
//   Multiplication by 1/2 (3B1B)
// ]

// #link("https://www.youtube.com/watch?v=mhhpBfITkjw")[
//   Multiplication by -3 (3B1B)
// ]

// #link("https://www.youtube.com/watch?v=5GaB5q_u6I0")[
//   Multiplication by 2 (3B1B)
// ]

// #link("https://www.youtube.com/watch?v=2xKaXDHDGsA")[
//   Examples Of Two Dimensional Linear Transformations (3B1B)
// ]

// #link("https://www.youtube.com/watch?v=x1dGfxBdDlM")[
//   Examples Of Nonlinear Two Dimensional Transformations (3B1B)
// ]

== Matrix Vector Products

Matrix product with vector is always a linear transformation

$
  T: RR^n arrow RR^m \
  T(accent(x, arrow)) = A accent(x, arrow)
$

$
  A = mat(
     , , , ;
    v_1, v_2, dots, v_n;
     , , , ;
  ) \

  accent(x, arrow) = vec(x_1, x_2, dots.v, x_n)
$

$
  A accent(x, arrow) = mat(
     , , , ;
    v_1, v_2, dots, v_n;
     , , , ;
  ) vec(x_1, x_2, dots.v, x_n) = x_1 v_1 + x_2 v_2 + dots + x_n v_n
$

1. Additivity (or linearity of addition)

#result[
  $
    T(accent(a, arrow) + accent(b, arrow)) = T(accent(a, arrow)) + T(accent(b, arrow))
  $
]

$
  A dot (accent(a, arrow) + accent(b, arrow)) = A vec(a_1 + b_1, a_2 + b_2, dots.v, a_n + b_n) &= (a_1 + b_1) v_1 + (a_2 + b_2) v_2 + dots + (a_n + b_n) v_n \

  &= a_1 v_1 + b_1 v_1 + a_2 v_2 + b_2 v_2 + dots + a_n v_n + b_n v_n \

  &= (a_1 v_1 + a_2 v_2 + dots + a_n v_n) + (b_1 v_1 + b_2 v_2 + dots + b_n v_n) \

  &= A vec(a_1, a_2, dots.v, a_n) + A vec(b_1, b_2, dots.v, b_n) \
$

#eg[
  $
    A = mat(
      2, 1;
      0, 3;
    ) quad quad bold(u) = vec(1, 2) quad quad bold(v) = vec(3, 4)
  $

  1. Calculate $A(bold(u) + bold(v))$

  $
    bold(u) + bold(v) 
    &= vec(1, 2) + vec(3, 4) \
    &=  vec(4, 6)
  $

  $
    A(bold(u) + bold(v)) 
    &= mat(
      2, 1;
      0, 3;
    ) vec(4, 6) \
    &= vec((2 dot 1) + (1 dot 6), (0 dot 4) + (3 dot 6)) \
    &= #result[$vec(14, 18)$]
  $

  2. Calculate $A bold(u) + A  bold(v)$

  $
    A bold(u) 
    &= mat(
      2, 1;
      0, 3;
    ) vec(1, 2) \
    &= vec((2 dot 1) + (1 dot 2), (0 dot 1) + (3 dot 2)) \
    &= vec(4, 6)
  $

  $
    A bold(v)
    &= mat(
      2, 1;
      0, 3;
    ) vec(3, 4) \
    &= vec((2 dot 3) + (1 dot 4), (0 dot 3) + (3 dot 4)) \
    &= vec(10, 12) \
  $

  $
    A bold(u) + A bold(v) 
    &= vec(4, 6) + vec(10, 12) \
    &= #result[$vec(14, 18)$] 
  $
]

2. Homogeneity (or linearity of scalar multiplication):

#result[
  $
    T(c accent(a, arrow)) = c T(accent(a, arrow))
  $  
]

$
  A dot (c accent(a, arrow)) &= mat(
     , , , ;
    v_1, v_2, dots, v_n;
     , , , ;
  ) vec(c a_1, c a_2, dots.v, c a_n) \
  &= c a_1 v_1 + c a_2 v_2 + dots + c a_n v_n \
   &= c underbrace((a_1 v_1 + a_2 v_2 + dots + a_n v_n), A accent(a, arrow))
$

#eg[
  $
    A = mat(
      2, 1;
      0, 3;
    ) quad quad bold(v) = vec(3, 4) quad quad c = 5
  $

  1. Calculate $A(c bold(v))$

  $
    c v = 5 dot vec(3, 4) = vec(15, 20)
  $

  $
    A(c bold(v)) 
    &= mat(
      2, 1;
      0, 3;
    ) vec(15, 20) \
    &= vec((2 dot 15) + (1 dot 20), (0 dot 15) + (3 dot 20)) \
    &= #result[$vec(50, 60)$]
  $

  2. Calculate $c (A bold(v))$

  $
    A bold(v) 
    &= mat(
      2, 1;
      0, 3;
    ) vec(3, 4) \
    &= vec((2 dot 3) + (1 dot 4), (0 dot 3) + (3 dot 4)) \
    &= vec(10, 12)
  $

  $
    c(A bold(v))
    &= 5 dot vec(10, 12) \
    &= #result[$vec(50, 60)$]
  $
]

== Linear transformations as matrix vector products

The $n times n$ matrix $I_n$:

$
  I_n = mat(
    1, 0, 0, dots, 0;
    0, 1, 0, dots, 0;
    0, 0, 1, dots, 0;
    dots.v, dots.v, dots.v, dots.down, dots.v;
    0, 0, 0, dots, 1;
  )

$

$
accent(x, arrow) = vec(x_1, x_2, dots.v, x_n)
$

$
  I_n accent(x, arrow) = mat(
    1, 0, 0, dots, 0;
    0, 1, 0, dots, 0;
    0, 0, 1, dots, 0;
    dots.v, dots.v, dots.v, dots.down, dots.v;
    0, 0, 0, dots, 1;
  ) vec(x_1, x_2, dots.v, x_n) = vec(x_1, x_2, dots.v, x_n)
$

*Standard Basis*

$
  I_n accent(x, arrow) = mat(
    1, 0, 0, dots, 0;
    0, 1, 0, dots, 0;
    0, 0, 1, dots, 0;
    dots.v, dots.v, dots.v, dots.down, dots.v;
    underbrace(0, e_1), underbrace(0, e_2), underbrace(0, e_3), dots, underbrace(1, e_n);
  )
$

${e_1, e_2, dots, e_n}$ is the standard basis for $RR^n$

$
  I_n vec(a_1, a_2, dots.v, a_n) &= a_1 accent(e, arrow)_1 + a_2 accent(e, arrow)_2 + dots + a_n accent(e, arrow)_n \
  &= a_1 vec(1, 0, dots.v, 0) + a_2 vec(0, 1, dots.v, 0) + dots + a_n vec(0, 0, dots.v, 1) \
  &= vec(a_1, 0, dots.v, 0) + vec(0, a_2, dots.v, 0) + dots + vec(0, 0, dots.v, a_n)
$
