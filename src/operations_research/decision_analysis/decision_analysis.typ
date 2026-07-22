#import "/lib/imports.typ": *
#show: formatting

= Decision Analysis <operations_research_decision_analysis_decision_analysis>

A framework for making *decisions under uncertainty*. Distinguishes:

- *States of nature*: random outcomes outside your control (demand, weather, exchange rates)
- *Acts / decisions*: things you choose (build big plant? buy insurance? launch product?)
- *Payoffs*: cost or reward depending on (act, state) combination
- *Probabilities*: belief about likelihood of each state

Decision analysis asks: *given uncertainty, how should I choose?*

== Core components

1. *Decision tree* — graphical representation of the decision problem
2. *#link(<operations_research_decision_analysis_emv>)[EMV]* — Expected Monetary Value, the standard decision criterion
3. *#link(<operations_research_decision_analysis_evpi>)[EVPI]* — value of perfectly knowing the state in advance
4. *#link(<operations_research_decision_analysis_evsi>)[EVSI]* — value of imperfect (sample) information
5. *#link(<operations_research_decision_analysis_decision_criteria>)[Decision criteria]* — alternatives to EMV under deep uncertainty
6. *#link(<operations_research_decision_analysis_utility_theory>)[Utility theory]* — risk-averse decision making

== Steps in a decision analysis

1. *Frame*: identify objectives, alternatives, uncertainties, payoffs
2. *Structure*: build a decision tree (or influence diagram)
3. *Quantify*: assign probabilities and payoff values
4. *Evaluate*: compute expected value of each strategy
5. *Sensitivity analysis*: how does the answer change with input changes?
6. *Recommend*: highest expected value (or by other criterion)

== When to use

- *Strategic decisions* (capital projects, market entry) with multi-million-dollar payoffs
- *Decisions involving uncertain outcomes* with quantifiable probabilities
- *Sequence decisions* (act, observe, decide again) — decision trees are natural
- *Comparison of alternatives* under uncertainty

== Limits

- *Probability estimation* is hard — anchoring, overconfidence biases
- *Risk aversion* not captured by EMV alone — use utility theory
- *Deep uncertainty* (probabilities themselves unknown) — see #link(<operations_research_decision_analysis_decision_criteria>)[non-probabilistic criteria]
- *Behavioral / strategic* considerations (game theory) outside this framework

== See also

- *#link(<operations_research_decision_analysis_decision_trees>)[Decision Trees]*
- *#link(<operations_research_decision_analysis_emv>)[EMV]*
- *#link(<operations_research_decision_analysis_evpi>)[EVPI]* / *#link(<operations_research_decision_analysis_evsi>)[EVSI]*
- *#link(<operations_research_decision_analysis_decision_criteria>)[Decision Criteria]*
- *#link(<operations_research_decision_analysis_utility_theory>)[Utility Theory]*
