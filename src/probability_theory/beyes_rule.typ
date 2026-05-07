#import "/lib/imports.typ": *

== Beyes' Rule

$
  P(A | B) = (P(B | A) P(A)) / P(B)
$

Start with the multiplication rule in both directions:

$
  P(A inter B) = P(A) P(B | A) \
  P(A inter B) = P(B) P(A | B) \
$

Set them equal:

$
  P(A) P(B | A) = P(B) P(A | B)
$

Solve for $P(A | B)$:

$
  P(A | B) = (P(B | A) P(A)) / P(B)
$

So Bayes' Rule is the multiplication rule rearranged.

#line(length: 100%)

Start: Definition of conditional probability

$
  P(A_i | B) = (P(A_i inter B)) / P(B)
$

1. *Numerator*: $P(A_i inter B)$ (Multiplication Rule)

Using the multiplication rule:

$
  P(A_i inter B) = P(A_i) P(B | A_i)
$

This expresses the joint probability as _prior_ $times$ _likelihood_

So the numerator comes directly from multiplying:
- prior $P(A_i)$
- likelihood $P(B | A_i)$

2. *Denominator*: $P(B)$ (Total Probability Theorem)

If $A_1, dots, A_n$ form a partition, then the total probability theorem gives:

$
  P(B) = sum_(j=1)^n P(B | A_j) P(A_j)
$

This decomposes the probability of the “evidence” $B$ into all possible scenarios $A_j$

3. Put numerator & denominator together

Substitute both results into the definition:

$
  P(A_i | B) = (P(A_i) P(B | A_i)) /
  (sum_(j=1)^n P(B | A_j) P(A_j))
$

#align(center)[
  #canvas({
    import cetz.draw: *

    rect((0, 0), (10, 5))

    content((10 - 0.25, 5 + 0.25), $ Omega $)

    circle((5, 2.5), name: "A", radius: (4, 2), fill: blue.lighten(80%), stroke: color.blue + 2pt)

    rect((0, 0), (5, 5))
    content((0 + 0.5, 5 - 0.5), $ A_1 $, anchor: "center", padding: (x: 0, y: 0))

    rect((5, 0), (10, 2.5))
    content((10 - 0.5, 5 - 0.5), $ A_2 $, anchor: "center", padding: (x: 0, y: 0))

    rect((5, 5), (10, 2.5))
    content((10 - 0.5, 0 + 0.5), $ A_3 $, anchor: "center", padding: (x: 0, y: 0))

    content((3., 2.5), $ A_1 inter B $, anchor: "center", padding: (x: 0, y: 0))
    content((6.5, 3.5), $ A_2 inter B $, anchor: "center", padding: (x: 0, y: 0))
    content((6.5, 1.5), $ A_3 inter B $, anchor: "center", padding: (x: 0, y: 0))
  })
]


*Interpretation*

- Numerator: how strongly scenario $A_i$ explains the evidence $B$ (_likelihood $times$ prior_)
- Denominator: total probability of seeing the evidence at all (_sum of all scenario contributions_)

So Bayes' Rule is literally:

$
  "Posterior" = ("Likelihood" times "Prior") /
  "Total Evidence"
$

#example[
  Identifying Source of a Defective Part

  A company sources a critical component from three suppliers:

  - Supplier A_1: 50% of parts

  - Supplier A_2: 30% of parts

  - Supplier A_3: 20% of parts

  Each supplier has a different defect rate:

  - $P(B | A_1) = 0.01$

  - $P(B | A_2) = 0.03$

  - $P(B | A_3) = 0.05$

  Here:

  - $A_i$: part comes from supplier i

  - $B$: part is defective

  *1. Total Probability Theorem*: What is the overall defect rate?

  We compute

  $
    P(B) = sum_(i=1)^3 P(B | A_i) P(A_i)
  $

  Plug in numbers:

  $
    P(B) & = 0.01(0.50) + 0.03(0.30) + 0.05(0.20) \
         & = 0.005 + 0.009 + 0.010 = 0.024 \
  $

  Overall defect rate = 2.4%

  *2. Multiplication Rule*: Joint probability from each supplier

  - Supplier 1:

  $
    P(A_1 inter B) & = P(A_1) P(B | A_1) \
                   & = 0.50 times 0.01 \
                   & = 0.005 \
  $

  - Supplier 2:

  $
    P(A_2 inter B) & = P(A_2) P(B | A_2) \
                   & = 0.30 times 0.03 \
                   & = 0.009 \
  $

  - Supplier 3:

  $
    P(A_3 inter B) & = P(A_3) P(B | A_3) \
                   & = 0.20 times 0.08 \
                   & = 0.016 \
  $

  This term appears in the numerator of Bayes' Rule.

  *3. Bayes' Rule*: If a part is defective, what is the probability it came from supplier 3?

  $
    P(A_3 | B) = (P(A_3) P(B | A_3)) / P(B)
  $

  Substitute:

  $
    P(A_3 | B) & = (0.20 dot 0.05) / 0.024 \
               & = 0.010 / 0.024 \
               & approx 0.4167
  $

  About a 41.7% chance the defective part came from supplier 3.

  Even though supplier 3 supplies only 20% of parts, it becomes the most likely source of a defect because its defect rate is highest.
]
