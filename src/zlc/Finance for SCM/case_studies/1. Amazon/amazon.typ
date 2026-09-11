#import "/lib/imports.typ": *
#import "/lib/formatting.typ": *
#show: formatting

= Case Study 1. Amazon

- Revenue is the one unambiguous term here — it's the top line, the total amount generated from selling goods or services, before a single cost is subtracted.
- Profit is a generic term for "revenue minus some set of costs," and it's only meaningful once you say which stage you mean
  - Gross Profit (Net Sales - COGS)
  - Operating Profit (Gross Profit - OPEX, i.e. EBIT)
  - Net Profit (the very bottom line, after taxes and everything else)
- Income is generic and stage-dependent 
  - Operating Income (EBIT, Pretax Income, Net Income)
- Earning: Net Income



== Balance Sheet (BS)



== Income Statement (P&L)

Net Sales = Net product sales + Net service sales

Net:
- Sales returns (goods customers sent back)
- Sales allowances (price reductions given for damaged or unsatisfactory goods without a full return)
- Sales discounts (early-payment or volume discounts taken by the customer)

OPEX = Marketing + G&A + Tech & Content + Fulfillment

- OPEX (Operating Expenses) — the recurring costs of running the core business
- Marketing — spend to acquire and retain customers
- G&A (General & Administrative) — corporate overhead that isn't tied to any one function
- Tech & Content — the cost of building and running the technology platform and any content offered to customers
- Fulfillment — the cost of getting an order from warehouse to customer

Gross Profit = Net Sales - COGS

- COGS (Cost of Goods Sold) — the direct cost of the products a company actually sold during the period
  - Purchase price paid to suppliers or manufacturers for the goods sold
  - Inbound freight and shipping to get inventory into the warehouse
  - Outbound shipping and delivery costs to get the product to the customer
  - Packaging materials
  - Write-downs for inventory that's obsolete or unsellable

EBIT = Gross Profit - OPEX

Pretax Income = EBIT - Non-Op (Inc) Loss - Abnormal (Gains)

- EBIT (Earnings Before Interest and Taxes) — operating profit from the core business, before any financing costs or taxes are applied
- Non-Op (Inc) Loss — "Non-Operating (Income) Loss" — the net effect of financial activity outside core operations 
  - Interest expense on debt
  - Interest income earned on cash
  - Foreign-currency gains/losses
  - Earnings from equity stakes in other companies
- Abnormal (Gains) [Losses] — one-time, non-recurring items with nothing to do with ongoing operations
  - Restructuring charges
  - Asset impairments/write-downs
  - Litigation settlements
  - Gain/loss from selling a business unit
- Pretax Income (also called Income Before Taxes, or EBT) — total earnings after both operating results and these non-operating/unusual items are folded in, but before income tax expense is applied

Net Income = Pretax Income - Income Tax Expense

Mkt Cap / EBITDA = Market Cap / EBITDA

ROS = Net Income / Net Sales

Turnover = Net Sales / Total Assets #text(fill: rgb("#8E44AD"))[(Total Assets imported from the Balance Sheet — shown here as a placeholder, not expanded)]

Leverage = Total Assets / Equity #text(fill: rgb("#8E44AD"))[(both imported from the Balance Sheet)]

RONA = EBIT / Net Assets #text(fill: rgb("#8E44AD"))[(Net Assets imported from the Balance Sheet)]

ROA = Net Income / Total Assets #text(fill: rgb("#8E44AD"))[(Total Assets imported from the Balance Sheet)]

ROE = ROS × Turnover × Leverage #text(size: 7.5pt, fill: rgb("#777777"))[(DuPont identity)]

== Cash Flow (CF)




#set page(width: 15in, height: auto, margin: 0.4in, fill: white)

= P&L

#let INPUT = (fill: rgb("#DCE6F1"), stroke: rgb("#5B7DB1"))
#let FORM  = (fill: rgb("#E2F0D9"), stroke: rgb("#6A9955"))
#let XREF  = (fill: rgb("#E8DAEF"), stroke: rgb("#8E44AD"))
#let OUT   = (fill: rgb("#FDEBD0"), stroke: rgb("#B7472A"))

