#import "../../../utils/code.typ": code
#import "../../../utils/examples.typ": eg

== Solving Systems of Linear Equations

Linear Equation

$
y = a_1 x_1 + a_1 x_2 + ... + a_n x_n
$

1. Consistency 

Whether a system of linear equations has at least one solution

#eg[

  *Consistent System*
  
  $
  x + y = 3 \
  x - y = 1 \
  $
  
  This system has a unique solution 
  
  $
  (x, y) = (2, 1)
  $

  *Inconsistent System*

  $
  x + y = 3 \
  x + y = 5 \
  $

  This system is inconsistent (equations contradict each other, no solution can satisfy both)
]

2. Independence

Whether the equations in the system provide unique and non-redundant information about the variables

#eg[
  *Independent Equations*

  $
  x + y = 3 \
  x - y = 1 \
  $

  Neither equation can be derived from the other (they provide unique information and intersect at a single point)

  *Dependent Equations*

  $
  x + y = 3 \
  2 x + 2 y = 6 \
  $

  Second equation is just a multiple of the first equation (they describe the same line)

]

3. Recognizing Systems with No Solution or Infinite Solutions

#eg[
  $
  3 x + 2 y = 6 quad quad ("Equation" 1) \
  6 x + 4 y = 12 quad quad ("Equation" 2) \
  $

  #figure(
    image("../vis/system_linear_unique_solution.png", width: 50%),
    caption: [Unique Solution (Consistent and Independent)],
  )

  #figure(
    image("../vis/system_linear_eq_no_solution.png", width: 50%),
    caption: [No Solution (Inconsistent)]
  )
  
  #figure(
    image("../vis/system_linear_eq_infinite_solution.png", width: 50%),
    caption: [Infinitely Many Solutions (Consistent and Dependent)]
  )

]

2. Matrix Respresentation 

System of Equations 

$
a_(1 1) x_1 + a_(1 2) x_2 + dots + a_(1 n) x_n = b_1 \
a_(2 1) x_1 + a_(2 2) x_2 + dots + a_(2 n) x_n = b_2 \
dots.v \
a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n = b_m \
$

Matrix Respresentation

Coefficient vector ($Alpha$)

$
A = mat(
  a_(1 1), a_(1 2), dots, a_(1 n);
  a_(2 1), a_(2 2), dots, a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(2m 1), a_(m 2), dots, a_(m n);
)
$

Variable vector ($x$)

$
x = vec(x_1, x_2, dots.v, x_n) \
$

Constant vector ($b$)

$
b = vec(b_1, b_2, dots.v, b_m)
$

Matrix equation

$
A x = b
$

#code[
  ```py
  from scipy.linalg import solve

  X = np.array([
    [1, 1, 1],
    [2, -1, 3],
    [3, 4, -1]
  ])

  Y = np.array([6, 14, 1])

  intersection_point = solve(X, Y)
  ```
]