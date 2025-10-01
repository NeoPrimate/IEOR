#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition
#import "../utils/color_mat.typ": colorMat

#set math.vec(delim: "[")
#set math.mat(delim: "[")


== Minor

*Determinant* of some smaller square matrix obtained by deleting certain rows and columns from the original matrix

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

$
  mat(
    delim: "|",
    a_12, a_14;
    a_32, a_24;
  )
$

=== Principal Minor

*Determinant* of some smaller square matrix obtained by deleting certain rows and columns from the original matrix

The diagonal of the principal minor is a subset of the diagonal of $A$

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

$
  mat(
    delim: "|",
    a_11, a_13;
    a_31, a_23;
  )
$

=== Levels

$A$'s level-$k$ principal minors is the determinant of a $k times k$ submatrix whose diagonal is a subset of $A$'s diagonal

For an $n times n$
- There are $n$ levels of minors
- The number of principle minors at level $k$ is $binom(n, k)$

=== Leading Principal Minor

#align(center)[

  #grid(
    columns: 3,
    gutter: 2em,
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (0, 0)), red),
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (1, 1)), red),
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (2, 2)), red),
          )
        )
      $
    ],
  )
]