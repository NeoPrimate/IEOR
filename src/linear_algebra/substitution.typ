#import "../utils/code.typ": code
#import "../utils/examples.typ": eg

=== Substitution

#eg[

  #linebreak()

  $
  x + y = 10 quad quad ("Equation" 1) \
  
  2 x - y = 5 quad quad ("Equation" 2) \
  $

  #linebreak()

  1. Solve Equation 1 for $y$

  $
  y = 10 - x
  $

  2. Substitute into Equation 2

  $
  2 x - (10 - x) = 5
  $

  3. Solve for x:

  $
  2 x - 10 + x = 5 \
  3 x - 10 = 5 \
  3 x = 15 \
  x = 5
  $

  4. Find $y$ using value of $x$

  $
  y = 10 - x \
  y = 10 - 5 \
  y = 5
  $
]