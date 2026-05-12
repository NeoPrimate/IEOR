#import "/lib/imports.typ": *
#show: formatting

1. Definition of Linear Independence

The set of vectors

$
  S = {v_1, v_2, dots, v_n}
$

is said to be *linearly independent* if the only solution to the equation

$
  c_1 v_1 + c_2 v_2 + dots + c_n v_n = bold(0)
$

is $c_1 = c_2 = dots = c_n = 0$. In other words, no vector in the set can be written as a linear combination of the others.

If at least one constant $c_i$ is non-zero, the set is linearly dependent.

#example[

  *Example 1*: Testing for Linear Independence

  *Problem*: Is the following set of vectors *linearly dependent*?

  $
    S = {accent(v, arrow)_1 accent(v, arrow)_2}
  $

  Where:

  $
    accent(v, arrow)_1 = vec(2, 1) quad "and" quad accent(v, arrow)_2 = vec(3, 2)
  $

  For a set of vectors to be *linearly independent*, the only solution to the equation:

  $
    c_1 accent(v, arrow)_1 + c_2 accent(v, arrow)_2 = bold(0)
  $

  must be $c_1 = 0$ and $c_2 = 0$

  In this case:

  $
    c_1 vec(2, 1) + c_2 vec(3, 2) = bold(0)
  $

  If not only the zero solution exists (i.e., if $c_1$ or $c_2$ can be non-zero), the set is *linearly dependent*.

  *Step 1. Set up the system of equations:*

  1. $2 c_1 + 3 c_2 = 0$
  2. $1 c_1 + 2 c_2 = 0$

  *2. Eliminate one variable*

  $
    2 times (1 c_1 + 2 c_2 = 0) arrow.double 2 c_1 + 4 c_2 = 0
  $

  #h(1em) Now the system is

  $
    2 c_1 + 3 c_2 = 0 \
    2 c_1 + 4 c_2 = 0 \
  $

  *3. Subtract the equations*

  $
    (2 c_1 + 3 c_2) - (2 c_1 + 4 c_2) = 0
  $

  #h(1em) Simplifies to:

  $
    (2 c_1 - 2 c_1) + (4 c_2 - 3 c_2) = 0 \
  $

  #h(1em) So:

  $
    c_2 = 0
  $

  *4. Substitute back to find $bold(c_1)$*

  Now that we know $c_2 = 0$, substitute this value into one of the original equations. Let's use the second equation:

  $
    1 c_1 + 2 c_2 = 0
  $

  #h(1em) Substitute $c_2 = 0$:

  $
    1 c_1 + 2 (0) = 0 \
    c_1 = 0
  $

  *Conclusion:*

  Since $c_1 = 0 quad quad quad c_2 = 0$, the set of vectors $S$ is *linearly independent*. These vecots span $RR^2$.

  #line(length: 100%)

  *Example 2*: Testing for Linear Dependence

  *Problem*: Is the following set of vectors *linearly dependent*?

  $
    S = {accent(v, arrow)_1 accent(v, arrow)_2}
  $

  Where:

  $
    accent(v, arrow)_1 = vec(2, 3) quad "and" quad accent(v, arrow)_2 = vec(4, 6)
  $

  The span of this set is the collection of all vectors that can be formed by linear combinations of $accent(v, arrow)_1$ and $accent(v, arrow)_2$:

  $
    c_1 v_1 + c_2 v_2
  $

  Since $v_2 = 2 v_1$, the linear combination becomes:

  $
    c_1 v_1 + c_2 (2 v_1) = (c_1 + 2 c_2) v_1 \
    c_1 vec(2, 3) + c_2 vec(4, 6) \
    c_1 vec(2, 3) + c_2 2 vec(2, 3) \
    (c_1 + 2 c_2) vec(2, 3) \
    c_3 vec(2, 3)
  $

  Thus, any linear combination of these vectors is just a scalar multiple of $v_1$. The span is a single line in $RR^2$, and the vectors are *linearly dependent*.

  For any two *colinear* vectors in $RR^2$, their span reduces to a single line.

  One vector in the set can be represented by some combination of other vectors in the set
]

*2. General Rule*

In $RR^n$ , if you have more than $n$ vectors, at least one vector must be linearly dependent on the others, meaning the set cannot be linearly independent.
