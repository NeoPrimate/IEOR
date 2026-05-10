#import "/lib/imports.typ": *

The *columns space* (or range) of matrix $A$ is span of its columns vectors

If the matrix $A$ has columns $accent(a, arrow)_1, accent(a, arrow)_2, ..., accent(a, arrow)_n$, then the column space of $A$ is defined as:

$
  "Col"(A) = {accent(y, arrow) in RR^m | accent(y, arrow) = A accent(x, arrow) "for some" accent(x, arrow) in RR^n}
$

or equivalently,

$
  "Col"(A) = "span"({accent(a, arrow)_1, accent(a, arrow)_2, ..., accent(a, arrow)_n})
$

#example[
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
