#import "/lib/imports.typ": *

== Sample Space

A probability model begins with two tasks:

1.	Specify the set of all possible *outcomes*

2.	Specify beliefs about how *likely* each outcome is

The Sample Space

- The sample space, denoted by $Omega$, is the set of all possible outcomes of an experiment

- The elements of $Omega$, called outcomes, must satisfy:

  - *Mutually exclusivity*: No two distinct outcomes can occur simultaneously

  - *Collective exhaustiveness*: Every possible result of the experiment must be included in $Omega$

#align(center)[
  #canvas({
    import cetz.draw: * 
    rect((0, 0), (5, 3), name: "sample_space")
    content((5-0.5, 3-0.5), $ Omega $, anchor: "south-west", padding: (x: 0, y: 0))
  })
]