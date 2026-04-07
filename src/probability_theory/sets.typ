#import "../utils/examples.typ": eg
#import "../utils/code.typ": code

== Sets

A *set* is a collection of distinct elements

- ${a, b, c, d}$: a finite set

- $RR$: an inifinite set

*Membership*

If $S$ is a set and $x$ is an element of $S$:

$
  x in S
$

If $S$ is a set and $x$ is not an element of $S$:

$
  x in.not S
$

#eg[
  Let $S$ be the set of real numbers whose cosine is greater than $1/2$:

  $
    S = {x in RR: cos(x) > 1/2}
  $
]

*Universal Sets and Complements*

$Omega$: universal set (sample space)

Compliment of a set

$
  x in S^c quad "iff" x in Omega "and" x in.not S
$

Key identities:

$
  (S^c)^c = S
$

$emptyset$: the empty set

$
  Omega^c = emptyset
$

*Subsets*

If set $S$ is a subset of the set $T$:

$
  S subset T
$

This means:

$
  x in S arrow.double x in T
$

*Union*

$
  S union T
$

Membership Rule

$
  x in S union T 
  quad 
  arrow.l.r.double 
  quad
  x in S or x in T
$

*Intersection*

$
  S inter T
$

Membership Rule

$
  x in S inter T 
  quad
  arrow.l.r.double 
  quad
  x in S and x in T
$

=== Inifinite Collection of Sets

Let 

$
  S_n quad n = 1, 2, dots
$

*Countable Union*

$
  x in union.big_n S_n quad "iff" quad x in S_n bold("for some") n
$

*Countable Intersection*

$
  x in inter.big_n S_n quad "iff" quad x in S_n bold("for all") n
$

*Set properties*

#align(center)[
  #grid(
    columns: 2,
    gutter: 3em,
    align: top,
    [
      $
        S union T 
        &= T union S
      $
    ],
    [
      $
        S union (T union U) 
        &= (S union T) union U \
        &= S union T union U\
      $
    ],
    [
      $
        S inter (T union U) 
        &= (S inter T) union (S inter U)
      $
    ],
    [
      $
        S union (T inter U) 
        &= (S union T) inter (S union U)
      $
    ],
    [
      $
        (S^c)^c 
        &= S
      $
    ],
    [
      $
        (S inter S^c) 
        &= emptyset
      $
    ],
    [
      $
        S union Omega 
        &= Omega
      $
    ],
    [
      $
        S inter Omega 
        &= S
      $
    ]
  )
]


