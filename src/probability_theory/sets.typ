== Sets

Collection of distinct elements

- ${a, b, c, d}$: finite
- $RR$: inifinite

If $S$ is a set and $x$ is in $S$:

$
  x in S
$

If $S$ is a set and $x$ is not in $S$:

$
  x in.not S
$

$S$ is the set of real numbers such that the $cos$ of $x$ is greater than $1/2$:

$
  S = {x in RR: cos(x) > 1/2}
$

$Omega$: universal set

Compliment of a set

$x in S^c$ if: 
- $x in Omega$ 
- $x in.not S$

$
  (S^c)^c = S
$

$emptyset$: empty set

$Omega^c = emptyset$

If the set $S$ is a subset of the set $T$:

$
  S subset T
$

- $x in S arrow.double x in T$

Union

$
  S union T
$

- $x in S union T arrow.l.r.double x in S or x in T$

Intersection

$
  S inter T
$

- $x in S inter T arrow.l.r.double x in S and x in T$

=== Inifinite Sets

$
  S_n quad n = 1, 2, dots
$

Union

$
  x in union.big_n S_n "iff" x in S_n bold("for some") n
$

Intersection

$
  x in inter.big_n S_n "iff" x in S_n bold("for all") n
$

Set properties

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


