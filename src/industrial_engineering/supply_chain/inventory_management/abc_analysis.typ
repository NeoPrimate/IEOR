#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== ABC Analysis

categorizes inventory items into three groups (A, B, and C) based on their importance

- A: Top 70-80% of the total annual consumption value

- B: Next 15-25% of the total annual consumption value

- C: Remaining 5-10% of the total annual consumption value

#eg[
#table(
  columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Item*], [*Usage Quantity (Annual)*], [*Unit Cost*], [*Conumption Value (Annual)*]
  ),
  [$I_1$], [50], [\$100], [\$5000],
  [$I_2$], [150], [\$20], [\$3000],
  [$I_3$], [300], [\$10], [\$3000],
  [$I_4$], [400], [\$5], [\$2000],
  [$I_5$], [500], [\$1], [\$500],
)

*Step 1*: Calculate Annual Consumption Values

*Step 2*: Sort Items by Annual Consumption Value (Descending)

*Step 3*: Calculate Total Annual Consumption Value

$
"Total" = \$5,000 (I_1) + \$3,000 (I_2) + \$3,000 (I_3) + \$2,000 (I_4) + \$500 (I_5) =\$13500
$

*Step 4*: Calculate Cumulative Consumption Value Percentages

- $I_1: 5000 / 13500 times 100% = 37.04%$

- $I_2: 3000 / 13500 times 100% = 22.22%$

- $I_3: 3000 / 13500 times 100% = 22.22%$

- $I_4: 2000 / 13500 times 100% = 14.81%$

- $I_5: 500 / 13500 times 100% = 3.7%$

*Step 5*: Cumulative Percentages

- $I_1$: 37.04%

- $I_1 + I_2$: 59.26%

- $I_1 + I_2 + I_3$: 81.48%

- $I_1 + I_2 + I_3 + I_4$: 96.3%

- $I_1 + I_2 + I_3 + I_4 + I_5$: 100%

*Step 6*: Categorize Items

- A: $I_1, I_2, I_3$

- B: $I_4$

- C: $I_5$

]