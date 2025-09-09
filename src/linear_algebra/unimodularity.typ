#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition
#import "../utils/color_mat.typ": colorMat

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Unimodularity

=== Unimodular Matrix

Integer square matrix whose determinant is +1 or -1:

$
  det(A) = plus.minus 1
$

- Always invertible, and its inverse is also an integer matrix
- Applying such a matrix (transformation) to an integer vector gives another integer vector

=== Totally Unimodular Matrix

A totally unimodular (TU) matrix is a (not necessarily square) matrix in which every square submatrix (determinant of any square submatrix of any size) has determinant in:

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
