#import "/lib/imports.typ": *

A discipline for modeling and simulating *complex dynamic systems* with *feedback*. Developed by Jay Forrester (MIT, 1956) to understand industrial dynamics, urban dynamics, and social systems. Codified by John Sterman (*Business Dynamics*, 2000).

== Core concepts

- *#link(<system-dynamics-stocks-flows>)[Stocks and flows]*: state variables (stocks) change via rates (flows); foundation in ODEs
- *#link(<system-dynamics-causal-loop-diagrams>)[Causal loop diagrams]*: graphical representation of feedback structures
- *#link(<system-dynamics-feedback-loops>)[Feedback loops]*: reinforcing (R) vs balancing (B); positive vs negative feedback
- *#link(<system-dynamics-delays>)[Delays]*: material, information, perception
- *Nonlinearity*: table functions, saturation effects

== When to use

- *Long-term, complex dynamics* with non-obvious feedbacks
- *Policy analysis*: predict consequences of changes before implementing
- *Systems with delays* where intuition fails (planning, supply chains, public health)
- *Stakeholder communication*: visual model helps shared mental models

== When not to use

- *Short-term operational decisions*: discrete-event simulation or OR more appropriate
- *Detailed scheduling*: discrete techniques, not continuous SD
- *Statistical estimation*: regression / time series, not SD
- *Single-decision optimization*: OR / DP, not SD

== Vs other approaches

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*System Dynamics*], [*Other*]),
  [Time], [Continuous (ODEs)], [Discrete or instantaneous],
  [Focus], [Feedback, accumulation], [Optimization, statistical fit],
  [Granularity], [Aggregate (whole system)], [Individual entities],
  [Outcome], [Trajectory over time], [Optimal decision now],
  [Compare with], [OR / DP (optimization), discrete-event sim (entities), agent-based (individuals)], [],
)

== Classic SD applications

- *#link(<system-dynamics-beer-game>)[Beer Distribution Game]* — supply-chain bullwhip
- *Industrial dynamics* — order-inventory-capacity cycles
- *#link(<system-dynamics-bass-diffusion>)[Bass diffusion]* — new product adoption
- *#link(<system-dynamics-sir-seir>)[SIR / SEIR]* — epidemic spread
- *Population* — predator-prey, demographic transitions
- *#link(<system-dynamics-logistic-growth>)[Logistic growth]* — capacity-limited expansion
- *Public policy* — urban planning, climate scenarios, healthcare

== Software

- *Vensim* (industry standard, free PLE version)
- *Stella / iThink* (Apple-era educational)
- *AnyLogic* (also discrete + agent-based)
- *Python: PySD* (parses Vensim models)

== See also

- *#link(<system-dynamics-stocks-flows>)[Stocks and Flows]*
- *#link(<system-dynamics-causal-loop-diagrams>)[Causal Loop Diagrams]*
- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]*
- *#link(<system-dynamics-delays>)[Delays]*
- *#link(<system-dynamics-numerical-integration>)[Numerical Integration]*
- *#link(<system-dynamics-bullwhip-sd>)[Bullwhip in SD]*
- *#link(<system-dynamics-beer-game>)[Beer Game]*
