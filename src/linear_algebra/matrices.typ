#import "../utils/code.typ": code
#import "../utils/examples.typ": eg

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Matrices

$m times n$ matrix $bold(A)$
- $m$: rows
- $n$: columns

$
bold(A) = mat(
  a_(1 1), a_(1 2), ..., a_(1 n);
  a_(2 1), a_(2 2), ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(m 1), a_(m 2), dots.h, a_(m n);
)
$

=== Matrix-Vector Products

$
bold(A) = mat(
  a_(1 1), a_(1 2), ..., a_(1 n);
  a_(2 1), a_(2 2), ..., a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(m 1), a_(m 2), dots.h, a_(m n);
)
$

$
accent(x, arrow) = vec(x_1, x_2, dots.v, x_n)
$

$
bold(A) accent(x, arrow) = vec(
  a_(1 1) x_1 + a_(1 2) x_2 + dots + a_(1 n) x_n,
  a_(2 1) x_1 + a_(2 2) x_2 + dots + a_(2 n) x_n,
  dots.v,
  a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n,
) = vec(b_1, b_2, dots.v, b_n)
$

// For the dot product to be defined $bold(A)$ and $accent(x, arrow)$ must have the same number of columns (n) (for the matrix) and elements (n) (for the vector)

// The resulting vector will be 1 by m (number of matrix rows)

// $m times cancel(n)$ 

// $cancel(n) times 1$

// $m times 1$

For the dot product to be defined, the number of columns in the matrix
$bold(A)$ (which is $n$) must match the number of elements in the vector $accent(x, arrow)$ (also $n$).

The result of multiplying matrix $bold(A)$ and vector $accent(x, arrow)$ will be a column vector with dimensions $m times 1$, where $m$ is the number of rows in the matrix $bold(A)$

$
(m times n) dot (n times 1) = m times 1
$

1. As Row vectors

$
#text(red)[$accent(a, arrow) = vec(a_1, a_2, dots.v, a_n)$] \
#text(blue)[$accent(b, arrow) = vec(b_1, b_2, dots.v, b_n)$] \
$

$
#text(red)[$accent(a, arrow)^T = [a_1, a_2, dots, a_n]$] \
#text(blue)[$accent(b, arrow)^T = [b_1, b_2, dots, b_n]$] \
$

$
bold(A) = vec(
  #text(red)[$[a_1, a_2, dots, a_n]$],
  #text(blue)[$[b_1, b_2, dots, b_n]$],
)
$

$
bold(A) = vec(
  #text(red)[$accent(a, arrow)$],
  #text(blue)[$accent(b, arrow)$],
)
$

$
accent(x, arrow) = vec(x_1, x_2, dots.v, x_n)
$

$
vec(#text(red)[$accent(a, arrow)^T$], #text(blue)[$accent(b, arrow)^T$]) dot accent(x, arrow) = vec(#text(red)[$accent(a, arrow)$] dot accent(x, arrow), #text(blue)[$accent(b, arrow)$] dot accent(x, arrow))
$

2. As Column Vectors

$
#text(red)[$accent(a, arrow) = vec(a_1, a_2, dots.v, a_n)$] \
#text(blue)[$accent(b, arrow) = vec(b_1, b_2, dots.v, b_n)$] \
$

$
bold(A) = mat(
  #text(red)[$vec(a_1, a_2, dots.v, a_n)$]
  #text(blue)[$vec(b_1, b_2, dots.v, b_n)$]
)
$

$
bold(A) = mat(
  #text(red)[$accent(a, arrow)$],
  #text(blue)[$accent(b, arrow)$],
)
$

$
accent(x, arrow) = vec(x_1, x_2)
$

$
bold(A) accent(x, arrow) = x_1 #text(red)[$accent(a, arrow)$] + x_2 #text(blue)[$accent(b, arrow)$]
$

=== Null Space

The null space (or kernel) of a matrix $bold(A)$ is the set of all vectors $bold(x)$ that satisfy the equation:

$
bold(A) accent(x, arrow) = bold(0)
$

Where:
- $bold(A)$: $m times n$ matrix
- $accent(x, arrow)$: $n$-dimansional vector
- $bold(0)$: zero vecor in $RR^m$

$
  N(bold(A)) = N("rref"(bold(A))) = "span"(accent(v, arrow)_1, accent(v, arrow)_2, accent(v, arrow)_3)
$

#eg[
  $
    bold(A) = mat(
      1, 1, 1, 1;
      1, 2, 3, 4;
      4, 3, 2, 1;
    )
  $

  We want to find the null space of $A$, which consists of all vectors $x = vec(x_1, x_2, x_3, x_4)$ that satisfy:

  $
    bold(A) accent(x, arrow) = bold(0)
  $

  This expands to the following system of linear equations:

  $
    cases(
      1 x_1 + 1 x_2 + 1 x_3 + 1 x_4 = 0,
      1 x_1 + 2 x_2 + 3 x_3 + 4 x_4 = 0,
      4 x_1 + 3 x_2 + 2 x_3 + 1 x_4 = 0,
    )
  $

  This can be represented as the augmented matrix:

  $
    mat(
      augment: #4,
      1, 1, 1, 1, 0;
      1, 2, 3, 4, 0;
      4, 3, 2, 1, 0;
    )
    
  $
  
]
=== Column Space

The *columns space* (or range) of matrix $A$ is span of its columns vectors

