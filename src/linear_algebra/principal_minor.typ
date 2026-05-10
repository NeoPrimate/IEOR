#import "/lib/imports.typ": *

#set math.mat(delim: "[")

A *principal minor* of an $n times n$ matrix $A$ is the #link(<linear-algebra-determinant>)[determinant] of a square submatrix whose diagonal is a subset of $A$'s diagonal.

To form a principal minor: pick a subset of indices $I subset.eq {1, 2, dots, n}$, then delete every row and column *not* in $I$. The resulting submatrix is square; its determinant is the principal minor.

$
  #colorMat(
    (
      ($a_11$, $a_12$, $a_13$, $a_14$),
      ($a_21$, $a_22$, $a_23$, $a_24$),
      ($a_31$, $a_32$, $a_33$, $a_34$),
      ($a_41$, $a_42$, $a_43$, $a_44$),
    ),
    (
      (((0,0), (0, 0)), red),
      (((2,0), (2, 0)), red),
      (((2,2), (2, 2)), red),
      (((0,2), (0, 2)), red),
    )
  )
$

Pick rows/columns $I = {1, 3}$:

$
  mat(
    delim: "|",
    a_11, a_13;
    a_31, a_33;
  )
$

== Levels (order)

A principal minor formed from $|I| = k$ indices is called a *level-$k$* (or *order-$k$*) principal minor.

For an $n times n$ matrix:
- There are $n$ levels (from $k = 1$ to $k = n$)
- The number of level-$k$ principal minors is $binom(n, k)$
- Total number of principal minors: $sum_(k=0)^n binom(n, k) = 2^n$ (including the trivial empty one)

== Where they show up

- *#link(<linear-algebra-determinant>)[Sylvester's criterion]* (positive-definiteness test): a symmetric matrix is positive definite iff every #link(<linear-algebra-leading-principal-minor>)[leading principal minor] is positive
- *Positive semi-definiteness*: requires *every* principal minor (not just leading) to be non-negative
- *#link(<operations-research-optimization-convex-analysis>)[Convex analysis]* — checking definiteness of the Hessian via principal minors

== See also

- *#link(<linear-algebra-leading-principal-minor>)[Leading Principal Minor]* — minors from the top-left corner
- *#link(<linear-algebra-minor>)[Minor]* — general minors (rows and columns can differ)
- *#link(<linear-algebra-determinant>)[Determinant]*
