#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== Test of independence

Compares two *observed* categorical distributions.

$
Chi^2 = sum_(i=1)^k (o_(i j) - e_(i j))^2 / e_(i j)
$

- $o_(i j)$: observed frequency in cell $(i, j)$
- $e_(i j)$: expected frequency in category $(i, j)$ calculated as: 

$
E_(i j) = (R_i times C_j) / N
$

- $R_i$: Row total for row $i$
- $C_j$: Column total for column $j$
- $N$: Total number of observations