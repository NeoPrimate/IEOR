#import "../../../utils/examples.typ": eg
#import "../../../utils/result.typ": result
#import "../../../utils/matvec_mult.typ": matvec_mult
#import "../../../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

#import "@preview/numty:0.0.4" as nt

#set math.vec(delim: "[")
#set math.mat(delim: "[")


== Projection

The projection of a vector $accent(x, arrow)$, onto a line $L$, denoted as $"Proj"_L (accent(x, arrow))$, is a vector that lies on the line $L$, such that the difference between $accent(x, arrow)$ and its projection, $"Proj"_L (accent(x, arrow)) - accent(x, arrow)$, is orthogonal to $L$

$"Proj"_L (accent(x, arrow))$ can be seen as the "shadow"cast by $accent(x, arrow)$ onto $L$ when light shines perpendicularly to $L$.

$
  "Proj"_L (accent(x, arrow)) = c #text(red)[$accent(v, arrow)$] = ((accent(x, arrow) dot accent(v, arrow)) / (accent(v, arrow) dot accent(v, arrow))) #text(red)[$accent(v, arrow)$]
$

Equivalently

$
  "Proj"_L (accent(x, arrow)) = c #text(red)[$accent(v, arrow)$] = ((accent(x, arrow) dot accent(v, arrow)) / (||accent(v, arrow)||^2)) #text(red)[$accent(v, arrow)$]
$

Where:
- $accent(v, arrow)$ is a direction vector for the line $L$
- $c = (accent(x, arrow) dot accent(v, arrow)) / (accent(v, arrow) dot accent(v, arrow))$ is a scalar

#eg[


  #let x = (2, 3)
  #let v = (2, 1)

  #let num = nt.dot(x, v)
  #let den = nt.dot(v, v)
  #let c = num / den
  #let proj = nt.mult(c, v)

  #let a = (v.at(1) - 0) / (v.at(0) - 0)
  #let b = 0

  $
    accent(x, arrow) = #nt.print(x), 
    quad quad
    accent(v, arrow) = #nt.print(v)
  $

  1. Define the line $L$ as all vectors of the form $c accent(v, arrow)$, where $c$ is a scalar:

  $
    L &= {c accent(v, arrow) | c in RR} \
    &= {c #nt.print(v) | c in RR} \ 
  $

  2. Compute the projection using

  $
    "Proj"_L (accent(x, arrow)) 
    &= (accent(x, arrow) dot accent(v, arrow)) / (accent(v, arrow) dot accent(v, arrow)) accent(v, arrow) \
    &= (#nt.print(x) dot #nt.print(v)) / (#nt.print(v) dot #nt.print(v)) #nt.print(v) \
    &= num / den #nt.print(v) \
    &= nt.print(proj) \
  $

  #align(center)[
    #cetz.canvas(length: 6cm, {
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
          cetz-plot.plot.add-anchor("o", (0, 0))
          cetz-plot.plot.add-anchor("x", x)
          cetz-plot.plot.add-anchor("v", v)
          cetz-plot.plot.add-anchor("proj", proj)
          cetz-plot.plot.add(domain: (-5, 5), x => a * x + b)

        }, 
        name: "plot"
      )
      
      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.x", stroke: green, mark: (fill: green), name: "x")
      cetz.draw.content("x.end", text(green)[$accent(x, arrow)$], anchor: "south", padding: 0.01, angle: "x.end")
      
      cetz.draw.line("plot.o", "plot.proj", stroke: purple, mark: (fill: purple), name: "proj")
      cetz.draw.content("proj.end", text(purple)[$"Proj"_L (accent(x, arrow))$], anchor: "west", padding: 0.05, angle: "proj.end")
      
      cetz.draw.line("plot.o", "plot.v", stroke: red, mark: (fill: red), name: "v")
      cetz.draw.content("v.end", text(red)[$accent(v, arrow)$], anchor: "north", padding: 0.05, angle: "v.end")
      
      cetz.draw.line("plot.x", "plot.proj", stroke: black, mark: (fill: black, end: none), name: "conn")

      // cetz.angle.right-angle(
      //   "proj.start",
      //   "proj.end",
      //   "conn.end",
      //   radius: 1.5
      // )

    })
  ]
]

*Projection as a Transformation*

As a matrix vector product

$
  L = {c accent(v, arrow) | c in RR}
$

$
  "Proj"_L : RR^n arrow RR^n
$

$
  accent(v, arrow) dot accent(v, arrow) = || accent(v, arrow) ||^2
$

If $accent(v, arrow)$ is a unit vector:

$
  ||accent(v, arrow)|| = 1
$

Then

$
  "Proj"_L (accent(x, arrow)) 
  &= ((accent(x, arrow) dot accent(v, arrow)) / (accent(v, arrow) dot accent(v, arrow))) accent(v, arrow) \
  &= ((accent(x, arrow) dot accent(v, arrow)) / (|| accent(v, arrow) ||^2)) accent(v, arrow)
$

If we redefine our line $L$ as all the scalar multiples of out unit vector $hat(u)$:

$
  L = {c hat(u) | c in RR}
$

Simplifies to:

$
  #result[$(accent(x, arrow) dot hat(u)) hat(u)$]
$

#let v = (2, 1)
#let mag_v = calc.sqrt(nt.dot(v, v))
#let u = nt.mult(1 / mag_v, v)

