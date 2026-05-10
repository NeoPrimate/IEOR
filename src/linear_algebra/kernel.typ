#import "/lib/imports.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")

For a #link(<linear-algebra-linear-transformation>)[linear transformation] $T: RR^n -> RR^m$, the *kernel* (or *null space* of $T$) is the set of vectors that map to the zero vector:

$
  ker(T) = { accent(x, arrow) in RR^n | T(accent(x, arrow)) = bold(0) }
$

The kernel is the #link(<linear-algebra-preimage>)[preimage] of $bold(0)$.

== Why the kernel is a subspace

For any $accent(x, arrow), accent(y, arrow) in ker(T)$ and scalar $c$:

- $T(accent(x, arrow) + accent(y, arrow)) = T(accent(x, arrow)) + T(accent(y, arrow)) = bold(0) + bold(0) = bold(0)$ → closed under addition
- $T(c #h(0.2em) accent(x, arrow)) = c #h(0.2em) T(accent(x, arrow)) = c #h(0.2em) bold(0) = bold(0)$ → closed under scalar multiplication
- $bold(0) in ker(T)$ since $T(bold(0)) = bold(0)$

Hence $ker(T)$ is a #link(<linear-algebra-subspace>)[subspace] of $RR^n$.

== Matrix form: kernel ↔ null space

If $T$ is represented by a matrix $A$ (so $T(accent(x, arrow)) = A accent(x, arrow)$), the kernel of $T$ equals the #link(<linear-algebra-null-space>)[null space] of $A$:

$
  ker(T) = "null"(A) = { accent(x, arrow) | A accent(x, arrow) = bold(0) }
$

#example[
  Let $T: RR^2 -> RR^2$ with $A = mat(2, 0; 0, 3)$. Solve $A accent(x, arrow) = bold(0)$:

  $
    2 x_1 = 0 #h(0.5em) arrow.r.double #h(0.5em) x_1 = 0 \
    3 x_2 = 0 #h(0.5em) arrow.r.double #h(0.5em) x_2 = 0
  $

  Only the trivial solution: $ker(T) = {bold(0)}$. The transformation is *injective*.
]

== Injectivity

A linear transformation $T$ is *injective* (one-to-one) if and only if $ker(T) = {bold(0)}$.

Proof sketch: if $T(accent(x, arrow)_1) = T(accent(x, arrow)_2)$, then $T(accent(x, arrow)_1 - accent(x, arrow)_2) = bold(0)$, so $accent(x, arrow)_1 - accent(x, arrow)_2 in ker(T)$. The kernel being trivial forces $accent(x, arrow)_1 = accent(x, arrow)_2$.

== Connections

- *#link(<linear-algebra-null-space>)[Null Space]* — kernel of the matrix representation
- *#link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity]*: $dim(ker(T)) + dim(im(T)) = n$
- *#link(<linear-algebra-image>)[Image]* — the "output side" counterpart
- *#link(<linear-algebra-preimage>)[Preimage]* — generalization to non-zero target sets
- *#link(<linear-algebra-zero-matrix>)[Zero Vector]* — what kernel elements map to
