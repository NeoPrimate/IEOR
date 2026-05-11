#import "/lib/imports.typ": *

*Expected Value of Sample Information* (EVSI) — value of *imperfect* information, like a market survey that updates (but doesn't fully reveal) the state of nature.

The realistic counterpart of #link(<operations-research-decision-analysis-evpi>)[EVPI]; what most real-world decisions face.

== Setup

You can run a test or survey before deciding. Each test outcome $z$:
- Occurs with some probability $P(z)$
- Updates your beliefs about state $s$ via *Bayes' theorem*:
  $
    P(s | z) = (P(z | s) P(s)) / P(z)
  $

After observing $z$, you make the *optimal* decision *given the updated beliefs*:

$
  V(z) = max_a sum_s P(s | z) V_(a, s)
$

== EVSI formula

$
  "EV with sample info" = sum_z P(z) V(z)
$

$
  "EVSI" = "EV with sample info" - "EMV"^*
$

EVSI is always between $0$ and EVPI:

$
  0 <= "EVSI" <= "EVPI"
$

— at most EVPI (since no info beats perfect info), at least $0$ (you can always ignore the info).

== Example

States $s_1$ (high demand), $s_2$ (low demand), with $P(s_1) = 0.6$.

Test reliability:
- If $s_1$, test says "high" with $P = 0.8$
- If $s_2$, test says "high" with $P = 0.3$

$P("test high") = 0.6 dot 0.8 + 0.4 dot 0.3 = 0.60$
$P("test low") = 0.40$

Updates:
- $P(s_1 | "high") = (0.6 dot 0.8) / 0.60 = 0.80$
- $P(s_1 | "low") = (0.6 dot 0.2) / 0.40 = 0.30$

Given "test high" (probs $0.80, 0.20$):
- $a_1$: $0.8 dot 80 + 0.2 dot (-10) = 62$
- $a_2$: $0.8 dot 40 + 0.2 dot 20 = 36$
- *Best*: $a_1$, value $62$

Given "test low" (probs $0.30, 0.70$):
- $a_1$: $0.3 dot 80 + 0.7 dot (-10) = 17$
- $a_2$: $0.3 dot 40 + 0.7 dot 20 = 26$
- *Best*: $a_2$, value $26$

$"EV with sample info" = 0.60 dot 62 + 0.40 dot 26 = 37.2 + 10.4 = 47.6$

$"EVSI" = 47.6 - 44 = 3.6$ (vs EVPI $= 12$)

So this test is worth at most \\$3.6$M. If it costs more, skip it.

== Why EVSI < EVPI

The sample provides *probabilistic* updating, not certainty. Some test outcomes still leave significant ambiguity. EVPI assumes you'd be told *exactly* which state — much stronger.

== Use cases

- *Market research budgeting*: should I commission a \\$100$K consumer survey? Compare EVSI to cost.
- *Pilot programs*: small-scale rollout to learn before full commitment
- *Diagnostic tests*: in healthcare, sequential decisions to test before treating
- *A/B testing*: when is the next experiment worth running?

== Bayesian decision-making

EVSI is fundamentally *Bayesian*: it requires prior probabilities, likelihood functions, and updating. The Bayesian decision theory framework subsumes EVPI and EVSI as special cases of expected utility under updated beliefs.

== See also

- *#link(<operations-research-decision-analysis-evpi>)[EVPI]* — upper bound
- *#link(<operations-research-decision-analysis-emv>)[EMV]*
- *#link(<probability-theory-bayes-rule>)[Bayes' Rule]* — the updating
- *#link(<operations-research-decision-analysis-decision-trees>)[Decision Trees]*
