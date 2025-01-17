#import "../utils/code.typ": code
#import "../utils/examples.typ": eg

#import "@preview/cetz:0.2.2"

#set math.vec(delim: "[")

= Vectors
$
  "Vector" = "Magnitude" + "Direction"
$
#eg[
  A car is moving:

  #linebreak()

  $
  underbrace(underbrace("3 MPH", "Magnitude"\ "(Speed" arrow "Scalar)") quad quad underbrace("East", "Direction"), "Velocity (Vector)")
  $

  #linebreak()

  #align(center)[
    #cetz.canvas(length: 5cm, {
      cetz.plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -2,
        y-min: -3,
        x-max: 5,
        y-max: 5,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("a", (0,0))
          cetz.plot.add-anchor("b", (3,0))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red))
    })
  ]
]

$
accent(v, arrow) = vec(x_1, x_2)
$

== Real Coordinate Spaces

N-dimensional Real Coordinate Space

$
RR^n
$

$
accent(x, arrow) in RR^n
$

All possible real-valued n-tuples

$
accent(x, arrow) = vec(x_1, x_2, dots.v, x_n)
$

== Vector Operations

=== Vector Addition

$
vec(x_1, x_2, x_3) + vec(y_1, y_2, y_3) = vec(x_1 + y_1, x_2 + y_2, x_3 + y_3)
$

#eg[

  $
  accent(a, arrow) = #text(red)[$vec(6, -2)$]
  quad quad quad quad
  accent(b, arrow) = #text(blue)[$vec(-4, 4)$]
  $

  $
  accent(a, arrow) + accent(b, arrow) = vec(#text(red)[$6$] + #text(blue)[$-4$], #text(red)[$-2$] + #text(blue)[$4$]) = #text(green)[$vec(2, 2)$]
  $

  #align(center)[
    #cetz.canvas(length: 5cm, {
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
          cetz.plot.add-anchor("a", (0,0))
          cetz.plot.add-anchor("b", (6,-2))
          cetz.plot.add-anchor("c", (0,0))
          cetz.plot.add-anchor("d", (-4,4))
          cetz.plot.add-anchor("e", (0,0))
          cetz.plot.add-anchor("f", (2,2))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red))
        cetz.draw.line("plot.c", "plot.d", stroke: blue, mark: (fill: blue))
        cetz.draw.line("plot.e", "plot.f", stroke: green, mark: (fill: green))
    })
  ]
  
  #align(center)[
    #cetz.canvas(length: 5cm, {
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
          cetz.plot.add-anchor("a", (0,0))
          cetz.plot.add-anchor("b", (6,-2))
          cetz.plot.add-anchor("c", (6,-2))
          cetz.plot.add-anchor("d", (2,2))
          cetz.plot.add-anchor("e", (0,0))
          cetz.plot.add-anchor("f", (2,2))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red))
        cetz.draw.line("plot.c", "plot.d", stroke: blue, mark: (fill: blue))
        cetz.draw.line("plot.e", "plot.f", stroke: green, mark: (fill: green))
    })
  ]
]

=== Vector Subtraction

$
vec(x_1, x_2, x_3) - vec(y_1, y_2, y_3) = vec(x_1 - y_1, x_2 - y_2, x_3 - y_3)
$

#eg[

  #let (ax, ay) = (1, 5)
  #let (bx, by) = (5, 1)
  #let (cx, cy) = (ax - bx, ay - by)

  $
  accent(u, arrow) = vec(#str(ax), #str(ay)) quad quad quad accent(v, arrow) = vec(#str(bx), #str(by)) \
  accent(u, arrow) - accent(v, arrow) = vec(#str(ax) - #str(bx), #str(ay) - #str(by)) = vec(#str(ax - bx), #str(ay - by))
  $

  #align(center)[

  #cetz.canvas(length: 6cm, {
    cetz.plot.plot(
      x-tick-step: 5,
      y-tick-step: 5,
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
        cetz.plot.add-anchor("a", (ax,ay))
        cetz.plot.add-anchor("b", (bx,by))
        cetz.plot.add-anchor("c", (cx,cy))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.end", text(red)[$accent(u, arrow)$], anchor: "south", padding: 0.025, angle: "a.end")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "a")
      cetz.draw.content("a.end", text(blue)[$accent(v, arrow)$], anchor: "south", padding: 0.025, angle: "a.end")
      
      cetz.draw.line("plot.o", "plot.c", stroke: purple, mark: (fill: purple), name: "a")
      cetz.draw.content("a.end", text(purple)[$accent(u, arrow) - accent(v, arrow)$], anchor: "south", padding: 0.025, angle: "a.end")
  })
]
]

