#import "../../../../../utils/code.typ": code
#import "../../../../../utils/examples.typ": eg

== Little's Law

$
L = lambda W
$

Where:

- $L$: average number of items (customers, tasks, etc.) in the system
- $lambda$: average arrival rate (items per unit time)
- $W$: average time an item spends in the system

#eg[
  Bank where customers arrive at an average rate of 10 customers per hour ( $lambda = 10$  customers / hour). Each customer spends an average of 12 minutes in the bank ($W = 12/60 = 0.2$ hours).

  $
  L = lambda W = 10 times 0.2 = 2
  $

  On average, there are 2 customers in the bank at any given time (includes being served and those waiting in line)
]