#import "/lib/imports.typ": *
#show: formatting

= Cross-Entropy Loss <statistics_error_metrics_cross_entropy_loss>

== Cross-Entropy Loss (Log Loss)

Binary and multi-class classification

$
"Log Loss" = - 1 / n sum_(i=1)^n [y_i log(hat(y)_i) + (1 - y_i) log(1 - hat(y)_i)]
$