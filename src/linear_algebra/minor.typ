#import "/lib/imports.typ": *

#set math.mat(delim: "[")

A *minor* of a matrix $A$ is the #link(<linear-algebra-determinant>)[determinant] of a smaller square matrix obtained by deleting some rows and some columns of $A$. The deleted rows and columns *do not need to share indices* — that distinguishes a minor from a #link(<linear-algebra-principal-minor>)[principal minor].

$
  #colorMat(
    (
      ($a_11$, $a_12$, $a_13$, $a_14$),
      ($a_21$, $a_22$, $a_23$, $a_24$),
      ($a_31$, $a_32$, $a_33$, $a_34$),
      ($a_41$, $a_42$, $a_43$, $a_44$),
    ),
    (
      (((0,1), (0, 1)), red),
      (((2,3), (2, 3)), red),
      (((2,1), (2, 1)), red),
      (((0,3), (0, 3)), red),
    )
  )
$

Pick rows $\{1, 3\}$ and columns $\{2, 4\}$ — different sets, this is *not* a principal minor:

$
  mat(
    delim: "|",
    a_12, a_14;
    a_32, a_34;
  )
$

== $(i, j)$-minor (cofactor expansion)

The most-used minor is the $(i, j)$-minor $M_(i j)$: delete row $i$ and column $j$ from $A$ and take the determinant of what's left. Used in #link(<linear-algebra-determinant>)[cofactor expansion]:

$
  det(A) = sum_(j=1)^n (-1)^(i+j) a_(i j) #h(0.2em) M_(i j)
$

== Variants

- *#link(<linear-algebra-principal-minor>)[Principal minor]* — same row and column indices deleted
- *#link(<linear-algebra-leading-principal-minor>)[Leading principal minor]* — keep only the top-left $k times k$ block
- *Cofactor* $C_(i j) = (-1)^(i+j) M_(i j)$ — signed minor used in #link(<linear-algebra-adjugate>)[adjugate] and inverse formulas

== Where minors show up

- *#link(<linear-algebra-determinant>)[Determinant]* via cofactor expansion
- *#link(<linear-algebra-adjugate>)[Adjugate]* matrix and the inverse formula $A^(-1) = "adj"(A) / det(A)$
- *#link(<linear-algebra-rank>)[Rank]* — equals the size of the largest non-zero minor
- *Cramer's Rule* — see #link(<linear-algebra-cramers-rule>)[Cramer's Rule]
