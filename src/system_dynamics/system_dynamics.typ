#import "/lib/imports.typ": *
#show: formatting

= System Dynamics <system_dynamics_system_dynamics>

A discipline for modeling and simulating *complex dynamic systems* with *feedback*. Developed by Jay Forrester (MIT, 1956) to understand industrial dynamics, urban dynamics, and social systems. Codified by John Sterman (*Business Dynamics*, 2000).

== Core concepts

- *#link(<system_dynamics_stocks_flows>)[Stocks and flows]*: state variables (stocks) change via rates (flows); foundation in ODEs
- *#link(<system_dynamics_causal_loop_diagrams>)[Causal loop diagrams]*: graphical representation of feedback structures
- *#link(<system_dynamics_feedback_loops>)[Feedback loops]*: reinforcing (R) vs balancing (B); positive vs negative feedback
- *#link(<system_dynamics_delays>)[Delays]*: material, information, perception
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

- *#link(<system_dynamics_beer_game>)[Beer Distribution Game]* — supply-chain bullwhip
- *Industrial dynamics* — order-inventory-capacity cycles
- *#link(<system_dynamics_bass_diffusion>)[Bass diffusion]* — new product adoption
- *#link(<system_dynamics_sir_seir>)[SIR / SEIR]* — epidemic spread
- *Population* — predator-prey, demographic transitions
- *#link(<system_dynamics_logistic_growth>)[Logistic growth]* — capacity-limited expansion
- *Public policy* — urban planning, climate scenarios, healthcare

== Software

- *Vensim* (industry standard, free PLE version)
- *Stella / iThink* (Apple-era educational)
- *AnyLogic* (also discrete + agent-based)
- *Python: PySD* (parses Vensim models)

== See also

- *#link(<system_dynamics_stocks_flows>)[Stocks and Flows]*
- *#link(<system_dynamics_causal_loop_diagrams>)[Causal Loop Diagrams]*
- *#link(<system_dynamics_feedback_loops>)[Feedback Loops]*
- *#link(<system_dynamics_delays>)[Delays]*
- *#link(<system_dynamics_numerical_integration>)[Numerical Integration]*
- *#link(<system_dynamics_bullwhip_sd>)[Bullwhip in SD]*
- *#link(<system_dynamics_beer_game>)[Beer Game]*