#let pnl-digraph = fletcher.diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 3pt,
  node-inset: 6pt,
  spacing: (18pt, 26pt),
  edge-stroke: 0.7pt,

  // ---- node coordinates are dot's own layout (x,y in inches, y flipped so
  // row increases downward), not hand-placed or re-derived ----
  node((5.65,0.25), [Net product\ sales], name: <prod>, ..INPUT),
  node((7.10,0.25), [Net service\ sales], name: <serv>, ..INPUT),
  node((5.23,1.19), [COGS], name: <cogs>, ..INPUT),
  node((0.53,1.19), [Marketing], name: <mktg>, ..INPUT),
  node((1.70,1.19), [G&A], name: <gna>, ..INPUT),
  node((2.78,1.19), [Tech &\ Content], name: <tech>, ..INPUT),
  node((4.05,1.19), [Fulfillment], name: <fulf>, ..INPUT),
  node((9.99,3.08), [Non-Op\ (Inc) Loss], name: <nonop>, ..INPUT),
  node((8.69,3.08), [Abnormal\ (Gains)], name: <abn>, ..INPUT),
  node((8.34,4.03), [Income Tax\ Expense], name: <taxexp>, ..INPUT),
  node((8.55,0.25), [Market Cap], name: <mktcap>, ..INPUT),
  node((9.83,0.25), [EBITDA], name: <ebitda>, ..INPUT),
  node((8.53,4.97), [Total Assets\ (from BS)], name: <ta>, ..XREF),
  node((7.15,4.97), [Equity\ (from BS)], name: <eq>, ..XREF),
  node((4.02,3.08), [Net Assets\ (from BS)], name: <na>, ..XREF),
  node((6.38,1.19), [Net Sales], name: <sales>, ..FORM),
  node((2.78,2.14), [OPEX], name: <opex>, ..FORM),
  node((8.20,5.92), [Leverage], name: <lev>, ..XREF),
  node((9.19,1.19), [Mkt Cap /\ EBITDA], name: <capebitda>, ..FORM),
  node((5.23,2.14), [Gross Profit], name: <gp>, ..FORM),
  node((6.94,5.92), [Turnover], name: <turn>, ..XREF),
  node((5.23,3.08), [EBIT], name: <ebit>, ..FORM),
  node((9.90,4.03), [Pretax Income], name: <pretax>, ..FORM),
  node((4.63,4.03), [RONA], name: <rona>, ..XREF),
  node((10.01,4.97), [Net Income], name: <ni>, ..FORM),
  node((10.34,5.92), [ROS], name: <ros>, ..FORM),
  node((9.34,5.92), [ROA], name: <roa>, ..XREF),
  node((8.20,6.86), [ROE], name: <roe>, ..OUT),

  // ---- edges: bend angle fit to dot's actual spline curvature ----
  edge(<prod>, <sales>, "->"),
  edge(<serv>, <sales>, "->"),
  edge(<mktg>, <opex>, "->"),
  edge(<gna>, <opex>, "->"),
  edge(<tech>, <opex>, "->"),
  edge(<fulf>, <opex>, "->"),
  edge(<mktcap>, <capebitda>, "->"),
  edge(<ebitda>, <capebitda>, "->"),
  edge(<eq>, <lev>, "->"),
  edge(<ta>, <lev>, "->"),
  edge(<sales>, <gp>, "->"),
  edge(<cogs>, <gp>, "->"),
  edge(<sales>, <turn>, "->", bend: -26deg),
  edge(<ta>, <turn>, "->"),
  edge(<gp>, <ebit>, "->"),
  edge(<opex>, <ebit>, "->", bend: 5deg),
  edge(<ebit>, <pretax>, "->", bend: 5deg),
  edge(<nonop>, <pretax>, "->"),
  edge(<abn>, <pretax>, "->"),
  edge(<ebit>, <rona>, "->"),
  edge(<na>, <rona>, "->"),
  edge(<pretax>, <ni>, "->"),
  edge(<taxexp>, <ni>, "->"),
  edge(<ni>, <ros>, "->"),
  edge(<sales>, <ros>, "->", bend: 55deg),
  edge(<ni>, <roa>, "->"),
  edge(<ta>, <roa>, "->"),
  edge(<ros>, <roe>, "->", bend: 3deg),
  edge(<turn>, <roe>, "->"),
  edge(<lev>, <roe>, "->"),
)

