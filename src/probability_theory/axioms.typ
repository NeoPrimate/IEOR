#import "@preview/cetz:0.4.2" 
#import "../utils/color_math.typ": colorMath
#import "../utils/examples.typ": eg

#import "../utils/code.typ": code
#import "@preview/cetz-plot:0.1.3"

#show sym.emptyset: set text(font: "Fira Sans")

== Probability Axioms

- Event: subset of the sample space
  - Probability is assigned to an event

We carry out the experiment, once we observe the outcome of the experiment, either the outcome is in the set $A$ (event A has occurred), or it is not in the set $A$ (event A has not occurred)

#align(center)[
  #cetz.canvas({
    import cetz.draw: * 

    // grid((0,0), (5,3), help-lines: true)
    
    rect((0, 0), (5, 3), name: "sample_space")

    content((5-0.25, 3+0.25), $ Omega $)

    circle((1.5,1.5), name: "A", radius: (1, 0.75), fill: blue.transparentize(80%), stroke: color.blue + 2pt)
    content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))

    circle((1, 1.5), name: "event_1", radius: 0.1, fill: red)
    circle((4, 1), name: "event_2", radius: 0.1, fill: red)
  })
]

=== Non-Negativity Axiom

Probability of any event cannot be negative

$
P(A) ≥ 0
$

=== Normalization Axiom

The probability of the sample space is always 1

$
P(Omega) = 1
$

=== (Finite) Additivity Axiom

If two events are mutually exclusive (cannot happen at the same time), the probability of either occurring is the sum of their individual probabilities

$
  "If" A inter B = emptyset \
  P(A union B) = P(A) + P(B)
$


#align(center)[
  #grid(
    columns: 2,
    inset: 1em,
    align: center + horizon,
    stroke: black + 1pt,
    [
      $A inter B$
    ],
    [
      #cetz.canvas({
        import cetz.draw: * 
        // grid((0,0), (3,2), help-lines: true)

        circle((1,1), name: "A", radius: 1)
        content("A", $ A $, anchor: "east", padding: (x: 0.5, y: 0))
        circle((2,1), name: "B", radius: 1)
        content("B", $ B $, anchor: "west", padding: (x: 0.5, y: 0))

        intersections("i", "A", "B")

        merge-path(
          stroke: color.red + 2pt,
          fill: color.red.transparentize(80%),
          close: true,
          {
            arc-through("i.0", "A.east", "i.1")
            arc-through("i.1", "B.west", "i.0")
          }
        )

      })
    ],
    [
      $A union B$
    ],
    [
      #cetz.canvas({
        import cetz.draw: * 
        // grid((0,0), (3,2), help-lines: true)

        circle((1,1), name: "A", radius: 1)
        content("A", $ A $, anchor: "east", padding: (x: 0.5, y: 0))
        circle((2,1), name: "B", radius: 1)
        content("B", $ B $, anchor: "west", padding: (x: 0.5, y: 0))

        intersections("i", "A", "B")

        merge-path(
          stroke: color.blue + 2pt,
          fill: color.blue.transparentize(80%),
          close: true,
          {
            arc-through("i.0", "A.west", "i.1")
            arc-through("i.1", "B.east", "i.0")
          }
        )

      })
    ],
    [
      $A inter B = emptyset$
    ],
    [
      #cetz.canvas({
        import cetz.draw: * 
        // grid((0,0), (3,2), help-lines: true)

        circle((1,1), name: "A", radius: 1, fill: blue.transparentize(80%), stroke: color.blue + 2pt)
        content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
        circle((3.5,1), name: "B", radius: 1, fill: red.transparentize(80%), stroke: color.red + 2pt)
        content("B", $ B $, anchor: "center", padding: (x: 0, y: 0))

      })
    ],
    [
      $A^c$
    ],
    [
      #align(center)[
        #cetz.canvas({
        import cetz.draw: * 

        // grid((0,0), (5,3), help-lines: true)
        
        rect((0, 0), (5, 3), name: "sample_space", fill: red.transparentize(80%), stroke: color.red + 2pt)
        content((3.5, 1.5), $ A^c $)

        content((5-0.25, 3+0.25), $ Omega $)

        circle((1.5,1.5), name: "A", radius: (1, 0.75), fill: blue.lighten(80%), stroke: color.blue + 2pt)
        content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
      })
    ]
    ]
  )
]

Derived from axioms:

=== $P(A) lt.eq 1$

$
  A union A^c = Omega \
  A inter A^c = emptyset \
$

$
  1 
  &=^((b)) P(Omega) = P(A union A^c) \
  &=^((c)) P(A) + P(A^c) \
$

$
  P(A) = 1 - P(A^c) lt.eq^((a)) 1
$



=== $P(emptyset) = 0$

$
  1 
  &= P(Omega) + P(Omega^c) \
  &= 1 + P(emptyset) 
  quad arrow.double quad 
  P(emptyset) = 0
$

=== $P(A) + P(A^c) = 1$

=== Proability of Disjoint Events

We want to show:

$
  P(A union B union C) 
  &= P(A) + P(B) + P(C)
$

