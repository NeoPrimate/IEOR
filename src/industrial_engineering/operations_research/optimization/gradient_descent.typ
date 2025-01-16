#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== Gradient Descent

Find the minimum of a function

1. *Initialize*: Start with an initial guess for the parameters
2. *Compute Gradient*: Find the gradient of the function at the current parameters
3. *Update Parameters*: Adjust the parameters by moving in the opposite direction of the gradient, scaled by the learning rate
4. *Repeat*: Continue the process until the parameters converge to a minimum or the changes are minimal

*Update Rule*:

$
theta arrow.l theta - alpha gradient f(theta)
$

Where:
- $theta$: parameter being optimized
- $alpha$: learning rate
- $gradient f(theta)$: gradient of the funtion $f$ with respect to $theta$ 

#figure(image("../../../vis/gradient_descent.png", width: 80%))

#eg[
  
  1. Function and Gradient:

    - Function: $theta^2_1 + theta^2_2$

    - Gradient: $gradient f(theta) = ((partial f) / (partial theta_1), (partial f) / (partial theta_2)) = (2 theta_1, 2 theta_2)$

  2. Initial Values:

  $
  theta_1 = 1 \
  theta_2 = 2 \
  $

  3. Learning Rate:

  $
  alpha = 0.1
  $

  4. Gradient Calculation
    - For $theta_1 = 1$ and $theta_2 = 2$:

  $
  gradient f(theta) = (2 dot 1, 2 dot 2) = (2, 4)
  $

  5. Parameter Update:

    - Update $theta_1$ and $theta_2$ using the rule $theta arrow.l theta - alpha gradient f(theta)$:

  $
  theta_1 arrow.l 1 - 0.1 dot 2 = 1 - 0.2 = 0.8 \

  theta_2 arrow.l 1 - 0.1 dot 4 = 2 - 0.4 = 1.6 \
  $

  6. New Values:

  $
  theta_1 = 0.8 \
  theta_2 = 1.6 \
  $

  #figure(image("../../../vis/gradient_descent_example.png", width: 80%))
]
