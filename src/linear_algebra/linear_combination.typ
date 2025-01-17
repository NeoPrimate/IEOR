#import "../utils/code.typ": code
#import "../utils/examples.typ": eg
#import "@preview/cetz:0.2.2"

#set math.vec(delim: "[")

= Linear Combinations



Set of vector

$
v_1, v_2, dots, v_n in RR^n
$

Where
- $v_1, v_2, dots, v_n$: set of vectors
- $RR^n$: set of all ordered tuples of $n$ real numbers

Linear combination of those vector

$
#text(red)[$c_1$] v_1 + #text(red)[$c_2$] v_2 + ... + #text(red)[$c_n$] v_n
$

$
c_1, c_2, dots, c_n in RR
$

Where:
- $c_1, c_2, ..., c_n$: constants or weights

#eg[
  
  $
  accent(a, arrow) = vec(1, 2)
  quad quad quad quad 
  accent(b, arrow) = vec(0, 3)
  $

  $
  #text(red)[$0$] accent(a, arrow) + #text(red)[$0$] accent(b, arrow)
  $
  
  $
  #text(red)[$3$] accent(a, arrow) + #text(red)[$2$] accent(b, arrow)
  $

]

= Span

Represents the subspace of the vector space that is "covered" by these vectors through their linear combinations

If you have a set of vectors $v_1, v_2, dots, v_n$, the span of these vectors is the set of all vectors that can be written as:

$
"Span"(v_1, v_2, dots, v_n) = {c_1 v_1 + c_2 v_2 + dots + c_n v_n | c_1, c_2, dots, c_n in RR}
$

Any vector in $RR^2$ can be represented by a linear combination with some combination of these vectors

