#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== (OCT) Order Cycle Time

Measures the total time taken from when a customer places an order to when the order is delivered

$
"OCT" = T_"order" + T_"processing" + T_"production" + T_"shipping"
$

Where:

- $T_"order"$: Order Entry Time (time it takes to receive and log the order)

- $T_"processing"$: Order Processing Time (time to check inventory, verify details, and prepare for production or shipment)

- $T_"production"$: Production Time (time to manufacture or prepare the product)

- $T_"shipping"$: Shipping Time (time it takes to deliver the product from the warehouse to the customer)