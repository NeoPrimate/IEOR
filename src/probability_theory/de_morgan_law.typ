#import "@preview/cetz:0.4.2" 
#import "../utils/color_math.typ": colorMath
#import "../utils/examples.typ": eg
#import "@preview/modpattern:0.1.0": modpattern

#import "../utils/code.typ": code
#import "@preview/cetz-plot:0.1.3"

#show sym.emptyset: set text(font: "Fira Sans")

== De Morgan's Law

Allows going back and forth between unions and intersections

#align(center)[
  #table(
    columns: 2,
    inset: 2em,
    [
      $
        (inter.big_n S_n)^c = union.big_n S_n^c
      $
    ],
    [
      $
        (union.big_n S_n)^c = inter.big_n S_n^c
      $
    ]
  )
]

1. 

$
  (S inter T)^c = S^c union T^c
$

#let hatched(color) = modpattern(
  (10pt, 10pt),
  std.line(
    start: (0%, 100%), 
    end: (100%, 0%), 
    stroke: color + 0.5pt
  ),
)

#align(center)[
    #cetz.canvas({
    import cetz.draw: * 
    
    rect(
      (0, 0), (5, 5), 
      name: "sample_space", 
    )

    content((5-0.25, 5+0.25), $ Omega $)
    
    rect(
      (0, 0), (5, 2), 
      name: "S", 
      radius: 15pt, 
      fill: blue.lighten(80%), 
      stroke: color.blue + 2pt
    )
    content("S", $ S $, anchor: "west", padding: (x: 0.75, y: 0))

    rect(
      (0, 0), (2, 5), 
      name: "T", 
      radius: 15pt, 
      fill: red.lighten(80%), 
      stroke: color.red + 2pt
    )
    content("T", $ T $, anchor: "south", padding: (x: 0, y: 0.75))

    rect(
      (0, 0), (2, 2), 
      name: "C", 
      radius: (south-west: 15pt), 
      fill: purple.lighten(80%), 
      stroke: color.purple + 2pt
    )
    content("C", $ S inter T $, anchor: "center", padding: (x: 0, y: 0.75))

    
    rect(
      (0, 2), (5, 5), 
      name: "D",
      fill: modpattern(
        (30pt, 30pt),
        std.line(
          start: (0%, 100%), 
          end: (100%, 0%), 
          stroke: blue + 0.5pt
        ),
      ),
      stroke: none
    )

    content("D", $ S^c $, anchor: "center", padding: (x: 0, y: 0), fill: white)
    
    rect(
      (2, 0), (5, 5), 
      name: "E",
      fill: modpattern(
        (30pt, 30pt),
        std.line(
          start: (0%, 0%), 
          end: (100%, 100%), 
          stroke: red + 0.5pt
        ),
      ),
      stroke: none
    )

    content("E", $ T^c $, anchor: "center", padding: (x: 0, y: 0), fill: white)
  })
]

$
  x in (S inter T)^c 
  quad arrow.l.r.double quad 
  x in.not S inter T 
  quad arrow.l.r.double quad 
  cases(
    x in.not S,
    or,
    x in.not T,
  )
  quad arrow.l.r.double quad 
  cases(
    x in S^c,
    or,
    x in T^c,
  )
  quad arrow.l.r.double quad 
  x in S^c union T^c
$

2.

$
  S^c inter T^c = (S union T)^C
$

We start with the first De Morgan's Law:

$
  (S inter T)^c = S^c union T^c
$

and substitute:

$
  S &arrow S^c \
  S^c &arrow S \
  T &arrow T^c \
  T^c &arrow T \
$

to obtain:

$
  (S^c inter T^c)^c = S union T
$

take the compliment of both sides:

$
  ((S^c inter T^c)^c)^c = (S union T)^c
$

since the compliment of a compliment is the set itself:

$
  S^c inter T^c = (S union T)^C
$



