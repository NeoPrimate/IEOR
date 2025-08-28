#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

#set math.vec(delim: "[")
#set math.mat(delim: "[")
#set math.vec(gap: 0.5em)
// #set math.mat(gap: 1em)
#set math.mat(column-gap: 1em, row-gap: 0.5em)

== Input Output Model (Leontief)

$
  bold("A") = mat(
    a_(1 1), a_(1 2), dots, a_(1 n);
    a_(2 1), a_(2 2), dots, a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n);
  )
  quad quad
  bold("x") = vec(x_1, x_2, dots.v, x_n)
  quad quad
  bold("d") = vec(d_1, d_2, dots.v, d_n)
$

Where:
- $a_(i j)$: units of good $i$ needed to produce 1 unit of good $j$
- $bold("x")$: total outputs for each sector
- $bold("d")$: vector of goods used *externally by consumers*
- $bold("A") bold("x")$: vector of goods used *internally in production*

*Technical coefficient*: the amount of input required per unit of output

Balance Equation

Total production = production used as inputs for other sectors+final consumption

$
  bold("x") = bold("A") bold("x") + bold("d")
$

Rewrite the Equation

1. Subtract $bold("A") bold("x")$ from both sides:

$
  bold("x") - bold("A") bold("x") = bold("d")
$

2. Factor out $bold("x")$:

$
  bold("x") (bold("I") - bold("A")) = bold("d")
$

Given final demand $bold("d")$ and input requirements $bold("A")$, what total production $bold("x")$ is needed?

2. Solving for Production

$
  bold("x") = (bold("I") - bold("A"))^(-1) bold("d")
$

This gives exactly how much each sector must produce to satisfy both internal (inputs) and external (final demand) needs.

$(I - A)^(-1)$: Leontief inverse, each element shows the total output needed from sector $i$ per unit of final demand in sector $j$, accounting for indirect effects

#eg[

  - Steel (S)
  - Rubber (R)
  - Chemicals (C)

  #grid(
    columns: (1fr, 1fr),
    row-gutter: 2em,
    column-gutter: 1em,
    align: center,
    [
      #table(
        columns: (auto, auto, auto, auto),
        inset: 0.75em,
        align: left,
        [O / I], [Steel], [Rubber], [Chemicals],
        [Steel], [0.1], [0.2], [0.1],
        [Rubber], [0.1], [0.1], [0.2],
        [Chemicals], [0.2], [0.1], [0.1],
      )
    ],
    [
      #table(
        columns: (auto, auto),
        inset: 0.75em,
        align: left,
        [Resource], [Demand],
        [Steel], [10],
        [Rubber], [20],
        [Chemicals], [30],
      )
    ], 
    [
      $
        bold("A") = mat(
          0.1, 0.2, 0.1;
          0.1, 0.1, 0.2;
          0.2, 0.1, 0.1;
        )
      $
    ],
    [
      $
        bold("d") = vec(10, 20, 30)
      $
    ]
  )

  

  #align(center)[
    #diagram(
      node-inset: 0pt,

      node(pos: (0,0), label: {$S$}, stroke: 0.1em, radius: 1em, name: <s>),
      
      node(pos: (3,0), label: {$R$}, stroke: 0.1em, radius: 1em, name: <r>),
      
      node(pos: (1.5,(3*calc.sqrt(3))/2), label: {$C$}, stroke: 0.1em, radius: 1em, name: <e>),
      
      edge(
        <s>, <r>, 
        "-|>", 
        label: text(size: 10pt)[0.2], 
        label-side: center, 
        label-fill: luma(230),
        bend: 20deg, 
        shift: 0pt,
      ),
      
      edge(
        <r>, <s>, 
        "-|>", 
        label: text(size: 10pt)[0.1], 
        label-side: center, 
        label-fill: luma(230),
        bend: 20deg, 
        shift: 0pt,
      ),
      
      edge(
        <r>, <e>, 
        "-|>", 
        label: text(size: 10pt)[0.2], 
        label-side: center, 
        label-fill: luma(230),
        bend: 20deg, 
        shift: 0pt,
      ),
      
      edge(
        <e>, <r>, 
        "-|>", 
        label: text(size: 10pt)[0.1], 
        label-side: center, 
        label-fill: luma(230),
        bend: 20deg, 
        shift: 0pt,
      ),
      
      edge(
        <e>, <s>, 
        "-|>", 
        label: text(size: 10pt)[0.2], 
        label-side: center, 
        label-fill: luma(230),
        bend: 20deg, 
        shift: 0pt,
      ),
      
      edge(
        <s>, <e>, 
        "-|>", 
        label: text(size: 10pt)[0.1], 
        label-side: center, 
        label-fill: luma(230),
        bend: 20deg, 
        shift: 0pt,
      ),

      edge(
        <s>, <s>, 
        "-|>", 
        label: text(size: 10pt)[0.1], 
        label-side: center, 
        label-fill: luma(230),
        bend: 140deg, 
        shift: 0pt,
      ),
      
      edge(
        <e>, <e>, 
        "-|>", 
        label: text(size: 10pt)[0.1], 
        label-side: center, 
        label-fill: luma(230),
        bend: -140deg, 
        shift: 0pt,
      ),
      
      edge(
        <r>, <r>, 
        "-|>", 
        label: text(size: 10pt)[0.1], 
        label-side: center, 
        label-fill: luma(230),
        bend: 140deg, 
        shift: 0pt,
      ),
    )
  ]

  $
    bold("x") = (bold("I") - bold("A"))^(-1) bold("d") \
    bold("x") = (mat(0, 0, 0; 0, 0, 0; 0, 0, 0;) - mat(0.1, 0.2, 0.1; 0.1, 0.1, 0.2; 0.2, 0.1, 0.1;))^(-1) vec(10, 20, 30) \
    bold("x") = vec(23.42, 34.23, 42.34)
  $

  - Steel ($bold(x_1) = 23.42$): *total units* needed for final demand and as inputs to other sectors
  - Rubber ($bold(x_2) = 34.23$): *total units* for final demand plus inputs to all sectors
  - Chemicals ($bold(x_2) = 42.34$): *total units* including intermediate uses


]

