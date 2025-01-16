#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== Variance

Quantifies the spread or dispersion of a set of data points in a dataset

- Population

$
sigma^2 = 1/N sum_(i=1)^n (x_i - mu)^2
$

- Sample

$
s^2 = 1/(n - 1) sum_(i=1)^n (x_i - overline(x))^2
$

#eg[
$
[70, 75, 80, 85, 90]
$

*Step 1*: Find mean

$
overline(x) = (70 + 75 + 80 + 85 + 90) / 5 = 400 / 5 = 80
$

*Step 2*: Subtract the Mean and Square the result

$
(70 - 80)^2 = (-10)^2 = 100
\
(75 - 80)^2 = (-5)^2 = 25
\
(80 - 80)^2 = 0^2 = 0
\
(85 - 80)^2 = 5^2 = 25
\
(90 - 80)^2 = 10^2 = 100
$

*Step 3*: Calculate variance

$
s^2 = (100 + 25 + 0 + 25 + 100) / (5 - 1) = 250 / 4 = 62.5
$

]
