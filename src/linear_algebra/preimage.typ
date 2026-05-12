#import "/lib/imports.typ": *
#show: formatting



For a transformation $T: RR^n -> RR^m$ and a subset $S subset.eq RR^m$, the *preimage of $S$ under $T$* is the set of inputs that map into $S$:

$
  T^(-1)(S) = { accent(x, arrow) in RR^n | T(accent(x, arrow)) in S }
$

For a single point $accent(y, arrow) in RR^m$, the preimage $T^(-1)(accent(y, arrow))$ may be empty, a single point, or an entire affine subspace — depending on $T$.

#example[
  Let $T: RR^2 -> RR^2$ be defined by $A = mat(2, 0; 0, 3)$, so $T(accent(x, arrow)) = vec(2 x_1, 3 x_2)$.

  *Preimage of $vec(4, 6)$*:

  Solve $A accent(x, arrow) = vec(4, 6)$:

  $
    2 x_1 = 4 #h(0.5em) arrow.r.double #h(0.5em) x_1 = 2 \
    3 x_2 = 6 #h(0.5em) arrow.r.double #h(0.5em) x_2 = 2
  $

  $
    T^(-1)(vec(4, 6)) = {vec(2, 2)}
  $

  *Preimage of $vec(2, 3)$*: similarly $T^(-1)(vec(2, 3)) = {vec(1, 1)}$.

  *Preimage of the set $S = {vec(4, 6), vec(2, 3)}$*:

  $
    T^(-1)(S) = {vec(2, 2), vec(1, 1)}
  $
]

== Properties

- $T^(-1)(emptyset) = emptyset$
- $T^(-1)(RR^m) = RR^n$
- $T^(-1)(S_1 union S_2) = T^(-1)(S_1) union T^(-1)(S_2)$
- $T^(-1)(S_1 inter S_2) = T^(-1)(S_1) inter T^(-1)(S_2)$
- For a linear $T$: $T^(-1)(bold(0))$ is exactly the #link(<linear-algebra-kernel>)[kernel] of $T$
- For linear $T$ and any $accent(y, arrow) in im(T)$: $T^(-1)(accent(y, arrow)) = accent(x, arrow)_p + ker(T)$ for any particular solution $accent(x, arrow)_p$ — an *affine subspace* parallel to the kernel

== Connections

- *#link(<linear-algebra-image>)[Image]* — the forward direction
- *#link(<linear-algebra-image-of-subset>)[Image of a subset]* — applying $T$ to a set rather than $T^(-1)$
- *#link(<linear-algebra-kernel>)[Kernel]* — preimage of the zero vector under a linear map
