#import "/lib/imports.typ": *

The foundation of #link(<system-dynamics-system-dynamics>)[system dynamics] modeling. Two element types:

- *Stocks* (or *levels*) — accumulations: inventory, population, money
- *Flows* (or *rates*) — rates of change: orders, births, spending

Stocks change *only* through flows. Flows change instantaneously based on system state.

== Mathematical foundation

For a stock $S(t)$ with inflow rate $f_("in")(t)$ and outflow rate $f_("out")(t)$:

$
  (d S) / (d t) = f_("in")(t) - f_("out")(t)
$

In integral form:

$
  S(t) = S(t_0) + integral_(t_0)^t [f_("in")(tau) - f_("out")(tau)] d tau
$

Each stock obeys this *conservation law*: change in stock = net flow.

== Units

Dimensional consistency is mandatory:

$
  [text("stock")] = [text("flow")] dot [text("time")]
$

- Inventory in *units*; production rate in *units / day*; integration over time recovers units.
- Money in *dollars*; spending in *dollars / month*.
- Population in *people*; birth rate in *people / year*.

A model with mismatched units is wrong; checking units catches half of all SD modeling errors.

== Three classes of stock-flow systems

*First-order linear*:

$
  dot S = -k S + f_("in")
$

Equivalently: stock decays toward $f_("in") / k$ with time constant $1/k$. Examples: exponential decay (radioactive substance), goal-seeking (workforce hiring toward target).

*Second-order linear*: two stocks, coupled

$
  dot S_1 = a S_1 + b S_2 \
  dot S_2 = c S_1 + d S_2
$

Eigenvalues determine behavior: stable / unstable spirals, exponential growth/decay, oscillation. Predator-prey, mass-spring, etc.

*Nonlinear*: $dot S = f(S)$ with $f$ nonlinear — limit cycles, chaos, bifurcations. Most real-world systems.

== Bathtub metaphor

A common teaching tool: a bathtub with a tap (inflow) and drain (outflow). Water level = stock. Tap and drain rates = flows.

Even simple bathtubs are non-intuitive: most people overestimate how fast filling a bathtub increases water level, because they fail to integrate the flow over time.

== Stocks have memory; flows don't

If you turn off the tap (set inflow to zero), the bathtub doesn't suddenly empty — water remains. Same with inventory after halting production, or accumulated CO2 after stopping emissions. *Stocks persist*.

Conversely, a flow can change instantaneously: stop the inflow → inflow rate is zero immediately.

This distinction is fundamental: policy interventions on *flows* have *delayed* effects on *stocks*.

== Connection to differential equations

Stocks and flows = the language of *ordinary differential equations* (ODEs). SD diagrams are just an alternative notation for systems of ODEs. The visual language helps:

- Identify state variables (= stocks)
- Track causal pathways (= flow equations)
- Communicate model structure to non-modelers

== See also

- *#link(<system-dynamics-causal-loop-diagrams>)[Causal Loop Diagrams]* — qualitative version
- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]*
- *#link(<system-dynamics-numerical-integration>)[Numerical Integration]* — for simulation
- *#link(<calculus-differential-equations>)[Differential Equations]*
