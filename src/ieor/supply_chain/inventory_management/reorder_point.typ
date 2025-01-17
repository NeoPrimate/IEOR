#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code


== ROP (Reorder Point)

The inventory level at which a new order should be placed to avoid stockouts

$
"ROP" = ("Average Demand per Period" times "Lead Time")
$

#eg[
Suppose your business sells 50 units per week, and the lead time for a new order is 2 weeks. Using the formula:

$
"ROP" = 50 ("units per week") times 2 ("weeks") = 100 "units"

$

This means that when your inventory level drops to 100 units, you should place a new order to avoid running out of stock.
]