#align(center)[
  #cetz.canvas(length: 6cm, {
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
        cetz-plot.plot.add-anchor("o", (0, 0))
        cetz-plot.plot.add-anchor("u", u)
        cetz-plot.plot.add-anchor("v", v)
      }, 
      name: "plot"
    )
    
    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

    cetz.draw.line("plot.o", "plot.v", stroke: red, mark: (fill: red), name: "v")
    cetz.draw.content("v.end", text(red)[$|| accent(v, arrow) || eq.not 0$], anchor: "south-west", padding: 0.01, angle: "v.end")

    cetz.draw.line("plot.o", "plot.u", stroke: green, mark: (fill: green), name: "u")
    cetz.draw.content("u.end", text(green)[$hat(u) = 1 / (||accent(v, arrow)||) accent(v, arrow)$], anchor: "north-west", padding: 0.075, angle: "u.end")
  })
]

*Projection as a Linear Transformation*

Let $hat(u) in RR^n$ be a unit vector:

$
  hat(u) = vec(u_1, u_2, dots.v, u_n), quad "where" ||hat(u)|| = 1
$

The projection matrix $A$ is:

$
  A = hat(u) hat(u)^T = vec(u_1, u_2, dots.v, u_n) [u_1 quad u_2 quad dots quad u_n]
$

Expands to:

$
  A = mat(
    u_1 u_1, u_1 u_2, dots, u_1 u_n;
    u_2 u_1, u_2 u_2, dots, u_2 u_n;
    dots.v, dots.v, dots.down, dots.v;
    u_n u_1, u_n u_2, dots, u_n u_n;
  )  
$

For any $accent(x, arrow) in RR^n$, the projection of $accent(x, arrow)$ onto the line spanned by $hat(u)$ is:

$
  "Proj"_L (accent(x, arrow)) = A accent(x, arrow) = (hat(u) dot accent(x, arrow)) hat(u)
$

#eg[

  #let v = (2, 1)
  #let mag_v = calc.sqrt(nt.dot(v, v))
  #let u = nt.mult(1 / mag_v, v)

  Consider a vector $accent(v, arrow)$ in $RR^2$:

  $
    accent(v, arrow) = #nt.print(v)
  $

  *1. Construct the Unit Vector*

  $
    ||accent(v, arrow) = sqrt(2^2 + 1^2) = sqrt(5)
  $
  
  $
    hat(u) = accent(v, arrow) / (|| accent(v, arrow) ||) = 1 / sqrt(5) vec(2, 1) = vec(2 / sqrt(5), 1 / sqrt(5))
  $

  This unit vector $hat(u)$ defines the line $L$, which consists of all the scalar multiples og $accent(v, arrow)$:

  $
    L = {c accent(v, arrow) | c in RR}
  $

  *2. Derive the Projection Matrix*

  The projection of any vector $accent(x, arrow)$ onto the line $L$ is given by:

  $
    "Proj"_L (accent(x, arrow)) = A accent(x, arrow)
  $

  Where $A$ is the projection matrix. To construct $A$ we use the formula:

  $
    A 
    &= hat(u) hat(u)^T \
    &= vec(u_1, u_2) [u_1 quad u_2] \
    &= mat(
      u_1 dot u_1, u_1 dot u_2;
      u_2 dot u_1, u_2 dot u_2;
    ) \
    &= vec(2 / sqrt(5), 1 / sqrt(5)) [2 / sqrt(5) quad 1 / sqrt(5)] \
    &= mat(
      (2 / sqrt(5))^2, 1 / sqrt(5) 2 / sqrt(5);
      2 / sqrt(5) 1 / sqrt(5), (1 / sqrt(5))^2;
    ) \
    & = mat(
      4/5, 2/5;
      2/5, 1/5;
    )
  $

  *3. Applying the Projection*

  To project any vector $accent(x, arrow)$ onto $L$, we multiply $accent(x, arrow)$ by the matrix $A$:

  $
    "Proj"_L (accent(x, arrow)) 
    &= A accent(x, arrow) \
    &= mat(
      4/5, 2/5;
      2/5, 1/5;
    ) accent(x, arrow)
  $

  #align(center)[
  #cetz.canvas(length: 6cm, {
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
        cetz-plot.plot.add-anchor("o", (0, 0))
        cetz-plot.plot.add-anchor("u", u)
        cetz-plot.plot.add-anchor("v", v)
      }, 
      name: "plot"
    )
    
    cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

    cetz.draw.line("plot.o", "plot.v", stroke: red, mark: (fill: red), name: "v")
    cetz.draw.content("v.end", text(red)[$accent(v, arrow) = #nt.print(v)$], anchor: "south-west", padding: 0.01, angle: "v.end")

    cetz.draw.line("plot.o", "plot.u", stroke: green, mark: (fill: green), name: "u")
    cetz.draw.content("u.end", text(green)[$hat(u)$], anchor: "south", padding: 0.05, angle: "u.end")
  })
]
]

1. Additivity of Projections (Linearity with respect to addition)

$
  "Proj"_L (accent(a, arrow) + accent(b, arrow)) 
  &= ((accent(a, arrow) + accent(b, arrow)) dot hat(u)) \
  &= (accent(a, arrow) dot hat(u) + accent(b, arrow) dot hat(u)) hat(u) \
  &= (accent(a, arrow) dot hat(u)) hat(u) + (accent(b, arrow) dot hat(u)) hat(u) \
  &= "Proj"_L (accent(a, arrow)) + "Proj"_L (accent(b, arrow))
$

2. Homogeneity of Projections (Linearity with respect to scalar multiplication)

$
  "Proj"_L (c accent(a, arrow)) 
  &= (c accent(a, arrow) dot hat(u)) hat(u) \
  &= c (accent(a, arrow) dot hat(u)) hat(u) \
  &= c "Proj"_L (accent(a, arrow)) \
$

*General Properties of $A$*

1. Idempotence

$
  A^2 = A
$

2. Symmetry

$
  A^T = A
$

3. Rank

$
  "rank"(A) = 1
$

Because $hat(u) hat(u)^T$ projects onto a one-dimensional subspace spanned by $hat(u)$










