#table(
  columns: 2,
  inset: 1em,
  align: center + horizon,
  
  table.cell(
    rowspan: 3,
    [Axioms]
  ),
  [$P(A) ≥ 0$],
  [$P(Omega) = 1$],
  [
    $
      "If" A inter B = emptyset \
      P(A union B) = P(A) + P(B)
    $
  ],

  [], [$P(A) lt.eq 1$],
  [], [$P(emptyset) = 0$],
  [Compliment\ Rule], [$P(A) + P(A^c) = 1$],
  [], [$P(A^c) = 1 - P(A)$],
  [], [],
  [], [],
  [Union Bound], [$P(A union B) lt.eq P(A) + P(B)$],
  [Discrete\ Uniform Law], [$P(A) = k 1/n$],
  [Finite Additivity\ 
  *Disjoint Events*], 
  [
    $
      P(union.big^n_(i=1) A_i) = sum^n_(i=1) P(A_i) 
    $
  ],
  [Countable Additivity\ 
  *Disjoint Events*], 
  [
    $
      P(union.big_i^infinity A_i) = sum_(i=1)^infinity P(A_i)
    $
  ],
table.cell(
  rowspan: 2,
  [De Morgan\ Laws]
),
[
  $
    (inter.big_n S_n)^c = union.big_n S_n^c
  $
],
[
  $
    (union.big_n S_n)^c = inter.big_n S_n^c
  $
],
  [Bonferroni\ Inequality], [
    $
      P(S inter T) gt.eq P(S) + P(T) - 1
    $
  ],
  [Monotonicity], [$A subset.eq B arrow.long.double P(A) lt.eq P(B)$],
  [], [],
  table.cell(
    rowspan: 2,
    [Continuity of\ Probability]
  ),
  [
    $
      A_1 subset.eq A_2 subset.eq dots 
      arrow.long.double 
      P(union.big_(n) A_n) = lim_(n arrow infinity) P(A_n)
    $
  ],
  [
    $
      A_1 supset.eq A_2 supset.eq dots and P(A_1)< infinity 
      \
      arrow.long.double 
      \
      P(union.big_(n) A_n)= lim_(n arrow infinity) P(A_n)
    $
  ],

  [Conditional\ probability], 
  [
    $
      P(A | B) = P(A inter B) / P(B)
    $
  ],
  [Multiplication\ Rule], [$P(A inter B) = P(A | B) P(B)$],
  [Law of\ total probability], [
    $
      P(A) = sum_i P(A | B_i) P(B_i)
    $
  ],
  [Beyes'\ Theorem], [
    $
      P(B_j | A) = (P(A | B_j) P(B_j)) / (sum_i P(A | B_i)P(B_i))
    $
  ],
  [], [],
  [], [],
)
