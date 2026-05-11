#import "/lib/imports.typ": *

A framework for decisions under *risk aversion*. Instead of maximizing expected payoff (#link(<operations-research-decision-analysis-emv>)[EMV]), maximize *expected utility* — where the utility function $u(x)$ encodes the decision-maker's preferences over wealth.

== Why EMV is incomplete

Consider a fair coin flip: win $1$M or lose $1$M. EMV $= 0$. But most people refuse this gamble — the $1$M downside is *worse* in subjective terms than the $1$M upside is *better*.

This is *risk aversion*: declining marginal utility of wealth.

== Utility function

$u: RR -> RR$ maps wealth to utility. The decision-maker maximizes:

$
  E[u(W)] = sum_j p_j u(W_j)
$

instead of $E[W] = sum_j p_j W_j$.

For a risk-averse decision-maker, $u$ is *concave*: $u''(x) <= 0$.

== Common forms

*Linear* — risk-neutral: $u(x) = x$. Reduces to EMV.

*Logarithmic* (Bernoulli 1738): $u(x) = log(x)$. Strongly risk-averse for losses; resolves the St. Petersburg paradox.

*Exponential*: $u(x) = -e^(-x / R)$ for some risk parameter $R > 0$. Constant absolute risk aversion (CARA).

*Power*: $u(x) = (x^(1 - r) - 1) / (1 - r)$ for $r > 0$. Constant relative risk aversion (CRRA).

*Quadratic*: $u(x) = x - a x^2$. Mean-variance — used implicitly in Markowitz portfolio theory.

== Risk aversion measures

*Arrow-Pratt absolute* risk aversion:
$
  A(x) = -u''(x) / u'(x)
$

*Arrow-Pratt relative* risk aversion:
$
  R(x) = x A(x) = -x u''(x) / u'(x)
$

Used to *parameterize* and *measure* risk aversion empirically. Typical values for stock-market investors: $R approx 1$ to $5$.

== Certainty equivalent

The *certainty equivalent* (CE) of a gamble $X$ is the certain amount $c$ with the same utility:

$
  u(c) = E[u(X)] #h(2em) arrow.r.double #h(0.5em) c = u^(-1)(E[u(X)])
$

The *risk premium* is the amount the decision-maker would pay to avoid the risk:

$
  pi = E[X] - c
$

For a risk-averse DM ($u$ concave): $c < E[X]$ → $pi > 0$. The DM is willing to give up expected return to reduce variance.

== Insurance application

You face a risk of losing $L$ with probability $p$.

- *Expected loss*: $p L$
- *Certainty equivalent of loss*: $c$ where $u(W - c) = (1-p) u(W) + p u(W - L)$
- *Maximum premium you'd pay*: $c$ — could be much greater than $p L$ if you're risk-averse

This is *why insurance exists* — risk-averse buyers transfer risk to risk-pooling insurers.

== Calibration: lottery method

To estimate someone's utility function:

1. Anchor: $u(W_("min")) = 0$, $u(W_("max")) = 1$
2. For intermediate $W$: ask "you're indifferent between $W$ guaranteed and a 50/50 lottery between $W_("min")$ and $W_("max")$ — but at what $W$?"
3. Result: $u(W) = 0.5$ at the indifference point
4. Repeat to fill in the curve

Subjective and biased — but operationally usable.

== See also

- *#link(<operations-research-decision-analysis-emv>)[EMV]* — risk-neutral baseline
- *#link(<operations-research-decision-analysis-decision-trees>)[Decision Trees]* — apply utility to payoffs at leaves
- *#link(<economics-utility>)[Economics: Utility]* — classical economic foundation
- *#link(<operations-research-decision-analysis-decision-criteria>)[Decision Criteria]* — non-probabilistic alternative
