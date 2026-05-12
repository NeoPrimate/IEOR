#import "/lib/imports.typ": *
#show: formatting

= Supply Chains, Demand Management, and Forecasting

== Introduction to Supply Chain

1. Supply Chain

Network of organizations, people, activities, information and resources involvd in supplying a product or service to a customer. Encompasses everything from procurement of raw materials to final delivery of finished product to the customer.

- Suppliers: Providers of raw materials or components
- Manufacturers: Transform raw materials into finished goods
- Distributors: Warehouses that hold & deliver goodsRetailers: Interface with final customers
- Customer: End users of product or service

2. Supply Chain Management

Overseeing and managing the entire flow of goods and services, ensuring efficient movement from raw materials to finished products.
- Minimize costs
- Optimize inventory levels
- Improving efficiency
- Ensure timely delivery of customers
- Enhance customer satisfaction
- Meet customer demand

Types of supply chains

- Make-to-Stock (MTS): Products are manufactured in advance and stocked based on demand forecast (Coca-Cola)
- Make-to-Order (MTO): Products are made only after a customer order is received (Boeing)
- Assemble-to-Order (ATO): Products are assembled from pre-manufactured components only after a customer order is received (Dell)

3. Flows

- Information: Data exchanged between different parts of the supply chain (orders, inventory levels, product status)
- Product: Physical movement of goods from suppliers to manufacturers, distributors, retails and consumers
- Financial: Payment and credit processes between participants (cost transfers, invoicing, patments)

4. Globalization

Challenges

- Longer lead times
- Currency flucutations
- Regulation compliance
- Geopolitical tensions

5. Competitive advantage

- Speed to market: Reducing time it takes to get products to market
- Cost efficiency: Reducing production and transportation costs
- Felxibility: Ability to adapt to market changes and customer need
- Customer service: Ensuring timely delivery and product availability

6. Technology & Digitalization

- AI/ML: Demand forecasing & predictive maintenance
- IoT: Track shipments & manage inventory
- Blockchain: transactions transparency and security

7. Sustainability

Minimize environmental & social impact
- Carbon emissions (efficient transportation)
- Energy efficient processes in production
- Minimize waste
- Renewable / recyclable resources
- Fair labor practices / ethical labor practices

8. Risk Management

Supply chain resilience
- Operational risk: Breakdown in manufacturing or distribution process
- Supply risk: Disruption in availability of materials or services
- Demand risk: fluctuation in customer demand
- Environmental risk: Natual disacters / climate change

- Natural disters
- Geopolitical tensions
- Supplier failures
- Demand fluctuation

9. Collaboration
- Supplier partnerships: Building long term relationships with key suppliers
- Shared logistics: Coordinating tranportation & warehousing partners
- Data sharing: sharing real time date, production schedules, dand demand forecasts

10. Supply Chain Integration

- Horizontal: Collaboration between different firms at the same level of the supply chain (2 manufacturers or 2 distributors)
- vertical: Multiple stages of the supply chain, from raw materials to final product distribution
- Technology: Shared platforms for operations and communication across supply chain

11. Ethical Supply Chains

- Fair wages
- Safe working conditions
- Environmental protection
- Corporate transparency

12. Bullwhip Effect

small fluctuations in customer demand at the retail level become larger and larger as you move upstream (wholesalers → distributors → manufacturers → suppliers)

Casuses: information distortion + delayed reactions

- Delays in demand information moving up the supply chain
- Batch ordering (retailers order large quantities irregularly)
- Price fluctuations (order spikes)
- Overreaction to demand signals by upstream suppliers

== Demand Analysis and Patterns

1. Demand Analysis

Predict demand for products and services

- Historical Data: Analyzing past sales & trends
- Market Conditions: Understanding current market dynamics & economic indicators
- Consumer Behavior: Identifying changes in customer preferences and buying patterns

2. Demand Patterns

- Seasonal: Peaks and trophs (hilodays, summer, etc.)
- Cyclical: Economic cycles (recessions & booms)
- Random: Noise
- Trend: Long term movement (up or down)

3. Demand Forecasting Methods

