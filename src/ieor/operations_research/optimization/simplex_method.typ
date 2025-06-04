#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== Simplex Method

1. Formulation

*Objective Function* 

$
Z &= c_1 x_1 + c_2 x_2 + dots + c_n x_n = c^T x
$

*Constraints*

$
a_11 + x_1 + a_12 x_2 + dots + a_(1 n) x_n #text(fill: red)[$lt.eq$] "or" #text(fill: red)[$gt.eq$] b_1 \
a_21 + x_1 + a_22 x_2 + dots + a_(2 n) x_n #text(fill: red)[$lt.eq$] "or" #text(fill: red)[$gt.eq$] b_2 \
dots.v \
a_(m 1) + x_1 + a_(m 2) x_2 + dots + a_(m n) x_n #text(fill: red)[$lt.eq$] "or" #text(fill: red)[$gt.eq$] b_m \
$

$
x_1, x_2, dots, x_n gt.eq  0
$

Or,

$
A x #text(fill: red)[$lt.eq$] "or" #text(fill: red)[$gt.eq$] b \
x gt.eq 0
$

- #text(fill: red)[$lt.eq$] for maximization
- #text(fill: red)[$gt.eq$] for minimization

2. Convert to Canonical Form

$
a_11 + x_1 + a_12 x_2 + dots + a_(1 n) x_n #text(fill: red)[$+ s_1$] eq b_1 \
a_21 + x_1 + a_22 x_2 + dots + a_(2 n) x_n #text(fill: red)[$+ s_2$] eq b_2 \
dots.v \
a_(m 1) + x_1 + a_(m 2) x_2 + dots + a_(m n) x_n #text(fill: red)[$+ s_m$] eq b_m \
$

$
x_1, x_2, dots, x_n gt.eq  0
$

$
#text(fill: red)[$s_1, s_2, dots, s_m gt.eq 0$]
$

Or,

$
A x  #text(fill: red)[$+ I s$] = b_i
$

$
x gt.eq  0
$

$
#text(fill: red)[$s_i gt.eq 0$]
$

3. Set up Simplex Tableau

#align(
  center,
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
    inset: (x: 0.5em, y: 0.5em),
    align: horizon,
    stroke: none,
    table.vline(x: 1, start: 0),
    table.vline(x: 5, start: 0),
    table.vline(x: 9, start: 0),
    table.header(
      [], [$x_1$], [$x_2$], [$dots$], [$x_n$], [$s_1$], [$s_2$], [$dots$], [$s_m$], [RHS],
    ),
    table.hline(),
    [Constraint 1], [$a_11$], [$a_12$], [$dots$], [$a_1n$], [1], [0], [$dots$], [0], [$b_1$], 
    [Constraint 2], [$a_21$], [$a_22$], [$dots$], [$a_2n$], [0], [1], [$dots$], [0], [$b_2$],
    [$dots.v$], [$dots.v$], [$dots.v$], [$dots.down$], [$dots.v$], [$dots.v$], [$dots.v$], [$dots.down$], [$dots.v$], [$dots.v$],
    [Constraint $n$], [$a_(m 1)$], [$a_(m 2)$], [$dots$], [$a_(m n)$], [0], [0], [$dots$], [1], [$b_m$],
    table.hline(),
    [Objective Function], [$#text(fill: red)[$-$]c_1$], [$#text(fill: red)[$-$]c_2$], [$dots$], [$#text(fill: red)[$-$]c_n$], [0], [0], [$dots$], [0], [0],
  )
)

- #text(fill: red)[$-$] for maximization
- #text(fill: red)[$+$] for minimization

4. Perform Pivot Operation

- *Identify the Pivot Column*: Choose the column with the most: 

  - Maximization: Negative coefficient 

  - Minimization: Positive coefficient (or multiply the objective by -1 and treat it as a maximization)

in the objective function row (this indicates which variable will enter the basis).

- *Identify the Pivot Row*: Calculate the ratio of RHS to the pivot column's coefficients (only where coefficients are positive). The row with the smallest ratio determines the variable to leave the basis.

