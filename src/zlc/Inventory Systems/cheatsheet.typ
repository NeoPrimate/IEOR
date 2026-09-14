#set page(
  margin: (
  x: 0.1cm,
  y: 0.1cm,
  )
)

#set par(
  leading: 0.5em
)

#set text(
  font: "Helvetica", 
  size: 8pt
)

= EOQ

$
  "TC"(Q) = c D + S D / Q + H Q / 2 \
  "TVC"(Q) = S D / Q + H Q / 2 \
$

$
  (dif "TVC") / (dif Q) = - (S D) / Q^2 + H / 2 = 0 quad arrow.double quad Q^* = sqrt((2 D S) / H)
$
$
  "TVC"(Q^*) = sqrt(2 D S H)
$
Average Inventory / Cycle Inventory

$
  macron(I) = Q / 2
$

Cycle Time
$
  T^* = Q^* / D = sqrt((2 S) / (D H))
$

$
  "TC"(T) = S / T + H (T D) / 2 + c D
$

$
  (dif "TC"(T)) / (dif T)
$


Order Frequncy
$
  N^* = Q^* / D = sqrt((D H) / (2 S))
$

Sensitivity

$
  "TVC"(Q) / "TVC"(Q^*) = 1 / 2 (x + 1 / x) \
  x = Q / Q^*
$

Lead Time

$
  R = d L
$

Power of 2

Base period ($T_B$) = 1 day
$
  2^0 dot T_B = 1 "day" \
  2^1 dot T_B = 2 "day" \
  2^2 dot T_B = 4 "day" \
  dots.v \
$

= EPQ


$
  "TVC"(Q) = S D / Q + H I_max / 2 \  
$

$
  Q = T_p dot P \
  I_max = T_p (P - D) \
  I_max = Q (1 - D / P)
$

$
  Q^* &= sqrt((2 D S) / (H (1 - D / P))) 
  quad arrow.double quad
  "TVC"(Q^*) &= sqrt(2 D S H (1 - D / P)) \
$

$
  T^* = Q^* / D
$

$
  (dif"TVC") / (dif Q) = - (S D) / Q^2 + H / 2
$

$
  "TVC"(Q) = S D / Q + H Q / 2 (1 - D / P) \
$


$
  (dif"TVC") / (dif Q) = 
$

$
  T &= T_p + T_d \
  T &= Q / D \
  T_p &= Q / P \
  T_d &= Q (1 - D / P) \
$

$
  macron(I) = I_max / D
$

= All Unit Discount

$
  "TVC"_i (Q) = c_i D + S D / Q_i + h c_i Q_i / 2
$

$
  Q^*_i = sqrt((2 D S) / (h c_i))
$

= Marginal Unit Discount 

$
  cases(
    0 lt.eq Q lt.eq 1000 quad &c = 500,
    1001 lt.eq Q lt.eq 2000 quad &c = 4.75,
    2001 lt.eq Q lt.eq infinity quad &c = 4.50,
  )
$

For $Q gt.eq 2001$ 

$
  C(Q) 
  &= 1000(5) + 1000(4.75) + (Q-2000)4.50 \
  & = underbrace(5000 + 4750 - 9000, R_i) + 4.5 Q
$

$
  C(Q) = R_i + c_i Q quad "for" Q in {i}
$


$
  "TVC"_i(Q) 
  &= S D / Q + h C(Q) / cancel(Q) cancel(Q) / 2 + C(Q) \
  &= S D / Q + h (R_i + c_i Q) Q / 2 + R_i + c_i Q \
$

$
  (dif "TVC"(Q)) / (dif Q) = - (S D) / Q^2 + (h c_i) / 2 + c_i = 0 
$

Plug $Q^*$ in $"TVC"(Q)$

Breakpoints can never be optimal

#align(center)[
  #table(
    columns: 7,
    inset: 1em,
    [Category ($i$)], [Range], [$c_i$], [$R_i$], [$Q^*$], [Feasible], [TVC],
    [1], [0 - 1000], [5], [0], [], [No], [], 
    [2], [1001 - 2000], [4.75], [250], [], [Yes], [], 
    [3], [2001 - infinty], [4.50], [750], [], [Yes], [], 
  )
]

See which TVC is lowest for candidate (feasible) solutions

= Aggregation

Several *products* same shipment
OR
Several *customers* same shipment 

- $D_i$: Demand $i = 1, dots, m$
- $h$: Holding cost %
- $S$: Setup cost per shipment
- $c_i$: cost per unit $i = 1, dots, m$
- $s_i$: Setup cost per product
- $n$: Number of shipments

*Complete Aggregation*
$
  tilde(S) = S + s_1 + s_2 + dots + s_m
$

$
  Q_i = D_i / n quad arrow.double quad n = D_i / Q_i
$

$
  "TVC"(n) 
  &= tilde(S) n + sum_(i=1)^m h c_i Q_i / 2 \
  &= tilde(S) n + sum_(i=1)^m h c_i D_i / n
$

$
  (dif "TVC"(n)) / (dif n) = tilde(S) - (sum_(i=1)^m h c_i D_i) / (2 n^2) = 0 quad arrow.double quad n^* = sqrt((sum_(i=1)^m h c_i D_i) / (2 tilde(S)))
$

#line(length: 100%)

$
  n = D_1 / Q_1 = D_2 / Q_2 = dots = D_m / Q_m
$

$
  "TVC"(n) = n S' + (h c_1 D_1) / (2 n) + dots + (h c_m D_m) / (2 n)
$

$
  Q^*_i = D_i / n^* quad "for" i = 1, dots, m
$

= Extra Credit

1. 
Split production and consumption process

2.

$
  "TVC"(Q) = S D / Q + "Holding" + "Shortage"
$