=== Labor

1. Direct Labor

Each sector requires some amount of direct labor to produce a unit of output. Direct labor coefficient:

- $l_k$: hours of labor needed to produce *one unit of good* $j$

2. Indirect Labor

Producing goods often requires inputs from other sectors, which themselves required labor. To account for this:

$
  bold(lambda) = bold("l")(bold("I") - bold("A"))^(-1)
$

- $bold("l")$: vector of direct labor coefficients
- $bold("A")$: input-output matrix
- $bold(lambda)$: *total (direct and indirect) labor required per unit* of each good

Interpretation: $lambda_j$is the total socially necessary labor time embedded in one unit of good $j$

3. Labor as a “Currency”

- People earn labor vouchers corresponding to the hours they work.
- Each good has a price in labor time: $λ_j$ hours per unit.
- If you work $h$ hours, you get $h$ labor vouchers to spend.

Budget constraint for a worker:

$
  sum_j lambda_j c_j lt.eq h
$

Where:
- $c_j$: units of good $j$ the worker wants to consume
- $lambda_j$: labor time required to produce one unit of good $j$ (includes direct and indirect) labor
- $h$: total labor hours the worker has contributed (i.e., the number of labor vouchers they possess)

#eg[
  Suppose:
  - Good 1: $lambda_1 = 2 "hours/unit"$
  - Good 2: $lambda_1 = 5 "hours/unit"$
  - Worker labor: $h = 20 "hours"$

  Constraint:

  $
    2c_1 + 5c_2 lt.eq 20
  $

  - If the worker wants 4 units of Good 1: $2 times 4 = 8 "hours"$
  - Then they could afford at most $(20 - 8) div 5 = 2.4 "units"$ of Good 2

  So their consumption plan is limited by their labor contribution
]

4. Labor Planning

Labor also acts as a constraint for the whole economy:

$
  bold("I") bold("x") lt.eq L
$

Where:
- $bold("x")$: vector of production
- $L$: total labor available in society
- This ensures that planned production doesn’t require more labor than society can provide