- Qualitative: Expert judgement (e.g., Delphi method)
- Quantitative: Mathematical model, historical data (e.g., time series analysis)

4. Factos affecting demand

- Price
- Consumer preferences
- Income levels
- Competition
- Substitute products

5. Role of Technology in Demand Analysis

- AI/ML
- Big Data

6. Balancing Supply and Demand

- Just-in-Time (JIT) inventory: reducing inventory costs by producing just when needed
- Safety stock: Extra inventory to cushion against demand fluctuation
- Felxible production systems: Quickly adapting production levels based on demand change

7. Impact of external factors on demand

- Political: Policy, trade tariffs, international relations
- Economic: Recession & booms
- Social: Societal values
- Environmental: Natural disasters, pandemics

8. Measuring demand accuracy

- Mean Absolute Deviation (MAD): Measures average magnitude of forecast errors, regardless of direction
- Mean Squared Error (MSE): Squared errors, giving more weight to larger deviations
- Tracking Signal: Monitors whether a forecast is consistently over or underestimating demand, detecting bias in forecasting methods

8. Demand Management and Planning

- Product promotion
- Pricing strategies
- Collaborative demand Planning
- Flexible production

== Demand Management

1. Demand Drivers

- Economic conditions
- Market trends
- Technological advancements
- Consumer preferences
- Seasonality
- Marketing

2. Forecasting Demand

- Quantitative
- Qualitative
- Hybrid

3. Collaborative Demand Planning

Collaborate across
- Internal Units (marketing, sales, production)
- External partners (suppliers, retailers)

4. balancing Supply and Demand

Meeting demand without over- or under-production

5. Demand Shaping

Influence demand through strategic initiatives
- promotions
- discounts
- advertising
- product bundling

6. Technology in Demand Management

- Big Data
- AL/ML

7. Inventory Management

- Overstocking: ties up capital & incurs storage cost
- Unserstocking: missed sales opportunities

8. Demand Management Chellenges

- Demand variability
- Lead times
- Supply chain disruptions
- Changes in customer preferences

9. Risk Management

- Buffer inventory
- Supplier diversification
- Contingency planning (natural disasters, economic downturn, etc.)

10. Sales & Operations Planning (S&OP)

Integrated business management process that bring together sales, marketing, supply chain, finance teams to align demand forecasts with operational plans

== Forecasting

1. Importance

Planning supply chain activities to meet future demand while optimizing costs

2. Qualitative v. Quantitative

- Qualitative
- Quantitative

3. Time Series Forecasting

Predict future demand

- Moving averages
- Exponential smoothing
- Seasonal adjustments

4. Causal Forecasting Models

Cause-and-Effect relationship between demand and various external factors (price, economic indicators, marketing)

5. Forecasting Tools & Software

- ML
- Data analytics
- Real-time data

6. Forecasting Horizon

Time period that the forecast covers
- Short-term (days to weeks)
- Medium-term (months)
- Long-term (years)

Accuracy decreases with longer time horizons

7. Seasonal and Cyclical Demand

- Seasonal: Predictable variation in demand (weather, holidays)
- Cyclical: Fluctuations tied to broader economic cycles

8. Collaborative Planning, Forecasting & Replenishment (CPFR)

Businesses work with suppliers, customers, & other partners to jointly forecast demand

9. Forecasting Challenges






#example[
  *MAPE*

  Data:

  #align(center)[
    #table(
      columns: 3,
      align: center,
      inset: 1em,
      [Month], [Actual], [Forecast],
      [1], [1200], [1250],
      [2], [1400], [1350],
      [3], [1100], [1000],
      [4], [1300], [1200],
    )
  ]

  Steps:

  #align(center)[
    #table(
      columns: 5,
      align: center + horizon,
      inset: 1em,
      [Month], [Actual], [Forecast], [Error\ $abs(A - F)$], [% Error\ $abs(A - F) / A$],
      [1], [1200], [1250], [-50], [4.17%],
      [2], [1400], [1350], [50], [3.57%],
      [3], [1100], [1000], [100], [9.09%],
      [4], [1300], [1200], [100], [7.69%],
    )
  ]

  $
    "MAPE" = (4.17 + 3.57 + 9.09 + 7.69) / 4 = 6.6%
  $
]

