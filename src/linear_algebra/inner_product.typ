#import "/lib/imports.typ": *



An *inner product* is a function $⟨ dot, dot ⟩: V times V -> RR$ that generalizes the #link(<linear-algebra-dot-product>)[dot product] to arbitrary vector spaces.

== Axioms

For all $accent(u, arrow), accent(v, arrow), accent(w, arrow) in V$ and scalar $c in RR$:

1. *Symmetry*: $⟨ accent(u, arrow), accent(v, arrow) ⟩ = ⟨ accent(v, arrow), accent(u, arrow) ⟩$
2. *Linearity in the first argument*:
$
  ⟨ c accent(u, arrow) + accent(w, arrow), accent(v, arrow) ⟩ = c ⟨ accent(u, arrow), accent(v, arrow) ⟩ + ⟨ accent(w, arrow), accent(v, arrow) ⟩
$
(by symmetry, also linear in the second argument)
3. *Positive-definiteness*: $⟨ accent(v, arrow), accent(v, arrow) ⟩ >= 0$, with equality only when $accent(v, arrow) = bold(0)$

A vector space with an inner product is an *inner product space*.

== Standard examples

*Dot product on $RR^n$*: $⟨ accent(u, arrow), accent(v, arrow) ⟩ = sum_(i=1)^n u_i v_i = accent(u, arrow)^T accent(v, arrow)$

*Weighted inner product*: $⟨ accent(u, arrow), accent(v, arrow) ⟩_W = accent(u, arrow)^T W accent(v, arrow)$ where $W$ is symmetric positive-definite

*Function space inner product* (continuous functions on $[a, b]$):
$
  ⟨ f, g ⟩ = integral_a^b f(x) g(x) #h(0.1em) d x
$

*Frobenius inner product on matrices*:
$
  ⟨ A, B ⟩_F = "tr"(A^T B) = sum_(i, j) A_(i j) B_(i j)
$

== Induced norm

Every inner product induces a #link(<linear-algebra-norm>)[norm]:

$
  ||accent(v, arrow)|| = sqrt(⟨ accent(v, arrow), accent(v, arrow) ⟩)
$

This norm satisfies the parallelogram law $||accent(u, arrow) + accent(v, arrow)||^2 + ||accent(u, arrow) - accent(v, arrow)||^2 = 2 ||accent(u, arrow)||^2 + 2 ||accent(v, arrow)||^2$ — a necessary and sufficient condition for a norm to come from an inner product.

== Cauchy–Schwarz (general form)

The #link(<linear-algebra-cauchy-schwarz-inequality>)[Cauchy–Schwarz inequality] holds in every inner product space:

$
  |⟨ accent(u, arrow), accent(v, arrow) ⟩| <= ||accent(u, arrow)|| #h(0.2em) ||accent(v, arrow)||
$

== Orthogonality

Two vectors are *orthogonal* if their inner product is zero:

$
  accent(u, arrow) perp accent(v, arrow) #h(0.5em) arrow.l.r.double #h(0.5em) ⟨ accent(u, arrow), accent(v, arrow) ⟩ = 0
$

This generalizes perpendicularity in $RR^n$. See #link(<linear-algebra-orthogonality>)[Orthogonality].

== Angle between vectors

$
  cos theta = (⟨ accent(u, arrow), accent(v, arrow) ⟩) / (||accent(u, arrow)|| #h(0.2em) ||accent(v, arrow)||)
$

In abstract spaces this *defines* the angle (between non-zero vectors).

== Why inner products matter

- *Generalize geometry* (length, angle, projection) to any vector space
- *Function spaces*: e.g., Hilbert spaces in functional analysis use $⟨ f, g ⟩ = integral f g$
- *Quantum mechanics*: state space is a complex inner product space (Hilbert space)
- *Statistics*: covariance is an inner product on centered random variables
- *Machine learning*: kernel methods replace explicit inner products with implicit ones via *kernels*

== See also

- *#link(<linear-algebra-dot-product>)[Dot Product]* — special case in $RR^n$
- *#link(<linear-algebra-norm>)[Norm]* — derived from the inner product
- *#link(<linear-algebra-orthogonality>)[Orthogonality]*
- *#link(<linear-algebra-gram-schmidt>)[Gram–Schmidt Process]* — orthogonalization via inner products
- *#link(<linear-algebra-cauchy-schwarz-inequality>)[Cauchy–Schwarz Inequality]*
