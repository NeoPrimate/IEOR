== t-Distribution

$
f(t | nu) = (Gamma ((nu + 1) / 2)) / (sqrt(nu pi) Gamma (nu / 2)) (1 + t^2 / nu)^(-(nu + 1) / 2)
$

Where:
- $t$: t-statistic
- $nu$ (or $d f$): degrees of freedom
- $Gamma$: Gamma function (generalizes the factorial function)

#figure(image("../../vis/t_distribution.png", width: 30%))

Continuous probability distribution for estimating the mean of a normally distributed population in situations where:

- Sample size is small 

- Population standard deviation is unknown

Similar in shape to the normal distribution but has heavier tails, which means it gives more probability to values further from the mean



