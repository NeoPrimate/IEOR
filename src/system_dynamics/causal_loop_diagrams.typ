#import "/lib/imports.typ": *

A *qualitative* diagram showing causal relationships between variables in a system. Used for understanding feedback structure without building a quantitative model.

== Anatomy

*Variables* (nodes): named quantities, e.g., "Population", "Birth rate".

*Links* (arrows): cause → effect relationships, labeled with polarity:

- *Positive link* (`+`): cause increases → effect increases (and decreases → decreases). Same direction.
- *Negative link* (`-`): cause increases → effect *decreases* (opposite direction).

== Loop polarity

Trace a loop and multiply link polarities:

- *Reinforcing loop* (R): odd number of negative links 'multiplied out' to positive net effect. Self-amplifying.
- *Balancing loop* (B): even number of negatives → net negative. Goal-seeking, stabilizing.

== Example: population growth

```
              ┌──→  Birth rate
              │       │
              │       │ +
              │       ↓
   Population ──+──→ Population
              ↑      │
              │      │
              │ -    │
              └── Death rate
```

Loops:
- *Population → Births → Population*: reinforcing (R) — more people → more births → even more people
- *Population → Deaths → Population*: balancing (B) — more people → more deaths → less population

Behavior depends on which loop dominates. With more births than deaths: exponential growth. With more deaths than births: exponential decay. Balance: steady state.

== Common patterns / archetypes

- *Reinforcing loop*: exponential growth or collapse (population, viral spread, runaway inflation)
- *Balancing loop*: goal-seeking, homeostasis (thermostat, predator-prey, supply-demand equilibrium)
- *Limits to growth*: R + B = S-curve (logistic growth, market penetration)
- *Shifting the burden*: short-term fix, long-term fundamental solution underused
- *Tragedy of the commons*: individual benefit ≠ collective benefit
- *Eroding goals*: gap → lower goal → narrower gap → success theater

== From CLD to quantitative model

A CLD shows *structure*, not *magnitudes*. To predict behavior quantitatively, convert each link into an equation (a #link(<system-dynamics-stocks-flows>)[stock-flow] system):

- *Variables* become stocks or auxiliaries
- *Positive links* with cause = $x$, effect = $f(x)$ where $f$ is increasing
- *Negative links*: $f$ is decreasing
- Define *table functions* for non-linear effects
- Quantify all parameters

== Common pitfalls

- *Drawing too many links*: keep CLDs focused — 5–15 variables, 10–25 links max
- *Confusing correlation with causation*: only draw a link if A *causes* B (not just correlates)
- *Implicit time scales*: real links have delays; CLDs don't show them — note carefully
- *Bypassing CLDs* and jumping to stock-flow: tempting but loses high-level structure

== See also

- *#link(<system-dynamics-stocks-flows>)[Stocks and Flows]* — quantitative version
- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]*
- *#link(<system-dynamics-system-dynamics>)[System Dynamics]* — overview