#eg[

  *1. Spanning $RR^2$*

  $
  "Span"(accent(a, arrow), accent(b, arrow)) = RR^2
  $

  $
  accent(a, arrow) = vec(1, 2)
  quad quad quad quad 
  accent(b, arrow) = vec(0, 3)
  $

  $
  #text(red)[$3$] accent(a, arrow) + #text(red)[$(-2)$] accent(b, arrow) = vec(3 - 0, 6 - 6) = vec(3, 0)
  $

  #align(center)[
    #cetz.canvas(length: 10cm, {
      cetz.plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -7,
        y-min: -7,
        x-max: 7,
        y-max: 7,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("o", (0,0))
          cetz.plot.add-anchor("a", (1,2))
          cetz.plot.add-anchor("b", (0,3))
          
          cetz.plot.add-anchor("c", (3,6))
          cetz.plot.add-anchor("d", (0,-6))
          
          cetz.plot.add-anchor("e", (3,0))

        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

        cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.025)

        cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$hat(u)$], anchor: "east", padding: 0.025)
        
        cetz.draw.line("plot.o", "plot.c", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$3 accent(a, arrow)$], anchor: "south", padding: 0.025)
        
        cetz.draw.line("plot.o", "plot.d", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$-2 accent(b, arrow)$], anchor: "west", padding: 0.025)
        
        cetz.draw.line("plot.c", "plot.e", stroke: purple, mark: (fill: purple), name: "line")
        cetz.draw.content("line.end", text(purple)[$3 accent(a, arrow) + (-2) accent(b, arrow)$], anchor: "south-west", padding: 0.025)
    })
  ]

  Any point $accent(x, arrow)$ can be represented as a linear combination of $accent(a, arrow)$ and $accent(b, arrow)$

  1. Define the vectors

  $
  accent(a, arrow) = vec(1, 2)
  quad quad quad quad 
  accent(b, arrow) = vec(0, 3)
  quad quad quad quad 
  accent(x, arrow) = vec(x_1, x_2)
  $

  2. Express $accent(x, arrow)$ as a linear combinations

  $
  c_1 accent(a, arrow) + c_2 accent(b, arrow) = accent(x, arrow)
  $

  #h(1em) Which expands to

  $
  c_1 vec(1, 2) + c_2 vec(0, 3) = vec(x_1, x_2)
  $

  3. Set up the system of equations

  $
  1 c_1 + 0 c_2 &= x_1 quad quad (1) \

  2 c_1 + 3 c_2 &= x_2 quad quad (2) \
  $

  4. Express $c_1$: From equation (1), we can directly express $c_1$	
 
  $
  c_1 = x_1
  $

  5. Substitute $c_1$ into equation (2)

  $
  2 x_1 + 3 c_2 = x_2
  $

  #h(1em) Rearranging gives:

  $
  3 c_2 = x_2 - 2 x_1
  $

  6. Solve for $c_2$ : Dividing both sides by 3 yields

  $
  c_2 = (x_2 - 2 x_1) / 3
  $

  7. Example with specific values: Let's say we want to find $c_1$ and $c_2$ when $accent(x, arrow) = vec(2, 2)$

  #h(1em) Substitute $x_1 = 2$ and $x_2 = 2$

  $
  c_1 = x_1 = 2 \
  c_2 = (2 - 2 dot 2) / 3 = - 2 / 3
  $

  8. Final linear combination: Now, substituting $c_1$ and $c_2$ back into the linear combination

  $
  2 accent(a, arrow) - 2 / 3 accent(b, arrow) = vec(2, 2)
  $

  #h(1em) Verifying 

  $
  2 vec(1, 2) + 1 / 3 vec(0, 3) = vec(2, 2)
  $
  
  9. This shows that

  $
  2 accent(a, arrow) - 2 / 3 accent(b, arrow) = accent(x, arrow)
  $
  
  *2. Spanning Line in $RR^2$*

  Any linear combination of $accent(a, arrow)$ and $accent(b, arrow)$ will produce vectors that lie along the same line. This is the line through the origin in the direction of $accent(a, arrow)$ (or $accent(b, arrow)$), with all points on the line being scalar multiples of $accent(a, arrow)$

  $
  accent(a, arrow) = vec(2, 2)
  quad quad quad quad 
  accent(b, arrow) = vec(-2, -2)
  $


  $
  #text(red)[$3$] accent(a, arrow) + #text(red)[$(-2)$] accent(b, arrow) = vec(6 - 4, 6 - 4) = vec(2, 2)
  $

  #align(center)[
    #cetz.canvas(length: 10cm, {
      cetz.plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -7,
        y-min: -7,
        x-max: 7,
        y-max: 7,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("o", (0,0))
          cetz.plot.add-anchor("a", (2,2))
          cetz.plot.add-anchor("b", (-2,-2))
          
          cetz.plot.add-anchor("c", (6,6))
          cetz.plot.add-anchor("d", (4,4))
          
          cetz.plot.add-anchor("e", (2,2))

        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

        cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south-east", padding: 0.025)

        cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$hat(u)$], anchor: "east", padding: 0.025)
        
        cetz.draw.line("plot.o", "plot.c", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$3 accent(a, arrow)$], anchor: "south", padding: 0.025)
        
        cetz.draw.line("plot.o", "plot.d", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$-2 accent(b, arrow)$], anchor: "west", padding: 0.025)
        
        cetz.draw.line("plot.c", "plot.e", stroke: purple, mark: (fill: purple), name: "line")
        cetz.draw.content("line.end", text(purple)[$3 accent(a, arrow) + (-2) accent(b, arrow)$], anchor: "north-west", padding: 0.025)
    })
  ]
]

= Linear Independence

1. Definition of Linear Independence

The set of vectors 

$
S = {v_1, v_2, dots, v_n}
$ 

is said to be *linearly independent* if the only solution to the equation

$
c_1 v_1 + c_2 v_2 + dots + c_n v_n = bold(0)
$

is $c_1 = c_2 = dots = c_n = 0$. In other words, no vector in the set can be written as a linear combination of the others. 

If at least one constant $c_i$ is non-zero, the set is linearly dependent.

