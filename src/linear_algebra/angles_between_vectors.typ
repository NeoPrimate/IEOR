#import "../utils/examples.typ": eg
#import "../utils/result.typ": result

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

#set math.vec(delim: "[")

== Angles Between Vectors

The scalar $||accent(u, arrow)||$ is the length of the vector $accent(u, arrow)$

Say $accent(u, arrow), accent(v, arrow) in RR^n$

#align(center)[

  #let (ax, ay) = (1, 5)
  #let (bx, by) = (6, 1)
  #let (cx, cy) = (ax - bx, ay - by)

  #cetz.canvas(length: 6cm, {
    import cetz.draw: *
    import cetz-plot: *
    plot.plot(
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
        plot.add-anchor("o", (0,0))
        plot.add-anchor("a", (ax,ay))
        plot.add-anchor("b", (bx,by))
        plot.add-anchor("c", (cx,cy))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.end", text(red)[$accent(u, arrow)$], anchor: "south", padding: 0.025, angle: "a.end")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.end", text(blue)[$accent(v, arrow)$], anchor: "south", padding: 0.025, angle: "b.end")
      
      cetz.draw.line("plot.b", "plot.a", stroke: purple, mark: (fill: purple), name: "c")
      cetz.draw.content("c.mid", text(purple)[$accent(u, arrow) - accent(v, arrow)$], anchor: "south", padding: 0.025, angle: "c.start")

      cetz.angle.angle("a.start", "a.end", "b.end", label: $Theta$, radius: 30%, label-radius: 130%, inner: true)
  })

  #linebreak()
  #linebreak()
  
  #cetz.canvas(length: 6cm, {
    import cetz.draw: *
    import cetz-plot: *
    plot.plot(
      x-tick-step: none,
      y-tick-step: none,
      x-minor-tick-step: none,
      y-minor-tick-step: none,
      x-min: -7,
      y-min: -7,
      x-max: 7,
      y-max: 7,
      axis-style: none,
      x-label: $x$,
      y-label: $y$,
      x-grid: "both",
      y-grid: "both",
      {
        plot.add-anchor("o", (0,0))
        plot.add-anchor("a", (ax,ay))
        plot.add-anchor("b", (bx,by))
        plot.add-anchor("c", (cx,cy))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: none, size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.mid", text(red)[$||accent(u, arrow)||$], anchor: "south", padding: 0.05, angle: "a.end")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.mid", text(blue)[$||accent(v, arrow)||$], anchor: "north", padding: 0.05, angle: "b.end")
      
      cetz.draw.line("plot.b", "plot.a", stroke: purple, mark: (fill: purple), name: "c")
      cetz.draw.content("c.mid", text(purple)[$||accent(u, arrow) - accent(v, arrow)||$], anchor: "south", padding: 0.05, angle: "c.start")

      cetz.angle.angle("a.start", "a.end", "b.end", label: $Theta$, radius: 30%, label-radius: 130%, inner: true)
  })
]

Law of Cosines

$
c^2 = a^2 + b^2 - 2 a b dot cos(C) 
$

Where:
- $a$, $b$ and $c$: lengths of the sides of a triangle
- $C$: angle opposite the side $c$

$
||accent(u, arrow) - accent(v, arrow)||^2 &= ||accent(u, arrow)||^2 + ||accent(v, arrow)||^2 - 2 ||accent(u, arrow)|| ||accent(v, arrow)|| dot cos(Theta) \

(accent(u, arrow) - accent(v, arrow)) dot (accent(u, arrow) - accent(v, arrow)) &= \

accent(u, arrow) dot accent(u, arrow) - accent(u, arrow) dot accent(v, arrow) - accent(v, arrow) dot accent(u, arrow) + accent(v, arrow) dot accent(v, arrow) &= \

cancel(||accent(u, arrow)||^2) cancel(- 2) (accent(u, arrow) dot accent(v, arrow)) + cancel(||accent(v, arrow)||) &= cancel(||accent(u, arrow)||^2) + cancel(||accent(v, arrow)||^2) cancel(- 2) ||accent(u, arrow)|| ||accent(v, arrow)|| dot cos(Theta) \
$