#grid(
  columns: 1,
  inset: 1em,
  align: (left),
  [
    #pnl-digraph
  ],
  [
    #set text(size: 9pt)

    == Formulas

    Net Sales = Net product sales + Net service sales

    OPEX = Marketing + G&A + Tech & Content + Fulfillment

    Gross Profit = Net Sales - COGS

    EBIT = Gross Profit - OPEX

    Pretax Income = EBIT - Non-Op (Inc) Loss - Abnormal (Gains)

    Net Income = Pretax Income - Income Tax Expense

    Mkt Cap / EBITDA = Market Cap / EBITDA

    ROS = Net Income / Net Sales

    Turnover = Net Sales / Total Assets #text(fill: rgb("#8E44AD"))[(Total Assets imported from the Balance Sheet — shown here as a placeholder, not expanded)]

    Leverage = Total Assets / Equity #text(fill: rgb("#8E44AD"))[(both imported from the Balance Sheet)]

    RONA = EBIT / Net Assets #text(fill: rgb("#8E44AD"))[(Net Assets imported from the Balance Sheet)]

    ROA = Net Income / Total Assets #text(fill: rgb("#8E44AD"))[(Total Assets imported from the Balance Sheet)]

    ROE = ROS × Turnover × Leverage #text(size: 7.5pt, fill: rgb("#777777"))[(DuPont identity)]

    #v(6pt)
    #text(size: 7.5pt, fill: rgb("#777777"))[
      Purple nodes/notes are values that live in the Balance Sheet exhibit, not
      here — Total Assets, Equity and Net Assets are drawn as placeholders so
      Turnover, Leverage, RONA and ROA show where their other input comes from,
      but their own formulas aren't expanded (see the BS section for that).
      Pretax Income's sign convention follows the exhibit's own "(Inc) Loss" /
      "(Gains)" labeling, not re-derived from the source figures just now.
    ]

  ]
)



#set page(width: 15in, height: auto, margin: 0.4in, fill: white)

= BS

#let INPUT = (fill: rgb("#DCE6F1"), stroke: rgb("#5B7DB1"))
#let FORM  = (fill: rgb("#E2F0D9"), stroke: rgb("#6A9955"))
#let OUT   = (fill: rgb("#FDEBD0"), stroke: rgb("#B7472A"))

#let bs-digraph = fletcher.diagram(
  node-stroke: 0.6pt,
  node-corner-radius: 3pt,
  node-inset: 6pt,
  spacing: (18pt, 26pt),
  edge-stroke: 0.7pt,

  // ---- node coordinates are dot's own layout (x,y in inches, y flipped so
  // row increases downward), not hand-placed or re-derived ----
  node((6.21,0.25), [Cash &\ STI], name: <cash>, ..INPUT),
  node((2.26,0.25), [Accounts\ Receivable], name: <ar>, ..INPUT),
  node((0.85,0.25), [Inventories], name: <inv>, ..INPUT),
  node((2.29,1.19), [Total Non-current\ Assets], name: <nca>, ..INPUT),
  node((3.67,0.25), [Payables &\ Accruals], name: <pay>, ..INPUT),
  node((8.62,0.25), [ST Debt], name: <stdebt>, ..INPUT),
  node((5.01,0.25), [Other ST\ Liabilities], name: <otherst>, ..INPUT),
  node((9.78,0.25), [LT Debt], name: <ltdebt>, ..INPUT),
  node((7.40,0.25), [Other LT\ Liabilities], name: <otherlt>, ..INPUT),
  node((4.06,4.03), [Other LT\ Free Financing], name: <otherfree>, ..INPUT),
  node((4.00,1.19), [Total Current\ Assets], name: <tca>, ..FORM),
  node((5.54,1.19), [Total Current\ Liabilities], name: <tcl>, ..FORM),
  node((7.79,1.19), [Total Non-current\ Liabilities], name: <tncl>, ..FORM),
  node((0.85,1.19), [NFO], name: <nfo>, ..FORM),
  node((9.38,1.19), [D, Debt\ (ST + LT)], name: <ddebt>, ..FORM),
  node((3.89,2.14), [TOTAL ASSETS], name: <ta>, ..FORM),
  node((7.01,2.14), [TOTAL\ LIABILITIES], name: <tliab>, ..FORM),
  node((2.18,2.14), [NA, Net Assets], name: <na>, ..FORM),
  node((7.01,3.08), [TOTAL EQUITY], name: <teq>, ..FORM),
  node((8.39,4.03), [TOTAL LIAB\ & EQUITY], name: <tliabeq>, ..OUT),
  node((7.04,4.03), [E, Equity], name: <eequity>, ..FORM),
  node((7.04,4.97), [Financing], name: <financing>, ..FORM),
  node((8.42,2.14), [Net Debt\ (D - Cash)], name: <netdebt>, ..OUT),
  node((5.53,2.14), [Current Ratio], name: <curratio>, ..OUT),
  node((5.65,4.03), [BS Leverage\ (Liab/Eq)], name: <bslev>, ..OUT),
  node((0.60,2.14), [NFO / Sales], name: <nfosales>, ..OUT),

  // ---- edges: bend angle fit to dot's actual spline curvature ----
  edge(<cash>, <tca>, "->"),
  edge(<ar>, <tca>, "->"),
  edge(<inv>, <tca>, "->", bend: -3deg),
  edge(<pay>, <tcl>, "->"),
  edge(<stdebt>, <tcl>, "->", bend: 6deg),
  edge(<otherst>, <tcl>, "->"),
  edge(<ltdebt>, <tncl>, "->"),
  edge(<otherlt>, <tncl>, "->"),
  edge(<ar>, <nfo>, "->"),
  edge(<inv>, <nfo>, "->"),
  edge(<pay>, <nfo>, "->", bend: -8deg),
  edge(<otherst>, <nfo>, "->", bend: -12deg),
  edge(<stdebt>, <ddebt>, "->"),
  edge(<ltdebt>, <ddebt>, "->"),
  edge(<tca>, <ta>, "->"),
  edge(<nca>, <ta>, "->"),
  edge(<tcl>, <tliab>, "->"),
  edge(<tncl>, <tliab>, "->"),
  edge(<nfo>, <na>, "->"),
  edge(<nca>, <na>, "->"),
  edge(<ta>, <teq>, "->"),
  edge(<tliab>, <teq>, "->"),
  edge(<tliab>, <tliabeq>, "->", bend: 27deg),
  edge(<teq>, <tliabeq>, "->"),
  edge(<teq>, <eequity>, "->"),
  edge(<ddebt>, <financing>, "->", bend: 55deg),
  edge(<eequity>, <financing>, "->"),
  edge(<otherfree>, <financing>, "->"),
  edge(<ddebt>, <netdebt>, "->"),
  edge(<cash>, <netdebt>, "->", bend: -39deg),
  edge(<tca>, <curratio>, "->"),
  edge(<tcl>, <curratio>, "->"),
  edge(<tliab>, <bslev>, "->", bend: -28deg),
  edge(<teq>, <bslev>, "->"),
  edge(<nfo>, <nfosales>, "->"),
)

