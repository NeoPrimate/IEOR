#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== SF (Survival Function)

Probability that a certain event has not occurred by a certain time

$
S(t) = P(T > t)
$

#figure(image("../../vis/sf.png", width: 50%))

Relationship to PDF:

$
S(t) = 1 - F(t)
$

#code[
```python
from scipy.stats import norm

z = 3.4
mu = 0
sigma = 1

norm.sf(z, loc=mu, scale=sigma)
```
]