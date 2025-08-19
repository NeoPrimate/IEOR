== Double Integrals

=== 1. Double Indefinite Integral

$
  integral integral f(x, y) dif x dif y
$

*First Integration*:

Integrate with respect to $x$ (treat $y$ as constant):

$
  integral f(x, y) dif x = F(x, y) + C_1(y)
$

- $F(x, y)$: antiderivative of $f$ w.r.t. $x$
- $C_1(y)$: Constant of integration (can depend on $y$)

*Second Integration*:

Integrate with respect to $y$ (treat $x$ as constant):

$
  integral [F(x, y) + C_1(y)] dif y = G(x, y) + C_2(x)
$

- $G(x, y)$: antiderivative of $F(x,y)$ with respect to $y$

*Final Output*:

A family of functions $G(x,y) + C_2$, representing all functions whose mixed partial derivative $diff^2 / (diff y diff x)$ is $f(x,y)$