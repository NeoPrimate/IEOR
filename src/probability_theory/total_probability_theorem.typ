#import "/lib/imports.typ": *

== Total Probability Theorem

Let $B_1, B_2, dots, B_n$ be a partition of the sample space $Omega$, meaning:

1.	$B_i inter B_j = emptyset forall i eq.not j$ (disjoint)

2.	$inter.big_(i=1)^n B_i = Omega$ (cover the whole space)

Then for any event A:

$
  P(A) 
  &= sum_(i=1)^n P(A inter B_i) \
  &= sum_(i=1)^n P(A | B_i) P(B_i)
$

The total probability theorem arises by breaking an event into pieces using a partition, and each piece is expressed using the multiplication rule, which itself comes from the definition of conditional probability.

1. Conditional Probability:

$
  P(A | B) = P(A inter B) / P(B)
$

2. Multiplication Rule

$
  P(A inter B) = P(A | B) P(B)
$

3. Total Probability Theorem

$
  P(A) = sum_(i=1)^n P(A | B_i) P(B_i)
$
    