#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== Newsvendor

determine the optimal order quantity 
$Q^*$ that minimizes the total expected cost or maximizes the expected profit, based on the trade-off between the overage and underage costs

Assumptions

  - Products are separable
  - Planning is done for a single period
  - Demand is random
  - Deliveries are made in advance of demand
  - Costs of overage or underage are linear

1. Parameters

    - $P$: Sale Price
    - $C$: Purchase Cost
    - $S$: Unsold Value
    - $mu$: Mean Demand
    - $sigma$: Standard Deviation Demand

  2. Calculate Underage and Overage Costs:

    - Underage Cost ($C_u$): Profit lost for each unit of demand not met

    $
    C_u = P - C
    $
  
    - Overage Cost ($C_o$): This is the cost of holding an unsold newspaper.

    $
    C_o = C - S
    $

  3. Calculate Critical Ratio ($C R$)

  $
  C R = C_u / (C_u - C_o)
  $

  4. Find z-score: Find the number of standard deviations away from the mean corresponding to the critical ratio:

  $
  z^* = Phi^(-1)(C R)
  $

  Where:
  - $Phi^(-1)$: Inverse of the CDF of the standard normal distribution (PPF)

  5. Calculate Optimal Order Quantity ($Q^*$)

  $
  Q^* = mu + z^* sigma
  $

  Where:
  - $z^*$: z-score corresponding to the critical ratio $C R$ from the standard normal distribution

#eg[
  Consider a newsvendor selling newspapers:

  1. Parameters

    - Sale Price ($P$): \$3 (per unit)
    - Purchase Cost ($C$): \$1 (per unit)
    - Unsold Value ($S$): \$0 (per unit)
    - Mean Demand ($mu$): 100 (units)
    - Standard Deviation Demand ($sigma$): 20 (units)

  2. Calculate Underage and Overage Costs:

    - Underage Cost ($C_u$): Profit lost for each unit of demand not met

    $
    C_u = P - C = 3 - 1 = 2
    $
  
    - Overage Cost ($C_o$): This is the cost of holding an unsold newspaper.

    $
    C_o = C - S = 1 - 0 = 1
    $

  3. Calculate Critical Ratio ($C R$)

  $
  C R = C_u / (C_u - C_o) = 2 / (2 + 1) = 2 / 3 = 0.67
  $

  4. Find z-score: Find the number of standard deviations away from the mean corresponding to the critical ratio:

  $
  z^* = Phi^(-1)(C R) = 0.44
  $

  5. Calculate Optimal Order Quantity ($Q^*$)

  $
  Q^* = mu + z^* sigma = 100 + 0.44 dot 20 = 108.8
  $
]

#code(
  "newsvendor.py",
  ```py
  import numpy as np
  import scipy.stats as stats
  import matplotlib.pyplot as plt

  # Parameters for the newsvendor example
  selling_price = 3  # Selling price per newspaper
  purchase_cost = 1   # Purchase cost per newspaper
  unsold_value = 0    # Value of unsold newspapers
  mu = 100 # Mean of demand
  sigma = 20 # Standard deviation of demand

  # Calculate underage and overage costs
  C_u = selling_price - purchase_cost  # Underage cost
  C_o = purchase_cost - unsold_value    # Overage cost

  # Calculate the critical ratio
  CR = C_u / (C_u + C_o)

  # Assume a normal distribution for demand
  mu = 50    # Mean demand
  sigma = 10 # Standard deviation of demand

  # Calculate the optimal order quantity (Q*)
  z_star = stats.norm.ppf(CR)  # z-score corresponding to the critical ratio
  Q_star = mu + z_star * sigma  # Optimal order quantity
  ```
)


