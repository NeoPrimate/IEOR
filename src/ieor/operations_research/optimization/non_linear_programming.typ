#import "../../../../../utils/examples.typ": eg
#import "../../../../../utils/code.typ": code

== Non-Linear Programming

Optimizing (maximizing or minimizing) a linear objective function subject to linear equality or inequality constraints. In LP, the decision variables can take any continuous real values.


#eg[

  #linebreak()

  1. Non-Linear Programming (Linear Constraints)

  Objective function

  $
  f(x, y) = x^2 + y^2
  $

  Constraints

  $
  x + y gt.eq 0 \
  x gt.eq 0 \
  $

  #figure(image("../../../vis/non_linear_programming_linear_constraints.png", width: 80%))
  
  2. Non-Linear Programming (Non-Linear Constraints)

  Objective function

  $
  f(x, y) = x^2 + y^2
  $

  Constraints

  $
  x + y gt.eq 0 \
  x^2 + y^2 lt.eq 1 \
  $
  
  #figure(image("../../../vis/non_linear_programming_non_linear_constraints.png", width: 80%))

  #linebreak()
]