#align(center)[
    #cetz.canvas({
    import cetz.draw: * 

    // grid((0,0), (5,3), help-lines: true)
    
    rect((0, 0), (5, 4), name: "sample_space")

    content((5-0.25, 4+0.25), $ Omega $)

    circle((1.5,3), name: "A", radius: (1, 0.75), fill: blue.lighten(80%), stroke: color.blue + 2pt)
    content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
    
    circle((1.5,1), name: "B", radius: (1, 0.75), fill: red.lighten(80%), stroke: color.red + 2pt)
    content("B", $ B $, anchor: "center", padding: (x: 0, y: 0))
    
    circle((3.75,2), name: "C", radius: (1, 0.75), fill: green.lighten(80%), stroke: color.green + 2pt)
    content("C", $ C $, anchor: "center", padding: (x: 0, y: 0))
  })
]

From (Finite) Additivity, we have:

$
  P(A union B) 
  &= P(A) + P(B) \
$

So,

$
  P(A union B union C) 
  &= P((A union B) union C) \
  &= P(A union B) + P(C) \
  &= P(A) + P(B) + P(C) \
$


 
 
 #align(center)[
    #cetz.canvas({
    import cetz.draw: * 

    // grid((0,0), (5,3), help-lines: true)
    
    rect((0, 0), (5, 4), name: "sample_space")

    content((5-0.25, 4+0.25), $ Omega $)

    circle((1.5,3), name: "A", radius: (1, 0.75), fill: blue.lighten(80%), stroke: color.blue + 2pt)
    content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
    
    circle((1.5,1), name: "B", radius: (1, 0.75), fill: blue.lighten(80%), stroke: color.blue + 2pt)
    content("B", $ B $, anchor: "center", padding: (x: 0, y: 0))
    
    circle((3.75,2), name: "C", radius: (1, 0.75), fill: green.lighten(80%), stroke: color.green + 2pt)
    content("C", $ C $, anchor: "center", padding: (x: 0, y: 0))
  })
]

More generally, by induction:

$
  P(union.big^n_(i=1) A_i) = sum^n_(i=1) P(A_i) 
  quad quad
  A_i inter A_j = emptyset, 
  quad 
  "for" i eq.not j
$

=== If $A subset B$ then $P(A) lt.eq P(B)$

#let pat = tiling(size: (10pt, 10pt))[
  #place(line(start: (0%, 100%), end: (100%, 0%), stroke: 2pt + green))
]

#align(center)[
    #cetz.canvas({
    import cetz.draw: * 
    
    rect(
      (0, 0), (5, 3), 
      name: "sample_space", 
    )

    content((5-0.25, 3+0.25), $ Omega $)

    circle((1.5,1.5), name: "B", radius: (1.35, 1.35), fill: pat, stroke: none)
    
    circle((1.5,1.5), name: "B", radius: (1.35, 1.35), fill: red.transparentize(80%), stroke: color.red + 2pt)
    content("B", $ B $, anchor: "south", padding: (x: 0, y: 0.75))

    circle((1.5,1.05), name: "A", radius: (1, 0.75), fill: blue.lighten(80%), stroke: color.blue + 2pt)
    content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
    
    
  })
]

$
  colorMath(B, #blue) = colorMath(A, #red) union colorMath((B inter A^c), #green) \
  P(B) = P(A) + P(B inter A^c) gt.eq P(A)
$


=== $P(A union B) = P(A) + P(B) = P(A inter B)$

#align(center)[
  #cetz.canvas({
    import cetz.draw: * 
    // grid((0,0), (3,2), help-lines: true)

    circle((0,1), name: "A", radius: 3)
    content("A", $ P(A inter B^c) $, anchor: "east", padding: (x: 0.5, y: 0))
    circle((3,1), name: "B", radius: 3)
    content("B", $ P(B inter A^c) $, anchor: "west", padding: (x: 0.5, y: 0))
    
    content((1.5, 1), $ P(A inter B) $, anchor: "center", padding: (x: 0, y: 0))

    intersections("i", "A", "B")

    merge-path(
      stroke: color.blue + 2pt,
      fill: color.blue.transparentize(80%),
      close: true,
      {
        arc-through("i.0", "A.west", "i.1")
        arc-through("i.1", "B.west", "i.0")
      }
    )

    merge-path(
      stroke: color.red + 2pt,
      fill: color.red.transparentize(80%),
      close: true,
      {
        arc-through("i.0", "A.east", "i.1")
        arc-through("i.1", "B.east", "i.0")
      }
    )
    
    merge-path(
      stroke: color.green + 2pt,
      fill: color.green.transparentize(80%),
      close: true,
      {
        arc-through("i.0", "A.east", "i.1")
        arc-through("i.1", "B.west", "i.0")
      }
    )

  })
]

