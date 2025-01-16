#import "../../../utils/examples.typ": eg
#import "../../../utils/result.typ": result

#import "@preview/cetz:0.2.2"

#set math.vec(delim: "[")

=== Plane in $RR^3$

Plane: Each point $(x, y, z)$ on the satifies the equation

$
a x + b y + c y = d
$

Normal Vector: vector that is perpendicular (orthogonal) to a plane, line, or curve, at a specific point

1. *Plane*

If a plane is defined by the equation $a x + b y + c z = d$, the vector $accent(n, arrow) = angle.l a, b, c angle.r$ is a normal vector to the plane because it is perpendicular to any vector that lies in the plane

#align(center)[
  #cetz.canvas(length: 6cm, {
    cetz.plot.plot(
      x-tick-step: none,
      y-tick-step: none,
      x-minor-tick-step: none,
      y-minor-tick-step: none,
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
        cetz.plot.add-anchor("a", (-3,3))
        cetz.plot.add-anchor("b", (3,3))
        cetz.plot.add-anchor("p", (3,7))
        
        cetz.plot.add-anchor("p1", (-8,3))
        cetz.plot.add-anchor("p2", (8,3))
        
      }, name: "plot")
      
      
      cetz.draw.line("plot.p1", "plot.p2", stroke: black, mark: (fill: black), name: "a")
      cetz.draw.content("a.end", text(black)[plane], anchor: "south", padding: 0.025, angle: "a.end")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: green, mark: (fill: green), name: "a")
      cetz.draw.content("a.mid", text(green)[$accent(x, arrow)$], anchor: "north", padding: 0.025, angle: "a.mid")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.mid", text(blue)[$accent(x_0, arrow)$], anchor: "north", padding: 0.025, angle: "b.mid")
      
      cetz.draw.line("plot.b", "plot.a", stroke: red, mark: (fill: red), name: "c")
      cetz.draw.content("c.mid", text(red)[$accent(x, arrow) - accent(x_0, arrow)$], anchor: "south", padding: 0.025, angle: "c.mid")
      
      cetz.draw.line("plot.b", "plot.p", stroke: purple, mark: (fill: purple), name: "p")
      cetz.draw.content("p.mid", text(purple)[$accent(n, arrow)$], anchor: "west", padding: 0.025, angle: "p.mid")

      cetz.angle.right-angle("p.start", "a.end", "p.end", radius: 0.05)

  })
]

$
#text(green)[$accent(x, arrow) = vec(x, y, z)$] quad quad 
#text(blue)[$accent(x_0, arrow) = vec(x_0, y_0, z_0)$] quad quad 
#text(purple)[$accent(n, arrow) = vec(n_1, n_2, n_3)$] 
\ \ \
#text(red)[$accent(x, arrow) - accent(x_0, arrow) = vec(
  #text(blue)[$x$] - #text(green)[$x_0$],
  #text(blue)[$y$] - #text(green)[$y_0$],
  #text(blue)[$z$] - #text(green)[$z_0$],
)$] \
$

#text(red)[$accent(x, arrow) - accent(x_0, arrow)$] is a vector that lies on the plane, then $accent(n, arrow)$ is normal if:

$
#text(purple)[$accent(n, arrow)$] dot #text(red)[$accent(x, arrow) - accent(x_0, arrow)$] = 0
$

$
#text(purple)[$vec(n_1, n_2, n_3)$] dot #text(red)[$vec(
  #text(blue)[$x$] - #text(green)[$x_0$],
  #text(blue)[$y$] - #text(green)[$y_0$],
  #text(blue)[$z$] - #text(green)[$z_0$],
)$] = 0
$

$
#result[
$
n_1 (x - x_0) + n_2 (y - y_0) + n_3 (z - z_0) = 0
$
]
$

