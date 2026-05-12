#import "/lib/imports.typ": *
#show: formatting

For a function $f: X -> Y$, the *domain* is the set $X$ of inputs.

$
  X = "domain"(f) = "set of all valid inputs"
$

For a #link(<linear-algebra-linear-transformation>)[linear transformation] $T: RR^n -> RR^m$, the domain is $RR^n$.

== Domain vs codomain vs image

- *Domain* — where the inputs live ($X$)
- *#link(<linear-algebra-codomain>)[Codomain]* — where outputs are *allowed* to live ($Y$)
- *#link(<linear-algebra-image>)[Image / Range]* — where outputs *actually* land (a subset of the codomain)

#example[
  $f(x) = x^2$ from $RR$ to $RR$:

  - Domain: $RR$
  - Codomain: $RR$
  - Image: $[0, infinity)$ — only non-negative outputs

  The image is a strict subset of the codomain (negatives like $-3$ are in the codomain but not the image).
]

== For matrices

If $T(accent(x, arrow)) = A accent(x, arrow)$ with $A$ an $m times n$ matrix, then:

- Domain = $RR^n$ (number of *columns* of $A$)
- Codomain = $RR^m$ (number of *rows* of $A$)
- #link(<linear-algebra-image>)[Image] = #link(<linear-algebra-column-space>)[column space] of $A$ ⊆ $RR^m$

== See also

- *#link(<linear-algebra-codomain>)[Codomain]*
- *#link(<linear-algebra-image>)[Image]* — what lands in the codomain
- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]*