$
  P(A union B) = 
  colorMath(P(A inter B^c), #blue) + 
  colorMath(P(A inter B), #green) + 
  colorMath(P(B inter A^c), #red)
$

$
  P(A) + P(B) - P(A inter B) 
  &= 
  (colorMath(P(A inter B^c), #blue) + 
  colorMath(P(A inter B), #green)) +
  (cancel(colorMath(P(A inter B), #green)) + colorMath(P(B inter A^c), #red)) 
  cancel(- colorMath(P(A inter B), #green)) \
  &= 
  colorMath(P(A inter B^c), #blue) + 
  colorMath(P(A inter B), #green) + 
  colorMath(P(B inter A^c), #red)) 
$

=== Union Bound

$
  P(A union B) lt.eq P(A) + P(B)
$

Since $P(A inter B) gt.eq 0$

=== Union of more than two overlapping (non disjoint) sets

$
  P(A union B union C) 
  =
  P(A) + P(A^c inter B) + P(A^c inter B^c inter C) 
$

#align(center)[
  #cetz.canvas({
    import cetz.draw: * 
    // grid((0,0), (3,2), help-lines: true)

    circle((0,1), name: "A", radius: 3)
    content("A", $ A $, anchor: "south-east", padding: (x: 1, y: 1))
    
    circle((3,1), name: "B", radius: 3)
    content("B", $ B $, anchor: "south-west", padding: (x: 1, y: 1))

    circle((1.5,-1.5), name: "C", radius: 3)
    content("C", $ C $, anchor: "north", padding: (x: 0.5, y: 2))

    intersections("i1", "A", "B")
    intersections("i2", "A", "C")
    intersections("i3", "B", "C")

    merge-path(
      stroke: color.blue + 2pt,
      fill: color.blue.transparentize(80%),
      close: true,
      {
        arc-through("i1.0", "A.west", "i1.1")
        arc-through("i1.1", "A.east", "i1.0")
      }
    )

    merge-path(
      stroke: color.red + 2pt,
      fill: color.red.transparentize(80%),
      close: true,
      {
        arc-through("i1.0", "A.east", "i1.1")
        arc-through("i1.1", "B.east", "i1.0")
      }
    )
    
    merge-path(
      stroke: color.green + 2pt,
      fill: color.green.transparentize(80%),
      close: true,
      {
        arc-through("i2.0", "A.south", "i1.0")
        arc-through("i1.0", "B.south", "i3.1")
        arc-through("i3.1", "C.south", "i2.0")
      }
    )

  })
]

$
  A union B union C 
  &= colorMath(A, #blue) union colorMath(B inter A^c, #red) union colorMath(C inter A^c inter B^c, #green) \
  
  P(A union B union C) 
  &= colorMath(P(A), #blue) + colorMath(P(B inter A^c), #red) + colorMath(P(C inter A^c inter B^c), #green) \

$

== Discrete Uniform Law

- Assume $Omega$ consists of $n$ equally likely elements
- Assume $A$ consists of $k$ elements

$
  P(A) = k 1/n
$

== Probability Calculations Steps

- Specify a sample space
- Specify a probability law
- Identify an event of interest
- Calculate

Discrete but inifinite sample space

#eg[
   Number of coin tosses until we observe a heads toss

   Sample Space

  $
    Omega = {1, 2, ..., infinity }
  $

  We are given $P(n) = 1 / (2^n), quad n = 1, 2, dots$

  
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let n = 5
      let f(n) = 1 / (calc.pow(2, n))

      plot.plot(
        size: (7, 7),
        axis-style: "school-book",
        x-tick-step: 1,
        x-min: 0.,
        x-max: 5.,
        y-tick-step: 0.1,
        y-min: 0.,
        y-max: .6,
        legend: none,
        label: none,
        {
          for k in range(1, n+1) {
            plot.add-vline(
              k,
              max: f(k),
              style: (stroke: (paint: black))
            )
          }

          plot.add(
            range(1, n+1).map(k => (k, f(k))), 
            mark: "o",
            domain: (0, 5), 
            style: (stroke: none),
            mark-style: (fill: gray, stroke: 1pt),
          )

          for k in range(1, n+1) {
            plot.annotate(
              {
                content(
                  (k, f(k)),
                  $1 / #calc.pow(2, k)$,
                  anchor: "east",
                  padding: 0.1,
                )
              }
            )
          }
        }
      )
    })
  ]

  $
    sum^infinity_(n=1) 1 / (2^n) = 1/2 sum^infinity_(n=0) 1/2^n = 1/2 dot 1/(1-(1/2)) = 1
  $

  $
    P("outcome is even") 
    &= P({2, 4, dots}) \
    &= P({2} union {4} union dots) \
    &= P(2) + P(4) + dots \
    &= 1/2^2 + 1/2^4 + dots \
    & 1/4 (1 + 1/4 + 1/4^2 + dots) \
    &= 1/4 dot 1 / (1 - 1/4) \
    &= 1/3
  $
]

=== *Countable Additivity* Axiom

If $a_1, A_2, A_3 dots$ is an infinite *sequence* of *disjoint* events, then $P(A_1 union A_2 union A_3 dots) = P(A_1) + P(A_2) + P(A_3) + dots$


$
  P(union.big^infinity_(i=1) A_i) = sum^infinity_(i=1) P(A_i)
  quad quad
  A_i inter A_j = emptyset, 
  quad 
  "for" i eq.not j
$

- Additivity holds only for "countable" sequences of events
  - The unit square (or real line) if *not countable*

