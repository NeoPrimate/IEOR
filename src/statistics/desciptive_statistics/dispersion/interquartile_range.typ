#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== Interquartile Range (IQR)

$
"IQR" = "Q3" - "Q1"
$

#eg[
$
[1, 2, 3, 4, 5, 6, 7]
$

Step 1: Arrange the Data in Ascending Order

$
[1, 2, 3, 4, 5, 6, 7]
$

Step 2: Find the Quartiles

1. Calculate the Median (Q2)

$
"Median" ("Q2") = 4
$

2. Find First Quartile (Q1)

Q1 is the median of the first half of the dataset

$
"Q1" = 2
$

3. Find Third Quartile (Q3)

Q3 is the median of the second half of the dataset

$
"Q3" = 5
$

Step 3: Calculate the Interquartile Range (IQR)

$
"IQR" = 5 - 2 = 3
$
]