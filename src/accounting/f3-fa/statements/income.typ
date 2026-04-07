== Income Statement

*Revenue* and *expenses* over *time*

Simple:

#align(center)[
  #grid(
    columns: 2,
    inset: 1em,
    align: (right, center),
    stroke: (x, y) => if x == 1 and 
    (
      y == 2
    ) { (bottom: 1pt) },
    
    [], [MM-DD-YY],
    [Revenue], [X],
    [Expenses], [(X)],
    [*Profit / (Loss)*], [*X / (X)*],
  )
]

Detailed:

#align(center)[
  #grid(
    columns: 2,
    inset: 1em,
    align: (right, center),
    stroke: (x, y) => if x == 1 and 
    (
      y == 2 or 
      y == 4 or
      y == 7
    ) { (bottom: 1pt) },
    
    [], [MM-DD-YY],
    [Revenue], [X],
    [Cost of Goods Sold], [(X)],
    [*Gross Profit / (Loss)*], [*X / (X)*],
    [Operating Expenses], [(X)],
    [*Operating Profit / (Loss)*], [*X / (X)*],
    [Tax Expense], [(X)],
    [Interest Expense], [(X)],
    [*Net Profit / (Loss)*], [*X / (X)*],
  )
]

Revenue:
- Product Sales
- Services Rendered

Expenses:
- Direct (increase in direct proportion to sales)
  - Cost of services
  - Cost of goods sold
  - Product sales - cost of goods/services = gross profit
- Indirect (overhead)
  - Fixed (no correlation to sales)
    - Rent
    - Salaries
    - Insurance
    - Admin
    - Legally
    - Accounting
    - Marketing
    - Depreciation
    - Amortization
  - Variable (loosely correlated)
    - Advertising
    - Comissions
    - Utilities

