#import "../../../utils/code.typ": code
#import "../../../utils/examples.typ": eg
#import "../../../utils/result.typ": result
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/blob.typ": draw-blob


#import "@preview/cetz:0.3.1"

#set math.vec(delim: "[")
#set math.mat(delim: "[")

= Vector

$
  vec(x_1, x_2, dots.v, x_n)
$

== Vector Space

A vector space (or linear space) is a set of vectors that can be added together and scaled by scalars, following specific properties (axioms)

#align(center,
  table(
    columns: (auto, auto),
    inset: 10pt,
    stroke: none,
    align: center,
    "Closure under addition", $arrow(u), arrow(v) in V quad arrow.double quad arrow(u) + arrow(v) in V$,
    "Closure under scalar multiplication", $arrow(v) in V and c in RR quad arrow.double quad c arrow(v) in V$,
    "Commutativity of addition", $arrow(u) + arrow(v) = arrow(v) + arrow(u)$,
    "Associativity of addition", $(arrow(u) + arrow(v)) + arrow(w) = arrow(u) + (arrow(v) + arrow(w))$,
    "Additive identity", $exists bold(0) in V | arrow(v) + bold(0) = arrow(v)$,
    "Additive inverse", $forall arrow(v) in V exists -arrow(v) in V | arrow(v) + (- arrow(v)) = 0$,
    "Scalar multiplication (compatibility)", $a (b arrow(v)) = (a b) arrow(v)$,
    "Distributivity over vector addition", $a (arrow(u) + arrow(v)) = a arrow(u) + a arrow(v)$,
    "Distributivity over scalar addition", $(a + b) arrow(v) = a arrow(v) + b arrow(v)$,
    "Multiplicative identity", $1 arrow(v) = arrow(v)$,
  )
)

== Vector Addition

