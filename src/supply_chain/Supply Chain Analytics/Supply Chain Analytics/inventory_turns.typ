== Inventory Turns

*Inventory Turns*: How many times inventory is turned over per year

Inventory Turns = Cost of Goods Sold / Average Inventory Value

*Days of Supply*: Average days the item is held in inventory

Days of Supply = Number of Days in Period / Inventory Turns

Efficiency Benchmark

Supply chain strategies

- *Push*: Forecast-driven, build inventory based on demand forecasts
- *Pull*: Customer-order-driven, only produce when there is a demand


Factories -Shipping Inbound-> Distribution Centers -Shipping Outbound> Retail Stores \<- Customers

Factory -> DCs -Direct Ship-> Customer

Question: Use stores or direct shipping?

*Shipping v. Inventory Trade-off*

1. Classical (Store) Model

DCs -Truck Load (TL) -> Stores (Large Inventory) \<- Customers

*Transport v. Inventory Trade-off*

Save shipping cost by TL but require large inventory at stores

Low Value, Long Shelf Life, High Volume Items

2. Continuous Replenishment Model

DCs -Less Than Truck Load (LTL) -> Stores (Small Inventory) \<- Customers

Increase Shipping Cost but Reduce Inventory Cost at Stores

3. Direct Shipping Model (Showroom)

Factory -> DCs -Direct Ship-> Customer

No Stores, Direct Shipping

Almost Zero Inventory, High Shipping Cost

High Value, Slow Moving Items

*Inventory Risk Pooling Effect*

Consolidate inventory into fewer locations, and total safety stock drops — even while serving the same demand

Simple Example
Say you sell umbrellas in 2 cities. Each city has:

Average weekly demand: 100 units
Std deviation: 50 units
You hold $1.65 sigma$ safety stock (95% service level)

Decentralized (2 separate warehouses):

Safety stock per city = 1.65 × 50 = 82.5 units
Total safety stock = 82.5 × 2 = 165 units

Centralized (1 warehouse serving both cities):

Combined std deviation = √(50² + 50²) = √5000 ≈ 70.7 units
Safety stock = 1.65 × 70.7 ≈ 117 units

Savings: 165 → 117 units (~29% less inventory)

=== Push Pull Strategies

Push — you push product into the supply chain speculatively. You bet on your forecast being right.
Pull — you wait for a customer order, then pull production/replenishment. No forecast needed, but you need fast response.


The Push-Pull Boundary
Most real supply chains are hybrid. The boundary (called the decoupling point) is where you switch from push to pull.
Example — car manufacturing:

Steel → stamping → painting → [decoupling point] → final assembly per order
Everything upstream is pushed (economies of scale); downstream is pulled (customer config)

#table(
  columns: 2,
  align: left,
  [Push], [Pull],
  [Forecast-driven], [Order-driven],
  [Build inventory ahead], [Wait for order],
  [Higher inventory], [Lower inventory],
)

#table(
  columns: 3,
  align: left,
  [], [Pros], [Cons],
  [
    Push
  ],
  [
    -Customer doesn't wait
    - Batch picking / shipping as DCs
    - Economies of scale
  ],
  [
    - Significant inventory investment
    - Risk of obsolescence
  ],

  [Pull],
  [
    - Lower inventory investment
    - Faster response to customer demand\ (latest assets)
  ],
  [
    - Customer has to wait
    - Unit picking / packing at DCs
    - Higher shipping costs
    - Longer lead times
  ],
)

Tradeoff:
- Shipping, picking / packing
- Customer wait time

vs.

- Inventory investment
- New product introduction

Categorize Products

#table(
  columns: 4,
  align: center + horizon,
  inset: 1em,
  table.cell(colspan: 2, rowspan: 2, []), table.cell(colspan: 2, [Volumne]),
  [Low], [High],
  table.cell(rowspan: 2, [Price]),
  [Expensive], [Pull], [?],
  [Inexpensive], [?], [Push],
)

Data Collection
- Inventory Holding Cost
- Shipping Cost
- Picking / Packing Cost
- Sales Volumne (by product)
- Inventory Levels (by product)

Calculate:
- Inventory Cost
- Shipping Cost
- Warehouse Cost
Under Push / Pull by Product

1. Inventory Cost

Estimating Inventory Cost Rates (Per Week Per Unit) At Stores

Capital cost per week per unit + Depreciation per week per unit

Inventory cost per week per unit =
$
  "Annual capital cost" / 52 + ("Product Value" - "Liquidation Value") / "Product Life Cycle"
$

E.g.,
- Smartphones
  - Product Value: \$500
  - Liquidation value: 0%
  - Capital return rate: 8%
  - Inventory cost / unit: \$20
  - Life cycle: 26 weeks

- Feature Phone
  - Product Value: \$200
  - Liquidation value: 0%
  - Capital return rate: 8%
  - Inventory cost / unit: \$8

$(500 times 0.08) / 52 + (500 - 0) / 26 = \$20$

2. Picking / Packing Cost

- Push: Weekly

Cost of N units = Cost of 1st pick/pack cost + subsequent pick/pack cost \* (N-1)

- Pull: Unit

1st pick/pack cost \* N


=== Inventory cost rates (per week per unit)


Inventory cost per week (per unit) = Capital cost per week (per unit) + Depreciation per week (per unit)

Capital cost per week (per unit) = Product value \* Annual capital return rate / 52

Depreciation per week (per unit) = (Product value - Liquidation value) / Product life-cycle (in weeks)

Example 1: Smart phones

The value of a smart phone is \$500 on average. Suppose the annual capital return rate is 8% (if the \$500 is invested elsewhere, one may get a return of 8% annually), the liquidation value at the end of the product life-cycle is \$0, and the product life-cycle is 26 weeks (half a year). Then for smart phones,

Inventory holding cost per week (per unit) = \$500 \* 8% / 52 + (\$500 - \$0) / 26 = \$20.00 / unit.

Example 2: Feature phones

The value of a feature phone is \$200 on average. Suppose the annual capital return rate is 8%, the liquidation value at the end of the product life-cycle is \$0, and the product life-cycle is 26 weeks (half a year). Then for features phones,

Inventory holding cost per week (per unit) = \$200 \* 8% / 52 + (\$200 - \$0) / 26 = \$8.00 / unit.

=== Shipping cost rates (per unit)


Overnight express shipping rate (per unit): \$12.00 / unit (FedEx benchmark)

Standard 2-day shipping with batch discount:

The 2-day standard shipping cost is usually much cheaper than overnight express, and batch shipping (shipping more than 10 units at a time to the same destination) usually enjoy a discount depending on the carriers and distance.

Using FedEx as a benchmark, the ratio between overnight and 2-day shipping rates is 2.5 / 1, and shipping batch can enjoy a 50% discount per unit. Then the unit shipping cost for 2-day batch shipping is

\$12 / 2.5 \* 50% = \$2.40 / unit.

=== Warehouse picking / packing cost rates


To pick / pack N (>1) identical products in one order:

1st pick / pack cost = \$1.00.

subsequent pick / pack cost = \$0.10
