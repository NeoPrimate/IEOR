#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== EOQ (Economic Order Quantity)

Optimal order quantity that *minimizes the total cost*, which includes both *holding costs* and *ordering costs*

$
"EOQ" = sqrt((2 D S) / H)
$

Where:

- $D$: Demand per time period
- $S$: Ordering cost per order
- $H$: Holding cost per unit, per time period

#eg[
A company sells widgets and wants to determine the optimal order quantity for inventory.
- The annual demand for widgets ($D$) is 12,000 units.
- The cost to place an order ($S$) is \$50.
The holding cost per unit per year ($H$) is \$2.

$
"EOQ" = sqrt((2 times 12000 times 50) / 2) = 775
$

The company should order 775 widgets each time they place an order to minimize the total cost, which includes both ordering and holding costs

]