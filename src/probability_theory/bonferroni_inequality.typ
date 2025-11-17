#import "../utils/proof.typ": proof
#import "../utils/color_math.typ": colorMath

== Bonferroni Inequality

1. Two Sets

$
  P(S inter T) gt.eq P(S) + P(T) - 1
$

#proof(title: [Bonferroni Inequality (2 Sets)])[
  1. Start with *union bound*:

  $
    P(A^c union B^c) lt.eq P(A^c) + P(B^c)
  $

  2. And *De Morgan's Law*:

  $
    A^c union B^c = (A inter B)^c
  $

  3. Rewrite all terms in terms of probabilities of $A$ and $B$:

  $
    P(A^c) = 1 - P(A) 
    quad quad 
    P(B^c) = 1 - P(B)
  $

  Insert into the union bound:

  $
    P((A inter B)^c) lt.eq (1 - P(A)) + (1 - P(B))
  $

  4. Use complement again:

  $
    1 - P(A inter B) lt.eq 2 - P(A) - P(B)
  $

  5. Rearrange:

  $
    P(A inter B) gt.eq P(A) + P(B) - 1
  $
]

2. $n$ Sets

$
  colorMath(P(inter.big_(i=1)^n A_i), #red) &gt.eq  colorMath(sum_(i=1)^n A_i, #blue) colorMath(- (n - 1), #green)
  \ \
  colorMath(P(A_1, inter dots inter A_n), #red) &gt.eq colorMath(P(A_1) + dots + P(A_n), #blue) colorMath(- (n - 1), #green)
$

#proof(title: [Bonferroni Inequality ($n$ Sets)])[

  1. Start with the *union bound*

  $
    P(union.big_(i=1)^n A_i^c) lt.eq sum_(i=1)^n P(A_i^c)
  $

  2. *De Morgan's Law*

  $
    union.big_(i=1)^n A_i^c = (inter.big_(i=1)^n A_i)^c
  $

  So we can rewrite the LHS as:

  $
    P((inter.big_(i=1)^n A_i)^c)
  $

  3. Rewrite each complement probability

  For each $i$:
  
  $
    P(A_i^c) = 1 - P(A_i)
  $

  Thus:

  $
    P((inter.big_(i=1)^n A_i)^c) lt.eq sum_(i=1)^n (1 - P(A_i))
  $

  4. Use the complement relation $P(E^c) = 1-P(E)$
  
  $
    1 - P(inter.big_(i=1)^n A_i) lt.eq n - sum_(i=1)^n P(A_i)
  $

  5. Rearrange to obtain the lower bound

  Move terms around:

  $
    P(inter.big_(i=1)^n A_n) gt.eq sum_{i=1}^n P(A_i) - (n-1)
  $ 
]

