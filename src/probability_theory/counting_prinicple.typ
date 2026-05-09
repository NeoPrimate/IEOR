#import "/lib/imports.typ": *

== Counting Principle

Count the total number of possible outcomes in a multi-step process

- The first stage has $n_1$ possible outcomes,
- The second stage has $n_2$ possible outcomes,
- …
- The k-th stage has $n_k$ possible outcomes

then the total number of outcomes is:

$
  n_1 dot n_2 dot dots dot n_k = product_(i=1)^k n_i
$


#align(center)[
  #frame(fletcher.diagram(
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
  ))
]

*Permutations*

Number of $k$-element subsets of a given $n$-element set

$
  binom(n, k) = n! / (k! (n - k)!)
$

Because $0! = 1$:

$
  binom(n, n) = 1
$

$
  binom(n, 0) = 1
$

$
  sum_(k=0)^n binom(n, k) = binom(n, 0) + binom(n, 1) + dots + binom(n, n) = 2^n
$

#table(
  columns: 2,
  inset: 2em,
  [Ordering $n$ elements],
  [
    $
      n!
    $
  ],

  [Ordering $k$ out of $n$],
  [
    $
      P(n,k) = n!/(n-k)!
    $
  ],

  [Choosing and ordering $k$ out of $m$],
  [
    $
      binom(m, k) k!
    $
  ],

  [Number of subsets of $n$],
  [
    $
      2^n
    $
  ],

  [Sequences of length $n$ from $m$ choices],
  [
    $
      m^n
    $
  ],
)

#example[
  Find the probability that 6 rolls of a fair 6-sided die all give different numbers

  $
    P("all different") = "number of favorable outcomes" / "total outcomes"
  $

  - Total outcomes for 6 rolls: $6^6$
  - Favorable outcomes (all numbers different): $6! = 6 dot 5 dot 4 dot 3 dot 2 dot 1$

  Therefore:

  $
    6! / 6^6
  $
]

*Combination*

Definition: Number of $k$-element subsets of a given $n$-element set

$
  binom(n, k)
$

Two ways to construct an *ordered* sequence of $k$ *distinct* items:
- Choose the $k$ items one at a time

$
  n(n-1)(n-2) dots (n - k+1) = n! / (n - k)!
$

- Choose $k$ items, then order them

$
  binom(n, k) k!
$
