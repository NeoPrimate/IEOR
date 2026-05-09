#import "/lib/imports.typ": *

#show math.equation: set text(5pt)
#set text(size: 7pt)

#table(
  columns: 3,
  inset: 1em,
  align: center + horizon,
  
  [Non-negativity],
  [$P(A) ≥ 0$],
   [],

  [Normalization],
  [$P(Omega) = 1$],
   [],

  [Addition Rule\ (Disjoint)],
  [
    $
      inter.big_(i=1)^n A_i = emptyset 
      \
      arrow.double 
      \
      P(union.big_(i=1)^n A_i) = sum_(i=1)^n P(A_i)
    $
  ],
   [],

  // [Addition Rule\ (General)], [
  //   $
  //     P(union.big_(i=1)^n A_i) = sum_(i=1)^n P(A_i) - P(inter.big_(i=1)^n A_i)
  //   $
  // ],
  // [],
  [], [], [],
  [Union], [
    $
      union.big_(i=1)^n A_i    
    $
  ], [
    #frame(cetz.canvas(
      length: 0.5cm,
      {
        import cetz.draw: * 

        circle((1,1), name: "A", radius: 1)
        content("A", $ A $, anchor: "east", padding: (x: 0.5, y: 0))
        circle((2,1), name: "B", radius: 1)
        content("B", $ B $, anchor: "west", padding: (x: 0.5, y: 0))
        intersections("i", "A", "B")
        merge-path(
          stroke: color.blue + 1.5pt,
          fill: color.blue.transparentize(80%),
          close: true,
          {
            arc-through("i.0", "A.west", "i.1")
            arc-through("i.1", "B.east", "i.0")
          }
        )
      }
    ))
  ],

  [Intersection], [
    $
      inter.big_(i=1)^n A_i
    $
  ], [
    #frame(cetz.canvas(
      length: 0.5cm,
      {
        import cetz.draw: * 
        
        circle((1,1), name: "A", radius: 1)
        content("A", $ A $, anchor: "east", padding: (x: 0.5, y: 0))
        circle((2,1), name: "B", radius: 1)
        content("B", $ B $, anchor: "west", padding: (x: 0.5, y: 0))
        intersections("i", "A", "B")
        merge-path(
          stroke: color.red + 1.5pt,
          fill: color.red.transparentize(80%),
          close: true,
          {
            arc-through("i.0", "A.east", "i.1")
            arc-through("i.1", "B.west", "i.0")
          }
        )
      }
    ))
  ],
  [Empty set], [$P(emptyset) = 0$], [],
  [Disjoint\ (Mutually Exclusive)], [$A inter B = emptyset$], [
    #frame(cetz.canvas(
      length: 0.5cm,
      {
        import cetz.draw: * 
        circle((1,1), name: "A", radius: 1, fill: blue.transparentize(80%), stroke: color.blue + 1.5pt)
        content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
        circle((3.5,1), name: "B", radius: 1, fill: red.transparentize(80%), stroke: color.red + 1.5pt)
        content("B", $ B $, anchor: "center", padding: (x: 0, y: 0))
      }
    ))
  ],



  [], [], [],
  [Probability Bound], [$0 lt.eq P(A) lt.eq 1$], [],
  [], [], [],
  [Compliment], [$A^c$], [
    #align(center)[
      #frame(cetz.canvas(
        length: 0.5cm,
        {
          import cetz.draw: * 
          
          rect((0, 0), (5, 3), name: "sample_space", fill: gray.transparentize(80%), stroke: color.black + 1.5pt)
          content((3.5, 1.5), $ A^c $)

          content((5-0.25, 3+0.25), $ Omega $)

          circle((1.5,1.5), name: "A", radius: (1, 0.75), fill: blue.lighten(80%), stroke: color.blue + 1.5pt)
          content("A", $ A $, anchor: "center", padding: (x: 0, y: 0))
        }
      ))
    ]
  ],
  [Compliment\ Rule], [
    $
      P(A) + P(A^c) &= 1 \
      P(A^c) &= 1 - P(A)
    $
  ], [],

  [], [], [],

  [Commutative Law\ (Union)], [
    $
      S union T 
      &= T union S
    $
  ], [],
    [Associative Law\ (Union)], [
    $
      S union (T union U) 
      &= (S union T) union U \
      &= S union T union U\
    $
  ], [],
    [Distributive Law\ (Intersection over Union)],[
    $
      S inter (T union U) 
      &= (S inter T) union (S inter U)
    $
  ], [],
    [Distributive Law\ (Union over Intersection)],[
    $
      S union (T inter U) 
      &= (S union T) inter (S union U)
    $
  ], [],
    [Involution\ (Complement of a Complement)],[
    $
      (S^c)^c 
      &= S
    $
  ], [],
    [Complement Law\ (Disjointedness)],[
    $
      (S inter S^c) 
      &= emptyset
    $
  ], [],
    [Identity Law\ (Union with Universal Set)],[
    $
      S union Omega 
      &= Omega
    $
  ], [],
    [Identity Law\ (Intersection with Universal Set)],[
    $
      S inter Omega 
      &= S
    $
  ], [],

  [], [], [],
  [], [], [],
  [], [], [],

  [Independence], [
    Two processes are independent if knowing the outcome of one provides *no useful information*
about the outcome of the other
  ], [],
  [], [], [],
  [Union Bound], [$P(A union B) lt.eq P(A) + P(B)$], [],
  [Discrete\ Uniform Law], [$P(A) = k 1/n$], [],

  [Finite Additivity\ 
  *Disjoint Events*], 
  [
    $
      P(union.big^n_(i=1) A_i) = sum^n_(i=1) P(A_i) 
    $
  ], [],

  [Countable Additivity\ 
  *Disjoint Events*], 
  [
    $
      P(union.big_i^infinity A_i) = sum_(i=1)^infinity P(A_i)
    $
  ], [],

