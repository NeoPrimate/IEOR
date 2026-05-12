#import "/lib/imports.typ": *
#show: formatting

== Balance Sheet (Statement of Financial Position)

*Assets*, *liabilities* and *equity* at a single time point

#grid(
  columns: 2,
  align: center,
  column-gutter: 1em,
  [
    #grid(
      columns: 2,
      inset: 0.5em,
      align: (left, center),
      column-gutter: 3em,
      [*Assets*], [],
      [#h(2em) *Current Assets*], [],
      [#h(4em) Cash], [X],
      [#h(4em) Account Receivables], [X],
      [#h(4em) Prepaid Expenses], [X],
      [#h(2em) Total Current Assets], [X],
      [#h(2em) *Non-Current Assets*], [],
      [#h(4em) Property, Equipment], [X],
      [#h(4em) Intangible], [X],
      [#h(2em) Total Non-Current Assets], [X],
      [*Total Assets*], [X],
    )
  ],
  [
    #grid(
      columns: 2,
      inset: 0.5em,
      align: (left, center),
      column-gutter: 3em,
      [*Liabilities*], [],
      [#h(2em) *Current Liabilities*], [],
      [#h(4em) Account Payable], [X],
      [#h(4em) Tax Payable], [X],
      [#h(4em) Accrued Expenses], [X],
      [#h(4em) Deferred Revenue], [X],
      [#h(2em) Total Current Liabilities], [X],
      [#h(2em) *Non-Current Liabilities*], [],
      [#h(4em) Long Term Loans], [X],
      [#h(2em) Total Non-Current Liabilities], [X],
      [*Total Liabilities*], [X],
      [*Equity*], [],
      [#h(2em) Capital Contributions], [X],
      [#h(2em) Retained Earnings], [X],
      [*Total Equity*], [X],
      [*Total Liabilities & Equity*], [X],
    )
  ]
)



