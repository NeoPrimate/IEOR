#import "/lib/imports.typ": *
#show: formatting



A *scaling matrix* stretches (or compresses) each coordinate independently. It's a #link(<linear-algebra-diagonal-matrix>)[diagonal matrix]:

$
  S = mat(s_1, 0, dots, 0; 0, s_2, dots, 0; dots.v, dots.v, dots.down, dots.v; 0, 0, dots, s_n)
$

The $i$-th coordinate gets multiplied by $s_i$:

$
  S accent(x, arrow) = vec(s_1 x_1, s_2 x_2, dots.v, s_n x_n)
$

== Uniform vs non-uniform

- *Uniform scaling*: all $s_i = c$, i.e. $S = c I$ — stretches every direction by the same factor $c$. Shapes are similar (same angles, scaled lengths).
- *Non-uniform scaling*: $s_i$'s differ — distorts shapes. A circle becomes an ellipse.

#example[
  $S = mat(2, 0; 0, 3)$.

  $S vec(1, 1) = vec(2, 3)$. The unit circle $x^2 + y^2 = 1$ maps to the ellipse $(x/2)^2 + (y/3)^2 = 1$.
]

== Properties

- *#link(<linear-algebra-determinant>)[Determinant]*: $det(S) = s_1 s_2 dots s_n$ — total volume change factor
- *#link(<linear-algebra-matrix-inverse>)[Inverse]*: $S^(-1) = "diag"(1/s_1, 1/s_2, dots, 1/s_n)$ (when all $s_i eq.not 0$)
- *Singular when any $s_i = 0$*: the corresponding direction is collapsed
- *Eigenvalues*: the $s_i$'s themselves
- *Eigenvectors*: the standard basis $e_1, e_2, dots, e_n$
- *Already in diagonal form* — diagonalization is trivial

== Negative scaling

Scaling by $s_i < 0$ flips the $i$-th coordinate:

- One negative entry: orientation reverses ($det < 0$) — combination of a scaling and a #link(<linear-algebra-reflection-matrix>)[reflection]
- Two negative entries: orientation preserved ($det > 0$) — same as a 180° rotation by a scaling

== Scaling in a general direction

To scale by factor $c$ along a *non-axis* direction $hat(v)$, conjugate by a rotation that aligns $hat(v)$ with a coordinate axis:

$
  S_(hat(v), c) = R^T mat(c, 0; 0, 1) R
$

Or, more directly: $S_(hat(v), c) = I + (c - 1) hat(v) hat(v)^T$ — adds $c - 1$ extra of the projection onto $hat(v)$.

== Application to images / graphics

- $S = "diag"(s, s)$ — zoom in/out uniformly
- $S = "diag"(2, 1)$ — stretch horizontally
- $S = "diag"(1, -1)$ — flip vertically (= reflection)
- Singular value decomposition (#link(<linear-algebra-svd>)[SVD]) writes every linear map as rotate–*scale*–rotate, so non-uniform scaling is the "shape-distorting" core of any matrix

== See also

- *#link(<linear-algebra-diagonal-matrix>)[Diagonal Matrix]*
- *#link(<linear-algebra-rotation-matrix>)[Rotation Matrix]*
- *#link(<linear-algebra-reflection-matrix>)[Reflection Matrix]*
- *#link(<linear-algebra-shear-matrix>)[Shear Matrix]*
- *#link(<linear-algebra-svd>)[SVD]* — every matrix is rotate–scale–rotate
