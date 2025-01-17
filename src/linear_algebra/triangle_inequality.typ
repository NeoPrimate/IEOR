#import "../utils/examples.typ": eg

#import "@preview/cetz:0.2.2"

#set math.vec(delim: "[")

=== Vector Triangle Inequality

$
||accent(u, arrow) + accent(v, arrow)|| lt.eq ||accent(u, arrow)|| + ||accent(v, arrow)||
$

// #linebreak()

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
        cetz.plot.add-anchor("a", (-4,4))
        cetz.plot.add-anchor("b", (-6,3))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.mid", text(red)[$||accent(u, arrow)||$], anchor: "south", padding: 0.05, angle: "a.start")

      cetz.draw.line("plot.a", "plot.b", stroke: blue, mark: (fill: blue), name: "a")
      cetz.draw.content("a.mid", text(blue)[$||accent(v, arrow)||$], anchor: "south", padding: 0.05, angle: "a.start")
      
      cetz.draw.line("plot.o", "plot.b", stroke: purple, mark: (fill: purple), name: "a")
      cetz.draw.content("a.mid", text(purple)[$||accent(u, arrow) + accent(v, arrow)||$], anchor: "north", padding: 0.025, angle: "a.start")
  })
]

// #linebreak()

$
||accent(u, arrow) + accent(v, arrow)|| = ||accent(u, arrow)|| + ||accent(v, arrow)||
$

// #linebreak()

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
        cetz.plot.add-anchor("a", (-3,3))
        cetz.plot.add-anchor("b", (-5,5))
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
      cetz.draw.content("a.mid", text(red)[$||accent(u, arrow)||$], anchor: "south", padding: 0.05, angle: "a.start")

      cetz.draw.line("plot.a", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
      cetz.draw.content("b.mid", text(blue)[$||accent(v, arrow)||$], anchor: "south", padding: 0.05, angle: "b.start")
      
      cetz.draw.line("plot.o", "plot.b", stroke: 0pt, mark: (fill: none), name: "c")
      cetz.draw.content("c.mid", text(purple)[$||accent(u, arrow) + accent(v, arrow)||$], anchor: "north", padding: 0.05, angle: "c.start")
  })
]

// #linebreak()

$
accent(u, arrow) = c accent(v, arrow) quad quad c gt 0
$