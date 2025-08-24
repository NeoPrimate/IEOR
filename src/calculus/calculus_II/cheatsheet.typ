
Gradient: 

$
  gradient f(x) = vec(
    (diff f) / (diff x_1),
    (diff f) / (diff x_2),
    dots.v,
    (diff f) / (diff x_n),
  )
$

Hessian:

$
  gradient^2 f(x) = mat(
    (diff f) / (diff x_1),
  )
$

If

$
  f: RR^n arrow RR
$

Then

- 1st derivatives $arrow$ *gradient* (vector $RR^n$)
- 2nd derivatives $arrow$ *Hessian* (matrix $RR^(n times n)$)
- 3rd derivatives $arrow$ *Third-order derivative tensor* (rank-3 tensor in $RR^(n times n times n)$)

#line(length: 100%)

- *Gradient* $arrow$ vector ($n$)
- Hessian $arrow$ matrix ($n times n$)
- 3rd derivative $arrow$ tensor ($n times n times n$)
- 4th derivative $arrow$ tensor ($n times n times n times n$)
- and so on.