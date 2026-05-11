#import "/lib/imports.typ": *

Two complementary metrics for *how much uncertainty modeling adds* to a decision problem:

- *EVPI* (Expected Value of Perfect Information) — how much you'd gain by knowing $xi$ exactly before deciding
- *VSS* (Value of Stochastic Solution) — how much you gain by modeling uncertainty *at all*

== Three problem versions

For a stochastic program with random parameter $xi$:

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Problem*], [*Decision*]),
  [SP], [$min_x E_xi [f(x, xi)]$], [accounts for uncertainty],
  [WS (wait-and-see)], [$E_xi [min_x f(x, xi)]$], [decide *after* observing $xi$],
  [EV (expected value)], [$min_x f(x, E[xi])$], [decide using *average* $xi$, ignore variability],
)

Their optimal values: $z^("SP"), z^("WS"), z^("EV")$.

== EVPI

$
  "EVPI" = z^("SP") - z^("WS")
$

(For minimization: lower is better, so EVPI is positive when WS < SP, meaning perfect info would help.)

Interpretation: *upper bound on the value of information*. Knowing $xi$ in advance enables tailored optimal decisions per scenario — usually does better than committing to one decision before observing.

== VSS

$
  "VSS" = "EEV" - z^("SP")
$

where EEV (Expected result of the Expected-value solution) is the expected cost of using the EV-optimal $x$:

$
  "EEV" = E_xi [f(x^("EV"), xi)]
$

Interpretation: *value of modeling uncertainty*. If you ignore variability and just use mean parameters, your decision can be poor when actual $xi$ deviates. VSS measures this loss.

== Why both matter

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([Situation], [EVPI], [VSS]),
  [Worth investing in better forecasts?], [yes if EVPI is large], [—],
  [Worth doing stochastic programming instead of EV?], [—], [yes if VSS is large],
  [EVPI small, VSS small], [decision is robust to uncertainty], [],
  [EVPI large, VSS small], [forecasting is helpful, but you'd make the same decision anyway], [],
  [EVPI small, VSS large], [can't improve via forecasting, but must explicitly model variability], [],
  [Both large], [strongest case for both better data *and* stochastic modeling], [],
)

== Worked example

From #link(<operations-research-optimization-two-stage-recourse>)[two-stage recourse] example:

- $z^("SP")$: solve stochastic program → optimal $x^"SP"$ and expected cost
- $z^("WS")$: best $x$ in each scenario separately, average over scenarios
- $z^("EV")$: solve with $E[D]$ replacing $D$; then compute *actual* expected cost = $"EEV"$

A small calculation gives concrete EVPI and VSS. The relative magnitudes depend on:

- Spread of scenarios (larger spread → larger EVPI/VSS)
- Cost asymmetry between scenarios (asymmetric → larger VSS)
- Convexity of cost in $xi$ (concave → larger EVPI, by Jensen)

== Sanity check identities

- *EVPI $>= 0$* always (perfect info can't hurt)
- *VSS $>= 0$* always (stochastic modeling can't hurt)
- *VSS $<= "EEV" - z^("WS")$* (stochastic is no better than perfect info)

== See also

- *#link(<operations-research-optimization-stochastic-programming>)[Stochastic Programming]*
- *#link(<operations-research-optimization-two-stage-recourse>)[Two-stage Recourse]*
- *#link(<operations-research-decision-analysis-evpi>)[EVPI (Decision Analysis)]* — discrete analog
- *#link(<operations-research-decision-analysis-evsi>)[EVSI]* — value of sample info