If the matrix $A$ has columns $accent(a, arrow)_1, accent(a, arrow)_2, ..., accent(a, arrow)_n$, then the column space of $A$ is defined as:

$
  "Col"(A) = {accent(y, arrow) in RR^m | accent(y, arrow) = A accent(x, arrow) "for some" accent(x, arrow) in RR^n}
$ 

or equivalently,

$
  "Col"(A) = "span"({accent(a, arrow)_1, accent(a, arrow)_2, ..., accent(a, arrow)_n})
$

#eg[
  Consider the simple example of a $2 times 2$ matrix:

  $
    A = mat(
      1, 2;
      3, 6;
    )
  $

  The matrix has two columns:

  $
    accent(a, arrow)_1 = vec(1, 3) quad quad "and" quad quad accent(a, arrow)_2 = vec(2, 6)
  $

  The column space, denoted $"Col"(A)$, is the span of these two vectors:

  $
    "Col"(A) = "span"({vec(1, 3), vec(2, 6)})
  $

  *Finding the Column Space*

  We observe that the two columns $accent(a, arrow)_1$ and $accent(a, arrow)_2$ are *linearly dependent*: 

  $
    accent(a, arrow)_2 = k accent(a, arrow)_1
  $

  This means that $accent(a, arrow)_2$ is a scalar multiple of $accent(a, arrow)_1$, the the two columns are *linearly dependent*. As a result, the column space is spanned by just one vector, $accent(a, arrow)_1$, because any linear combination of $accent(a, arrow)_1$ and $accent(a, arrow)_2$ can be reduced to a multiple of $accent(a, arrow)_1$.

  Therefore, the column space of $A$ is:

  $
    "Col"(A) = "span"({vec(1, 3)})
  $

  which represents all vectors of the form:

  $
    c vec(1, 3) = vec(c, 3c) quad quad "for any scalar" c
  $

  In other words, the column space is a line in $RR^2$ through the origin in the direction of

  *Rank of $A$*

  The rank of $A$, which is the *dimension of its column space*, is 1 because there is only one linearly independent column
]


This means the column space is the span of the columns of $A$, or all vectors that can be formed by taking linear combinations of the columns of $A$.

=== Dimension of a Subspace

Number of elements in a basis for the subspace 

=== Nullity

*Dimension* of the *Null Space*

$
  dim(N(bold(A)))
$

The nullity of $A$: number of non-pivot columns (i.e., free variables) in the rref of A

=== Rank

*Dimension* of the column *space*

$
  "rank"(A) = "dim"(C(A))
$

=== Matrix Representation of Systems of Equations

$
a_(1 1) x_1 + a_(1 2) x_2 + ... + a_(1 m) x_m = b_1 \
a_(2 1) x_1 + a_(2 2) x_2 + ... + a_(2 m) x_m = b_2 \
dots.v \
a_(n 1) x_1 + a_(n 2) x_2 + ... + a_(n m) x_m = b_n \
$

Coefficient Matrix ($A$):

$
A = mat(
  a_(1 1), a_(1 2), ..., a_(1 m);
  a_(2 1), a_(2 2), ..., a_(2 m);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), dots.h, a_(n m);
)
$

Variable Vector (x):

$
" x " = vec(x_1, x_2, dots.v, x_m)
$

Constant Vector (b):

$
" b " = vec(b_1, b_2, dots.v, b_n)
$


$
"Ax" = b
$

#eg[
The system of equations:

$
2 x_1 + 3 x_2 + 5 x_3 = 100 \
4 x_1 + 2 x_2 + 1 x_3 = 80 \
1 x_1 + 5 x_2 + 2 x_3 = 60 \
$

Can be represented as a matrix equation:

$
mat(
  2, 3, 5;
  4, 2, 1;
  1, 5, 2;
)
vec(x_1, x_2, x_3) 
= vec(100, 80, 60)
$
]

=== Matrix Multiplication

$m times n$ matrix:

$
A = mat(
  a_(1 1), a_(1 2), ..., a_(1 m);
  a_(2 1), a_(2 2), ..., a_(2 m);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), dots.h, a_(n m);
)
$

$n times p$ matrix:

$
B = mat(
  a_(1 1), a_(1 2), ..., a_(1 p);
  a_(2 1), a_(2 2), ..., a_(2 p);
  dots.v, dots.v, dots.down, dots.v;
  a_(n 1), a_(n 2), dots.h, a_(n p);
)
$

Compute Each Element of Result Matrix $C$

$
c_(i j) = sum_(k=1)^n = a_(i k) b_(k j)
$

#eg[
Let $A$ be an $n times m$ matrix:

$
A = mat(
  1, 2, 3;
  4, 5, 6;
)
$

Let $B$ an $p times n$ matrix:

$
B = mat(
  7, 8;
  9, 10;
  11, 12;
)
$

Calculate Each Element of $C$

$
c_(1 1) = (1 dot 7) + (2 dot 9) + (3 dot 11) = 58 \
c_(1 2) = (1 dot 8) + (2 dot 10) + (3 dot 12) = 64 \
c_(2 1) = (4 dot 7) + (5 dot 9) + (6 dot 11) = 138 \
c_(2 2) = (4 dot 8) + (5 dot 10) + (6 dot 12) = 154 \
$

$C$ is a $m times p$ matrix

$
C = mat(
  58, 64;
  139, 154;
)
$
]