$
  arrow(x) 
  = vec(colorMath(x_1, #red), colorMath(x_2, #red), dots.v, colorMath(x_n, #red))
  quad quad 
  arrow(y) 
  = vec(colorMath(y_1, #blue), colorMath(y_2, #blue), dots.v, colorMath(y_n, #blue))
  \
  arrow(x) + arrow(y) 
  = vec(colorMath(x_1, #red) + colorMath(y_1, #blue), colorMath(x_2, #red) + colorMath(y_2, #blue), dots.v, colorMath(x_n, #red) + colorMath(y_n, #blue))
$

== Vector Scalar Multiplication

$
  colorMath(c, #blue) in RR
  quad quad
  arrow(x) 
  = vec(colorMath(x_1, #red), colorMath(x_2, #red), dots.v, colorMath(x_n, #red)) 
  \
  c arrow(x)
  = vec(colorMath(c, #blue) colorMath(x_1, #red), colorMath(c, #blue) colorMath(x_2, #red), dots.v, colorMath(c, #blue) colorMath(x_n, #red))
$

== Dot Product

$
  arrow(x) 
  = vec(colorMath(x_1, #red), colorMath(x_2, #red), dots.v, colorMath(x_n, #red))
  quad quad 
  arrow(y) 
  = vec(colorMath(y_1, #blue), colorMath(y_2, #blue), dots.v, colorMath(y_n, #blue))
  $
  
  $
  arrow(x) dot arrow(y) 
  &= sum_(i=1)^n colorMath(x_i, #red) colorMath(y_i, #blue) \
  &= colorMath(x_1, #red) colorMath(y_1, #blue) + colorMath(x_2, #red) colorMath(y_2, #blue) + dots + colorMath(x_n, #red) colorMath(y_n, #blue)
  \
  &= colorMath(arrow(x), #red)^T colorMath(arrow(y), #blue)
$

== Cross Product ($RR^3$)

Returns a vector orthogonal to the two vectors

$
accent(a, arrow) = vec(a_1, a_2, a_3) 
quad quad 
accent(b, arrow) = vec(b_1, b_2, b_3)
$

$
accent(c, arrow) = accent(a, arrow) times accent(b, arrow)
$

$
accent(c, arrow) = vec(
  a_2 b_3 - a_3 b_2,
  a_3 b_1 - a_1 b_3,
  a_1 b_2 - a_2 b_1,
)
$





== Norm (Magnitude, Length)

- $L_1$-Norm (Manhattan)

$
  ||arrow(x)||_1 = sum_(1=1)^n |v_i|
$

- $L_2$-Norm (Euclidean, Magnitude, Length)

$
  || arrow(v) || = sqrt(sum_(i=1)^n v_i^2)
$

== Projection

The projection of a vector $arrow(v)$ onto another vector 
$arrow(w)$ is the vector component of $arrow(v)$ that lies along the direction of $arrow(w)$

$
  "proj"_w arrow(v)  = (arrow(v) dot arrow(w)) / (arrow(w) dot arrow(w)) arrow(w)
$ 

== Distances Between Vectors

- Manhattan (using $L_1$-Norm)

$
  d(arrow(u), arrow(v)) = sum_(i=1)^n |u_i - v_i|
$

- Euclidean (using $L_2$-Norm)

$
  d(arrow(u), arrow(v)) = sqrt(sum_(i=1)^n (u_i - v_i)^2)
$

== Orthogonality

Angle between the two vectors is $90 degree$

$
  v dot w = bold(0)
$


== Angles Between Vectors

$
  Theta = arccos((colorMath(arrow(x), #red) dot colorMath(arrow(y), #blue)) / (|| colorMath(arrow(x), #red) || dot || colorMath(arrow(y), #blue) ||))
$

= Matrix

#align(center,
  table(
    columns: (auto, auto),
    inset: 5pt,
    align: (horizon, center),
    stroke: none,
    $$,
    $colorMath(n, #red)$,
    $colorMath(m, #blue)$,
    $
      mat(
        a_(11), a_(12), dots, a_(1colorMath(n, #red));
        a_(21), a_(22), dots, a_(2colorMath(n, #red));
        dots.v, dots.v, dots.down, dots.v;
        a_(colorMath(m, #blue) 1), a_(colorMath(m, #blue) 2), dots, a_(colorMath(m, #blue) colorMath(n, #red)))
      )
    $
  )
)



== Matrix Vector Product

#align(center,
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: (horizon, center),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $colorMath(n, #red)$,
      $m$,
      $
        mat(
          colorMath(a_(11), #blue), colorMath(a_(12), #blue), dots, colorMath(a_(1n), #blue);
          colorMath(a_(21), #blue), colorMath(a_(22), #blue), dots, colorMath(a_(2n), #blue);
          dots.v, dots.v, dots.down, dots.v;
          colorMath(a_(m 1), #blue), colorMath(a_(m 2), #blue), dots, colorMath(a_(m n), #blue)
        )
      $
    ),
    table(
      columns: (auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $
        vec(colorMath(x_1, #green), colorMath(x_2, #green), dots.v, colorMath(x_n, #green)) 
      $
    )
  )
)

$
  vec(
    colorMath(a_(11), #blue) colorMath(x_1, #green) + colorMath(a_(12), #blue) colorMath(x_2, #green) + dots + colorMath(a_(1n), #blue) colorMath(x_n, #green),
    colorMath(a_(21), #blue) colorMath(x_1, #green) + colorMath(a_(22), #blue) colorMath(x_2, #green) + dots + colorMath(a_(2n), #blue) colorMath(x_n, #green),
    dots.v,
    colorMath(a_(m 1), #blue) colorMath(x_1, #green) + colorMath(a_(m 2), #blue) colorMath(x_2, #green) + dots + colorMath(a_(m n), #blue) colorMath(x_n, #green),
  )
$

== Matrix Multiplication

#align(center,
  table(
    columns: (50%, 50%),
    inset: 5pt,
    align: (horizon, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $A =$,
      $colorMath(m, #blue)$,
      $
        mat(
          a_(11), a_(12), dots, a_(1n);
          a_(21), a_(22), dots, a_(2n);
          dots.v, dots.v, dots.down, dots.v;
          a_(m 1), a_(m 2), dots, a_(m n)
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(p, #blue)$,
      $B =$,
      $colorMath(n, #red)$,
      $
        mat(
          b_(11), b_(12), dots, b_(1p);
          b_(21), b_(22), dots, b_(2p);
          dots.v, dots.v, dots.down, dots.v;
          b_(n 1), b_(n 2), dots, b_(n p)
        )
      $
    )
  )
)
#align(center,
  table(
    columns: (50%, 50%),
    inset: 5pt,
    align: (horizon, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $A =$,
      $colorMath(m, #blue)$,
      $
        mat(
          gap: #1em,
          mat(gap: #1em, a_(11), a_(12), dots, a_(1n));
          mat(gap: #1em, a_(21), a_(22), dots, a_(2n));
          dots.v;
          mat(gap: #0.5em, a_(m 1), a_(m 2), dots, a_(colorMath(m, #blue) n));
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(p, #blue)$,
      $B =$,
      $colorMath(n, #red)$,
      $
        mat(
          gap: #1em,
          vec(gap: #1em, b_(11), b_(21), dots.v, b_(n 1)),
          vec(gap: #1em, b_(12), b_(22), dots.v, b_(n 2)),
          dots,
          vec(gap: #1em, b_(1p), b_(2p), dots.v, b_(n p)),
        )
      $
    )
  )
)
#align(center,
  table(
    columns: (50%, 50%),
    inset: 5pt,
    align: (horizon, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto),
      inset: 5pt,
      align: (horizon, horizon),
      stroke: none,
      [*$A$: Row Representation*],
      $$,
      $
        A = vec(r_1, r_2, dots.v, r_colorMath(m, #blue))
        \
        r_i = mat(a_(i 1), a_(i 2), dots, a_(i n)), quad "for" i = 1, 2, dots, colorMath(m, #blue)
      $,
    ),
    table(
      columns: (auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      [*$B$: Column Representation*],
      $$,
      $
        B = mat(c_1, c_2, dots, c_colorMath(p, #blue))
        \
        c_j = vec(b_1j, b_2j, dots.v, b_(n j)), quad "for" j = 1, 2, dots, colorMath(p, #blue)
      $,
    )
  )
)

#align(center,
table(
    columns: (auto, auto, auto),
    inset: 5pt,
    align: (horizon, horizon, center),
    stroke: none,
    $$,
    $$,
    $colorMath(p, #blue)$,
    $C =$,
    $colorMath(m, #blue)$,
    $
      mat(
          r_1 dot c_1, r_1 dot c_2, dots, r_1 dot c_p;
          r_2 dot c_1, r_2 dot c_2, dots, r_2 dot c_p;
          dots.v, dots.v, dots.down, dots.v;
          r_m dot c_1, r_m dot c_2, dots, r_m dot c_p;
        )
    $
  )
)

== Transpose

$
  A^T
$

#align(center,
  table(
    columns: (50%, 50%),
    inset: 5pt,
    align: (horizon, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $A =$,
      $colorMath(m, #blue)$,
      $
        mat(
          colorMath(a_(11), #purple), colorMath(a_(12), #purple), colorMath(dots, #purple), colorMath(a_(1 n), #purple);
          colorMath(a_(21), #green), colorMath(a_(22), #green), colorMath(dots, #green), colorMath(a_(2 n), #green);
          dots.v, dots.v, dots.down, dots.v;
          colorMath(a_(m 1), #yellow), colorMath(a_(m 2), #yellow), colorMath(dots, #yellow), colorMath(a_(m n), #yellow)
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(m, #blue)$,
      $A^T =$,
      $colorMath(n, #red)$,
      $
        mat(
          colorMath(a_(11), #purple), colorMath(a_(21), #green), dots, colorMath(a_(m 1), #yellow);
          colorMath(a_(12), #purple), colorMath(a_(22), #green), dots, colorMath(a_(m 2), #yellow);
          colorMath(dots.v, #purple), colorMath(dots.v, #green), dots.down, colorMath(dots.v, #yellow);
          colorMath(a_(1 n), #purple), colorMath(a_(2 n), #green), dots, colorMath(a_(m n), #yellow)
        )
      $
    )
  )
)

$
  det(A) = det(A^T) \
  (A B)^T = B^T A^T \
  (A^T)^(-1) = (A^(-1))^T

$

#align(center,
  table(
    columns: (50%, 50%),
    inset: 5pt,
    align: (horizon, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $A =$,
      $colorMath(m, #blue)$,
      $
        mat(
          colorMath(a_(11), #purple), colorMath(a_(12), #purple), colorMath(dots, #purple), colorMath(a_(1 j), #purple), colorMath(dots, #purple), colorMath(a_(1 n), #purple);
          colorMath(a_(21), #green), colorMath(a_(22), #green), colorMath(dots, #green), colorMath(a_(2 j), #green), colorMath(dots, #green), colorMath(a_(2 n), #green);
          dots.v, dots.v, , dots.v, , dots.v;
          colorMath(a_(i 1), #orange), colorMath(a_(i 2), #orange), colorMath(dots, #orange), colorMath(a_(i j), #orange), colorMath(dots, #orange), colorMath(a_(i n), #orange);
          dots.v, dots.v, , dots.v, , dots.v;
          colorMath(a_(m 1), #yellow), colorMath(a_(m 2), #yellow), colorMath(dots, #yellow), colorMath(a_(i j), #yellow), colorMath(dots, #yellow), colorMath(a_(m n), #yellow)
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(m, #blue)$,
      $A^T =$,
      $colorMath(n, #red)$,
      $
        mat(
          colorMath(a_(11), #purple), colorMath(a_(21), #green), dots, colorMath(a_(i 1), #orange), dots, colorMath(a_(m 1), #yellow);
          colorMath(a_(12), #purple), colorMath(a_(22), #green), dots, colorMath(a_(i 2), #orange), dots, colorMath(a_(m 2), #yellow);
          colorMath(dots.v, #purple), colorMath(dots.v, #green), , colorMath(dots.v, #orange), , colorMath(dots.v, #yellow);
          colorMath(a_(1 j), #purple), colorMath(a_(2 j), #green), dots, colorMath(a_(i j), #orange), dots, colorMath(a_(m j), #yellow);
          colorMath(dots.v, #purple), colorMath(dots.v, #green), , colorMath(dots.v, #orange), , colorMath(dots.v, #yellow);
          colorMath(a_(1 n), #purple), colorMath(a_(2 n), #green), dots, colorMath(a_(i n), #orange), dots, colorMath(a_(m n), #yellow)
        )
      $
    )
  )
)


= Linear Dependence

A set of vectors is linearly independent if no vector in the set can be written as a linear combination of the others

A set of vectors ${arrow(v)_1, arrow(v)_2, dots, arrow(v)_n}$ is linearly independent if the only solution to the the equation

$
  c_1 arrow(v)_1 + c_2 arrow(v)_2 + dots + c_n arrow(v)_n = bold(0) \
$

is $c_1 = c_2 = dots = c_n = 0$


= Span

The span of a set of vectors is the collection of all possible linear combinations of those vectors

= Subspace

A subspace is a subset of a vector space that is itself a vector space, satisfying the same axioms as the original. If $V$ is a vector space in $RR^n$, then the subspace $U$ is always contained in $RR^n$, meaning $U subset.eq RR^n$

- *Non-emptiness*: $bold(0) in V$

- *Closure under addition*: $"If" arrow(u), arrow(v) in V, "then" arrow(u) + arrow(v) in V$

- *Closure under scalar multiplication*: $"If" arrow(v) in V, c in RR, "then" c arrow(v) in V$

= Null Space (Kernel)<null-space>

The null space (or kernel) of a matrix $A$, denoted as $"Null"(A)$ or $ker(A)$

$
  "Null"(A) = {arrow(x) in RR^n | A arrow(x) = 0}
$

The set of all vectors $arrow(x)$ that satisfy the equation:

$
  A arrow(x) = bold(0)
$

$
  A = 
  mat(
    a_(11), a_(12), dots, a_(1n);
    a_(21), a_(22), dots, a_(2n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots, a_(m n)
  )
  quad 
  arrow(x) = vec(x_1, x_2, dots.v, x_n)
  quad
  bold(0) = vec(0_1, 0_2, dots.v, 0_m)
$

$
  a_11 x_1 + a_12 x_2 + dots + a_(1n) x_n = 0 \
  a_21 x_1 + a_22 x_2 + dots + a_(2n) x_n = 0 \
  dots.v \
  a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n = 0 \
$

= Transformations

$
  T: RR^n arrow RR^m \
$

$
  T(arrow(v)) = A arrow(v)
$

- Additivity: #h(3em) $T(arrow(u) + arrow(v)) = T(arrow(u)) + T(arrow(v))$

- Homogeneity: #h(3em) $T(c arrow(u)) = c T(arrow(u))$

== Image (Range, Column Space)

The image of a transformation is the set of all vectors in $W$ that can be written as $T(v)$ for some $v in V$:

$
  T: V arrow W \
  "Im"(T) = {arrow(w) in W | arrow(w) = T(arrow(v)) "for some" arrow(v) in V}
$

- The image is a subspace of the codomain $W$
- If $T$ is represented by a matrix $A$, the image of $T$ corresponds to the *column space* of $A$

== Preimage<pre-image>

The preimage of a transformation refers to the set of all elements in the domain that map to a particular element or subset in the codomain

$
  T: V arrow W \
  T^(-1)(arrow(w)) = {arrow(v) in V | T(arrow(v)) = arrow(w)}
$

== Column Space (Range, Image)

The column space (or range) of a matrix is the set of all possible linear combinations of its columns

$
  A = mat(
    arrow(c)_1, arrow(c)_2, dots, arrow(c)_3
  ) \
  "Col"(A) = "span"(arrow(c)_1, arrow(c)_2, dots, arrow(c)_3)
$

== 

$
  T: A arrow B
$

=== Surjective 

$
  "Range"(T) = B
$



=== Injective



== Composition

$
  T_1: RR^n arrow RR^m 
  quad quad quad 
  T_2: RR^m arrow RR^p 
  \
  T_1(arrow(v)) = A arrow(v) 
  quad quad quad 
  T_2(arrow(v)) = B arrow(v)
$

$
  T compose S (arrow(v)) = T_2(T_1(arrow(v)))
$

$
  T_2 compose T_1 (arrow(v)) = B(A arrow(v)) = (B A) arrow(v)
$

- Additivity: #h(3em) $(T_3 compose T_2) compose T_1 = T_3 compose (T_2 compose T_1)$

- Homogeneity: #h(3em) $T_2 compose T_1(c arrow(u)) = c (T_2 compose T_1)(arrow(u))$

- Identity Transformation

$
  I compose T = T quad quad quad T compose I = T
$

= Determinants

The determinant of a square matrix $A$ measure of the "scale factor" by which the matrix $A$ transforms a space

- $det(A) eq.not 0$
  - $A$ does not collapse the space
  - $A$ has full rank
  - $A$'s columns are linearly independent
  - $A$ is invertable

- $det(A) eq 0$
  - $A$ collapses the space into lower dimension
  - $A$ does not have full rank
  - $A$'s columns are linearly dependent
  - $A$ is non-invertable (singular)

= Dimension

The dimension of a vector (sub)space is the number of (linearly independent) vectors in any basis for the space

Subspaces of $RR^n$

#align(center,
  table(
    columns: (auto, auto),
    inset: 7pt,
    stroke: none,
    align: (center, left),
    $dim(U) = 0$, $U = { bold(0) }$,
    $dim(U) = 1$, [$U$ is a *line* through the origin in $RR^n$],
    $dim(U) = 2$, [$U$ is a *plane* through the origin in $RR^n$],
    $dim(U) = k$, [$U$ is a $k$-dimensional *flat* subspace of $RR^n$],
    $dim(U) = n$, $U = RR^n$,
  )
)

= Basis

A basis of a vector space is a set of vectors that are linearly independent & span the entire space



= Rank

The number of linearly independent columns of the matrix

$
  "rank"(A) = dim("Col"(A))
$

= Invertibility

$det(A) eq.not 0 quad arrow.double.long "Invertible"$

$det(A) eq 0 quad arrow.double.long "Non-Invertible"$

$
  A A^(-1) = A^(-1) A = I_n
$

$
  (A B)^(-1) = B^(-1) A^(-1)
$

$
  (A^T)^(-1) = (A^(-1))^T
$

= Eigenvectors & Eigenvalues

The matrix vector product $A arrow(v)$ is the same as scaling $arrow(v)$ by some value $lambda$

$
  A arrow(v) 
  &= lambda arrow(v) \
  &= (lambda I) arrow(v) \
  A arrow(v) - (lambda I) arrow(v) &= bold(0) \
  (A - lambda I) arrow(v) &= bold(0) \
$

$
  det(A - lambda I) &= 0
$

Where:
- $A$: Transformation matrix
- $arrow(v)$: Eigenvector
- $lambda$: Eigenvalue

Finding the vales of $arrow(v)$ and $lambda$ that make this expression true

= Matrix Factorization

== LU Decomposition

$
  A = L U
$

where:
- $L$: lower triangular matrix (entries above the diagonal are zero)
- $U$: upper triangular matrix (entries below the diagonal are zero)

1. $m times n$ Matrix (with $m gt.eq n$)

#align(center,
  table(
    columns: (50%, 50%),
    inset: 5pt,
    align: (horizon, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $L =$,
      $colorMath(m, #blue)$,
      $
        mat(
          l_(11), l_(12), dots, l_(1n);
          l_(21), l_(22), dots, l_(2n);
          dots.v, dots.v, dots.down, dots.v;
          l_(m 1), l_(m 2), dots, l_(m n)
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $U =$,
      $colorMath(n, #red)$,
      $
        mat(
          u_(11), u_(12), dots, u_(1n);
          u_(21), u_(22), dots, u_(2n);
          dots.v, dots.v, dots.down, dots.v;
          u_(n 1), u_(n 2), dots, u_(n n)
        )
      $
    )
  )
)

2. $m times n$ Matrix (with $m lt n$)

see QR Decomposition

== QR Decomposition

== Cholesky Decomposition


== Singular Value Decomposition (SVD)

$
  A = U Sigma V^T
$

#align(center,
  table(
    columns: (33%, 33%, 33%),
    inset: 0pt,
    align: (horizon, left, left),
    stroke: none,
    column-gutter: 2em,
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(m, #blue)$,
      $U =$,
      $colorMath(m, #blue)$,
      $
        mat(
          u_(11), u_(12), dots, u_(1m);
          u_(21), u_(22), dots, u_(2m);
          dots.v, dots.v, dots.down, dots.v;
          u_(m 1), u_(m 2), dots, u_(m m)
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $Sigma =$,
      $colorMath(m, #blue)$,
      $
        mat(
          epsilon_(11), epsilon_(12), dots, epsilon_(1m);
          epsilon_(21), epsilon_(22), dots, epsilon_(2m);
          dots.v, dots.v, dots.down, dots.v;
          epsilon_(n 1), epsilon_(n 2), dots, epsilon_(n m)
        )
      $
    ),
    table(
      columns: (auto, auto, auto),
      inset: 5pt,
      align: (horizon, horizon, center),
      stroke: none,
      $$,
      $$,
      $colorMath(n, #red)$,
      $V^T =$,
      $colorMath(n, #red)$,
      $
        mat(
          v_(11), v_(12), dots, v_(1n);
          v_(21), v_(22), dots, v_(2n);
          dots.v, dots.v, dots.down, dots.v;
          v_(n 1), v_(n 2), dots, v_(n n)
        )
      $
    )
  )
)

= RREF <rref>

1. Row Swapping (Interchange)

$
  R_1 arrow.l.r R_2
$

2. Row Scaling (Multiplication)

$
  R_1 arrow 1/3 R_1
$

3. Row Addition (Replacement)

$
  R_1 arrow R_1 - 2 R_2
$

#table(
  columns: (auto, auto),
  inset: 15pt,
  align: horizon,
  $ 
    
  $,
  $
    mat(
      augment: #3,
      1, 2, -1, 2;
      2, 3, 1, 5;
      3, 4, -2, 4;
    )
  $,
  $
    R_2 arrow R_2 - 2 R_1 \
    R_3 arrow R_3 - 3 R_1
  $,
  $
    mat(
      augment: #3,
      1, 2, -1, 2;
      0, -1, 3, 1;
      0, -2, 1, -2;
    )
  $,
  $
    R_2 arrow -R_2
  $,
  $
    mat(
      augment: #3,
      1, 2, -1, 2;
      0, 1, -3, -1;
      0, -2, 1, -2;
    )
  $,
  $
    R_1 arrow R_1 - 2 R_2 \
    R_3 arrow R_3 + 2 R_2 \
  $,
  $
    mat(
      augment: #3,
      1, 0, 5, 4;
      0, 1, -3, -1;
      0, 0, -5, -4;
    )
  $,
  $
    R_3 arrow 1 / (-5) R_3
  $,
  $
    mat(
      augment: #3,
      1, 0, 5, 4;
      0, 1, -3, -1;
      0, 0, 1, 4/5;
    )
  $,
  $
    R_1 arrow R_1 - 5 R_3 \
    R_2 arrow R_2 + 3 R_3 \
  $,
  $
    mat(
      augment: #3,
      1, 0, 0, 0;
      0, 1, 0, 7/5;
      0, 0, 1, 4/5;
    )
  $,
)

#eg[

  $
    A = mat(
      2, -1, -3;
      -4, 2, 6;
    )
  $

  1. Null Space

  The #link(<null-space>)[*null-space*] of $A$, denoted $N(A)$, consists of all vectors $arrow(x) in RR^3$ such that $A x = 0$. The set of all such vectors is the #link(<pre-image>)[*pre-image*] of the zero vector under the transformation defined by $A$. In other words, $N(A) = {x  in RR^3 | A arrow(x) = 0}$, which represents the set of vectors that $A$ maps to zero.

  $
    N(A) = {arrow(x) in RR^3 | A arrow(x) = bold(0)}
  $

  To find the null space $N(A)$ of the matrix $A$, we can use the #link(<rref>)[*row-reduced echelon form (RREF)*]. By augmenting the matrix $A$ with a zero column and performing row operations, we reduce it to the form:

  $
    mat(
      2, -1, -3;
      -4, 2, 6;
    ) vec(x_1, x_2, x_3)
    = vec(0, 0)
  $

  #align(center,
    table(
      columns: (auto, auto),
      inset: 15pt,
      align: horizon,
      $ 
        
      $,
      $
        mat(
          augment: #3,
          2, -1, -3, 0;
          -4, 2, 6, 0;
        ) 
      $,
      $
        R_1 arrow R_1 / 2 \
        R_2 arrow R_2 / 4 \
      $,
      $
        mat(
          augment: #3,
          1, -1/2, -3/2, 0;
          -1, 1/2, 3/2, 0;
        )
      $,
      $
        R_2 arrow R_2 - R_1
      $,
      $
        mat(
          augment: #3,
          1, -1/2, -3/2, 0;
          0, 0, 0, 0;
        )
      $,
    )
  )

  $
    mat(
      1, -1/2, -3/2;
      0, 0, 0;
    ) vec(x_1, x_2, x_3)
    = vec(0, 0)
  $

  $
    x_1 -1/2 x_2 -3/2 x_2 = 0 \
    x_1 = 1/2 x_2 + 3/2 x_2 \
    vec(x_1, x_2, x_3) = x_2 vec(1/2, 1, 0) + x_3 vec(3/2, 0, 1) \
    N(a) = "span"({vec(1/2, 1, 0) vec(3/2, 0, 1)})
  $

  The dimension of the #link(<null-space>)[*null-space*] is the number of vectors in this basis, which is 2. This is important because the dimension of the null space gives us insight into how many degrees of freedom exist in the system of equations $A x = 0$

  2. Column Space

  $
    C(A) 
    &= "span"({vec(2, -4) vec(-1, 2) vec(-3, 6)}) \
    &= "span"({vec(2, -4)}) \
  $

  3. Basis

  $
    vec(2, -4)
  $

  4. Rank

  Number of vector in the basis of our column space
  
  $
    "Rank"(A) = 1
  $

]