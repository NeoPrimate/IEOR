#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot

== Bernoulli Trial (Binomial trial)

A Bernoulli trial is a random experiment with exactly two possible outcomes: "success" and "failure," where the probability of success ($p$) remains constant across trials.

$P("success") = p$

$P("failure") = q$

$p = 1 - q$

$q = 1 - p$

$p + q = 1$

#eg[
  - Flipping a fair coin where "heads" is considered a *success* ($p = 0.5$) and "tails" a *failure* ($1 - p = 0.5$).

  - Rolling a die and checking if the outcome is a 6 (*success*) or not (*failure*). If the die is fair, the probability of success is $p = 1 / 6$ and the probability of failure is $1 - p = 5 / 6$.

  - Checking whether a shipment arrives on time (*success*) or is delayed (*failure*). If historical data shows that a shipment has a 90% chance of arriving on time, the probability of success ($p$) is 0.9, and the probability of failure ($1 - p$) is 0.1.
]

=== Odds

Odds for ($o_f$)

$
  o_f = p / q = p / (1 - p) = (1 - q) / q
$

Odds against ($o_a$)

$
  o_a = q / p = (1 - p) / p = q / (1 - q)
$

$
  o_f = 1 / o_a
$

$
  o_a = 1 / o_f
$

$
  o_f dot o_a = 1
$