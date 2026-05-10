#import "/lib/imports.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")

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

== Matrix-Vector Products

$
  bold(A) = mat(
    a_(1 1), a_(1 2), ..., a_(1 n);
    a_(2 1), a_(2 2), ..., a_(2 n);
    dots.v, dots.v, dots.down, dots.v;
    a_(m 1), a_(m 2), dots.h, a_(m n);
  )
$

$
  bold("x") = vec(x_1, x_2, dots.v, x_n)
$

$
  bold(A) bold("x") = vec(
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
  #text(red)[$bold("a") = vec(a_1, a_2, dots.v, a_n)$] \
  #text(blue)[$bold("b") = vec(b_1, b_2, dots.v, b_n)$] \
$

$
  #text(red)[$bold("a")^T = [a_1, a_2, dots, a_n]$] \
  #text(blue)[$bold("b")^T = [b_1, b_2, dots, b_n]$] \
$

$
  bold(A) = vec(
    #text(red)[$[a_1, a_2, dots, a_n]$],
    #text(blue)[$[b_1, b_2, dots, b_n]$],
  )
$

$
  bold(A) = vec(
    #text(red)[$bold("a")$],
    #text(blue)[$bold("b")$],
  )
$

$
  bold("x") = vec(x_1, x_2, dots.v, x_n)
$

$
  vec(#text(red)[$bold("a")^T$], #text(blue)[$bold("b")^T$]) dot bold("x") = vec(#text(red)[$bold("a")$] dot bold("x"), #text(blue)[$bold("b")$] dot bold("x"))
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
