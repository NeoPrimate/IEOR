#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition
#import "../utils/color_mat.typ": colorMat

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Unimodularity

=== Unimodular Matrix

A square matrix is unimodular if its determinant is 1 or -1

$
  det(A) = {1, -1}
$

=== Totally Unimodular Matrix

A matrix is totally unimodular (TU) is all its square submatrices are either singluar of unimodular

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

Reminder: Singluar
$det(A) = 0$
