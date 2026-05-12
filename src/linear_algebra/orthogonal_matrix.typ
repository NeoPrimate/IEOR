#import "/lib/imports.typ": *
#show: formatting


A square matrix $Q$ whose #link(<linear-algebra-transpose>)[transpose] is its #link(<linear-algebra-matrix-inverse>)[inverse]:

$
  Q^T Q = Q Q^T = I
$

Equivalently, the columns (and rows) of $Q$ form an *orthonormal set* — each is a #link(<linear-algebra-unit-vector>)[unit vector] and they are mutually #link(<linear-algebra-orthogonality>)[orthogonal]:

$
  q_i dot q_j = cases(1 "if" i = j, 0 "if" i eq.not j)
$

== Geometric meaning

An orthogonal matrix represents a *rigid* #link(<linear-algebra-linear-transformation>)[linear transformation] of $RR^n$: it preserves lengths and angles.

For any vectors $accent(u, arrow), accent(v, arrow) in RR^n$:
- *Lengths*: $||Q accent(v, arrow)|| = ||accent(v, arrow)||$ (#link(<linear-algebra-norm>)[norm] preserved)
- *Angles*: $(Q accent(u, arrow)) dot (Q accent(v, arrow)) = accent(u, arrow) dot accent(v, arrow)$ (dot product preserved)

== Properties

- *#link(<linear-algebra-determinant>)[Determinant]*: $det(Q) = plus.minus 1$
  - $+1$ → orientation preserving (a *rotation*)
  - $-1$ → orientation reversing (includes *reflections*)
- *Eigenvalues*: all have absolute value $1$ (they sit on the unit circle in $bb(C)$)
- *Inverse*: $Q^(-1) = Q^T$ — extremely cheap to invert
- *Closed under product*: $Q_1 Q_2$ orthogonal ($Q_1, Q_2$ orthogonal)
- *Orthogonal group* $O(n) = {Q in RR^(n times n) : Q^T Q = I}$
- *Special orthogonal group* $S O(n) = {Q in O(n) : det(Q) = 1}$ — pure rotations

#example[
  $2 times 2$ rotation matrix by angle $theta$ — see #link(<linear-algebra-rotation-matrix>)[Rotation Matrix]:

  $
    R(theta) = mat(cos theta, -sin theta; sin theta, cos theta)
  $

  $R(theta)^T R(theta) = I$, $det = cos^2 theta + sin^2 theta = 1$.
]

== Where they show up

- *#link(<linear-algebra-qr-decomposition>)[QR decomposition]*: $A = Q R$ — orthogonal × upper triangular
- *#link(<linear-algebra-svd>)[SVD]*: $A = U Sigma V^T$ — both $U$ and $V$ are orthogonal
- *#link(<linear-algebra-spectral-theorem>)[Spectral theorem]*: real symmetric matrices diagonalize via orthogonal $Q$
- *#link(<linear-algebra-gram-schmidt>)[Gram–Schmidt]*: produces orthonormal columns from any basis
- *Coordinate frame changes* in robotics, computer graphics, physics