table.cell(
  rowspan: 2,
  [De Morgan\ Laws]
),
[
  $
    (inter.big_n S_n)^c = union.big_n S_n^c
  $
], [],

[
  $
    (union.big_n S_n)^c = inter.big_n S_n^c
  $
], [],

  [Bonferroni\ Inequality], [
    $
      P(inter_(i=1)^n A_i) gt.eq sum_(i=1)^n P(A_i) - (n-1)
    $
  ], [
    $
      P(S inter T) gt.eq P(S) + P(T) - 1
    $
  ],

  [Monotonicity], [$A subset.eq B arrow.long.double P(A) lt.eq P(B)$],
  [],
  table.cell(
    rowspan: 2,
    [Continuity of\ Probability]
  ),
  [
    $
      A_1 subset.eq A_2 subset.eq dots 
      \
      arrow.double 
      \
      P(union.big_(n=1)^infinity A_n) = lim_(n arrow infinity) P(A_n)
    $
  ], [],
  [
    $
      A_1 supset.eq A_2 supset.eq dots
      \
      arrow.double 
      \
      P(inter.big_(n=1)^infinity A_n)= lim_(n arrow infinity) P(A_n)
    $
  ], [],

  [Conditional\ probability], 
  [
    $
      P(A | B) = P(A inter B) / P(B)
    $
  ], [],

  [Multiplication\ Rule\ (Independent)], [
    $
      P(inter.big_(i=1)^n A_i) = product_(i=1)^n P(A_i)
    $
  ], [],

  [Law of\ Total Probability], [
    $
      P(A) = sum_i P(A | B_i) P(B_i)
    $
  ], [],

  [Beyes'\ Theorem], [
    $
      P(B_j | A) = (P(A | B_j) P(B_j)) / (sum_(i=1)^n P(A | B_i)P(B_i))
    $
  ], [],
  [], [], [],
  [], [], [],
  [Independence], [
    $
      P(inter.big_(i=1)^n A_i) = product_(i=1)^n P(A_i)
    $
  ], [
    $
      P(A inter B) = P(A) dot P(B)
    $
  ],
  [Complement\ Independence], [
    For any $B_i in {A_i, A_i^c}$,

    $
      P(inter.big_(i=1)^n A_i) = product_(i=1)^n P(A_i)
    $
  ], [
    If

    $
      P(A inter B) = P(A)P(B)
    $

    then:

    $
      P(A inter B^c) &= P(A)P(B^c) \
      P(A^c inter B) &= P(A^c)P(B) \
      P(A^c inter B^c) &= P(A^c)P(B^c) \
    $
  ],
  [Conditional\ Independence], [
    $
      P(inter.big_(i=1)^n A_i | C) = product_(i=1)^n P(A_i | C)
    $
  ], [
    $
      P(A inter B | C) = P(A | C) P(B | C)
    $
  ],
  [], [], [],
  [], [], [],
  [Expected\ Value\ (Discrete)], [
    $
      E(X) = sum_(i=1)^k x_i P(X = x_i)
    $
  ], [],
  [Expected\ Value\ (Continuous)], [
    $
      E(X) = integral_(-infinity)^infinity x f_X (x) d x    
    $
  ], [],
  [Variance\ (Discrete)], [
    $
      "Var"(X) 
      &= E[(X - E(X))^2] \
      &= sum_(i=1)^(k) (x_i - E(X))^2 P(X = x_i)
    $
  ], [],
  [Variance\ (Continuous)], [
    $
      "Var"(X) 
      &= E[(X - E(X))^2] \
      &= integral_(-infinity)^infinity (x - E(X))^2 f_X (x) d x
    $
  ], [],
  [], [], [],
  [], [], [],

  [Linear\ Combination], [
    $
      sum_(i=1)^(n) a_i X_i
    $
  ], [
    $
      a_1 X_1 + a_2 X_2 + dots + a_n X_n
    $
  ],

  [Expected Value\ of Linear Combination], [
    $
      E(sum_(i=1)^(n) a_i X_i) = sum_(i=1)^(n) a_i E(X_i)
    $
  ], [
    $
      E(a_1 X_1 + x_2 X_2 + dots a_n X_n)\ = a_1 E(X_1) + a_2 E(X_2) + dots + a_n E(X_n)
    $
  ],

  [Variance\ (Independent)\ of Linear Combination], [
    $
      "Var"(sum_(i=1)^(n) a_i X_i) = sum_(i=1)^(n) a_i^2 "Var"(X_i)
    $
  ], [],
  [Variance\ (Dependent)\ of Linear Combination], [
    $
      "Var"(sum_(i=1)^(n) a_i X_i) = sum_(i=1)^(n) a_i^2 "Var"(X_i) + 2 sum_(1 lt.eq i < j lt.eq n) a_i a_j "Cov"(X_i, X_j)
    $
  ], [],
)

