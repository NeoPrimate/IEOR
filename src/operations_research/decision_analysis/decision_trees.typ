#import "/lib/imports.typ": *

A *decision tree* is the standard graphical model for #link(<operations-research-decision-analysis-decision-analysis>)[decision analysis]. Branches represent decisions or random outcomes; leaves carry payoffs; the tree's root is "now".

== Node types

- *Decision nodes* (squares ☐): branches are *acts* you choose
- *Chance nodes* (circles ◯): branches are *states of nature*, each with a probability
- *Terminal nodes* (triangles ▲): each leaf has a *payoff* (cost or revenue)

== Example: build big plant or small?

```
                    [build big]
   ☐──────────────────●(0.6 high demand) → $80M
   |                  ●(0.4 low demand)  → $-10M
   |
   |   [build small]
   └──────────────────●(0.6 high demand) → $40M
                      ●(0.4 low demand)  → $20M
```

== Folding-back (rollback) algorithm

The algorithm to *solve* a decision tree: work from leaves backward to root.

```
At each chance node: compute expected payoff
    E[payoff] = Σ p_i × payoff_i over branches
At each decision node: pick the branch with the best expected payoff
    Tag the node with that branch's value (and which act to pick)
At the root: read off the optimal first decision and its expected value
```

This is just #link(<operations-research-optimization-backward-induction>)[backward induction] applied to a decision tree.

== Solving the example

*Big plant*: $E["payoff"] = 0.6 dot 80 + 0.4 dot (-10) = 48 - 4 = 44$ (millions).

*Small plant*: $E["payoff"] = 0.6 dot 40 + 0.4 dot 20 = 24 + 8 = 32$ (millions).

Decision: build big. Expected value: $44$M.

== Multi-stage trees

Decisions can be sequenced: act, observe state, act again. Each stage adds a layer of (decision → chance) before reaching a payoff. Fold back as before — each chance / decision node still uses local expected value / argmax.

== Sensitivity analysis

After solving, vary inputs (probabilities, payoffs) and re-solve. Identify which inputs matter most. Standard tools:

- *Tornado diagrams* — rank inputs by impact on decision
- *Spider plots* — show decision threshold crossings
- *Probability sensitivity* — at what $p$ does the recommended decision change?

== Common applications

- *Capital investment* — go / no-go, big / small project
- *Drug development* — phase-by-phase, abandon if results poor
- *Insurance / risk management* — buy coverage vs self-insure
- *Marketing campaigns* — pilot test then full launch
- *Litigation* — settle vs go to trial

== See also

- *#link(<operations-research-decision-analysis-emv>)[EMV]* — the standard criterion
- *#link(<operations-research-decision-analysis-evpi>)[EVPI]* — value of resolving uncertainty
- *#link(<operations-research-decision-analysis-evsi>)[EVSI]* — value of imperfect info
- *#link(<operations-research-optimization-backward-induction>)[Backward Induction]* — same algorithm
