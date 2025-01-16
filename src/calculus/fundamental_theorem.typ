#import "../utils/examples.typ": eg
#import "../utils/code.typ": code

== Fundamental Theorem of Calculus

1. If $F(x)$ is the antiderivative of $f(x)$ (meaning $F'(x) = f(x)$), then the definite integral of $f(x)$ from $a$ to $b$ is the difference in the values of the antiderivative:

$
integral_a^b f(x) d x = F(b) - F(a)
$

If you take the derivative of a function and then integrate it, you recover the original function

2. If $f(x)$ is continuous on an interval, then the derivative of the integral of $f(x)$ from a constant $a$ to $x$ is the original function $f(x)$:

$
d / (d x) (integral_a^x f(t) d t) = f(x)
$

Differentiating the integral of a function recovers the original function

#eg[
  Suppose

  $
  f(x) = 3x^2
  $

  We want to: 
  
  - Find the definite integral of $f(x)$ from 1 to 2
  - Verify that the derivative of the integral function recovers $f(x)$

  *1. Using the First Part of the FTC:*

  We need to find the definite integral: 
  
  $
  integral^2_1 3x^2 d x
  $

  - The antiderivative of $3x^2$ is $F(x) = x^3$ (since the derivative of $x^3$ is $3x^2$)
  - Apply the formula:

  $
  integral^2_1 3x^2 d x = F(2) - F(1) = 2^3 - 1^3 = 8 - 1 = 7
  $

  So, 
  
  $
  integral^2_1 3x^2 d x = 7
  $

  *2. Using the Second Part of the FTC:*

  Let's define the integral function as:

  $
  F(x) = integral^x_1 3t^2 d t
  $

  Now, we take the derivative of $F(x)$. By the second part of the FTC:

  $
  F'(x) = 3x^2
  $

  This shows that the derivative of the integral function gives us back the original function $f(x)=3x^2$, verifying the relationship between differentiation and integration.

]

#code[
  ```py
  import sympy as sp

  # Define the variable
  x = sp.Symbol('x')

  # Define the function f(x)
  f = 3 * x**2

  # 1. Compute the definite integral of f(x) from 1 to 2

  # Find the antiderivative of f(x)
  F = sp.integrate(f, x)

  # Compute the definite integral using the antiderivative
  a, b = 1, 2
  definite_integral = F.subs(x, b) - F.subs(x, a)

  # Print the result
  print("Definite Integral of 3x^2 from 1 to 2:", definite_integral)

  # 2. Define the integral function F(x) with limits from 1 to x
  F_x = sp.integrate(f, (x, 1, x))

  # Compute the derivative of F(x)
  F_prime = sp.diff(F_x, x)

  # Print the results
  print("Integral Function F(x):", F_x)
  print("Derivative of the Integral Function F'(x):", F_prime)
  ```
]