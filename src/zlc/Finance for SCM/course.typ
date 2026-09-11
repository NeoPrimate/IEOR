#import "/lib/imports.typ": *
#import "/lib/formatting.typ": *
#import "@local/tystats:0.1.0": norm, poisson, expon

#import "@preview/tiptoe:0.4.0"
#import "@preview/komet:0.2.0"

#show: formatting

= Finance of Supply Chain Management



Everything is *stocks* and *flows*

== Accounting Rules

+ Financial (transactions -> accounts)
  - Provides information primarily to people *outside* the company
    - Equity & Debt
    - Credit from suppliers
    - Customers
    - Employees
+ Managerial 
  - Provides information primarily to people *inside* the company
    - internal investment decisions
    - performance monitoring & evaluation

== Concepts of Financial Accounting

- Conservatism: 
- Materiality: 
- Consistency: 
- Economic Entity: 
- Going Concern: 
- Accounting Period: 
- Cost Concept: 

== Principles of Accrual Accounting

Attempt to measure firm performance *regarless of when cash is exchanged*
- Revenue Recognition
  - Earnings process complete
  - Cash collection assured
- Mathcing Principles
  - Match effort to the benefits generted
  - Capitalize expenditure that will benefit future periods, expense as benefit are realized 
  - Recognize liability when efforts benefiting the period require cash payment in the future

== Financial Statements

// + BS: Balance Sheet
  
//   Inventory -> Account Receivables -> Cash

//   - Current assets: Cash, Account Receivables, Inventory
//   - Current liabilities: Account payables, debt

//   Equity (residual sharholders) calculated from Assets - Liabilities

//   Equity last to be payed (first banks, then Account payables, then employees)

//   Non-current assets:
//   - Investments
//   - Goodwill
//   - Fixed assets
//     - Useful service life
//     - Salvage value
//     - Depreciation method (production (use) method, straight line, accelerated)

//   OWC = Min Cash + Account Receivable + Inventory - Account Payable

// + Income Statement (P&L: Profit & Loss)
//   Revenue (-) Expenses = Net Income

//   Sales - COGS = GP - SGA = EBITDA - D&A = EBIT - Interest = EBT - Tax = NP

//   Inventory is not included so CF is used to reconsile BS and P&L

// + CF: Cash Flow
//   Operating, Investing & Financial Activities

#let in-color = green
#let out-color = red

=== Balance Sheet (BS)

$
  underbrace("Assets", "own") = underbrace("Liabilities", "owe") + underbrace("Equity", "shareholders")
$

$
  "Equity" = "Assets" - "Liabilities"
$

#table(
  columns: 2,
  inset: 1em,
  align: center + horizon,
  table.cell(
    [Assets],
    fill: black.transparentize(75%),
  ),
  table.cell(
    [Liabilities],
    fill: black.transparentize(75%),
  ),
  [Cash], [Account\ Payables],
  [Account\ Receivables], [Debt],
  [Inventory], [Equity],
  [PP&E], [],
)

- *Cash*: Money immediately available to spend. 
  
  \$50,000 sitting in the company's checking account.

- *Accounts Receivable*: Money owed by customers for sales already made on credit. 
  
  You deliver \$10,000 of consulting work in March, invoice the client with 30-day terms — that \$10,000 is receivable until they pay.

- *Inventory*: Goods held for sale but not yet sold. 

  A shoe retailer has \$200,000 of unsold shoes sitting in its warehouse.

- *PP&E*: Long-lived physical assets used to run the business. 

  A factory building and its production machinery, carried at \$2M after depreciation.

- *Accounts Payable*: Money owed to suppliers for goods/services already received but not yet paid for. 

  You receive \$5,000 of raw materials from a supplier on 60-day payment terms — that \$5,000 is payable until you pay it.

- *Debt*: Borrowed money owed to lenders, usually with interest. 

  A \$1M bank loan taken out to fund expansion.

- *Equity*: Owners' residual stake — assets minus liabilities. 

  Founders put in \$100,000 and the company has since kept \$400,000 of profit rather than paying it out — equity is \$500,000. 
 
#let asset-color = green
#let liab-color = red
#let equity-color = blue

