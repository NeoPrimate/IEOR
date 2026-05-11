#import "/lib/imports.typ": *

Time lags between cause and effect. Critical for explaining oscillation and instability in #link(<system-dynamics-feedback-loops>)[feedback systems].

== Three kinds

*Material delays*: physical movement / transformation takes time (shipping, manufacturing, aging).

*Information delays*: perception / measurement lags (reporting, accounting cycles).

*Decision delays*: time between observing data and acting (administrative).

== Pipeline (pure) delay

Constant time lag $D$:

$
  O(t) = I(t - D)
$

Output is just input shifted by $D$. Variance preserved.

== First-order exponential delay

$
  dot S = I - S/D, #h(1em) O = S/D
$

A stock $S$ holds material in transit; outflow rate is $S/D$. Mean delay $D$, but each unit's transit time is random (exponentially distributed). High variance.

== Higher-order Erlang delays

Cascade $n$ first-order delays in series, each of length $D/n$:

$
  dot S_k = (S_(k-1) - S_k) (n / D), #h(0.5em) k = 1, dots, n
$

Output = $S_n dot (n/D)$.

The impulse response is *Erlang-distributed*: mean $D$, variance $D^2 / n$. As $n -> infinity$, variance $-> 0$ and the cascade approaches a pure pipeline delay.

#table(
  columns: 2,
  align: (center, left),
  stroke: none,
  table.header([$n$], [Behavior]),
  [1], [Pure first-order (high variance, smooth)],
  [3], [Visible peak, moderate spread (typical SD default)],
  [10], [Tight pulse, low variance],
  [∞], [Pipeline delay (no spread)],
)

In Vensim: `DELAY1` (order 1), `DELAY3` (order 3), `DELAYN` (order n).

== Why delays drive oscillation

Imagine a thermostat that responds *late*. The room overheats; the system finally responds, cooling too much; oscillation. The delay turns a balancing loop into an oscillator.

Generic structure:

$
  dot x = (x^* - hat(x))/tau, #h(0.5em) hat(x) = "delayed perception of " x
$

When $tau >>$ delay, smooth approach. When $tau approx$ delay, oscillation. When $tau <<$ delay, instability.

== Common SD examples

- *Beer game*: each echelon has ordering + shipping delays → bullwhip oscillation
- *Capacity planning*: long construction lead times → boom-bust cycles
- *Workforce*: hiring + training delay → over/under-staffing oscillation
- *Public policy*: legislation lag → policy ineffectiveness

== See also

- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]*
- *#link(<system-dynamics-smoothing>)[Smoothing Operators]*
- *#link(<system-dynamics-second-order>)[Second-Order Systems]* — formal oscillation analysis
- *#link(<system-dynamics-beer-game>)[Beer Game]*