- *Pivot*: Perform row operations to change the pivot element to 1 and other elements in the pivot column to 0. This involves dividing the pivot row by the pivot element and then adjusting the other rows to zero out the pivot column.

5. Iterate

Repeat the pivot operations until there are no more negative coefficients in the objective function row, indicating that the current solution is optimal.

6. Read the Solution

The final tableau will give the values of the variables at the optimal solution. The basic variables are the variables corresponding to the columns with the identity matrix in the final tableau, while non-basic variables are set to zero.

#eg[
$"Maximize": quad quad Z = 3 x_1 + 2 x_2$

s.t.

#h(10mm) $x_1 + x_2 lt.eq 4$

#h(10mm) $2x_1 + x_2 lt.eq 5$

#h(10mm) $x_1, x_2 gt.eq 0$

*1. Convert to Canonical Form*

Introduce slack variables $s_1$ and $s_2$ to convert inequalities into equalities:

#h(10mm) $x_1 + x_2 + s_1 = 4$

#h(10mm) $2x_1 + x_2 + s_2 = 5$

#h(10mm) $x_1, x_2, s_1, s_2 gt.eq 0$

Initialize Simplex Tableau

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: (x: 0.5em, y: 0.5em),
  align: horizon,
  stroke: none,
  table.vline(x: 1, start: 0),
  table.vline(x: 3, start: 0),
  table.vline(x: 5, start: 0),
  table.header(
    [], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [RHS],
  ),
  table.hline(),
  [Constraint 1], [1], [1], [1], [0], [4], 
  [Constraint 2], [2], [1], [0], [1], [5],
  table.hline(),
  [Objective Function], [-3], [-2], [0], [0], [0],
)

*2. Identify the Pivot Column*

In the objective function row, the coefficients are $[-3, -2, 0, 0]$. The most negative coefficient is $-3$, which is in the $x_1$ column. Therefore, $x_1$ will enter the basis.

*3. Identify the Pivot Row*

Calculate the ratio of RHS to the pivot column's coefficients (where the coefficients are positive):

- For Row 1:  $4 / 1 = 4$  (pivot column coefficient is 1)

- For Row 2:  $5 / 2 = 2.5$  (pivot column coefficient is 2)

The smallest ratio is 2.5, so Row 2 will be the pivot row. This means that $s_2$ will leave the basis.

*4. Pivot*

Perform row operations to make the pivot element 1 and zero out other elements in the pivot column.

Pivot Element: The element at the intersection of Row 2 and $x_1$ column is 2.

Steps:

1. Make Pivot Element 1: Divide all elements in Row 2 by the pivot element (2):

$
"New Row" 2 &= 1 / 2 times "Old Row" 2 \
&= [1, 0.5, 0, 0.5, 2.5]
$

2. Zero Out Pivot Column in Other Rows:

- For Row 1: Subtract 1 times New Row 2 from Row 1:

$
"New Row" 1 &= "Old Row" 1 - [1, 0.5, 0, 0.5, 2.5] \
&= [0, 0.5, 1, -0.5, 1.5]
$

- For Objective Function: Add 3 times New Row 2 to the Objective Function row

$
"New Objective Function" &= "Old Objective Function" + 3 times [1, 0.5, 0, 0.5, 2.5] \
&= [0, -0.5, 0, 1.5, 7.5]
$

Updated Simplex Tableau

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: (x: 0.5em, y: 0.5em),
  align: horizon,
  stroke: none,
  table.vline(x: 1, start: 0),
  table.vline(x: 3, start: 0),
  table.vline(x: 5, start: 0),
  table.header(
    [], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [RHS],
  ),
  table.hline(),
  [Constraint 1], [0], [0.5], [1], [-0.5], [1.5], 
  [Constraint 2], [1], [0.5], [0], [0.5], [2.5],
  table.hline(),
  [Objective Function], [0], [-0.5], [0], [1.5], [7.5],
)



]