=== Scalar Multiplication

$
c times vec(x_1, x_2, x_3) = vec(c times x_1, c times x_2, c times x_3)
$

#eg[

  $
  accent(a, arrow) = vec(2, 1) 
  
  \
  \
  \

  3 accent(a, arrow) = #text(red)[$3$] vec(2, 1) = vec(#text(red)[$3$] dot 2, #text(red)[$3$] dot 1) = vec(6, 3)
  $

  #align(center)[
    #cetz.canvas(length: 5cm, {
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
          cetz.plot.add-anchor("a", (0,0))
          cetz.plot.add-anchor("b", (2,1))
          cetz.plot.add-anchor("c", (0,0))
          cetz.plot.add-anchor("d", (6,3))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.c", "plot.d", stroke: red, mark: (fill: red))
        cetz.draw.line("plot.a", "plot.b", stroke: green, mark: (fill: green))
    })
  ]
  
  $
  accent(a, arrow) = vec(2, 1) 
  
  \
  \
  \

  -1 accent(a, arrow) = #text(red)[$-1$] vec(2, 1) = vec(#text(red)[$-1$] dot 2, #text(red)[$-1$] dot 1) = vec(-2, -1)
  $

  #align(center)[
    #cetz.canvas(length: 5cm, {
      cetz.plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -3,
        y-min: -3,
        x-max: 3,
        y-max: 3,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("a", (0,0))
          cetz.plot.add-anchor("b", (2,1))
          cetz.plot.add-anchor("c", (0,0))
          cetz.plot.add-anchor("d", (-2,-1))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.c", "plot.d", stroke: red, mark: (fill: red))
        cetz.draw.line("plot.a", "plot.b", stroke: green, mark: (fill: green))
    })
  ]
]

== Unit Vector

A vector that has a magnitude (or length) of exactly 1

For a vector $accent(v, arrow)$ in $n$-dimensional space, a unit vector $hat(v)$ is defined as:

$
  hat(v) = accent(v, arrow) / (|| accent(v, arrow) ||)
$

Where:
- $||accent(v, arrow)||$ is the *magnitude* (or *norm*) of the vector $accent(v, arrow)$, computed as:

$
  ||accent(v, arrow)|| = sqrt(v^2_1 + v^2_2 + dots + v^2_n)
$

*Key Properties*

- *Magnitude*: 
$
  ||hat(v)|| = 1
$
- *Direction*: A unit vector points in the same direction as the original vector $accent(v, arrow)$


#eg[
  Finding unit vector (vector of magnitude 1) with given direction

  $
  accent(a, arrow) = vec(3, 4)
  $

  Magnitude 
  
  $
  || accent(a, arrow) || = sqrt(3^2 + 4^2) = sqrt(25) = 5
  $

  $
  hat(u) = (3 / (|| accent(a, arrow) ||), 4 / (|| accent(a, arrow) ||)) = (3 / 5, 4 / 5)
  $

  $
  || hat(u) || = sqrt((3/5)^2 + (4/5)^2) = sqrt(9 / 25 + 16 / 25) = sqrt(25 / 25) = sqrt(1) = 1
  $

  #align(center)[
    #cetz.canvas(length: 5cm, {
      cetz.plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: 0,
        y-min: 0,
        x-max: 5,
        y-max: 5,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("a", (0,0))
          cetz.plot.add-anchor("b", (3,4))
          cetz.plot.add-anchor("c", (0,0))
          cetz.plot.add-anchor("d", (3/5,4/5))
          
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.a", "plot.b", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.05)
        cetz.draw.line("plot.c", "plot.d", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$hat(u)$], anchor: "south", padding: 0.05)
    })
  ]

]

== Parametric Representation of line

Set $L$ of all points (i.e., line) equal to the set of all vectors $accent(x, arrow)$ plus some scalar $t$ times the vector $accent(v, arrow)$ such that $t$ can be any real number ($RR$)

$
L = {accent(x, arrow) + t accent(v, arrow) | t in RR }
$

