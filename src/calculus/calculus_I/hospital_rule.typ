#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

== L'Hôpital's Rule

Evaluating limits that result in a indeterminite form like $0 / 0$ or $infinity / infinity$

If $lim_(x arrow a) f(x) = 0$ and $lim_(x arrow a) g(x) = 0$ (or both go to $plus.minus infinity$), and $f(x)$ and $g(x)$ are differentiable near $a$, then:

$
  lim_(x arrow a) f(x) / g(x) = lim_(x arrow a) (f'(x)) / (g'(x))
$

#eg[
  Consider:

  $
    lim_(x arrow 0) (1 - cos(x)) / x^2
  $

  *Step 1*: Direct Substitution
  
  Substituting $x = 0$:

  $
    (1 - cos(0)) / 0^2 = (1 - 1) / 0 = 0 / 0
  $

  Since this is an indeterminate form, we apply L'Hôpital's Rule.

  *Step 2*: First Application of L'Hôpital's Rule

  Differentiate the numerator and denominator:

  - Numerator: $f(x) = 1 - cos(x) arrow.double f'(x) = sin(x)$
  
  - Denominator: $g(x) = x^2 arrow.double g'(x) = 2x$

  Thus, applying L'Hôpital's Rule:

  $
    lim_(x arrow 0) (1 - cos(x)) / x^2 = lim_(x arrow 0) sin(x) / (2 x)
  $

  *Step 3*: Second Check for Indeterminate Form

  Substituting $x = 0$:

  $
    sin(0) / (2 (0)) = 0 / 0
  $

  Since this is still an indeterminate form, we apply L'Hôpital's Rule again.

  *Step 4*: Second Application of L'Hôpital's Rule

  Differentiate again:

  - Numerator: $f'(x) = sin(x) arrow.double f''(x) = cos(x)$
  
  - Denominator: $g'(x) = 2 x arrow.double g''(x) = 2$

  Applying L'Hôpital's Rule again:

  $
    lim_(x arrow 0) (sin(x)) / (2 x) = lim_(x arrow 0) cos(x) / 2
  $

  *Step 5*: Evaluate the Limit

  Now, substituting $x = 0$:

  $
    cos(0) / 2 = 1 / 2
  $

  *Final Answer*:

  #result[
    $
      lim_(x arrow 0) (1 - cos(x)) / x^2 = 1 / 2
    $
  ]

]