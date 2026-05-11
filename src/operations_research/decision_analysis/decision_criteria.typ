#import "/lib/imports.typ": *

Five classical criteria for decisions under uncertainty when *probabilities are unknown* or *deeply uncertain* (probability estimates aren't trustworthy). Used when #link(<operations-research-decision-analysis-emv>)[EMV] doesn't apply.

== Setup

Acts $a_i$, states $s_j$, payoff matrix $V_(i j)$. No probabilities. How to choose?

Five rules give five different answers, reflecting different attitudes toward uncertainty.

== Maximin (pessimist)

*Worst-case thinking*. For each act, find the worst possible payoff. Pick the act with the *best worst case*:

$
  a^* = arg max_i (min_j V_(i j))
$

Very conservative — wars, safety-critical systems, fiduciary obligations.

== Maximax (optimist)

*Best-case thinking*. For each act, find the best possible payoff. Pick the act with the *best best case*:

$
  a^* = arg max_i (max_j V_(i j))
$

Aggressive — startup founders, venture capital, lottery players.

== Minimax regret (Savage)

*Avoid kicking-yourself thinking*. For each (act, state), compute the *regret* — how much better you'd have done with the best act for that state:

$
  R_(i j) = max_k V_(k j) - V_(i j)
$

Then minimize the *maximum regret*:

$
  a^* = arg min_i (max_j R_(i j))
$

Used when *retrospective comparison* is the bigger concern than absolute outcome — diplomatic / political decisions.

== Hurwicz criterion (compromise)

Linear combination of optimism and pessimism. Coefficient of optimism $alpha in [0, 1]$:

$
  H(a_i) = alpha #h(0.2em) max_j V_(i j) + (1 - alpha) #h(0.2em) min_j V_(i j)
$

$
  a^* = arg max_i H(a_i)
$

$alpha = 1$: maximax. $alpha = 0$: maximin. $alpha = 0.5$: balanced.

Calibrate $alpha$ to the decision-maker's risk attitude (or context: $alpha$ high in opportunity-rich environments, low in threat-heavy ones).

== Laplace (insufficient reason)

Pretend each state is equally likely (uniform prior), then apply EMV:

$
  L(a_i) = 1/n sum_j V_(i j) #h(2em) ("simple average over states")
$

$
  a^* = arg max_i L(a_i)
$

Equivalent to *Bayesian decision* under uniform prior. The first thing to try when you have no information about state probabilities.

== Comparison example

Payoffs:

#table(
  columns: 4,
  align: (left, center, center, center),
  stroke: none,
  table.header([], [$s_1$], [$s_2$], [$s_3$]),
  [$a_1$], $50$, $-10$, $30$,
  [$a_2$], $20$, $40$, $10$,
  [$a_3$], $0$, $0$, $100$,
)

#table(
  columns: 6,
  align: (left, center, center, center, center, center),
  stroke: none,
  table.header([], [Maximin], [Maximax], [Min Regret], [Hurwicz ($alpha = 0.6$)], [Laplace]),
  [$a_1$], $-10$, $50$, [$0$ (regret table needed)], $0.6 dot 50 + 0.4 dot (-10) = 26$, $1/3 dot (50-10+30) = 23.3$,
  [$a_2$], $10$, $40$, [], $28$, $23.3$,
  [$a_3$], $0$, $100$, [], $60$, $33.3$,
)

Different criteria, different winners — picks $a_2$ (Maximin) vs $a_3$ (Maximax / Hurwicz / Laplace).

== Which to use?

No single right answer — depends on:
- Stakes (high-stakes one-shot → maximin)
- Repeatability (many similar decisions → Laplace/EMV)
- Reputation cost (criticism risk → minimax regret)
- Risk preference (default to Hurwicz with calibrated $alpha$)

== See also

- *#link(<operations-research-decision-analysis-emv>)[EMV]* — when probabilities are known
- *#link(<operations-research-decision-analysis-utility-theory>)[Utility Theory]* — handles risk aversion under known probabilities
- *#link(<operations-research-decision-analysis-decision-analysis>)[Decision Analysis overview]*
