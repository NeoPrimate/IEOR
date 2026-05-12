#import "/lib/imports.typ": *
#show: formatting

*Distribution Requirements Planning* (DRP): MRP applied to the *distribution side* of the supply chain. Plans replenishment of regional warehouses / DCs / retail stores from upstream sources.

Whereas #link(<supply-chain-planning-mrp>)[MRP] explodes finished-good demand into component requirements, DRP *aggregates* downstream demand into upstream-warehouse requirements.

== Setup

Multi-echelon distribution network:

```
                  Plant
                    │
              Central DC
                /   \
        Regional DC  Regional DC
         /   |   \      /   |   \
       Store Store Store Store Store Store
```

Each location has its own:
- Forecast (or downstream-driven demand)
- On-hand inventory
- Lead-time from supplier upstream
- Safety stock

DRP computes time-phased orders at each level so the right inventory arrives at the right place at the right time.

== Pull-up logic

Each location computes:

$
  "Gross need"_t = "Forecast"_t (text("for stores; sum of downstream orders for DCs"))
$

$
  "Projected on-hand"_t = "Projected on-hand"_(t-1) + "Receipts"_t - "Gross need"_t
$

$
  "Planned order release"_(t - L) = "Replenishment quantity" #h(0.2em) "if projected drops below safety stock"
$

The store's planned order becomes the regional DC's gross need; the regional DC's planned order becomes the central DC's gross need; etc.

== Difference from MRP

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*MRP*], [*DRP*]),
  [Direction], [Top-down (BOM explosion)], [Bottom-up (demand pull-up)],
  [Goal], [Plan production / materials], [Plan distribution / replenishment],
  [Bill structure], [Bill of Materials (parts)], [Bill of Distribution (network)],
  [Demand source], [MPS (planned), forecast], [Customer demand (forecast or actual)],
  [Time-phasing], [Lead-time-offset for production], [Lead-time-offset for shipping],
)

Both use the same record structure (gross requirements, on-hand, planned orders) but with different drivers.

== Why DRP matters

- *Visibility*: every echelon knows what's needed where, time-phased
- *Reduce stockouts* at downstream locations
- *Smooth upstream demand* (somewhat — bullwhip still bites)
- *Coordinate transportation*: bunch orders into fewer, larger shipments

== Bullwhip implications

DRP can *amplify* the #link(<supply-chain-bullwhip-effect>)[bullwhip effect]: lot-sized replenishment + safety stock at each echelon → upstream sees orders far more variable than actual end-customer demand.

Mitigations:
- *Smaller lot sizes* (more frequent, smaller orders)
- *Information sharing* (each echelon sees true end-customer demand, not just downstream orders)
- *VMI* (vendor-managed inventory) — upstream supplier sees real downstream consumption

== Connection to S&OP

DRP feeds into *Sales & Operations Planning*: balancing distribution-network requirements with production capability.

== See also

- *#link(<supply-chain-planning-mrp>)[MRP]* — the production-side counterpart
- *#link(<supply-chain-planning-mps>)[MPS]* — central production plan
- *#link(<supply-chain-bullwhip-effect>)[Bullwhip Effect]* — DRP can amplify it
- *#link(<supply-chain-multi-echelon-multi-echelon>)[Multi-Echelon Inventory]*
