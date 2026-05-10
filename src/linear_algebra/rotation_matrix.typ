#import "/lib/imports.typ": *

#set math.mat(delim: "[")
#set math.vec(delim: "[")

A rotation matrix rotates vectors about the origin by an angle $theta$ without changing their lengths.

== 2D rotation

Rotation by angle $theta$ *counterclockwise* about the origin:

$
  R(theta) = mat(cos theta, -sin theta; sin theta, cos theta)
$

Applied to $accent(x, arrow) = vec(x, y)$:

$
  R(theta) accent(x, arrow) = vec(x cos theta - y sin theta, x sin theta + y cos theta)
$

#example[
  Rotate $vec(1, 0)$ by $theta = 90°$ ($pi/2$):

  $
    R(pi/2) = mat(0, -1; 1, 0)
  $

  $
    R(pi/2) vec(1, 0) = vec(0, 1)
  $

  The unit $x$-vector becomes the unit $y$-vector. ✓
]

== Properties

- *Orthogonal*: $R(theta)^T R(theta) = I$, so $R^(-1) = R^T$ — see #link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]
- *#link(<linear-algebra-determinant>)[Determinant]*: $det(R(theta)) = cos^2 theta + sin^2 theta = 1$ — orientation-preserving
- *Composition*: $R(alpha) R(beta) = R(alpha + beta)$ — rotations add
- *Inverse*: $R(theta)^(-1) = R(-theta)$
- *Preserves lengths and angles*

== 3D rotations (about coordinate axes)

About the $x$-axis:
$
  R_x (theta) = mat(1, 0, 0; 0, cos theta, -sin theta; 0, sin theta, cos theta)
$

About the $y$-axis:
$
  R_y (theta) = mat(cos theta, 0, sin theta; 0, 1, 0; -sin theta, 0, cos theta)
$

About the $z$-axis:
$
  R_z (theta) = mat(cos theta, -sin theta, 0; sin theta, cos theta, 0; 0, 0, 1)
$

== General 3D rotation

Any 3D rotation is a composition of rotations about coordinate axes. Common parameterizations:

- *Euler angles*: $R_z (alpha) R_y (beta) R_x (gamma)$ — three angles
- *Axis–angle (Rodrigues formula)*: rotate by angle $theta$ about unit axis $hat(k)$:
$
  R = I + sin theta #h(0.2em) K + (1 - cos theta) K^2
$
where $K$ is the skew-symmetric "cross-product matrix" of $hat(k)$
- *Quaternions*: $R = q dot accent(x, arrow) dot q^*$ — avoids gimbal lock, used in 3D graphics / robotics

== Eigenvalues

For a 2D rotation by $theta$:
$
  lambda = e^(plus.minus i theta) = cos theta plus.minus i sin theta
$

Real eigenvalues only when $theta = 0$ ($lambda = 1$) or $theta = pi$ ($lambda = -1$). Otherwise the eigenvalues are complex — rotations have no real eigenvectors (no fixed direction in the plane).

== Connection to special orthogonal group

The set of all $n times n$ rotation matrices forms the *special orthogonal group* $S O(n)$:

$
  S O(n) = { Q in RR^(n times n) : Q^T Q = I, det(Q) = 1 }
$

Excluding the $-1$ determinant case removes reflections — see #link(<linear-algebra-reflection-matrix>)[Reflection Matrix].

== See also

- *#link(<linear-algebra-orthogonal-matrix>)[Orthogonal Matrix]*
- *#link(<linear-algebra-reflection-matrix>)[Reflection Matrix]*
- *#link(<linear-algebra-scaling-matrix>)[Scaling Matrix]*
- *#link(<linear-algebra-shear-matrix>)[Shear Matrix]*
- *#link(<linear-algebra-linear-transformation>)[Linear Transformation]*
