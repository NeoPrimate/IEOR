#import "/lib/imports.typ": *

#let bent-edge(from, to, ..args) = {
  let midpoint = (from, 50%, to)
  let vertices = (
    from,
    (from, "|-", midpoint),
    (midpoint, "-|", to),
    to,
  )
  edge(..vertices, "-", ..args)
}


= Financial Accounting

== Objectives

1. Recording transactions

2. Summarizing 

Statements 
  - Profit & Loss
  - Financial Position (Balance Sheet)

== Types of Business Entities:

1. Sole Trader
One person

Owner has unlimited liability

2. Limited Liability Company
Several people 

Business separate in law from owners

Owners have limited liability 

== Users of accounting information

- Management
- Owners / Shareholders
- Potential investors
- Lenders
- Employees
- Government
- Public


== Accounts

#align(center)[
  #table(
    columns: 3,
    align: left,
    inset: 1em,
    [], [Management], [Financial],
    [Purpose], [Help management run business], [Required by law],
    [Timing], [Monthly], [Yearly],
    [Requirement], [No legal requirement], [Legally required],
    [Layout], [Useful], [International  Financial Reporting Standards (IFRS)],
    [Reporting], [Internal], [External],
    [], [], [],
  )
]

== Statement of Financial Position (Balance Sheet)

Every transaction has 2 effects (+ and -)

List of:
- Owned
- Owed

#linebreak()

- Assets
  - Current
  - Non-current
- Liabilities
  - Current
  - Non-current
- Capital / Equity

== Statement of Profit & Loss (P&L)

#align(center)[

  #sankey-diagram(
    (
      ("Revenue Stream A", "Revenue", 149),
      ("Revenue Stream B", "Revenue", 28.8),
      ("Revenue Stream C", "Revenue", 31.7),
      ("Revenue Stream D", "Revenue", 28),
      ("Revenue Stream E", "Revenue", 19.2),

      ("Revenue", "Gross Profit", 146.7),
      ("Revenue", "Cost of Sales", 110.9),

      ("Gross Profit", "Operating Profit", 78.7),

      ("Operating Profit", "Pre-tax Profit", 90.7),
      ("Other Income", "Pre-tax Profit", 12),
      
      ("Gross Profit", "Operating Expenses", 68),

      ("Pre-tax Profit", "Net Profit", 76),
      ("Pre-tax Profit", "Tax", 14.7),
    ),

    layout: layout.auto-linear(node-gap: 1.5),
    
    draw-label: label.default-linear-label-drawer(formatter: (val) => str(val) + "bn"),

    ribbon-stylizer: ribbon-stylizer.gradient-from-to(),

    tinter: tinter.dict-tinter(
      (
        "Revenue Stream A": blue,
        "Revenue Stream B": blue,
        "Revenue Stream C": blue,
        "Revenue Stream D": blue,
        "Revenue Stream E": blue,
        "Revenue Stream F": blue,
        
        "Gross Profit": green,
        "Operating Profit": green,
        "Pre-tax Profit": green,
        "Net Profit": green,
        "Other Income": green,
        
        "Cost of Sales": red,
        "Operating Expenses": red,
        "Tax": red,
      ),
    )
  )
]

== Cash Flow Statement

== Assets & Liabilities

#align(center)[
  #table(
    columns: 3,
    align: left,
    inset: 1em,
    [Concept], [Definition], [Example/Notes],
    [Asset], [Resource controlled by the business expected to provide future economic benefits.], [Cash, inventory, equipment, receivables.],
    [Liability], [Present obligation arising from past events, settlement expected to result in outflow of resources.], [Loans, payables, accruals.],
    [Capital \ Owner's Equity], [Owner’s claim on business assets after liabilities; money invested + retained profits.], [Net assets],
    [Current Asset], [Expected to be used or converted to cash within 12 months.], [Inventory, receivables, cash.],
    [Non-current Asset], [Expected to provide benefit over more than 12 months.], [Property, plant, equipment.],
    [Current Liability], [Obligation due within 12 months.], [Accounts payable, short-term loans.],
    [Non-current Liability], [Obligation due after 12 months.], [Long-term loans, bonds payable.],
  )
]

== Revenue & Expenses

#align(center)[
  #table(
    columns: 3,
    align: left,
    inset: 1em,
    [Concept], [Definition], [Example/Notes],
    [Revenue\ Income], [Inflows from selling goods or services in ordinary course of business.], [Sales, service income.],
    [Expense], [Outflows or use of assets in earning revenue.], [Rent, salaries, utilities.],
    [Capital Expenditure\ CapEx], [Spending to acquire or improve non-current assets that provide benefits over multiple periods], [Machinery, building.],
    [Revenue Expenditure\ RevEx], [Spending on operating costs whose benefits are consumed within the current accounting period], [Repairs, rent, electricity.],
  )
]

#align(center)[
  #table(
    columns: 3,
    align: left,
    inset: 1em,
    [Concept], [Definition], [Example/Notes],
    [Inventory], [Goods held for resale or raw materials to make goods.], [Retail: finished goods; Manufacturing: raw materials.],
    [Accounts Payable\ Payable], [Money owed to suppliers/creditors.], [Purchase of goods on credit.],
    [Accounts Receivable\ Receivable], [Money owed to the business by customers.], [Sales on credit.],
    [Drawings\ Withdrawals], [Assets taken out by owner for personal use.], [Cash withdrawn, goods taken for personal use.],
    [Bank\ Cash], [Liquid assets held by the business.], [Cash in hand, cash at bank.],
    [], [], [],
  )
]

Owns = Owes

Assets = Liabilities + Capital (Accounting Equation)

Current vs Non-current is always about the 12-month rule

Revenue - Expenses = Profit / Loss

Capital + Additional Investment - Drawings + Profit - Loss = Closing Capital

















































