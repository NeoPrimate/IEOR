#import "/src/imports.typ": *

== Conditional Probability

Probability of $A$ given that $B$ has occurred

$
  P(A | B) = P(A inter B) / P(B)
$

Note:

$
  P(A | B) gt.eq 0
$

$
  P(A | A) = 1
$

$
  P(Omega | A) = 1
$

Additivity:

$
  P(A union C | B) = P(A | B) + P(C | B)
  \
  "if" A inter C = emptyset
$

$
  P((A union C) inter B) / P(B) & = P((A inter B) union (C inter B)) / P(B) \
                                & = (P(A inter B) + P(C inter B)) / P(B) \
                                & = P(A | B) + P(C | B)
$

#example[

  Event $A$: Airplane is flying above

  Event $B$: Something registers on radar screen

  $
      P(A) & = 0.05 \
    P(A^c) & = 0.95
  $

  #align(center)[
    #diagram(
      node-stroke: .0em,
      spacing: 4em,
      node((0, 0), [], radius: 0em, name: "A"),

      node(
        (0.5, -1),
        [#align(center)[#move(dy: -15pt)[$A$]]],
        radius: 0em,
        stroke: none,
      ),
      node(
        (0.5, 1),
        [#align(center)[#move(dy: 5pt)[$A^c$]]],
        radius: 0em,
        stroke: none,
      ),

      node((2, -1.5), [$A inter B$], radius: 3em),
      node((2, -0.5), [$A inter B^c$], radius: 3em),

      node((2, 0.5), [$A^c inter B$], radius: 3em),
      node((2, 1.5), [$A^c inter B^c$], radius: 3em),

      edge(
        (0, 0),
        (0.5, -1),
        [$P(A) = 0.05$],
        "-",
        label-pos: 0.5,
        label-side: left,
      ),
      edge(
        (0, 0),
        (0.5, 1),
        [$P(A^c) = 0.95$],
        "-",
        label-pos: 0.5,
        label-side: right,
      ),

      edge(
        (0.5, -1),
        (2, -1.5),
        [$0.99$],
        "-",
        label-pos: 0.5,
        label-side: left,
      ),
      edge(
        (0.5, -1),
        (2, -0.5),
        [$0.01$],
        "-",
        label-pos: 0.5,
        label-side: right,
      ),

      edge(
        (0.5, 1),
        (2, 0.5),
        [$0.10$],
        "-",
        label-pos: 0.5,
        label-side: left,
      ),
      edge(
        (0.5, 1),
        (2, 1.5),
        [$0.90$],
        "-",
        label-pos: 0.5,
        label-side: right,
      ),
    )
  ]

  $
    P(A inter B) = P(A) dot P(B | A) = 0.05 dot 0.99
  $

  $
    P(B) = 0.05 dot 0.99 + 0.95 dot 0.10
  $

  $
    P(A | B) & = P(A inter B) / P(B) \
             & = (0.05 dot 0.99) / (0.05 dot 0.99 + 0.95 dot 0.10)
  $
]
