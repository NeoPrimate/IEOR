#import "/lib/imports.typ": *
#show: formatting

= Codomain <linear_algebra_codomain>

For a function $f: X -> Y$, the *codomain* is the set $Y$ where outputs are declared to live — though outputs don't necessarily fill it.

$
  Y = "codomain"(f)
$

The actual subset of $Y$ that gets hit by $f$ is the #link(<linear_algebra_image>)[image] (or *range*) — always a subset of the codomain, sometimes strict.

#example[
  $f: RR -> RR$, $f(x) = x^2$.

  - Codomain: $RR$
  - Image: $[0, infinity)$

  Negative reals like $-3$ are in the codomain (they're "allowed" outputs by the type signature) but not in the image (no real $x$ produces them).
]

== Codomain vs image

The choice of codomain is partly conventional. Two functions can be the "same" with different codomains:

$
  f_1: RR -> RR, #h(0.5em) f_1(x) = x^2 \
  f_2: RR -> [0, infinity), #h(0.5em) f_2(x) = x^2
$

$f_2$ is *surjective* (image = codomain); $f_1$ is not.

== For matrices

If $T(accent(x, arrow)) = A accent(x, arrow)$ with $A$ an $m times n$ matrix:

- *Codomain*: $RR^m$ (set by the number of rows)
- *Image*: #link(<linear_algebra_column_space>)[column space] of $A$, generally a subspace of $RR^m$
- *Surjective* iff the columns of $A$ span $RR^m$ — i.e., $"rank"(A) = m$

== See also

- *#link(<linear_algebra_domain>)[Domain]*
- *#link(<linear_algebra_image>)[Image]* / *#link(<linear_algebra_column_space>)[Column Space]*
- *#link(<linear_algebra_surjective_injective_bijective>)[Surjective / Injective / Bijective]*
