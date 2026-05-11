#import "/lib/imports.typ": *

*Expected Monetary Value* (EMV) — the standard decision criterion under #link(<operations-research-decision-analysis-decision-analysis>)[decision analysis]: pick the act with the highest expected payoff.

For act $a_i$ with payoff $V_(i j)$ in state $s_j$ (probability $p_j$):

$
  "EMV"(a_i) = sum_j p_j V_(i j)
$

Optimal act: $a^* = arg max_i "EMV"(a_i)$.

== Example

#table(
  columns: 4,
  align: (left, center, center, center),
  stroke: none,
  table.header([], [State $s_1$ (high, $p = 0.6$)], [State $s_2$ (low, $p = 0.4$)], [EMV]),
  [Act $a_1$ (build big)], [$80$], [$-10$], [$0.6 dot 80 + 0.4 dot (-10) = 44$],
  [Act $a_2$ (build small)], [$40$], [$20$], [$0.6 dot 40 + 0.4 dot 20 = 32$],
  [Act $a_3$ (don't build)], [$0$], [$0$], [$0$],
)

(All values in millions of dollars.) Optimal by EMV: $a_1$, EMV $= 44$.

== When EMV is the right criterion

- *Repeated decisions*: long-run average is the right measure; gambler's-ruin issues smoothed out
- *Risk-neutral* decision-maker: dollars are interchangeable
- *Decisions small relative to wealth*: linear approximation valid
- *Probabilities are reasonably well-known*: estimation error is small relative to payoffs

== When EMV is *not* the right criterion

- *One-shot decision* with large downside: someone facing potential ruin will rationally avoid the high-EMV gamble (insurance, hedging)
- *Risk-averse decision-maker*: use *utility theory* — payoffs run through a *concave* utility function before averaging — see #link(<operations-research-decision-analysis-utility-theory>)[Utility Theory]
- *Deep uncertainty*: probabilities not just unknown but unknowable — use #link(<operations-research-decision-analysis-decision-criteria>)[non-probabilistic criteria]
- *Multiple objectives*: not just money — see multi-criteria decision analysis

== The St. Petersburg paradox

A coin is flipped until tails. If $n$ flips, payoff $= 2^n$. Expected payoff: $sum_n (1/2)^n dot 2^n = sum_n 1 = infinity$.

But no rational person pays infinite money to play. Resolves: *utility* is concave (log-utility famously), and expected utility is finite. Bernoulli's solution from 1738 — first hint that EMV alone isn't enough.

== See also

- *#link(<operations-research-decision-analysis-decision-trees>)[Decision Trees]*
- *#link(<operations-research-decision-analysis-decision-analysis>)[Decision Analysis]*
- *#link(<operations-research-decision-analysis-evpi>)[EVPI]* / *#link(<operations-research-decision-analysis-evsi>)[EVSI]*
- *#link(<operations-research-decision-analysis-utility-theory>)[Utility Theory]* — when EMV isn't enough
