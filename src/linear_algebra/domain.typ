#import "/lib/imports.typ": *
#show: formatting

= Domain <linear_algebra_domain>

For a function $f: X -> Y$, the *domain* is the set $X$ of inputs.

$
  X = "domain"(f) = "set of all valid inputs"
$

For a #link(<linear_algebra_linear_transformation>)[linear transformation] $T: RR^n -> RR^m$, the domain is $RR^n$.

== Domain vs codomain vs image

- *Domain* — where the inputs live ($X$)
- *#link(<linear_algebra_codomain>)[Codomain]* — where outputs are *allowed* to live ($Y$)
- *#link(<linear_algebra_image>)[Image / Range]* — where outputs *actually* land (a subset of the codomain)

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
- #link(<linear_algebra_image>)[Image] = #link(<linear_algebra_column_space>)[column space] of $A$ ⊆ $RR^m$

== See also

- *#link(<linear_algebra_codomain>)[Codomain]*
- *#link(<linear_algebra_image>)[Image]* — what lands in the codomain
- *#link(<linear_algebra_linear_transformation>)[Linear Transformation]*