#eg[

  Find the equation of the plane given the point on the plane #text(blue)[$accent(x_0, arrow)$] and a the normal vector #text(purple)[$accent(n, arrow)$]

  $
  #text(purple)[$accent(n, arrow) = vec(1, 3, -2)$] quad quad 
  #text(blue)[$accent(x_0, arrow) = vec(1, 2, 3)$] quad quad
  #text(green)[$accent(x, arrow) = vec(x, y, z)$]
  $

  $
  #text(green)[$accent(x, arrow)$] - #text(blue)[$accent(x_0, arrow)$] = vec(
    #text(green)[$x$] - #text(blue)[$1$], 
    #text(green)[$y$] - #text(blue)[$2$], 
    #text(green)[$z$] - #text(blue)[$3$],
  )
  $

  $
  #text(purple)[$vec(1, 3, -2)$] dot vec(
    #text(green)[$x$] - #text(blue)[$1$], 
    #text(green)[$y$] - #text(blue)[$2$], 
    #text(green)[$z$] - #text(blue)[$3$],
  ) = 0
  $

  $
  (x - 1) + 3 (y - 2) - 2 (z - 3) = 0 \ 
  x - 1 + 3y cancel(- 6) -2z cancel(+ 6) = 0 \
  x + 3 y - 2 z = 1 \

  $
]

#align(center)[
  #cetz.canvas(length: 6cm, {
    cetz.plot.plot(
      x-tick-step: none,
      y-tick-step: none,
      x-minor-tick-step: none,
      y-minor-tick-step: none,
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
        cetz.plot.add-anchor("a", (-3,3))
        cetz.plot.add-anchor("b", (3,3))
        cetz.plot.add-anchor("p", (3,7))
        
        cetz.plot.add-anchor("p1", (-8,3))
        cetz.plot.add-anchor("p2", (8,3))
        
      }, name: "plot")
      
      
      cetz.draw.line("plot.p1", "plot.p2", stroke: black, mark: (fill: black), name: "a")
      cetz.draw.content("a.end", text(black)[plane], anchor: "south", padding: 0.025, angle: "a.end")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: green, mark: (fill: green), name: "a")
      cetz.draw.content("a.mid", text(green)[$accent(x, arrow)$], anchor: "north", padding: 0.025, angle: "a.mid")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.mid", text(blue)[$accent(x_0, arrow)$], anchor: "north", padding: 0.025, angle: "b.mid")
      
      cetz.draw.line("plot.b", "plot.a", stroke: red, mark: (fill: red), name: "c")
      cetz.draw.content("c.mid", text(red)[$accent(x, arrow) - accent(x_0, arrow)$], anchor: "south", padding: 0.025, angle: "c.mid")
      
      cetz.draw.line("plot.b", "plot.p", stroke: purple, mark: (fill: purple), name: "p")
      cetz.draw.content("p.mid", text(purple)[$accent(n, arrow)$], anchor: "west", padding: 0.025, angle: "p.mid")

      cetz.angle.right-angle("p.start", "a.end", "p.end", radius: 0.05)

  })
]

The normal vector to a plane can be directly obtained from the coefficients of $x$, $y$, and $z$ in the plane equation of the form:

$
A x + B y + C z = D
$

$
accent(n, arrow) = vec(A, B, C)
$

#eg[
  Find the equation of the normal vector #text(purple)[$accent(n, arrow)$] given the equation for the plane:

  $
  -3 x + sqrt(2) y + 7 z = pi \ 
  #text(purple)[$accent(n, arrow)$] = -3 hat(i) + sqrt(2) hat(j) + 7 hat(k) \ 
  #text(purple)[$accent(n, arrow)$] = vec(-3, sqrt(2), 7) \ 
  $
]

2. *Curve*

For a curve described by a function $y = f(x)$, the normal vector at a point on the curve is perpendicular to the tangent line at that point. If the tangent vector has slope $f'(x)$, the normal vector will have a slope of $- 1 / (f'(x))$

=== Point Distance to Plane

$
#result[
  $
  d &= (A x_0 + B y_0 + C z_0 - D) / sqrt(A^2 + B^2 + C^2)
  $
]
$

#eg[
  Given a the equation of the plane:

  $
  1 x - 2 y + 3 z = 5
  $

  And a point *not* on the plane:

  $
  (2, 3, 1)
  $

  Find the shortest path (normal vector) from the plane to the point

  $
  d &= (A x_0 + B y_0 + C z_0 - D) / sqrt(A^2 + B^2 + C^2) \ 

  &= (1 dot 2 - 2 dot 3 + 3 dot 1 - 5) / sqrt(1^2 + 2^2 + 3^2) \

  &= (2 - 6 + 3 - 5) / sqrt(1 + 4 + 9) \

  & = - 6 / sqrt(14)
  $


]

=== Distance Between Planes





