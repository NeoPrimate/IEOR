#import "../../../utils/examples.typ": eg

#import "@preview/cetz:0.2.2"

#set math.vec(delim: "[")

== Vector Dot Product

$
accent(a, arrow) dot accent(b, arrow) = vec(a_1, a_2, dots.v, a_n) dot vec(b_1, b_2, dots.v, b_n) = a_1 b_1 + a_2 b_2 + dots + a_n b_n
$

=== Magnitude (Length)

$
||accent(a, arrow)|| = sqrt(a_1^2 + a_2^2 + dots + a_n^2)
$

#eg[

  $
  accent(a, arrow) = vec(5, 2)
  $

  $
  ||accent(a, arrow)|| = sqrt(5^2 + 2^2)
  $

  #align(center)[
    #cetz.canvas(length: 7cm, {
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
          cetz.plot.add-anchor("a", (5,2))
          
          cetz.plot.add-anchor("b", (5,0))
          cetz.plot.add-anchor("c", (5,2))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: ">", size: .25)))
        cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "a")
        cetz.draw.content("a.mid", text(red)[$sqrt(5^2 + 2^2)$], anchor: "south", padding: 0.05, angle: "a.end")

        cetz.draw.set-style(line: (mark: (symbol: ">", size: .25)))
        cetz.draw.line("plot.o", "plot.b", stroke: green, mark: (fill: green), name: "a")
        cetz.draw.content("a.mid", text(green)[$5$], anchor: "south", padding: 0.025)
        cetz.draw.line("plot.b", "plot.c", stroke: blue, mark: (fill: blue), name: "a")
        cetz.draw.content("a.mid", text(blue)[$2$], anchor: "west", padding: 0.025)
    })
  ]
]

$
accent(a, arrow) dot accent(a, arrow) = vec(a_1, a_2, dots.v, a_n) dot vec(a_1, a_2, dots.v, a_n) = a_1^2 + a_2^2 + dots + a_n^2
$

$
||accent(a, arrow)|| = sqrt(accent(a, arrow) dot accent(a, arrow))
$

$
||accent(a, arrow)||^2 = accent(a, arrow) dot accent(a, arrow)
$

=== Properties

==== Commutative

$
accent(v, arrow) dot accent(w, arrow) = accent(w, arrow) dot accent(v, arrow)
$

==== Distributive

$
(accent(v, arrow) + accent(w, arrow)) dot accent(x, arrow) = accent(v, arrow) dot accent(x, arrow) + accent(w, arrow) dot accent(x, arrow)
$

==== Associativity

$
(c accent(v, arrow)) dot accent(w, arrow) = c (accent(v, arrow) dot accent(w, arrow))
$