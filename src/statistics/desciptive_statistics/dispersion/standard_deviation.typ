#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

=== Standard deviation

Quantifies the amount of variation or dispersion in a set of data points

- Population

$
sigma &= sqrt(sigma^2)
\
\
sigma &= sqrt(1/N sum_(i=1)^N (x_i - mu)^2)
$

- Sample

$
s &= sqrt(s^2)
\
\
s &= sqrt(1/(n-1) sum_(i=1)^N (x_i - macron(x))^2)
$