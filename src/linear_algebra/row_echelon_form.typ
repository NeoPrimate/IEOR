#import "../utils/code.typ": code
#import "../utils/examples.typ": eg
#import "@preview/cetz:0.2.2"

#set math.vec(delim: "[")
#set math.mat(delim: "[")


== Row Echelon Form (REF)

Visual Structure:

1. Pivot (leading 1): The leading entry of each non-zero row is 1
2. Zeros below pivots: Every pivot has zeros below it in its column
3. Rightward movement of pivots: Each leading 1 in a lower row is further to the right than in the row above it
4. Rows of all zeros (if any) are at the bottom of the matrix

$
mat(
  augment: #4,
  1, a_(1 2), a_(1 3), a_(1 4), b_1;
  0, 1, a_(2 3), a_(2 4), b_2;
  0, 0, 1, a_(3 4), b_3;
  0, 0, 0, 0, 0;
)
$


Elementary row operations:
1. *Row Swapping*: Swap two rows
2. *Row Multiplication*: Multiply a row by a non-zero scalar
3. *Row Addition / Subtraction*: Add or subtract a multiple of one row from another row



#eg[

Consider the system of linear equations:

$
2x + y + z = 8 \
-3x -y +2z = -11 \
-2x +1y + 2z = -3 \ 
$

The augmented matrix for this system is:

$
mat(
  augment: #3,
  2, 1, 1, 8;
  -3, -1, 2, -11;
  -2, 1, 2, -3;
)
$

*Step 1*: Make the leading entry of the first row a 1

We divide the first row by 2 (row multiplication):

$
R_1 arrow 1/2 R_1 = 
mat(
  augment: #3,
  1, 0.5, 0.5, 4;
  -3, -1, 2, -11;
  -2, 1, 2, -3;
)
$

*Step 2*: Eliminate the entries below the first pivot
We now want the entries below the first pivot (1 in the first column) to become zeros. We use row addition:

1. $
R_2 arrow R_2 + 3 R_1
$
2. $
R_3 arrow R_3 + 2 R_1
$

This gives:

$
mat(
  augment: #3,
  1, 0.5, 0.5, 4;
  0, 0.5, 3.5, 1;
  0, 2, 3, 5;
)
$

*Step 3*: Make the leading entry of the second row a 1

We divide the second row by 0.5 (row multiplication):

$
R_2 arrow 1 / 0.5 R_2 = mat(
  augment: #3,
  1, 0.5, 0.5, 4;
  0, 1, 7, 2;
  0, 2, 3, 5;
)
$

*Step 4*: Eliminate the entry below the second pivot

We now want the entry below the second pivot (1 in the second column) to become zero. We use row addition:

$
R_3 arrow R_2 - 2 R_2 = mat(
  augment: #3,
  1, 0.5, 0.5, 4;
  0, 1, 7, 2;
  0, 0, -11, 1;
)
$

*Step 5*: Make the leading entry of the third row a 1

We divide the third row by -11 (row multiplication):

$
R_3 arrow -1/11 R_3 = mat(
  augment: #3,
  1, 0.5, 0.5, 4;
  0, 1, 7, 2;
  0, 0, 1, -1/11;
)
$

*Step 6*: Back-substitute to solve for the variables

From the third row:

$
z = - 1 / 11
$

Substitute $z$ into the second row:

$
y + 7 z = 2 \
y + 7 (-1/11) = 2 \
y = 2 + 7 / 11 \
y = 29 / 11 \
$

Substitute $y$ and $z$ into the first row:

$
x + 0.5 y + 0.5 z = 4 \
x + 0.5 (29 / 11) + 0.5 (- 1 / 11) = 4 \
x = 4 - 14 / 11 + 1 / 11 \
x = 31 / 11
$

*Final Solution*:

$
x = 31 / 11 quad quad quad y = 29 / 11 quad quad quad z = - 1 / 11
$

]

=== Solution Types in Linear Systems: Unique, Infinite, or None

*1. Unique Solution*

$
mat(
  augment: #4,
  1, a_(1 2), a_(1 3), a_(1 4), b_1;
  0, 1, a_(2 3), a_(2 4), b_2;
  0, 0, 1, a_(3 4), b_3;
  0, 0, 0, 0, 0;
)
$

*2. No Solution*

$
0 = a
$

*3. No Unique Solution (Infinite Number of Solutions)*

Column 2 and 4 indicate free variables $x_2$ and $x_4$ becuase they have no pivot entries

$
mat(
  augment: #4,
  1, a_(1 2), a_(1 3), a_(1 4), b_1;
  0, 0, 1, a_(2 4), b_2;
  0, 0, 1, a_(3 4), b_3;
  0, 0, 0, 0, 0;
)
$

=== Special Cases

Rows of all zeros appear in row echelon form (REF) in the following situations:

*1. Dependent Equations*

Some equations are multiples or linear combinations of others

$
2x + 4y = 8 \
x + 2y = 4
$

Augmented matrix:

$
mat(
  augment: #2,
  2, 4, 8;
  1, 2, 4;
) 
$

After row reduction:

$
mat(
  augment: #2,
  1, 2, 4;
  0, 0, 0;
)
$

*2. Underdetermined Systems*

Number of variables is greater than the number of independent equations

$
x + y + z = 2 \
2x + 3y + z = 5
$

Augmented matrix:

$
mat(
  augment: #3,
  1, 1, 1, 2;
  2, 3, 1, 5;
) 
$

After row reduction:

$
mat(
  augment: #3,
  1, 1, 1, 2;
  0, 0, 0, 0;
)
$

*3. Inconsistent Systems*

No solution exists

Rows of zeros on the left side (coefficients of the variables) and a non-zero entry on the right side (augmented column)

$
x + y = 3 \
2x + 2y = 7
$

Augmented matrix:

$
mat(
  augment: #2,
  1, 1, 3;
  2, 2, 7;
)
$

After row reduction:

$
mat(
  augment: #2,
  1, 1, 3;
  0, 0, 1;
)
$