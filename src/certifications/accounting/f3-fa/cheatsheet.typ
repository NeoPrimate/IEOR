#import "/lib/imports.typ": *

// #set page(margin: 1em) — paged-only, can't apply inside bundle's document() container

#let columns = 2

#set heading(numbering: (..nums) => {
  let numbers = nums.pos()
  if numbers.len() == 1 {
    numbering("A.", ..numbers)
  } else {
    numbering("1.", numbers.at(1))
  }
})

#let section_counter = counter("section")
#let subsection_counter = counter("subsection")

#let section(title) = table.cell(
  align: left,
  colspan: columns,
  text(size: 12pt, weight: "bold")[
    = #title
  ]
)

#let subsection(title) = table.cell(
  align: left,
  colspan: columns,
  text(size: 12pt, weight: "bold")[
    == #title
  ]
)

#align(center)[
  #table(
    columns: columns,
    inset: 1em,
    align: (left, left),

    section([The context and purpose of financial reporting]),

    subsection([The context and purpose of financial reporting]),
    [Define financial reporting], [Process of recording, analysing, and summarising financial transactions for decision‑making],
    [Types of business entity], [Sole trader, partnership, limited liability company (LLC)],
    [Legal differences between entities], [
      Sole trader/partnership: unlimited liability 
      \
      LLC: separate legal entity, limited liability],
    [Advantages/disadvantages of entities], [Sole trader: simple but risky 
    \
    Partnership: shared skills but joint liability 
    \
    LLC: protection but regulation],
    [Nature, principles, scope of financial reporting], [Produces useful financial info for external users under standards],

    subsection([Stakeholders' needs]),
    [Identify the *users* of financial statements and state and differentiate between their *information needs*.], [
      - Investors $arrow$ returns & growth
      - Lenders $arrow$ repayment ability
      - Suppliers $arrow$ short-term liquidity
      - Employees $arrow$ stability & rewards
      - Government $arrow$ tax & compliance
    ],

    subsection([Financial statements]),
    [Statement\ of *financial position*], [Shows *assets*, *liabilities*, *equity* at a point in time],
    [Statement\ of *profit or loss*], [Shows performance over a period],
    [Statement\ of changes in *equity*], [Explains movements in equity], 
    [Statement\ of *cash flows*], [Explains cash inflows and outflows],
    [Asset], [Resources controlled from past events generating future benefits],
    [Liability], [Present obligations from past events],
    [Equity], [Residual interest: assets − liabilities],
    [Income], [Increases in economic benefits],
    [Expense], [Decreases in economic benefits],
    
    subsection([Regulatory framework]),
    [Purpose of regulatory system], [Ensure consistency, transparency, comparability],
    [*IFRS*\ Foundation], [Oversees standard-setting],
    [International Accounting Standards Board\ (*IASB*)], [Issues IFRS Accounting Standards],
    [*IFRS*\ Advisory Council], [Advises IASB],
    [IFRS Interpretations Committee\ (*IFRIC*)], [Interprets IFRS],
    [International Sustainability Standards Board\ (*ISSB*)], [Sustainability standards],

    subsection([Duties and responsibilities of those charged with governance]),
    [Define governance, in the context of the preparation of financial statements], [System directing and controlling preparation of accounts],
    [Duties and responsibilities of directors in the preparation of the financial statements], [Prepare true and fair financial statements],

    section([Accounting principles, concepts and qualitative characteristics]),
    subsection([Key principles and concepts of accounting]),
    [Going concern], [Assume business continues indefinitely],
    [Accrual accounting], [Record income/expenses when earned/incurred],
    [Materiality], [Ignore immaterial items],
    [Offsetting], [No netting unless permitted],
    [Consistency], [Same methods over time],
    [Prudence], [Caution under uncertainty],
    [Duality], [Every transaction has two effects],
    [Business entity], [Business separate from owner],
    [Historical cost], [Assets recorded at cost],
    [Current value], [Assets recorded at fair value], 
    [Substance over form], [Economic reality > legal form],

    subsection([Qualitative characteristics of useful financial information]),
    [Relevance], [],
    [Faithful representation], [],
    [Comparability], [],
    [Verifiability], [],
    [Timeliness], [],
    [Understandability], [],
    
    section([The use of double-entry bookkeeping and accounting systems]),
    [], [],
    [], [],
    [Quotation], [],
    [Sales order], [],
    [Purchase order], [],
    [Goods received note], [],
    [Goods dispatched note], [],
    [Customer (sales) invoice], [],
    [Supplier (purchase) invoice], [],
    [Supplier statement], [],
    [Credit note], [],
    [Debit note], [],
    [Remittance advice], [],
    [Receipt], [],
    [], [],
    [Accounting equation], [],

    section([Recording transactions and events]),
    subsection([Sales and purchases]),
    subsection([Cash]),
    subsection([Inventories]),
    subsection([Tangible non-current assets]),
    subsection([Depreciation]),
    subsection([Intangible non-current assets and amortisation]),
    subsection([Accrued expenses (accruals), prepaid expenses (prepayments), accrued income, and deferred income]),
    subsection([Receivables and payables]),
    subsection([Provisions and contingencies]),
    subsection([Capital structure and finance costs]),

  )
]
