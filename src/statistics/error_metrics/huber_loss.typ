== Huber Loss

Combines MSE and MAE to be less sensitive to outliers

$
L_delta (a) = cases(
  1 / 2 a^2 "for" abs(a) lt.eq delta,
  delta(abs(a) - 1/2 delta) "otherwise" 
)
$