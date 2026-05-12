#import "/lib/imports.typ": *
#show: formatting



Two vectors $accent(u, arrow), accent(v, arrow)$ are *orthogonal* (written $accent(u, arrow) perp accent(v, arrow)$) if their #link(<linear-algebra-dot-product>)[dot product] is zero:

$
  accent(u, arrow) perp accent(v, arrow) #h(0.5em) arrow.l.r.double #h(0.5em) accent(u, arrow) dot accent(v, arrow) = 0
$

In $RR^2$ and $RR^3$, this is the same as *perpendicular*. In higher dimensions or abstract #link(<linear-algebra-inner-product>)[inner product spaces], orthogonality generalizes the notion.

== Orthogonal sets and orthonormal sets

A set $\{accent(v, arrow)_1, dots, accent(v, arrow)_k\}$ is:

- *Orthogonal* if every pair is orthogonal: $accent(v, arrow)_i dot accent(v, arrow)_j = 0$ for $i eq.not j$
- *Orthonormal* if also each is a #link(<linear-algebra-unit-vector>)[unit vector]: $||accent(v, arrow)_i|| = 1$

A useful concise formula uses the Kronecker delta:

$
  accent(v, arrow)_i dot accent(v, arrow)_j = delta_(i j) = cases(1 "if" i = j, 0 "if" i eq.not j)
$

== Key facts

- *Linear independence*: any orthogonal set of non-zero vectors is automatically #link(<linear-algebra-linear-independence>)[linearly independent]
- *Pythagoras*: if $accent(u, arrow) perp accent(v, arrow)$, then $||accent(u, arrow) + accent(v, arrow)||^2 = ||accent(u, arrow)||^2 + ||accent(v, arrow)||^2$
- *Easy coordinates*: in an orthonormal #link(<linear-algebra-basis>)[basis] $\{accent(q, arrow)_1, dots, accent(q, arrow)_n\}$, the coordinates of $accent(x, arrow)$ are just dot products:
$
  accent(x, arrow) = (accent(x, arrow) dot accent(q, arrow)_1) accent(q, arrow)_1 + dots + (accent(x, arrow) dot accent(q, arrow)_n) accent(q, arrow)_n
$

== Orthogonal complement

For a #link(<linear-algebra-subspace>)[subspace] $W subset.eq RR^n$, its *orthogonal complement* is:

$
  W^perp = { accent(x, arrow) in RR^n : accent(x, arrow) dot accent(w, arrow) = 0 #h(0.5em) "for all" accent(w, arrow) in W }
$

— the set of vectors orthogonal to *every* vector in $W$.

Properties:

- $W^perp$ is itself a subspace
- $W inter W^perp = \{bold(0)\}$
- $dim(W) + dim(W^perp) = n$
- $(W^perp)^perp = W$
- $RR^n = W xor W^perp$ (every vector decomposes uniquely as $accent(w, arrow) + accent(w, arrow)^perp$)

== Four fundamental subspaces (and their complements)

For an $m times n$ matrix $A$, four subspaces and two pairings:

$
  underbrace("Col"(A), subset RR^m) perp underbrace("Null"(A^T), subset RR^m)
$

$
  underbrace("Row"(A), subset RR^n) perp underbrace("Null"(A), subset RR^n)
$

The #link(<linear-algebra-column-space>)[column space] is orthogonal to the *left* null space; the row space (= column space of $A^T$) is orthogonal to the #link(<linear-algebra-null-space>)[null space].

== Orthogonal projection

For a subspace $W$ with orthonormal basis $\{accent(q, arrow)_1, dots, accent(q, arrow)_k\}$, the projection of $accent(x, arrow)$ onto $W$ is:

$
  "proj"_W (accent(x, arrow)) = sum_(i=1)^k (accent(x, arrow) dot accent(q, arrow)_i) accent(q, arrow)_i
$

In matrix form with $Q = mat(accent(q, arrow)_1, dots, accent(q, arrow)_k)$: $"proj"_W (accent(x, arrow)) = Q Q^T accent(x, arrow)$. The matrix $P = Q Q^T$ is the *projection matrix* — see #link(<linear-algebra-projection>)[Projection].

== Why orthogonality matters

- *Best approximation*: projecting onto a subspace gives the closest point — basis of least-squares fitting
- *Decoupling*: in an orthonormal basis, coordinates are independent — no cross-terms, simpler computations
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal matrices]* preserve distances and angles — rigid transformations
- *#link(<linear-algebra-spectral-theorem>)[Spectral theorem]*: real symmetric matrices have orthogonal eigenvectors
- *#link(<linear-algebra-gram-schmidt>)[Gram–Schmidt]* builds orthonormal bases from any basis

== See also

- *#link(<linear-algebra-dot-product>)[Dot Product]*
- *#link(<linear-algebra-projection>)[Projection]*
- *#link(<linear-algebra-gram-schmidt>)[Gram–Schmidt]*
- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
- *#link(<linear-algebra-inner-product>)[Inner Product]* — generalization