#eg[

  #let a = (2, 1)
  #let b = (0, 3)

  #let vec_a = $vec(#str(a.at(0)), #str(a.at(1)))$
  #let vec_b = $vec(#str(b.at(0)), #str(b.at(1)))$

  #let t = 1

  #let ts = range(-15, 15, step: 2).map((i)=>i*0.1)

  #let diff_ba = (b.at(0) - a.at(0), b.at(1) - a.at(1))
  #let t_times_diff_ba = (t * diff_ba.at(0), t * diff_ba.at(1))
  
  #let b_plus_t_times_diff_ba = (b.at(0) + t * diff_ba.at(0), b.at(1) + t * diff_ba.at(1))

  $
  accent(a, arrow) = #vec_a
  $

  $
  accent(b, arrow) = #vec_b
  $

  $
  t = #t
  $

  The line $L$ can be defined as:

  $
  accent(b, arrow) + t (accent(b, arrow) - accent(a, arrow))
  &= #vec_b + #t (#vec_b - #vec_a) \
  &= #vec_b + #t vec(#str(b.at(0) - a.at(0)), #str( b.at(1) - a.at(1))) \
  &= vec(#str(b.at(0) + t * (b.at(0) - a.at(0))), #str(b.at(1) + t * (b.at(1) - a.at(1)))) \
  $

  #let vecs = ts.map((t)=> {
    (
      b.at(0) + t * (b.at(0) - a.at(0)), 
      b.at(1) + t * (b.at(1) - a.at(1)),
    )
  })

  #align(center)[
    #cetz.canvas(length: 10cm, {
      cetz.plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -6,
        y-min: -6,
        x-max: 6,
        y-max: 6,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("o", (0,0))
          cetz.plot.add-anchor("a", (a.at(0),a.at(1)))
          cetz.plot.add-anchor("b", (b.at(0),b.at(1)))
          cetz.plot.add-anchor("L", (diff_ba.at(0),diff_ba.at(1)))

          for (i, z) in vecs.enumerate() {
            cetz.plot.add-anchor(str(i), (z.at(0), z.at(1)))
          }
          
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        
        cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.01)

        cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$accent(b, arrow)$], anchor: "west", padding: 0.025)
        
        cetz.draw.line("plot.o", "plot.L", stroke: green, mark: (fill: green), name: "line")
        cetz.draw.content("line.end", text(green)[$accent(b, arrow) - accent(a, arrow)$], anchor: "east", padding: 0.03)
        
        for (i, z) in vecs.enumerate() {
          cetz.draw.line("plot.L", "plot." + str(i), stroke: purple, mark: (fill: purple), name: "line")
        }
    })
  ]

  The line $L$ can also be defined as:

  $
  accent(a, arrow) + t (accent(b, arrow) - accent(a, arrow))
  &= #vec_a + #t (#vec_b - #vec_a) \
  &= #vec_a + #t vec(#str(b.at(0) - a.at(0)), #str( b.at(1) - a.at(1))) \
  &= vec(#str(a.at(0) + t * (b.at(0) - a.at(0))), #str(a.at(1) + t * (b.at(1) - a.at(1))))
  $
  
  #let vecs = ts.map((t)=> {
    (
      a.at(0) + t * (b.at(0) - a.at(0)), 
      a.at(1) + t * (b.at(1) - a.at(1)),
    )
  })

  #align(center)[
    #cetz.canvas(length: 10cm, {
      cetz.plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -6,
        y-min: -6,
        x-max: 6,
        y-max: 6,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          cetz.plot.add-anchor("o", (0,0))
          cetz.plot.add-anchor("a", (a.at(0),a.at(1)))
          cetz.plot.add-anchor("b", (b.at(0),b.at(1)))
          cetz.plot.add-anchor("L", (diff_ba.at(0),diff_ba.at(1)))

          for (i, z) in vecs.enumerate() {
            cetz.plot.add-anchor(str(i), (z.at(0), z.at(1)))
          }
          
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        
        cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
        cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.01)

        cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
        cetz.draw.content("line.end", text(blue)[$accent(b, arrow)$], anchor: "west", padding: 0.025)
        
        cetz.draw.line("plot.o", "plot.L", stroke: green, mark: (fill: green), name: "line")
        cetz.draw.content("line.end", text(green)[$accent(b, arrow) - accent(a, arrow)$], anchor: "east", padding: 0.03)
        
        for (i, z) in vecs.enumerate() {
          cetz.draw.line("plot.L", "plot." + str(i), stroke: purple, mark: (fill: purple), name: "line")
        }
    })
  ]
]

