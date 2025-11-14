#import "@preview/cetz:0.4.2" 

== Probability Axioms

- Event: subset of the sample space
  - Probability is assigned to an event

We carry out the experiment, once we observe the outcome of the experiment, either the outcome is in the set $A$ (event A has occurred), or it is not in the set $A$ (event A has not occurred)

#align(center)[
  #cetz.canvas({
    import cetz.draw: * 

    // grid((0,0), (5,3), help-lines: true)
    
    rect((0, 0), (5, 3), name: "sample_space")

    content((5-0.5, 3-0.5), $ Omega $)

    circle((1.5,1.5), name: "A", radius: (1, 0.75), fill: blue.transparentize(80%), stroke: color.blue + 2pt)
    content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))

    circle((1, 1.5), name: "event_1", radius: 0.1, fill: red)
    circle((4, 1), name: "event_2", radius: 0.1, fill: red)
  })
]





=== Non-Negativity

Probability of any event cannot be negative

$
P(A) ≥ 0
$

=== Normalization

The probability of the sample space is always 1

$
P(Omega) = 1
$

=== (Finite) Additivity

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
    ]
  )
]


#align(center)[
  #cetz.canvas({
    import cetz.draw: * 

    // grid((0,0), (5,3), help-lines: true)
    
    rect((0, 0), (5, 3), name: "sample_space")

    content((5-0.5, 3-0.5), $ Omega $)

    circle((1.5,2), name: "A", radius: (1, 0.75), fill: blue.transparentize(80%), stroke: color.blue + 2pt)
    content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
    
    circle((3.5,1), name: "B", radius: (1, 0.75), fill: red.transparentize(80%), stroke: color.red + 2pt)
    content((3.5, 1), $ B $, anchor: "center", padding: (x: 0, y: 0))
  })
]