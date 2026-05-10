#import "/lib/imports.typ": *

#set math.vec(delim: "[")

Given a #link(<linear-algebra-linear-independence>)[linearly independent] set $\{accent(v, arrow)_1, accent(v, arrow)_2, dots, accent(v, arrow)_k\}$, the *Gram–Schmidt process* produces an #link(<linear-algebra-orthogonality>)[orthonormal] set $\{accent(q, arrow)_1, accent(q, arrow)_2, dots, accent(q, arrow)_k\}$ that spans the same subspace.

It "straightens out" the basis: removes the parallel components between successive vectors so they become mutually orthogonal, then normalizes each.

== The algorithm

Process the input vectors one at a time. For each new vector, subtract off its projection onto the orthonormal vectors already built, then normalize.

For $j = 1, 2, dots, k$:

$
  accent(u, arrow)_j = accent(v, arrow)_j - sum_(i=1)^(j-1) (accent(v, arrow)_j dot accent(q, arrow)_i) accent(q, arrow)_i #h(2em) "(subtract projections off the already-orthonormal vectors)"
$

$
  accent(q, arrow)_j = accent(u, arrow)_j / ||accent(u, arrow)_j|| #h(2em) "(normalize)"
$

The first step is just normalization: $accent(q, arrow)_1 = accent(v, arrow)_1 / ||accent(v, arrow)_1||$.

#example[
  $accent(v, arrow)_1 = vec(1, 1, 0)$, $accent(v, arrow)_2 = vec(0, 1, 1)$ in $RR^3$.

  *Step 1*: $accent(q, arrow)_1 = accent(v, arrow)_1 / ||accent(v, arrow)_1|| = 1/sqrt(2) vec(1, 1, 0)$.

  *Step 2*: project $accent(v, arrow)_2$ onto $accent(q, arrow)_1$ and subtract:

  $
    accent(v, arrow)_2 dot accent(q, arrow)_1 = 1/sqrt(2)
  $

  $
    accent(u, arrow)_2 = accent(v, arrow)_2 - 1/sqrt(2) accent(q, arrow)_1 = vec(0, 1, 1) - 1/2 vec(1, 1, 0) = vec(-1/2, 1/2, 1)
  $

  Normalize: $||accent(u, arrow)_2|| = sqrt(1/4 + 1/4 + 1) = sqrt(3/2)$.

  $
    accent(q, arrow)_2 = sqrt(2/3) vec(-1/2, 1/2, 1) = 1/sqrt(6) vec(-1, 1, 2)
  $

  Verify: $accent(q, arrow)_1 dot accent(q, arrow)_2 = 0 #h(0.5em) checkmark$ and $||accent(q, arrow)_1|| = ||accent(q, arrow)_2|| = 1 #h(0.5em) checkmark$.
]

== Why it works

After subtracting the projections, $accent(u, arrow)_j$ is orthogonal to every previously-built $accent(q, arrow)_i$. Inductively, after step $j$, the set $\{accent(q, arrow)_1, dots, accent(q, arrow)_j\}$ is orthonormal and spans the same subspace as $\{accent(v, arrow)_1, dots, accent(v, arrow)_j\}$.

== Numerical instability

Classical Gram–Schmidt (the version above) is *unstable in floating point* — small rounding errors compound, and the computed $accent(q, arrow)_j$'s drift away from being truly orthogonal.

Better alternatives:
- *Modified Gram–Schmidt* — subtract projections one at a time as you go, instead of all at once; much more stable
- *Householder reflections* — used to compute #link(<linear-algebra-qr-decomposition>)[QR] in practice
- *Givens rotations* — for sparse / structured input

For pencil-and-paper or symbolic use, classical Gram–Schmidt is fine. For numerical libraries, Householder is standard.

== Connection to QR

The Gram–Schmidt process is *exactly* the construction behind the #link(<linear-algebra-qr-decomposition>)[QR decomposition]: the orthonormal vectors form $Q$, and the projection coefficients form $R$.

== See also

- *#link(<linear-algebra-orthogonality>)[Orthogonality]*
- *#link(<linear-algebra-projection>)[Projection]*
- *#link(<linear-algebra-qr-decomposition>)[QR Decomposition]*
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
- *#link(<linear-algebra-basis>)[Basis]*
