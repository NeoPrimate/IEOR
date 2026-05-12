#import "/lib/imports.typ": *
#show: formatting

#let cm(x) = text(fill: red, [$#x$])

Inventory built up *in advance* of a *known* future demand spike. Distinct from safety stock (which buffers *unknown* uncertainty) — anticipation stock buffers *known* but *concentrated* demand.

=== When you build it

Three classic situations:

+ *Seasonal demand*: ice cream in summer, snowblowers in winter, retail before December. Production capacity is roughly flat year-round but demand is concentrated in a few months. Build inventory in low-demand months and sell it in peak months.

+ *Promotional events*: Black Friday, product launch, advertised sale. Known spike, fixed date. Build before to avoid stockouts during the event.

+ *Planned supply disruption*: known upcoming shutdown (factory maintenance, holiday closure, supplier plant retooling). Build before the gap to maintain customer service through it.

In each case, future demand exceeds future production capacity, so you *can't* meet it just-in-time. Build early.

=== The build-vs-capacity trade-off

You face two strategies:

#table(
  columns: 3,
  inset: 0.7em,
  align: (left, center, center),
  [*Strategy*], [*Pros*], [*Cons*],
  [*Build anticipation stock*],
  [Steady production rate, no capacity expansion needed],
  [Holding cost on the buffer; risk if forecast is wrong],

  [*Build to peak capacity*],
  [Match production to demand; no excess inventory],
  [High peak capacity → idle capacity off-peak; may need overtime, second shifts, or capital expansion],
)

The right answer depends on the *cost ratio*:
- Cheap to hold inventory + expensive to expand capacity → build anticipation stock.
- Cheap to add capacity (e.g., outsourced labor) + expensive to hold → match capacity to demand.

Most operations use a *blend*: a partial buffer plus some capacity flexibility.

=== Sizing anticipation stock

Given:
- Production rate $p$ (units / period, what your plant can produce)
- Demand rate by period: $d_t$, with peak $d_"peak" > p$

The cumulative gap between demand and production over the peak window must be covered by the buffer:

$ "Anticipation stock"_"start" = sum_(t in "peak window") max(0, d_t - p) $

Build this buffer up *before* the peak window starts, then drain during the peak.

=== When forecast is wrong

Anticipation stock is forecast-driven. If forecast is off:
- *Underbuilt* (forecast too low): stockout in peak. Recovery options: emergency overtime, third-party fulfillment, customer disappointment.
- *Overbuilt* (forecast too high): leftover inventory. Carry to next period, mark down, or write off. Common with seasonal apparel.

This is why fashion retailers struggle so much — anticipation stock + multiplicative demand uncertainty + short selling window. They blend anticipation (initial commitment) with reactive replenishment (postponement strategies, fast fashion).

=== How it composes with other stock types

Most operations have ZERO anticipation stock most of the time — it builds and drains around specific events. Different from cycle/safety/pipeline stock, which exist continuously.

Total inventory at a moment in time:

$ "Total inventory" = "Cycle stock" + "Safety stock" + "Pipeline stock" + "Anticipation stock" + "Decoupling stock" $

Anticipation is "spiky" — zero most of the year, large around events.

#example(title: "Seasonal anticipation stock for a snowblower factory")[
  *Given*:
  - Annual demand: 12,000 units
  - Demand concentrated in November-February (4 months): 9,600 units (80% of annual)
  - Off-peak (March-October, 8 months): 2,400 units (20%)
  - Production capacity: 1,000 units / month (12,000/yr — exactly matches average)
  - Holding cost: \$2 / unit / month

  *Step 1 — peak vs production*

  Peak demand: $9600 / 4 = 2400$ units / month.
  Production: 1000 units / month.
  *Gap*: 1400 units / month for 4 months = 5,600 units total *cannot be made just-in-time*.

  *Step 2 — anticipation stock requirement*

  Build 5,600 units before November 1. Production capacity in March-October must support both off-peak demand AND building the buffer:
  $ "Off-peak production needed" = "off-peak demand" + "buffer" = 2400 + 5600 = 8000 "units" $

  Over 8 off-peak months: $8000 / 8 = 1000$ units / month — *exactly the capacity*.

  Convenient: with capacity matched to average demand, anticipation stock fills exactly the off-peak idle capacity.

  *Step 3 — anticipation-stock holding cost*

  Buffer builds linearly from 0 (March) to 5,600 (November), then drains linearly to 0 (March again). Average level over the 12-month cycle:
  $ overline("anticipation") approx 1/2 dot 1/2 dot 5600 = 1400 "units (rough)" $

  More precisely: the integral of a triangle of height 5600 over 12 months / 12 months = $5600 dot 6 / 12 / 2 = 1400$ units average.

  Annual holding cost: $h_"month" dot 1400 dot 12 = 2 dot 1400 dot 12 =$ \$33,600 / year.

  *Step 4 — alternative: build peak capacity instead*

  Add capacity to make 2,400 units / month (matching peak). Idle most of the year. Capacity costs (extra equipment, plant, labor): say \$100,000 capital cost, depreciated over 10 years → \$10,000/year + variable labor.

  Compare:
  - Anticipation: \$33,600/year holding cost.
  - Capacity expansion: \$10,000+/year capital + idle-time cost.

  *Capacity expansion wins*. But the calculus depends on:
  - Higher holding cost → favor capacity.
  - Higher capacity cost → favor anticipation.
  - More uncertainty → favor capacity (less risk on forecast error).

  Real operations almost always *blend*: some anticipation, some flex capacity, some safety stock for forecast error.
]
