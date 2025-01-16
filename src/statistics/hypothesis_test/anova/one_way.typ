#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== One-way

Compares the means of three or more groups based on one independent variable

- $H_0$: $mu_1 = mu_2 = ... = mu_k$
- $H_1$: At least one $mu_i$ differs from the others

*Step 1*: Calculate Between-Group Variation ($S S_"between"$)

$
S S_"between" = sum_(i=1)^k n_i (overline(X)_i - overline(X)_("overall"))^2
$

- $n_1$: Number of observations in group $i$
- $overline(X)_i$: Mean of group $i$
- $overline(X)_"overall"$: Overall mean of all groups

*Step 2*: Calculate Within-Group Variation ($S S_"within"$)

$
S S_"within" = sum_(i=1)^k sum_(j=1)^(n_i) (X_(i j) - overline(X)_i)^2
$

- $X_(i j)$: Observation $j$ in group $i$

*Step 3*: Calculate Total Variation ($S S_"total"$)

$
S S_"total" = S S_"between" + S S_"within"
$

*Step 4*: Calculate Mean Squares

- Mean Square Between ($M S_("between")$)

$
M S_("between") = (S S_("between")) / (k - 1)
$

- Mean Square Within ($M S_("within")$)

$
M S_("within") = (S S_("within")) / (N - k)
$

- $N$: total number of observations
- $k$: number of groups

*Step 5*: Calculate the F-statistic

$
F = (M S_("between")) / (M S_("within"))
$

*Step 6*: Decision Rule

- Compare the F-statistic to the critical value from the F-distribution table (based on chosen significance level $alpha$).
- Alternatively, compare the p-value to the significance level $alpha$.
- Reject $H_0$ if the F-statistic is greater than the critical value or if the p-value is less than $alpha$, indicating that at least one group mean is significantly different.