$
#result[
  $
  accent(u, arrow) dot accent(v, arrow) &= ||accent(u, arrow)|| ||accent(v, arrow)|| dot cos(Theta)
  $
]
$
$
#result[
  $
  (accent(u, arrow) dot accent(v, arrow)) / (||accent(u, arrow)|| ||accent(v, arrow)||) = cos(Theta)
  $
]
$
$
#result[
  $
  Theta = arccos((accent(a, arrow) dot accent(b, arrow)) / (||accent(a, arrow)|| ||accent(b, arrow)||))
  $
]

$

So, if $accent(u, arrow)$ is a scalar multiple of $accent(v, arrow)$ ($accent(u, arrow) = c accent(v, arrow)$) where $c > 0$, then $Theta = 0 degree$


#align(center)[

  #let (ax, ay) = (3, 3)
  #let (bx, by) = (5, 5)

  #cetz.canvas(length: 5cm, {
    import cetz.draw: *
    import cetz-plot: *
    plot.plot(
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
        plot.add-anchor("o", (0,0))
        plot.add-anchor("a", (ax,ay))
        plot.add-anchor("b", (bx,by))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))


      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.end", text(blue)[$accent(v, arrow)$], anchor: "south", padding: 0.05, angle: "b.end")
      
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.end", text(red)[$accent(u, arrow)$], anchor: "south", padding: 0.05, angle: "a.end")

      // cetz.angle.angle("a.start", "a.end", "b.end", label-radius: 130%, label: $Theta$, radius: 30%, inner: true)
  })
]

And, if $accent(u, arrow)$ is a scalar multiple of $accent(v, arrow)$ ($accent(u, arrow) = c accent(v, arrow)$) where $c < 0$, then $Theta = 180 degree$

#align(center)[

  #let (ax, ay) = (5, 5)
  #let (bx, by) = (-6, -6)

  #cetz.canvas(length: 5cm, {
    import cetz.draw: *
    import cetz-plot: *
    plot.plot(
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
        plot.add-anchor("o", (0,0))
        plot.add-anchor("a", (ax,ay))
        plot.add-anchor("b", (bx,by))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.end", text(red)[$accent(u, arrow)$], anchor: "south", padding: 0.05, angle: "a.end")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.end", text(blue)[$accent(v, arrow)$], anchor: "south", padding: 0.05, angle: "b.end")

      cetz.angle.angle("a.start", "a.end", "b.end", label-radius: 130%, label: $Theta$, radius: 30%, inner: false)
  })
]

$accent(u, arrow)$ and $accent(v, arrow)$ are perpendicular if the angle $Theta$ between them is $90 degree$

$
accent(u, arrow) dot accent(v, arrow) &= ||accent(u, arrow)|| ||accent(v, arrow)|| dot cos(90) \

accent(u, arrow) dot accent(v, arrow) &= 0 \
$

If $accent(u, arrow)$ and $accent(v, arrow)$ are perpendicular, then $accent(u, arrow) dot accent(v, arrow) = 0$

If $accent(u, arrow)$ and $accent(v, arrow)$ are non-zer0 and $accent(u, arrow) dot accent(v, arrow) = 0$, then they are perpendicular

If $accent(u, arrow) dot accent(v, arrow) = 0$ then $accent(u, arrow)$ and $accent(v, arrow)$ are *orthogonal*.

#align(center)[

  #let (ax, ay) = (0, 5)
  #let (bx, by) = (6, 0)

  #cetz.canvas(length: 5cm, {
    import cetz.draw: *
    import cetz-plot: *
    plot.plot(
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
        plot.add-anchor("o", (0,0))
        plot.add-anchor("a", (ax,ay))
        plot.add-anchor("b", (bx,by))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.end", text(red)[$accent(u, arrow)$], anchor: "west", padding: 0.05, angle: "a.end")

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.end", text(blue)[$accent(v, arrow)$], anchor: "south", padding: 0.05, angle: "b.end")

      cetz.angle.angle("a.start", "a.end", "b.end", label-radius: 140%, label: $Theta$, radius: 30%, inner: true)
  })
]