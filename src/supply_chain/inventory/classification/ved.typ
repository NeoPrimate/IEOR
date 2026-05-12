#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

== VED Analysis (Vital / Essential / Desirable)

Classify items by *criticality of stockout*. Independent of value or variability — it's about consequence-of-failure.

=== The criticality split

- *V items* (Vital): stockout halts operations or risks safety / regulatory compliance. *No tolerance* for unavailability.
- *E items* (Essential): stockout causes significant disruption but operations can continue (degraded performance, workarounds available).
- *D items* (Desirable): stockout is an inconvenience; operations continue normally with minor impact.

=== Why classify by criticality

ABC, XYZ, and FSN look at *value*, *variability*, and *frequency*. None of these capture *what happens if you run out*. A \$1 fuse in a hospital ventilator is *Vital* even though it's low-value, low-variability, and slow-moving.

Criticality is what justifies:
- Higher service levels (target 99.9% for V vs 95% for D)
- Larger safety stocks regardless of holding cost
- Multiple suppliers for V items (sourcing redundancy)
- Emergency procurement contracts for V items

VED is most prevalent in:
- *Healthcare* (drugs, surgical supplies, life-support spares)
- *Manufacturing maintenance* (MRO spares — a \$50 bearing that holds together a \$500K production line)
- *Aviation / military* (anywhere a single failure has outsized cost)
- *Utilities* (grid, water, telecom — single-point-of-failure components)

=== Procedure

+ For each SKU, ask: *what's the cost of a stockout?*
+ Categorize:
  - *V*: stockout = life, safety, large operational halt, or regulatory violation
  - *E*: stockout = significant downtime / customer impact, but workarounds exist
  - *D*: stockout = minor inconvenience
+ Apply differential service levels and stocking policies.

=== Service-level targets by class

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, left),
  [*Class*], [*Target CSL*], [*Stocking philosophy*],
  [V],
  [99.5–99.99%],
  [*Never stockout*. Multiple suppliers, emergency stock, expedited freight contracts. Safety stock dominates regardless of holding cost.],

  [E], [95–99%], [Standard high service. Single reliable supplier; safety stock per (Q, r) or (s, S) policies.],
  [D], [85–95%], [Cost-optimized. Accept occasional stockouts to keep holding costs in check.],
)

=== VED + ABC = a richer matrix

VED is often combined with ABC into a 3×3 grid (similar to ABC-XYZ):

- *AV*: high-value, vital — heavy investment in inventory and supplier diversification.
- *CV*: low-value, vital — overstock liberally; the holding cost is trivial against the stockout cost.
- *AD*: high-value, desirable — most attention to lean inventory, can afford some stockouts.
- *CD*: low-value, desirable — minimum effort; overstock or eliminate.

The asymmetric cells — *low-value vital* especially — are why VED matters: ABC alone says "spend little time on it"; VED says "but never run out."


#example[
  *Given*: maintenance spares for a small manufacturing line.

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, left),
    [*Item*], [*Unit cost*], [*Annual demand*], [*Stockout consequence*],
    [Critical PLC controller], [\$2,000], [2 / year], [Production line halts; ~\$50K/day lost output],
    [Standard motor bearing], [\$50], [12 / year], [Specific machine offline; workaround possible],
    [Lubricant pail], [\$80], [40 / year], [Maintenance delayed a few hours],
    [Spare bolt set], [\$5], [200 / year], [Small inconvenience; alternative bolts on hand],
    [Calibration weight],
    [\$300],
    [1 / year],
    [Required for monthly calibration; no substitute; can pause operations until next cal cycle],
  )

  *Step 1 — assign VED*

  #table(
    columns: 3,
    inset: 0.6em,
    align: (left, center, left),
    [*Item*], [*Class*], [*Reasoning*],
    [Critical PLC controller], [V], [Halts whole line; \$50K/day downtime cost],
    [Standard motor bearing], [E], [One machine offline; workarounds available],
    [Lubricant pail], [D], [Maintenance delay only; common item],
    [Spare bolt set], [D], [Substitutes available],
    [Calibration weight], [V], [Compliance requirement; no substitute],
  )

  *Step 2 — set service levels*

  #table(
    columns: 4,
    inset: 0.6em,
    align: (left, center, center, center),
    [*Item*], [*VED*], [*CSL target*], [*Implied $z$*],
    [Critical PLC controller], [V], [99.9%], [3.09],
    [Standard motor bearing], [E], [97%], [1.88],
    [Lubricant pail], [D], [90%], [1.28],
    [Spare bolt set], [D], [90%], [1.28],
    [Calibration weight], [V], [99.5%], [2.58],
  )

  *Step 3 — compare safety stocks*

  Suppose the standard motor bearing had monthly demand $sigma$ = 0.5 units, lead time $L$ = 1 month. Safety stock at:
  - 95% (default): $z = 1.65$ → SS = 0.83 units → round up to 1.
  - 97% (E-target): $z = 1.88$ → SS = 0.94 → round up to 1.
  - 99.9% (if it were V): $z = 3.09$ → SS = 1.55 → round up to 2.

  Even at the *highest* service level, total SS for a slow-moving item is just 2 units. The *cost difference* is one extra bearing in stock — \$50 — vs the *downtime cost* if you stock out. Trivially worth it for E or V class items.

  *Step 4 — interpret cross-classification with ABC*

  - *Critical PLC controller*: A-class (\$4K annual value), V-class. *AV* — biggest priority. Multiple suppliers, expedited shipping contract, generous safety stock.
  - *Calibration weight*: C-class (\$300/year), V-class. *CV* — *low value, vital*. The right answer here is *overstock without thinking*. Holding cost is negligible; consequences of stockout are large. Carry 2 units instead of 1.
  - *Spare bolt set*: C-class, D-class. *CD* — automated two-bin replenishment. Don't waste planning effort.

  *The asymmetric cell — CV (low value vital)* — is the most common surprise in VED analysis. Operations teams often *under*-stock low-value vital items because ABC says "C-class, don't bother". VED corrects this.
]
