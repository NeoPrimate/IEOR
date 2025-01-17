#import "../utils/examples.typ": eg
#import "../utils/result.typ": result

=== Gaussian Elimination

Convert a matrix into its row echelon form (REF) or reduced row echelon form (RREF)

$
a_(1 1) x_1 + a_(1 2) x_2 + dots + a_(1 n) x_n = b_1 \
a_(2 1) x_1 + a_(2 2) x_2 + dots + a_(2 n) x_n = b_2 \
dots.v \
a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n = b_m \
$

1. Create an augmented matrix

$
A = mat(
  augment: #4,
  a_(1 1), a_(1 2), dots, a_(1 n), b_1;
  a_(2 1), a_(2 2), dots, a_(2 n), b_2;
  dots.v, dots.v, dots.down, dots.v, b_3;
  a_(2m 1), a_(m 2), dots, a_(m n), b_m;
)
$

2. Forward Elimination

Eliminate the element in the $i$-th of the $k$-th column ($k > i$)

$
R_k arrow.l R_k - a_(k i) / a_(i i) R_i
$

Where
- $a_(i i)$: Pivot element
- $R_k$: $k$-th row
- $R_i$: $i$-th row


3. Back Substitution



4.	Reduced Row Echelon Form (RREF)



#eg[
  $
  2 x_1 + 3 x_2 = 5 \
  4 x_1 + 5 x_2 = 5 \
  $

  1. Create an augmented matrix

  $
  mat(
    augment: #2,
    2, 3, 5;
    4, 5, 6;
  )
  $

  2. Forward Elimination

  $R_k arrow.l R_k - a_(k i) / a_(i i) R_i$
  
  $R_k arrow.l R_k - a_(2 1) / a_(1 1) R_i$
  
  $R_2 arrow.l R_2 - 4 / 2 R_1$

  $R_2 arrow.l R_2 - 2 times R_1$

  $
  mat(
    augment: #2,
    2, 3, 5;
    4 - 2 times 2, 5 - 2 times 3, 6 - 2 times 5;
  )
  $

  Simplifies to:

  $
  mat(
    augment: #2,
    2, 3, 5;
    0, -1, -4;
  )
  $

  System is now:

  $
  2 x_1 + 3 x_2 &= 5 \
  -1 x_2 &= -4 \
  $

  3. Back Substitution

  $
  -1 x_2 = -4 \
  x_2 = 4 \
  $

  Substitute:

  $
  2 x_1 + 3 (4) = 5 \
  2 x_1 + 12 = 5 \
  x_1 = -3.5 \
  $

  Solution:

  $
  x_1 = -3.5 \
  x_2 = 4 \
  $

]