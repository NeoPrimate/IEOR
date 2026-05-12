#import "/lib/imports.typ": *
#show: formatting



== Unimodular Matrix

Integer square matrix whose #link(<linear-algebra-determinant>)[determinant] is +1 or -1:

$
  det(A) = plus.minus 1
$

- Always invertible, and its inverse is also an integer matrix
- Applying such a matrix (transformation) to an integer vector gives another integer vector

== Totally Unimodular Matrix

A totally unimodular (TU) matrix is a (not necessarily square) matrix in which every square submatrix (#link(<linear-algebra-determinant>)[determinant] of any square submatrix of any size) has #link(<linear-algebra-determinant>)[determinant] in:

$
  {-1, 0, +1}
$

$
  A = #colorMat(
    (
      (1, 0, -1, 0),
      (0, -1, 0, 1),
      (-1, 0, 1, 0),
    ),
    (
      (((0,0), (1, 1)), red),
      (((0,1), (2, 3)), blue),
    )
  )
$

$
  det(
    #colorMat(
      (
        (1, 0),
        (0, -1),
      ),
      (
        (((0,0), (1, 1)), red),
      )
    )
  ) = 0
  quad quad
  det(
    #colorMat(
      (
        (0, -1, 0),
        (-1, 0, 1),
        (0, 1, 0),
      ),
      (
        (((0,0), (2, 2)), blue),
      )
    )
  ) = 0
$
