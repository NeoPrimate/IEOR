#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== MIP (Mixed Integer Programming)

Optimizing (maximizing or minimizing) a linear *objective function* subject to linear equality or inequality *constraints*. *Decision variables* can take any continuous real or integer values

Minimize (or Maximize): 
$
c^T x
$

Subject to:

- $A x ≤ b$

- $x_i in ZZ$ for some $i$
- $x_j in RR$ for the remaining $j$

Where:

- $x$ is the vector of decision variables
- $c$ is the vector of objective function coefficients
- $A$ is the constraint coefficient matrix
- $b$ is the vector of constraint right-hand side values
- $x_i$ represents integer variables
- $x_j$ represents continuous variables

#eg[

  *Objective Function*

  Maximize 
  
  $
  c^T x
  $

  $
  mat(3, 2, -5, -4) vec(x_1, x_2, x_3, x_4)
  $

  *Constraints*

  $
  A x lt.eq b
  $

  $
  mat(
    1, 2, 0, 0;
    3, 1, 0, 0;
    1, 0, -5, 0;
    0, 1, 0, -5;
  ) vec(x_1, x_2, x_3, x_4) lt.eq vec(8, 12, 0, 0) 
  $
]