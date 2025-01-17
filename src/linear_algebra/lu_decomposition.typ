#import "../utils/code.typ": code
#import "../utils/examples.typ": eg

=== LU Decomposition

Given a matrix $A$, LU decomposition aims to express $A$ as:

$
A = L U
$

Where:
- $L$: Lower triangular matrix (all elements above the diagonal are zero)
- $U$: Upper triangular matrix (all elements below the diagonal are zero)

1. Solve $L y = b$ Using Forward Substitution

$
L y = b
$

Where:
- $L$: Lower triangular matrix (all elements above the diagonal are zero)
- $y$: Intermediate vector we are solving for
- $b$: Right-hand side vector

$
mat(
  L_11, 0, 0;
  L_21, L_22, 0;
  L_31, L_32, L_33;
) 
vec(y_1, y_2, y_3)
vec(b_1, b_2, b_3)
$

- First row: $L_11 y_1 = b_1$, so $y_1 = b_1 / L_11$

- Second row: $L_21 y_1 + L_22 y_2 = b_2$, substitute $y_1$ into this equation and solve for $y_2$:

$
y_2 = (b_2 - L_21 y_1) / L_22
$

- Third row: $L_31 y_1 + L_32 y_2 + L_33 y_2 = b_3$, substitute $y_1$ and $y_2$ into this equation, solve for $y_3$:

$
y_3 = (b_2 - L_31 y_1 - L_32 y_2) / L_33
$

2. Solve  $U x = y$  Using Backward Substitution

$
U x = y
$

Where:
- $U$: Upper triangular matrix (all elements below the diagonal are zero)
- $y$: Vector of unknowns (solution)
- $b$: Vector computed from the forward substitution step

$
mat(
  U_11, U_12, U_13;
  0, U_22, U_23;
  0, 0, U_33;
)
vec(x_1, x_2, x_3)
vec(y_1, y_2, y_3)
$

- Third row: $U_33 x_3 = y_3$, so $x_3 = y_3 / U_33$

- Second row: $U_22 x_2 + U_23 x_3 = y_2$, substitute $x_3$ from the previous step and solve for $x_2$:

$
x_2 = (y_2 - U_23 x_3) / U_22
$

- First row: $U_11 x_1 + U_12 x_2 + U_13 x_3 = y_1$, substitute $x_2$ and $x_3$ from the previous step and solve for $x_1$:

$
x_1 = (y_1 - U_12 x_2 - U_13 x_3) / U_11
$

#eg[
  $
  A = mat(
    2, 3, 1;
    4, 7, 3;
    6, 18, 5;
  )
  quad quad
  b = vec(5, 12, 31)
  $

  1. Factor $A$ into $L$ and $U$:

  $
  L = mat(
    1, 0, 0;
    2, 1, 0;
    3, 6, 1;
  )
  quad quad
  U = mat(
    2, 3, 1;
    0, 1, 1;
    0, 0, -2;
  )
  $

  2. Solve $A x = b$

  - $y_1 = b_1 / L_(1 1) = 5 / 1 = 5$

  - $y_2 = (b_2 - L_(2 1) y_1) / L_(2 2) = (12 - 2 times 5) / 1 = 2$

  - $y_2 = (b_3 - L_(3 1) y_1 - L_(3 2) y_2) / L_(3 3) = (31 - 4 times 5 - 3 times 2) / 1 = 5$

  So,

  $
  y = vec(5, 2, 5)
  $

  3. Solve $U x = y$

  - $x_3 = y_3 / U_(3 3) = 5 / -2 = -2.5$

  - $x_2 = (y_2 - U_(2 3) x_3) / U_(2 2) = (2 - 1 times -2.5) / 1 = 4.5$

  - $x_1 = (y_1 - U_(1 2) x_2 - U_(1 3) x_3) / U_(1 1) = (5 - 3 times 4.5 - 1 times -2.5) / 2 = -4$
  
  So,

  $
  x = vec(-4, 4.5, -2.5)
  $

]