#grid(
  columns: 1,
  inset: 1em,
  align: (left),
  [
    #bs-digraph
  ],
  [
    #set text(size: 9pt)

    == Formulas

    Total Current Assets = Cash & STI + Accounts Receivable + Inventories

    Total Current Liabilities = Payables & Accruals + ST Debt + Other ST Liabilities

    Total Non-current Liabilities = LT Debt + Other LT Liabilities

    D, Debt (ST + LT) = ST Debt + LT Debt

    NFO = Accounts Receivable + Inventories - Payables & Accruals - Other ST Liabilities

    TOTAL ASSETS = Total Current Assets + Total Non-current Assets

    TOTAL LIABILITIES = Total Current Liabilities + Total Non-current Liabilities

    NA, Net Assets = NFO + Total Non-current Assets

    TOTAL EQUITY = TOTAL ASSETS - TOTAL LIABILITIES

    TOTAL LIAB & EQUITY = TOTAL LIABILITIES + TOTAL EQUITY #text(size: 7.5pt, fill: rgb("#777777"))[(tie-out check: should equal TOTAL ASSETS)]

    E, Equity = TOTAL EQUITY #text(size: 7.5pt, fill: rgb("#777777"))[(relabel used in the short-BS identity below)]

    Financing = D, Debt (ST + LT) + E, Equity + Other LT Free Financing

    Net Debt (D - Cash) = D, Debt (ST + LT) - Cash & STI

    Current Ratio = Total Current Assets / Total Current Liabilities

    BS Leverage (Liab/Eq) = TOTAL LIABILITIES / TOTAL EQUITY

    NFO / Sales = NFO / Net Sales #text(fill: rgb("#8E44AD"))[(→ P&L)]

    #v(6pt)
    #text(size: 7.5pt, fill: rgb("#777777"))[
      NA = NFO + Non-current Assets is the "short balance sheet" reformulation
      (net assets = net financial obligations + operating assets), separate from
      the ordinary TOTAL ASSETS = current + non-current identity above it. NFO's
      sign convention (receivables/inventory net of payables/other ST liabilities)
      and the tie-out follow the exhibit as built earlier in this session, not
      re-derived from the source PDF just now — worth a quick sanity check.
    ]

  ]
)
