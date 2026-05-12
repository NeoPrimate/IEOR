#import "/lib/imports.typ": *
#show: formatting

*Rough-Cut Capacity Planning* (RCCP): a *feasibility check* on the #link(<supply-chain-planning-mps>)[MPS]. Estimates whether key resources (workforce, machines, materials) can support the planned production *before* committing to MRP.

== Why RCCP

MPS plans *what to produce*. Without RCCP, the plan might be infeasible — exceed available capacity → MRP will issue impossible orders → cascading delays.

RCCP catches this at the strategic / tactical level *before* detailed MRP runs.

== Bills of capacity / bills of resources

A *bill of capacity* — like a BOM but for capacity — specifies how much of each *critical resource* each end product consumes.

Example: Product *Bicycle*:
- 0.5 hours on Assembly line A
- 0.3 hours on Welding station
- 1.2 hours of skilled-labor

Plan to produce 1,000 bicycles in week 5:
- Need 500 hours of Line A
- Need 300 hours of Welding
- Need 1,200 hours of skilled labor

== Capacity gap check

For each critical resource and each MPS week:

$
  text("Load"_(r, t)) = sum_i text("MPS"_(i, t)) dot text("usage"_(i, r))
$

$
  text("Slack"_(r, t)) = text("Available"_(r, t)) - text("Load"_(r, t))
$

If slack is negative for any (resource, week), the MPS is infeasible.

== Capacity vs Loading

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*RCCP*], [*Detailed CRP (Capacity Requirements Planning)*]),
  [When], [Before MRP], [After MRP],
  [Resources], [Few critical (work centers, key labor)], [All work centers],
  [Granularity], [Aggregate, weekly], [Per operation, per machine, daily],
  [Speed], [Fast (minutes)], [Slow (hours)],
  [Action], [Adjust MPS if infeasible], [Adjust schedule, expedite, overtime],
)

RCCP is the *coarse* feasibility check; CRP is the detailed scheduling that follows MRP.

== When RCCP detects infeasibility

If MPS exceeds capacity:

1. *Reduce MPS* — produce less, accept stockouts or backorders
2. *Expand capacity* — overtime, hire temps, weekend shifts
3. *Outsource* — third-party manufacturing
4. *Shift production timing* — produce earlier (carry inventory) or later (backorder)
5. *Substitute products* — produce alternatives that use unused capacity

== Limitations

- *Critical-resource focus* — ignores non-critical bottlenecks
- *Aggregate timing* — weekly buckets miss intra-week variations
- *Static* — doesn't model setup times / changeovers

RCCP is *sufficient* for strategic planning; *insufficient* for shop-floor execution.

== See also

- *#link(<supply-chain-planning-mps>)[MPS]* — what RCCP checks
- *#link(<supply-chain-planning-mrp>)[MRP]* — downstream of RCCP
- *#link(<supply-chain-planning-aggregate-planning>)[Aggregate Planning]* — upstream of RCCP