#example[
  *EOQ*

  Data:

  Annual Demand (D): 24,000 units

  Order Cost (S): \$60 / order

  Carrying (Holding) Cost: \$4/units/year

  Steps:

  $
    "EOQ" = sqrt((2 D S) / H) = sqrt((2 times 24000 times 60) / 4) approx 848
  $

  $
    "Orders/year" = D / "EOQ" = 24,000 / 848 approx 28.3
  $

  $
    "Ordering Cost" = 28.3 times 60 = \$ 1698
  $

  $
    "Holding Cost" = (848 \/ 2) times 4 = \$1696
  $

  $
    "Total Annual Cost" = "Ordering Cost" + "Holding Cost" = 1698 + 1696 = 3394
  $
]

#example[
  *Safety Stock (Service Level)*

  Data:

  Average Weekly Demand = 400

  Standard Deviation Demand = 50

  Lead Time = 2 Weeks

  Service Level = 95% $arrow$ z = 1.65

  Steps:

  $
    sigma_i = sigma sqrt(L) = 50 times sqrt(2) = 70.7
  $

  $
    "Safety Stock" = z times sigma_i = 1.65 times 70.7 = 117 "units"
  $

]

#example[
  *Reorder Point ROP*

  Data

  Average Daily Demand = 60 units

  Lead Time = 8 days

  Safety Stock = 100 units

  Steps

  $
    "ROP" = ("Demand" times "Lead Time") + "Safety Stock"
  $

  $
    "ROP" = (60 times 8) + 100 = 480 + 100 = 580 "units"
  $

  Reorder Point = 580 units
]

#example[
  *Capacity Utilization*

  Data

  Design Capacity = 10000 units / week

  Actual Output = 8500 units / week

  Steps:

  $
    "Utilization" = ("Actual" / "Design") times 100 = (8500 / 10000) times 100 = 85%
  $

  Capacity utilization = 85%

  Plant is operating efficiently below full load
]

#example[
  *Inventory Turnover & Days of Supply*

  Data

  COGS = \$4,800,000

  Average Inventory = \$600,000

  Steps

  $
    "Inventory Turnover" = "COGS" / "Average Inventory" = 4800000 / 600000 = 8 "turns" \/ "year"
  $

  $
    "Inventory Turnover" = 8 times "per year" quad arrow quad 45.6 "days of supply"
  $
]

#example[
  *Total Landed Cost Comparison*

  Data:

  Supplier A: \$20 / unit + \$2000 freight per 1000 units

  Supplier B: \$19 / unit + \$3500 freight per 1000 units

  Steps

  Supplier A: cost / unit = 20 + (2000 / 1000) = \$22.00

  Supplier B: cost / unit = 19 + (3500 / 1000) = \$22.50

  Supplier A is cheaper by \$0.50 *per unit*
]

#example[
  *Cycle Time Reduction*

  Data

  Output = 500 units / day

  Cycle Time = 1.2 min / unit

  Improvement = 15% reduction

  Steps

  New Cycle Time = 1.2 times (1 - 0.15) = 1.02 min / unit

  Available time = 500 times 1.2 = 600 min / day

  New output = 600 / 1.02 = 588 units / day

  Increase = 588 - 500 = +88 units / day
]

#example[
  *Cash To Cash Cycle Time*

  Data

  Days of Inventory = 40

  Days receivable = 30

  Days payable = 25

  Steps

  C2C = Days Inventory + Days Receivable - Days Payable = 40 + 30 - 25 = 45

  Cash to Cash Cycle Time = 45 days
]

#example[
  *Distribution Network Optimization*

  Data

  Current (1 DC)
  - Transportation = \$ 300,000
  - Facility = \$100,000

  New (2 DCs)
  - Transportation = \$220,000
  - Facility = \$180,000

  Steps

  Current total = 300,000 + 100,000 = 400,000

  New Total = 220,000 + 180,000 = 400,000

  Nototal cost change


]
