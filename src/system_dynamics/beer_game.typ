#import "/lib/imports.typ": *

The *Beer Distribution Game* (MIT Sloan, 1960s) — a tabletop / simulation exercise demonstrating the #link(<supply-chain-bullwhip-effect>)[bullwhip effect]. The most-played management game ever.

== Setup

Four-stage supply chain: Retailer → Wholesaler → Distributor → Factory. Each stage:

- Receives orders from downstream
- Ships goods to downstream
- Places orders upstream
- Carries inventory; pays *holding cost* and *backorder cost*

There's a *2-week shipping delay* between stages and *1-week order delay*. Initially, demand is 4 cases/week (stable).

== The shock

After 4 weeks, retail customer demand *steps up* to 8 cases/week and stays there.

== The result (consistent across hundreds of plays)

Despite the step being small (4 → 8), upstream stages see:
- Factory orders peak at 20-40 cases/week
- All stages alternate between massive backorders and massive overstocks
- Total system cost is *10-30× higher* than the optimum

Even MIT students consistently exhibit this behavior. The bullwhip is *structural*, not a personal failure.

== Sterman's decision-rule estimate

Sterman (1989) fit each player's order rule to:

$
  text("Order"_t) = max{0, hat(D)_t + alpha_S (S^* - S_t) + alpha_(S L)(S L^* - S L_t)}
$

where $hat(D)_t$ is smoothed demand. He found:

- $alpha_S approx 0.36$ (modest correction speed)
- $alpha_(S L) approx 0.26$ — but more critically:
- Players *underweight* the supply line (most attention on $S$, less on $S L$)

This *supply-line neglect* drives oscillation: players keep ordering even though previous orders are en route.

== What works

After playing several rounds, players learn:

1. *Slow down*: smaller corrections per period
2. *Pay attention to the supply line*: full $alpha_(S L)$
3. *Smooth demand*: don't react to every blip
4. *Information sharing*: when upstream sees end-customer demand (not just downstream orders), bullwhip largely vanishes

== Mathematical structure

Each echelon is a 2nd-order delayed feedback system (#link(<system-dynamics-second-order>)[here]). Four cascaded → high-order oscillator. With shock input + supply-line neglect → sustained large oscillation.

== Variations

- *Beer Game online*: Powersim, Forio, MIT's online version
- *Reduced-delay variant*: shorter lead times → less bullwhip
- *Information-sharing variant*: all stages see end-demand → bullwhip eliminated

== Why it matters

The beer game is the *empirical* answer to "do real people exhibit bullwhip?" Answer: yes, robustly. It validates the SD theory and motivates:

- Lead-time reduction
- Information sharing (CPFR, VMI, EDI)
- Order-policy training
- Centralized planning

== See also

- *#link(<system-dynamics-bullwhip-sd>)[Bullwhip in SD]* — closed-form analysis
- *#link(<system-dynamics-stock-management>)[Stock Management]* — the decision rule
- *#link(<supply-chain-bullwhip-effect>)[Bullwhip Effect]*
- *#link(<system-dynamics-delays>)[Delays]*
