#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== PPF (Percent-Point Function)

Gives the value $x$ such that the probability of a random variable being less than or equal to $x$ is equal to a given probability $p$

#code(
  "ppf.py",
  ```python
  from scipy.stats import norm

  p = 0.95
  mu = 0
  sigma = 1

  x_value = norm.ppf(p, loc=mu, scale=sigma)
  ```
)