#eg[

  *Example 1*: Testing for Linear Independence

  *Problem*: Is the following set of vectors *linearly dependent*?

  $
  S = {accent(v, arrow)_1 accent(v, arrow)_2}
  $

  Where:

  $
  accent(v, arrow)_1 = vec(2, 1) quad "and" quad accent(v, arrow)_2 = vec(3, 2)
  $

  For a set of vectors to be *linearly independent*, the only solution to the equation:

  $
  c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 = bold(0)
  $

  must be $c_1 = 0$ and $c_2 = 0$

  In this case:

  $
  c_1 vec(2, 1) + c_2 vec(3, 2) = bold(0)
  $

  If not only the zero solution exists (i.e., if $c_1$ or $c_2$ can be non-zero), the set is *linearly dependent*.

  *Step 1. Set up the system of equations:*

  1. $2 c_1 + 3 c_2 = 0$
  2. $1 c_1 + 2 c_2 = 0$

  *2. Eliminate one variable*
  
  $
  2 times (1 c_1 + 2 c_2 = 0) arrow.double 2 c_1 + 4 c_2 = 0
  $

  #h(1em) Now the system is 

  $
  2 c_1 + 3 c_2 = 0 \
  2 c_1 + 4 c_2 = 0 \
  $

  *3. Subtract the equations*

  $
  (2 c_1 + 3 c_2) - (2 c_1 + 4 c_2) = 0
  $

  #h(1em) Simplifies to:

  $
  (2 c_1 - 2 c_1) + (4 c_2 - 3 c_2) = 0 \
  $

  #h(1em) So:

  $
  c_2 = 0
  $

  *4. Substitute back to find $bold(c_1)$*

  Now that we know $c_2 = 0$, substitute this value into one of the original equations. Let's use the second equation:

  $
  1 c_1 + 2 c_2 = 0
  $

  #h(1em) Substitute $c_2 = 0$:

  $
  1 c_1 + 2 (0) = 0 \
  c_1 = 0
  $

  *Conclusion:*

  Since $c_1 = 0 quad quad quad c_2 = 0$, the set of vectors $S$ is *linearly independent*. These vecots span $RR^2$.

  #line(length: 100%)

  *Example 2*: Testing for Linear Dependence

  *Problem*: Is the following set of vectors *linearly dependent*?

  $
  S = {accent(v, arrow)_1 accent(v, arrow)_2}
  $

  Where:

  $
  accent(v, arrow)_1 = vec(2, 3) quad "and" quad accent(v, arrow)_2 = vec(4, 6)
  $

  The span of this set is the collection of all vectors that can be formed by linear combinations of $accent(v, arrow)_1$ and $accent(v, arrow)_2$:

  $
  c_1 v_1 + c_2 v_2
  $

  Since $v_2 = 2 v_1$, the linear combination becomes:

  $
  c_1 v_1 + c_2 (2 v_1) = (c_1 + 2 c_2) v_1 \
  
  c_1 vec(2, 3) + c_2 vec(4, 6) \

  c_1 vec(2, 3) + c_2 2 vec(2, 3) \

  (c_1 + 2 c_2) vec(2, 3) \

  c_3 vec(2, 3)
  $

  Thus, any linear combination of these vectors is just a scalar multiple of $v_1$. The span is a single line in $RR^2$, and the vectors are *linearly dependent*.

  For any two *colinear* vectors in $RR^2$, their span reduces to a single line.

  One vector in the set can be represented by some combination of other vectors in the set
]

*2. General Rule*

In $RR^n$ , if you have more than $n$ vectors, at least one vector must be linearly dependent on the others, meaning the set cannot be linearly independent.

= Subspace

$V$ is a linear subspace of $RR^n$:

- *Non-emptiness*: $V$ contains the $bold(0)$ vector

$
bold(0) in V
$

- *Closure under addition*: If $u$ and $v$ are any vectors in the subspace $V$, then their sum $u + v$ must also be in $V$.

$
"If" u, v in V, "then" u + v in V
$

- *Closure under scalar multiplication*: If $u$ is any vector in $V$ and $c$ is any scalar (real number), then the product $c u$ must also be in $V$.

$
"If" u in V "and" c in V, "then" c u in V
$

