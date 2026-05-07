#import "/lib/imports.typ": *

== Independence

Two events are said to be independent if the occurrence of one event does not change our beliefs about the other

Events A and B are independent from each other if:

$
  P(A inter B) = P(A) dot P(B)
$

Implies:
 
$
  P(B | A) = P(B) \
  P(A | B) = P(A)
$

Applies even if $P(A) = 0$

== Independence of Complements

If A and B are independent, then the following pairs are also independent:

- $A$ and $B^c$
- $A^c$ and $B$
- $A^c$ and $B^c$

Formally:

If

$
  P(A inter B) = P(A) P(B)
$

then:

$
  P(A inter B^c) &= P(A)P(B^c) \
  P(A^c inter B) &= P(A^c)P(B) \
  P(A^c inter B^c) &= P(A^c)P(B^c) \
$

#proof[
  Start with:

  $
    A = colorMath((A inter B), #green) union colorMath((A inter B^c), #blue)
  $

  #align(center)[
    #scale(50%)[
      #canvas({
        import cetz.draw: * 

        circle((0,1), name: "A", radius: 3)
        content("A", $ A inter B^c $, anchor: "east", padding: (x: 1, y: 0))
        circle((3,1), name: "B", radius: 3)
        content((5, 4), $ B $, anchor: "west", padding: (x: 0, y: 0))
        
        content((1.5, 1), $ A inter B $, anchor: "center", padding: (x: 0, y: 0))

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
  ]

  Since $(A inter B)$ and $(A inter B^c)$ are disjoint, by the Additivity Axiom:

  $
    P(A) 
    &= P(A inter B) + P(A inter B^c) \
    &= P(A) P(B) + P(A inter B^c) \
  $

  Rearanging:

  $
    P(A inter B^c) 
    &= P(A) - P(A) P(B) \
    &= P(A) (1 - P(B)) \
    &= P(A) P(B^c) \
  $

  Thus we are back at out definition of independence:

  $
    P(A inter B^c) = P(A) P(B^c)
  $
]


== Conditional Independence

$
  P(A inter B | C) = P(A | C) P(B | C)
$

== Pairwise Independence

- *Mutual (collective) independence* $arrow.double$ pairwise independence

  If a collection of events is mutually independent, then every pair of events in the collection is independent.

- *Pairwise independence* $arrow.double$ mutual (collective) independence

  A collection of events can be pairwise independent but not mutually independent.

== Reliability