#sankey-diagram(
  (
    ("Cash", "Assets", 20),
    ("Receivables", "Assets", 30),
    ("Inventory", "Assets", 40),
    ("PP&E", "Assets", 110),

    ("Assets", "Liabilities", 200),

    ("Liabilities", "Payables", 25),
    ("Liabilities", "Debt", 75),
    ("Liabilities", "Equity", 100),
  ),
  layout: layout.auto-linear(
    node-gap: 1.5,
    layer-gap: 3,
    node-width: 0.9,
    min-node-height: 0.6,
  ),
  categories: (
    "Asset":     ("Cash", "Receivables", "Inventory", "PP&E", "Assets"),
    "Liability": ("Liabilities", "Payables", "Debt"),
    "Equity":    ("Equity",),
  ),
  tinter: tinter.dict-tinter((
    "Cash": asset-color, "Receivables": asset-color, "Inventory": asset-color,
    "PP&E": asset-color, "Assets": asset-color,
    "Liabilities": liab-color, "Payables": liab-color, "Debt": liab-color,
    "Equity": equity-color,
  )),
  ribbon-stylizer: ribbon-stylizer.match-to(),
  draw-label: label.default-linear-label-drawer(formatter: (val) => ""),
)

==== Operating Working Capital (OWC)

$
  colorMath("OWC", #orange) = colorMath("Min Cash", #green) + colorMath("Account Receivable", #green) + colorMath("Inventory", #green) - colorMath("Account Payable", #red)
$

#linebreak()
#linebreak()
#linebreak()

#table(
  columns: 5,
  inset: 1em,
  align: center + horizon,
  table.cell(
    [Assets],
    fill: black.transparentize(75%),
  ),
  table.cell(
    [Liabilities],
    fill: black.transparentize(75%),
  ),
  
  table.cell(
    rowspan: 5, 
    stroke: none,
    [$arrow$]
  ),

  table.cell(
    [Assets],
    fill: black.transparentize(75%),
  ),
  table.cell(
    [Liabilities],
    fill: black.transparentize(75%),
  ),

  table.cell(
    [Cash],
    fill: green.transparentize(75%),
  ),
  
  table.cell(
    [Account\ Payables],
    fill: red.transparentize(75%),
  ), 

  table.cell(
    [OWC],
    rowspan: 2,
    fill: orange.transparentize(75%),
  ), 
  
  table.cell(
    [Debt],
    rowspan: 2,
  ), 

  table.cell(
    [Account\ Receivables],
    fill: green.transparentize(75%),
  ), 
  [Debt],
  
  table.cell(
    [Inventory],
    fill: green.transparentize(75%),
  ), 
  table.cell(
    [Equity],
    rowspan: 2,
  ), 

  table.cell(
    [PP&E],
    rowspan: 2,
  ), 
  
  table.cell(
    [Equity],
    rowspan: 2,
  ), 
  [PP&E]
)



=== Income Statement (P&L)

#let top-flush-linear(
  layer-gap: 2,
  node-gap: 1,
  node-width: 0.25,
  base-node-height: 3,
  min-node-height: 0.1,
  vertical: false,
  layers: (:),
  radius: 2pt,
  curve-factor: 0.3,
) = {
  let layer-override = layers
  (
    layouter: (nodes) => {
      let layers = data-processing.assign-layers(nodes, layer-override: layer-override)
      for (layer-index, layer) in layers.enumerate() {
        for node-id in layer { nodes.at(node-id).insert("layer", layer-index) }
      }
      for (node-id, properties) in nodes {
        nodes.at(node-id).insert("size", calc.max(properties.in-size, properties.out-size))
      }
      for (node-id, properties) in nodes {
        nodes.at(node-id).insert("width", node-width)
      }
      let max-node-size = 0
      for (node-id, properties) in nodes { max-node-size = calc.max(max-node-size, properties.size) }
      for (node-id, properties) in nodes {
        let h = calc.max(properties.size / max-node-size * base-node-height, min-node-height)
        nodes.at(node-id).insert("height", h)
      }
      for (node-id, properties) in nodes {
        let x = properties.layer * (node-width + layer-gap) + node-width / 2
        nodes.at(node-id).insert("x", x)
      }
      for layer in layers {
        let offset = 0.0
        for node-id in layer {
          let h = nodes.at(node-id).height
          nodes.at(node-id).insert("y", offset - h / 2)
          offset -= h + node-gap
        }
      }
      let min-y = 99999999
      for (node-id, properties) in nodes {
        min-y = calc.min(min-y, properties.y - properties.height / 2)
      }
      for (node-id, properties) in nodes {
        nodes.at(node-id).insert("y", properties.y - min-y)
      }
      nodes
    },
    drawer: layout.auto-linear(vertical: vertical, radius: radius, curve-factor: curve-factor).drawer,
  )
}