#eg[

  *Example 1*: Subspace

  *Problem*: Is $V$ a subspace of $RR^2$

  $
  V = {bold(0)} = {vec(0, 0, 0)}
  $

  - *Non-emptiness* #emoji.checkmark.box

  $
  bold(0) in V
  $

  - *Closure under addition* #emoji.checkmark.box

  $
  vec(0, 0, 0) + vec(0, 0, 0) = vec(0, 0, 0)
  $

  - *Closure under scalar multiplication* #emoji.checkmark.box

  $
  c vec(0, 0, 0) = vec(0, 0, 0)
  $

  *Conclusion*

  The subset $V$ of $RR^3$ is a *subspace*

  #line(length: 100%)

  *Example 2*: Not Subspace

  *Problem*: Is $S$ a subspace of $RR^2$ #emoji.checkmark.box

  $
  S = {vec(x_1, x_2) in RR^2 | x_1 gt.eq 0}
  $

  #align(center)[
    #cetz.canvas(length: 10cm, {
      cetz.plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -10,
        y-min: -10,
        x-max: 10,
        y-max: 10,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("o", (0,0))
          cetz.plot.add-anchor("a", (5,5))
          cetz.plot.add-anchor("b", (-5,-5))
          cetz.plot.add-fill-between(
            domain: (0, 10),
            // style: (fill: red),
            (x) => 11,
            (x) => -11,
          )
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.o", "plot.a", stroke: green, mark: (fill: green), name: "a")
        cetz.draw.content("a.end", text(green)[$vec(a, b)$], anchor: "south", padding: 0.05)
        cetz.draw.line("plot.o", "plot.b", stroke: red, mark: (fill: red), name: "b")
        cetz.draw.content("b.end", text(red)[$vec(-a, -b)$], anchor: "south", padding: 0.1)
      })
  ]

  - *Non-emptiness* #emoji.checkmark.box

  $
  bold(0) in S
  $

  - *Closure under addition* #emoji.checkmark.box

  $
  vec(a, b) + vec(c, d) = vec(a + c, b + d)
  $

  $
  a &gt.eq 0 \
  b &gt.eq 0 \
  a + b &gt.eq 0 \
  $

  - *Closure under scalar multiplication* #emoji.crossmark

  $
  -1 vec(a, b) = vec(-a, -b)
  $

  *Conclusion*



]

*Span and Subspace*

The span of any set of vectors is a valid subspace

$
U = "Span"(v_1, v_2, dots, v_n) = "Valid Subspace of" RR^n
$

- *Non-emptiness*

$
0 v_1 + 0 v_2 + dots + 0 v_n = bold(0)
$

- *Closure under addition*

$
accent(X, arrow) = a_1 v_1 + a_2 v_2 + dots + a_n v_n \

accent(Y, arrow) = b_1 v_1 + b_2 v_2 + dots + b_n v_n \
$

$
accent(X, arrow) + accent(Y, arrow) 
&= (a_1 + b_1) v_1 + (a_2 + b_2) v_2 + dots + (a_n + b_n) v_n \

&= c_1 v_1 + c_2 v_2 + dots + c_n v_n
$

- *Closure under scalar multiplication*

$
accent(X, arrow) = a_1 v_1 + a_2 v_2 + dots + a_n v_n
$

$
b accent(X, arrow) 
&= b c_1 v_1 + b c_2 v_2 + dots + b c_n v_n \
&= c_1 v_1 + c_2 v_2 + dots + c_n v_n
$

= Basis

Non-redundant set of vectors that span $RR^n$

A basis of a vector space is a set of vectors that satisfies two conditions:
1. *Linear Independence*: No vector in the set can be written as a linear combination of the others. This means that *the only way to combine the vectors to get the zero vector is by using all zero coefficients*.

  The vectors $accent(v, arrow)_1, accent(v, arrow)_2, dots, accent(v, arrow)_n$ are linearly independent if the only solution to the equation

  $
  c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 + dots + c_n accent(v, arrow)_n = bold(0)
  $

  is $c_1 = c_2 = dots = c_n = 0$, where $c_i$ are scalar coefficients.


2. *Spanning*: The set of vectors can be linearly combined to form any vector in the vector space. In other words, *every vector in the vector space can be expressed as a linear combination of the basis vectors*.

  The set ${accent(v, arrow)_1, accent(v, arrow)_2, dots, accent(v, arrow)_n}$ spans the vector space $V$ if any vector $v in V$ can be expressed as a linear combination of the basis vectors:

  $
  accent(v, arrow) = c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 + dots + c_n accent(v, arrow)_n
  $

  for some scalars $c_1, c_2, dots, c_n$.

#eg[
Consider the vector space $RR^2$ (the 2-dimensional Euclidean space). A common basis for $RR^2$ is ${e_1, e_2}$, where:

$
e_1 = vec(1, 0) quad quad quad e_2 = vec(0, 1)
$

This set is a basis because:

- Linear Independence: The only solution to $c_1 e_1 + c_2 e_2 = bold(0)$ is $c_1 = c_2 = 0$.
- Spanning: Any vector $accent(v, arrow) = vec(x, y) in RR^2$ can be written as $accent(v, arrow) = x e_1 + x e_2$

This means ${e_1, e_2}$ is a basis for $RR^2$, and the dimension of $RR^2$ is 2.

]





