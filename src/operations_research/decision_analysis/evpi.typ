#import "/lib/imports.typ": *
#show: formatting

*Expected Value of Perfect Information* (EVPI) — how much more you'd earn by *knowing the state of nature in advance*. The upper bound on what information is worth.

== Definition

Let $"EMV"^* = max_i "EMV"(a_i)$ — best expected value under uncertainty.

With perfect information (you know $s_j$ before deciding): pick the *best act for each state*. Expected value:

$
  "EV under PI" = sum_j p_j max_i V_(i j)
$

(Note: $max$ inside the sum vs $max$ of sums — perfect info lets you tailor act to state.)

$
  "EVPI" = "EV under PI" - "EMV"^*
$

== Example

From #link(<operations-research-decision-analysis-emv>)[EMV example]:

#table(
  columns: 4,
  align: (left, center, center, center),
  stroke: none,
  table.header([], [$s_1$ (high)], [$s_2$ (low)], []),
  [$a_1$ (big)], [$80$], [$-10$], [],
  [$a_2$ (small)], [$40$], [$20$], [],
  [$a_3$ (no build)], [$0$], [$0$], [],
  [Best in this state], [$80$ ($a_1$)], [$20$ ($a_2$)], [],
)

$"EV under PI" = 0.6 dot 80 + 0.4 dot 20 = 48 + 8 = 56$

$"EMV"^* = 44$ (from $a_1$)

$"EVPI" = 56 - 44 = 12$

So perfectly knowing the market state in advance is worth $12$M to this decision.

== Why it's an upper bound

Real information sources (market research, pilot tests, expert forecasts) are *imperfect* — they update probabilities but don't reveal the state directly. The value of imperfect information (#link(<operations-research-decision-analysis-evsi>)[EVSI]) is *always* less than EVPI:

$
  "EVSI" <= "EVPI"
$

If EVPI itself is small, *no information* is worth much — don't bother investing in market research.

== Usage

- *Set a budget* for information gathering: $"EVPI" = 12$M means no research is worth more than $12$M
- *Identify high-stakes uncertainties*: high EVPI signals where uncertainty matters most
- *Drive sensitivity analysis*: if EVPI is low, the decision is robust to uncertainty about that state

== Decomposition by uncertainty

If there are multiple sources of uncertainty (demand *and* exchange rate), you can compute EVPI for each separately, or jointly. They're not additive in general.

== See also

- *#link(<operations-research-decision-analysis-evsi>)[EVSI]* — value of imperfect information
- *#link(<operations-research-decision-analysis-emv>)[EMV]*
- *#link(<operations-research-decision-analysis-decision-trees>)[Decision Trees]*
