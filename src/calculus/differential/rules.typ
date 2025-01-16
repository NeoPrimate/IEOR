#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== Derivative

Measures the instantaneous rate of change of a function

Derivative of of a function $f(x)$

$
f'(x) = d / (d x) f(x)
$

General Pattern:
- *Linear term*: If a function is linear (e.g., $a x + b$), the first derivative will be a constant $a$.
- *Constant term*: The derivative of a constant is zero.
- *Higher-degree polynomials*: For polynomials of higher degrees, each derivative decreases the degree of the polynomial until you get a constant, after which all further derivatives are zero.

#eg[
Consider the quartic function: $f(x) = x^4 - 2x^2 + 1$
- First derivative: $f'(x) = 4x^3 - 4x$ (*cubic*)
- Second derivative: $f''(x) = 12x^2 - 4$ (*quadratic*)
- Third derivative: $f'''(x) = 24x$ (*linear*)
- Fourth derivative: $f''''(x) = 24$ (*constant*)
- Fourth derivative: $f'''''(x) = 0$ (*zero*)
]

#figure(image("../../vis/derivatives.png", width: 50%))

=== Power Rule

$
f(x) &= x^n \

f'(x) &= n x^(n-1) \
$

#eg[
  $
  f(x) &= x^3 \

  f'(x) &= 3x^2 \
  $
]

=== Product Rule

$
f(x) &= u(x) dot v(x) \

f'(x) &= u'(x) v(x) + u(x) v'(x) \
$

#eg[
  $ f(x) = x^2 dot x^3 $

  $ u(x) = x^2 $
  $ v(x) = x^3 $

  1. Compute the derivatives of $u(x)$ and $v(x)$

  $ u'(x) = 2x $
  $ v'(x) = 3x^2 $

  2. Apply rule

  $ 
  f'(x) &= (2x)(x^3)+(x^2)(3x^2) \
  &= 2x^2 + 3x^4 \
  &= 5x^4 \
  $
]

=== Quotient Rule

$
f(x) &= u(x) / v(x) \

f'(x) &= (u'(x) v(x) - u(x) v'(x)) / v(x)^2 \
$

#eg[
  $ f(x) = x^3 / x^2 $

  $ u(x) = x^3 $

  $ v(x) = x^2 $

  1. Compute the derivatives of $u(x)$ and $v(x)$

  $ u'(x) = 3x^2 $

  $ v'(x) = 2x $

  2. Apply rule

  $ 

  f'(x) &= ((3x^2)(x^2) - (x^3)(2x)) / (x^2)^2 \
  &= (3x^4 - 2x^4) / x^4 \
  &= x^4 / x^4 \
  &= 1 \
$

]

=== Chain Rule

$
f(g(x)) \

f'(x) = f'(g(x)) dot g'(x) \
$

#eg[
  $
  f(x) = (2x + 1)^3
  $

  - Outer function: 
  $
  f(u) = u^3
  $

  - Inner function
  $
  g(x) = 2x + 1 \
  $

  1. Compute the derivatives of $f'(u)$ and $g'(x)$

  $ f'(u) = 3u^2 $

  $ g'(x) = 2 $

  2. Apply rule

  $ 
  f'(x) &= 3(2x + 1)^2 dot 2 \
  
  &= 6(2x + 1)^2 \

  $
]

=== Others

*1. Trigonometric Functions*

$
d / (d x) [sin(x)] = cos(x) \
$

$
d / (d x) [cos(x)] = -sin(x) \
$

$
d / (d x) [tan(x)] = sec^2(x) \
$

$
d / (d x) [cot(x)] = csc^2(x) \
$

$
d / (d x) [sec(x)] = sec(x)tan(x) \
$

$
d / (d x) [csc(x)] = -csc(x)cot(x) \
$

*2. Inverse Trigonometric Functions*

$
d / (d x) [arcsin(x)] = 1 / sqrt(1 - x^2) \
$

$
d / (d x) [arccos(x)] = -1 / sqrt(1 - x^2) \
$

$
d / (d x) [arctan(x)] = 1 / (1 + x^2) \
$

$
d / (d x) ["arccot"(x)] = -1 / (1 + x^2) \
$

$
d / (d x) ["arcsec"(x)] = 1 / (|x| sqrt(x^2 - 1)) \
$

$
d / (d x) ["arccsc"(x)] = -1 / (|x| sqrt(x^2 - 1)) \
$

*3. Exponential and Logarithmic Functions*

$
d / (d x) [e^x] = e^x \
$

$
d / (d x) [a^x] = a^x ln(a) \
$

$
d / (d x) [ln(x)] = 1 / x \
$

$
d / (d x) [log_a(x)] = 1 / (x ln(a)) \
$


#code[
  ```py
  import sympy as sp

  # Define the symbolic variable x
  x = sp.symbols('x')

  # Define the function f(x) = 3x^2 + 2x + 1
  f = 3 * x**2 + 2 * x + 1

  # Compute the derivative of f with respect to x
  f_prime = sp.diff(f, x)

  # Print the derivative of f
  print(f_prime)  # Output: 6x + 2

  # Create a numerical function from the symbolic derivative
  f_prime_func = sp.lambdify(x, f_prime)

  # Evaluate the derivative at x = 2
  result = f_prime_func(2)

  # Print the result of f'(2)
  print(result)  # Output: 14

  # Solve f'(x) = 0 to find the critical values (where the derivative is 0)
  critical_values = sp.solve(f_prime, x)

  # Print the critical values (roots of the derivative)
  print(critical_values)  # Output: [-1/3]
  ```
]
