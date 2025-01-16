#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== CDF (Cumulative Distribution Function)

Gives the probability that $X$ will take a value less than or equal to $x$

$
F(x) = P(X ≤ x)
$

#figure(image("../../vis/cdf.png", width: 50%))

1. Categorical

$
F(x) = integral_(-inf)^x f(t) d t
$

2. Continuous

$
F(x) = sum_(t ≤ x) P(X = t)
$

#code[
```python
from scipy.stats import norm

x = 1
mu = 0
sigma = 1

norm.cdf(x, loc=mu, scale=sigma)
```
]