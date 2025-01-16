#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== p-Values

Probability of obtaining results at least as extreme as the observed results

1. One-Tailed

$
p = P(Z > z_"observed")
$

#figure(image("../../../vis/p_value_one_tail.png", width: 30%))

2. Two-Tailed

$
p = 2 dot P(Z > |z_"observed"|)
$

#figure(image("../../../vis/p_value_two_tail.png", width: 30%))

#code[
```python

z = 2.1
df = 3
scipy.stats.norm.sf(abs(z), df=df)

```
]