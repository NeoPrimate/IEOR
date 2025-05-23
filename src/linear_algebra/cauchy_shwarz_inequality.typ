#import "../utils/examples.typ": eg

#import "@preview/cetz:0.3.4"

#set math.vec(delim: "[")

=== Cauchy-Schwarz Inequality

$
abs(accent(u, arrow) dot accent(v, arrow)) &lt.eq ||accent(u, arrow)|| ||accent(v, arrow)|| \

abs(accent(u, arrow) dot accent(v, arrow)) &eq ||accent(u, arrow)|| ||accent(v, arrow)|| quad "when" quad  accent(u, arrow) = c accent(v, arrow) 
$

Where:
- $accent(u, arrow) dot accent(v, arrow)$:  dot product of vectors $accent(u, arrow)$ and $accent(v, arrow)$
- $||accent(u, arrow)||$ and $||accent(v, arrow)||$: magnitudes (lengths) of vectors $accent(u, arrow)$ and $accent(v, arrow)$

*Step 1*: Understand the dot product

The dot product of two vectors $accent(u, arrow) = [u_1, u_2, dots, u_n]$ and $accent(v, arrow) = [v_1, v_2, dots, v_n]$ is calculated as:

$
accent(u, arrow) dot accent(v, arrow) = u_1 v_1 + u_2 v_2 + dots + u_n v_n
$

The magnitude (or norm) of a vector $accent(u, arrow)$ is:

$
||accent(u, arrow)|| = sqrt(u_1^2 + u_2^2 + dots + u_n^2)
$

*Step 2*: Define a new function

We introduce a parameter $t in RR$ and define a new vector:

$
w(t) = u - t v
$

Now, consider the dot product of this new vector with itself, which is always non-negative because it represents the square of the magnitude of $w(t)$:

$
w(t) dot w(t) gt.eq 0
$

This inequality makes sense because the dot product of any vector with itself is the square of its magnitude, and *a square is always non-negative*.

*Step 3*: Expand the dot product

Expand $w(t) dot w(t)$:

$
w(t) dot w(t) = (accent(u, arrow) - t accent(v, arrow)) dot (accent(u, arrow) - t accent(v, arrow))
$

Now, we apply the distributive property of the dot product, which behaves similarly to the distributive property of multiplication. We expand each term:

$
(accent(u, arrow) - t accent(v, arrow)) dot (accent(u, arrow) - t accent(v, arrow)) = accent(u, arrow)  dot accent(u, arrow) - t(accent(u, arrow) dot accent(v, arrow)) - t(accent(v, arrow) dot accent(u, arrow)) + t^2 (accent(v, arrow) dot accent(v, arrow))
$

Since the dot product is commutative ($accent(u, arrow) dot accent(v, arrow) = accent(v, arrow) dot accent(u, arrow)$), we can rewrite this as:

$
accent(u, arrow) dot accent(u, arrow) - 2 t (accent(u, arrow) dot accent(v, arrow)) + t^2 (accent(v, arrow) dot accent(v, arrow))
$

This simplifies to:

$
||accent(u, arrow)||^2 - 2 t (accent(u, arrow) dot accent(v, arrow)) + t^2 ||accent(v, arrow)||^2
$

We've now expressed the result of expanding the dot product as a quadratic expression in $t$, where 
- $||accent(u, arrow)||^2$ is a constant term,
- $-2 t (accent(u, arrow) dot accent(v, arrow))$ is the linear term in $t$ 
- $t^2 ||accent(v, arrow)||^2$ is the quadratic term

*Step 4*: Treat as a quadratic equation

Now that we have the quadratic expression:

$
||accent(v, arrow)||^2 t^2 - 2 (accent(u, arrow) dot accent(v, arrow))t + ||accent(u, arrow)||^2 gt.eq 0
$

We recognize this as a standard quadratic inequality of the form $a t^2 + b t + c gt.eq 0$, where:

- $a = ||accent(v, arrow)||^2$
- $b = -2 (accent(u, arrow) dot accent(v, arrow))$
- $c = ||accent(u, arrow)||^2$

For any quadratic expression $a t^2 + b t + c$ to always be non-negative, its discriminant must be less than or equal to zero. The discriminant of a quadratic equation $a t^2 + b t + c = 0$ is given by:

$
Delta = b^2 - 4 a c
$

Substituting in the values of $a$, $b$, and $c$ from our expression:

$
Delta = (-2 (accent(u, arrow) dot accent(v, arrow)))^2 - 4 dot ||accent(v, arrow)||^2 dot ||accent(u, arrow)||^2
$

Simplifying:

$
Delta = 4(accent(u, arrow) dot accent(v, arrow))^2 - 4 ||accent(v, arrow)||^2 ||accent(u, arrow)||^2
$

*Step 5*: Apply the discriminant condition

For the quadratic inequality to hold, the discriminant must be less than or equal to zero:

$
Delta = 4(accent(u, arrow) dot accent(v, arrow))^2 - 4 ||accent(v, arrow)||^2 ||accent(u, arrow)||^2 lt.eq 0
$

Divide by 4:

$
Delta = (accent(u, arrow) dot accent(v, arrow))^2 lt.eq ||accent(v, arrow)||^2 ||accent(u, arrow)||^2
$

Take the square root of both sides:

$
|accent(u, arrow) dot accent(v, arrow)| lt.eq ||accent(u, arrow)|| ||accent(v, arrow)||
$

#eg[
  $
  accent(u, arrow) = vec(1, 2) quad quad quad accent(v, arrow) = vec(3, 4)
  $

  *Step 1*: Compute the dot product $accent(u, arrow) dot accent(v, arrow)$

  $
  accent(u, arrow) dot accent(v, arrow) = (1)(3) + (2)(4) = 3 + 8 = 11
  $

  *Step 2*: Compute the norms of $accent(u, arrow)$ and $accent(v, arrow)$

  - The norm $||accent(u, arrow)||$ is:

  $
  ||accent(u, arrow)|| = sqrt(1^2 + 2^2) = sqrt(1 + 4) = sqrt(5)
  $

  - The norm $||accent(v, arrow)||$ is:

  $
  ||accent(v, arrow)|| = sqrt(3^2 + 4^2) = sqrt(9 + 16) = sqrt(25) = 5
  $

  *Step 3*: Verify the Cauchy-Schwarz inequality

  The inequality states:

  $
  |accent(u, arrow) dot accent(v, arrow)| lt.eq ||accent(u, arrow)|| ||accent(v, arrow)||
  $

  Substitute the values:

  $
  |11| lt.eq 5 sqrt(5) = 11.18
  $

  Since $11 lt.eq 11.18$, the inequality holds.

  The Cauchy-Schwarz inequality is satisfied for the vectors $accent(u, arrow) = vec(1, 2)$ and $accent(v, arrow) = vec(3, 4)$

]
