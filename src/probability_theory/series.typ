== Series

$
  sum_(i=1)^infinity a_i = lim_(n arrow infinity) sum_(i=1)^n a_i
$

Provided the limit exists:
- If $a_i gt.eq 0$: limit exists
- If $a_i$ do not have the same sign:
  - Limit need not exists 
  - Limit may exists but be different if we sum in a different order
    - Limit exists and *independent of order* of summation if 
    
$
  sum_(i=1)^infinity abs(a_i) lt.eq infinity
$

Geometric Series

$
  S = sum_(i=0)^infinity alpha^i = 1 + alpha + alpha^2 + dots = 1 / (1 - alpha) quad abs(alpha) lt 1 
$

Derivation:

$
  (1 - alpha) (1 + alpha + dots alpha^n) = 1 - alpha^(n + 1) \

  n arrow infinity \

  (1 - alpha) S = 1 \

  S = 1 / (1 - alpha)
$

Summation in series with multiple indices

$
  sum_(i gt.eq 1, j gt.eq 1) a_(i j)
$

If the sum of the absolute value of the terms of the series are finite, 

$
  sum abs(a_(i j)) lt infinity
$

the order in which the elements are summed will not matter

E.g.:

$
  sum_(i=1)^infinity (sum_(j=1)^infinity a_(i j)) 
  = 
  sum_(j=1)^infinity (sum_(i=1)^infinity a_(i j))
$