Generalization



$
P_1 = vec(x_1, x_2, dots.v, x_n) quad quad quad P_2 = vec(x_1, x_2, dots.v, x_n)
$

$
L = P_1 + t (P_1 - P_2) | t in RR
$

#eg[

  #let p1 = (-1, 2, 7)
  #let p2 = (0, 3, 4)

  #let p1_vec = $vec(#str(p1.at(0)), #str(p1.at(1)))$
  #let p2_vec = $vec(#str(p2.at(0)), #str(p2.at(1)))$

  #let p1_minus_p2 = $vec(#str(p1.at(0) - p2.at(0)), #str(p1.at(1) - p2.at(1)))$
  #let p2_minus_p1 = $vec(#str(p2.at(0) - p1.at(0)), #str(p2.at(1) - p1.at(1)))$

  $
  accent(P_1, arrow) = #p1_vec quad quad quad accent(P_2, arrow) = #p2_vec
  $

  $
  accent(P_1, arrow) - accent(P_2, arrow) = #p1_minus_p2
  $

  - $L$ starts at $P_1$ and moves toward $P_2$ as $t$ decreases
  $
  L &= P_1 + t (P_1 - P_2) = #p1_vec + t #p1_minus_p2
  $

  $
  x &= -1 + t (-1) \
  y &= 2 + t (-1) \
  $

  - $L$ starts at $P_2$ and moves toward $P_1$ as $t$ increases

  $
  L = P_2 + t (P_1 - P_2) = #p2_vec + t #p1_minus_p2
  $

  $
  x &= 0 + t (-1) \
  y &= 3 + t (-1) \
  $

  - $L$ starts at $P_1$ and moves toward $P_2$ as $t$ increases
  
  $
  L = P_1 + t (P_2 - P_1) = #p1_vec + t #p2_minus_p1
  $

  $
  x &= -1 + t (1) \
  y &= 2 + t (1) \
  $

  - $L$  starts at $P_2$ and moves toward $P_1$ as $t$ decreases
  
  $
  L = P_2 + t (P_2 - P_1) = #p2_vec + t #p2_minus_p1
  $

  $
  x &= 0 + t (1) \
  y &= 3 + t (1) \
  $

  #let line1_x(t) = -1 + t * (-1)
  #let line1_y(t) = 2 + t * (-1)

  #let line2_x(t) = 0 + t * (-1)
  #let line2_y(t) = 3 + t * (-1)

  #let line3_x(t) = -1 + t * (1)
  #let line3_y(t) = 2 + t * (1)

  #let line4_x(t) = 0 + t * (1)
  #let line4_y(t) = 3 + t * (1)

// P_1 t + P_2 (1-t)
  #let line_luis_1_x(t) = ( -1 ) * t  + ( 0 ) * (1-t)
  #let line_luis_1_y(t) = ( 2 ) * t  + ( 3 ) * (1-t)

  #let line_luis_2_x(t) = ( 0 ) * t  + ( -1 ) * (1-t)
  #let line_luis_2_y(t) = ( 3 ) * t  + ( 2 ) * (1-t)


  #align(center)[
    #cetz.canvas(length: 10cm, {
      cetz.plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -3,
        y-min: -3,
        x-max: 3,
        y-max: 3,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        { 
          cetz.plot.add(
            (t) => (line1_x(t), line1_y(t)),
            domain: (-0.25,0),
          )
          cetz.plot.add(
            (t) => (line2_x(t), line2_y(t)),
            domain: (0,0.25),
          )
          cetz.plot.add(
            (t) => (line3_x(t), line3_y(t)),
            domain: (0.25,0.5),
          )
          cetz.plot.add(
            (t) => (line4_x(t), line4_y(t)),
            domain: (-0.25,-0.5),
          )
        }, name: "plot")
    })
  ]
  
]

== Vector Spaces

#eg[
Let's say your factory can produce up to 300 units of product 1, 500 units of product 2, and 400 units of product 3. The set of all possible production combinations forms a vector space:

$
x = vec(x_1, x_2, x_3) \

0 ≤ x_1 ≤ 300 \

0 ≤ x_2 ≤ 500 \

0 ≤ x_3 ≤ 400 \
$

]

