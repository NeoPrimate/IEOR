#import "../../utils/code.typ": code
#import "../../utils/examples.typ": eg

== Spearman's Rank

Non-linear relationships

$
rho = 1 - (6 sum_(i=1)^n d_i^2) / (n (n^2 - 1))
$

Where

- $rho$: Spearman rank correlation coefficient
- $d_i$: difference between the ranks of corresponding values
- $n$: number of observations

Rank: position of a value within a data set when the values are ordered in ascending order

#align(
  center,
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [Observation $i$], 
      [$X$], 
      [Rank $X$],
      [$Y$], 
      [Rank $Y$],
      [$d_i$ = Rank $X$ - Rank $Y$], 
      [$d_i^2$]
    ),
    [1], [3], [3], [8], [5], [-2], [4],
    [2], [1], [1], [6], [3], [-2], [4],
    
    [3], [4], [4], [7], [4], [0], [0],
    [4], [2], [2], [4], [1], [1], [1],
    [5], [5], [5], [5], [2], [3], [9],
  )

)


Interpretation

- $rho$ = 1: Perfect positive correlation
- $rho$ = -1: Perfect negative correlation
- $rho$ = 0: No correlation