#import "/lib/imports.typ": *
#show: formatting

*Material Requirements Planning* (MRP): explodes the #link(<supply-chain-planning-mps>)[MPS] into time-phased requirements for *every part / component / material* needed to make the planned products.

Foundation of every ERP system (SAP, Oracle, NetSuite, etc.).

== Inputs

1. *MPS* — planned production quantities, time-phased
2. *Bill of materials (BOM)* — what components go into each product (and how many of each)
3. *Inventory file* — on-hand and scheduled receipts of every part
4. *Lead-time data* — manufacturing / procurement lead time for each part

== BOM example

Product *Bicycle*:
- 2 × Wheel
  - 1 × Tire
  - 1 × Rim
  - 30 × Spoke
- 1 × Frame
  - 5 × Steel tube (cut from raw)
  - 4 × Bracket
- 1 × Handlebar

Two-level explosion: Bicycle → Wheel/Frame/Handlebar; then Wheel → Tire/Rim/Spoke; etc.

== Three core steps per item

For each part, working *level-by-level from top to bottom* of the BOM:

1. *Gross requirements* — how many needed in each period (driven by parent's planned orders + parent's lead time)

2. *Net requirements* — gross minus available (on-hand + scheduled receipts)

3. *Planned orders* — when to *release* an order to cover net requirements, offset by lead time

```
For each part, time period t:
    Gross[t] = parent_demand[t]
    Net[t] = max(0, Gross[t] - OnHand[t-1] - SchedReceipts[t])
    OnHand[t] = OnHand[t-1] + SchedReceipts[t] - Gross[t] + PlannedReceipt[t]
    Planned release at t - lead_time = Net[t]  (lot-sized; see below)
```

== Lot sizing

Plan orders in batches, not unit-by-unit:

- *Lot-for-lot (LFL)*: order exactly the net requirement each period — minimal inventory, max setups
- *Fixed quantity*: always order $Q$ units (e.g., EOQ)
- *Periods of supply (POS)*: cover $k$ periods of demand
- *#link(<supply-chain-planning-silver-meal>)[Silver-Meal]* / *#link(<supply-chain-planning-least-unit-cost>)[Least Unit Cost]* / *#link(<supply-chain-planning-part-period-balancing>)[Part-Period Balancing]* — heuristics
- *#link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin]* — DP-optimal lot-sizing

== Time-phased record example

Part: Wheel. Lead time: 2 weeks. On-hand: 50. Lot size: 100.

#table(
  columns: 7,
  align: (left, center, center, center, center, center, center),
  stroke: none,
  table.header([Week], [1], [2], [3], [4], [5], [6]),
  [Gross requirements (from Bicycle)], [200], [240], [220], [200], [260], [240],
  [Scheduled receipts], [100], [0], [0], [0], [0], [0],
  [Projected on-hand], [-50], [60], [-160], [40], [-220], [40],
  [Net requirements], [0], [0], [160], [0], [220], [0],
  [Planned order receipt], [0], [0], [200], [0], [300], [0],
  [Planned order release (lead time -2)], [200], [0], [300], [0], [0], [0],
)

(Numbers illustrative; not perfectly consistent — purpose is to show the structure.)

== MRP I → MRP II → ERP

- *MRP I* (1970s): material requirements only
- *MRP II* (1980s): adds capacity requirements, financial integration, scheduling
- *ERP* (1990s+): fully integrated business systems including HR, accounting, CRM

== Limitations

- *Deterministic*: ignores demand and lead-time uncertainty (planners add safety stock manually)
- *Schedule nervousness*: small changes ripple
- *Push system*: drives production based on plan, not on-the-ground signal — compare with Kanban / pull
- *Lot sizing tension*: heuristics like EOQ optimize per part, missing cross-part synergies

== See also

- *#link(<supply-chain-planning-mps>)[MPS]* — input
- *#link(<supply-chain-planning-drp>)[DRP]* — same logic, distribution side
- *#link(<supply-chain-planning-rccp>)[RCCP]* — capacity check
- *#link(<supply-chain-eoq-wagner-whitin>)[Wagner-Whitin]* — lot-sizing