#sankey-diagram(
  (
    ("Sales", "GP", 75),
    ("Sales", "COGS", 25),

    ("GP", "EBITDA", 55),
    ("GP", "SGA", 20),

    ("EBITDA", "EBIT", 45),
    ("EBITDA", "D&A", 10),

    ("EBIT", "EBT", 40),
    ("EBIT", "Interest", 5),

    ("EBT", "NP", 30),
    ("EBT", "Tax", 10),
  ),
  layout: top-flush-linear(
    node-gap: 1.0,
    node-width: 0.9,       // was 0.25 — much thicker bar
    min-node-height: 0.6,  // floor so Interest/D&A are tall enough for a label
  ),
  categories: (
    "In": ("Sales", "GP", "EBITDA", "EBIT", "EBT", "NP"),
    "Out": ("COGS", "SGA", "D&A", "Interest", "Tax")
  ),
  tinter: tinter.dict-tinter(
    (
    "Sales": in-color,
    "GP": in-color,
    "EBITDA": in-color,
    "EBIT": in-color,
    "EBT": in-color,
    "NP": in-color,
    
    "COGS": out-color,
    "SGA": out-color,
    "D&A": out-color,
    "Interest": out-color,
    "Tax": out-color,
    )
  ),
  ribbon-stylizer: ribbon-stylizer.match-to(),
  draw-label: label.default-linear-label-drawer(formatter: (val) => ""),
)

- *Sales*: Revenue — total money brought in from selling goods or services, before any costs are subtracted. Also called "revenue" or the "top line."
- *GP* (Gross Profit): Sales − COGS. What's left after covering the direct cost of producing or delivering what was sold.
- *EBITDA* (Earnings Before Interest, Taxes, Depreciation & Amortization): GP − SGA in this chain. A rough proxy for core operating profitability, stripped of financing costs, taxes, and non-cash charges — often used to compare operating performance across companies with different debt loads or asset ages.
- *EBIT* (Earnings Before Interest & Taxes): EBITDA − D&A. Also called "Operating Income" — profit from core operations after accounting for the wear-down of assets, but still before financing costs and taxes.
- *EBT* (Earnings Before Tax): EBIT − Interest. Pre-tax profit, after the cost of servicing debt.
- *NP* (Net Profit / Net Income): EBT − Tax. The bottom line — what's actually left over for shareholders or retained earnings.
- *COGS* (Cost of Goods Sold): The direct costs of producing or acquiring what was sold — materials, direct labor, manufacturing costs. Excludes overhead, marketing, and admin.
- *SGA* (Selling, General & Administrative): Indirect operating costs to run the business that aren't tied directly to production — sales and marketing, administrative salaries, rent, overhead.
- *D&A* (Depreciation & Amortization): A non-cash expense that spreads the cost of long-lived assets over their useful life — depreciation for tangible assets like PP&E, amortization for intangibles like patents or acquired goodwill.
- *Interest*: Interest expense — the cost of servicing debt, i.e. interest paid on loans and bonds.
- *Tax*: Income tax expense — taxes owed on EBT.

=== Cash Flow (CF)

#sankey-diagram(
  (
    ("Beginning Cash", "Cash Flow", 50),
    ("Operating Activities", "Cash Flow", 70),

    ("Cash Flow", "Ending Cash", 60),
    ("Cash Flow", "Investing Activities", 40),
    ("Cash Flow", "Financing Activities", 20),
  ),
  layout: layout.auto-linear(
    node-gap: 1.5,
    layer-gap: 5,
    node-width: 0.9,
    min-node-height: 0.6,
  ),
  categories: (
    "Kept":  ("Beginning Cash", "Operating Activities", "Ending Cash"),
    "Spent": ("Investing Activities", "Financing Activities"),
  ),
  tinter: tinter.dict-tinter((
    "Beginning Cash": in-color, "Operating Activities": in-color, "Ending Cash": in-color,
    "Investing Activities": out-color, "Financing Activities": out-color, "Cash Flow": in-color
  )),
  ribbon-stylizer: ribbon-stylizer.match-to(),
  draw-label: label.default-linear-label-drawer(formatter: (val) => ""),
)

#example([Vending Machines])[

]



#let cash = t-account(
  [Cash],
  [], [],
  [], [],
)

#let inventory = t-account(
  [Inventory],
  [], [],
  [], [],
)

#let infrastucture = t-account(
  [Infrastructure],
  [], [],
  [], [],
)

#let land = t-account(
  [Land],
  [], [],
  [], [],
)

#let equity = t-account(
  [Equity],
  [], [],
  [], [],
)

#let bank-debt = t-account(
  [Bank Debt],
  [], [],
  [], [],
)

#let ap = t-account(
  [A/P],
  [], [],
  [], [],
)

#balance-sheet(
  assets: (
    cash,
    inventory,
    infrastucture,
    land,
  ),
  liabilities: (
    ap,
    bank-debt,
    equity,
  )
)


#balance-sheet-summary(
  27.8,
  16,
  42,
  7.5,
  47,
  10,
  36.3,
)

#income-statement(
  80,
  36,
  25.2,1.5,
  1,
  5
)

#statement-cash-flow(
  
)

