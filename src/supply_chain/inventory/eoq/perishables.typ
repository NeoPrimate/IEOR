#import "/src/imports.typ": *

#let cm(x) = text(fill: red, [$#x$])

== EOQ for perishable items

Relax one dimension from basic EOQ: items *deteriorate over time*. Each unit decays at constant exponential rate $theta$ — even sitting on the shelf untouched, fraction $theta$ of stock is lost per unit time.

Examples: pharmaceuticals with shelf life, fresh produce, photographic film, blood products.

=== Setup

New variable beyond basic EOQ:
- $theta$ = decay rate (fraction of stock lost per unit time)

Inventory dynamics with continuous demand $d$ and continuous decay:

$ (d I) / (d t) = -d - theta I(t) $

The stock drops both from sales (rate $d$) and from spoilage (rate $theta I$). Solve this ODE with $I(0) = Q$:

$ I(t) = (Q + d / theta) e^(-theta t) - d / theta $

Cycle ends when $I(T) = 0$:

$ (Q + d / theta) e^(-theta T) = d / theta quad arrow.r quad T = (1 / theta) ln(1 + (Q theta) / d) $

The cycle is *shorter* than basic EOQ's $Q\/d$ — decay shortens how long each order lasts.

=== Cost model — exact form

Per cycle:
- *Order*: $S$
- *Holding*: $h dot integral_0^T I(t) d t$

Compute the integral. Using $I(t) = (Q + d\/theta) e^(-theta t) - d \/ theta$:

$ integral_0^T I(t) d t = -(Q + d \/ theta)/theta dot (e^(-theta T) - 1) - d T \/ theta $

After substituting $e^(-theta T) = d \/ (Q theta + d)$ and simplifying:

$ integral_0^T I(t) d t = Q / theta - (d T) / theta $

The exact TC per unit time is then $S\/T + h(Q\/(theta T) - d\/theta)$ — but $T$ is transcendental in $Q$, so there's no clean closed-form $Q^*$. Use the small-$theta$ approximation instead.

=== Small-decay approximation

For modest decay ($theta T << 1$), expand $T$:

$ T = (1 / theta) ln(1 + Q theta / d) approx Q / d - (Q^2 theta) / (2 d^2) + cal(O)(theta^2) $

Decay loss per cycle = $Q - d T approx Q^2 theta \/ (2 d)$ — quadratic in $Q$.

Annualizing: number of cycles per year is $1\/T approx d\/Q + theta\/2$, so:
- Annual order cost: $S \/ T approx S d \/ Q$
- Annual holding cost: $h Q \/ 2$ (basic EOQ approximation, leading order)
- *Annual decay loss*: $approx Q theta \/ 2$ units, valued at unit cost $c$, costs $cm(c Q theta \/ 2)$

The decay term *shows up as an extra holding-like cost*: it scales with $Q$. Combine it with the standard holding term:

$ "TRC"(Q) approx S (d / Q) + (h + cm(c theta)) (Q / 2) $

The decay rate effectively *raises the holding cost* from $h$ to $h + c theta$.

=== Derive $Q^*$

Same calculus as basic EOQ with the inflated holding cost:

$ Q^* approx sqrt((2 S d) / (h + cm(c theta))) $

=== Final formulas (small-$theta$ approximation)

$
  Q^* approx sqrt((2 S d) / (h + c theta))
  quad
  T^* approx Q^* / d
  quad
  "TRC"^* approx sqrt(2 S d (h + c theta))
$

Sanity check: as $theta -> 0$ (no decay), $h + c theta -> h$ and we recover basic EOQ exactly ✓. As $theta -> infinity$ (instant decay), $Q^* -> 0$ — order infinitesimally small, infinitely often, so nothing decays.

The result is intuitive: *decay acts like an extra carrying cost of $c theta$ per unit per unit time*. This captures most of the effect when decay is moderate; for high $theta$, you'd need the exact transcendental form.


#example[
  *Given* (shared EOQ params + a 5%/year decay rate):
  - Annual demand: $d = 12000$ units/year
  - Order cost: $S$ = \$50 / order
  - Holding cost: $h$ = \$2 / unit / year
  - Unit cost: $c$ = \$10
  - Decay rate: $theta = 0.05$ /year (5% of stock spoils per year)

  *Step 1 — effective holding cost*

  $
    h_"eff" = h + cm(c theta) = 2 + cm(10 dot 0.05) = 2 + 0.5 = 2.5
  $

  Decay raises the effective holding cost by 25% over the basic EOQ rate.

  *Step 2 — order quantity*

  $
    Q^* approx sqrt((2 dot 50 dot 12000) / cm(2.5)) = sqrt(480000) approx 693 "units"
  $

  *Step 3 — cycle and cost*

  $
    T^* approx Q^* / d = 693 / 12000 approx 0.058 "years" approx 21 "days"
  $
  $ "TRC"^* approx sqrt(2 dot 50 dot 12000 dot 2.5) approx 1732 $ \$/year

  *Decay loss per year*: $Q^* theta \/ 2 approx 693 dot 0.05 \/ 2 approx 17$ units (worth \$170).

  *Compare to basic EOQ* on the same params (ignoring decay):
  - Basic EOQ ($theta = 0$): $Q^* = 775$, $"TRC"^* approx$ \$1549.
  - With decay ($theta = 0.05$): $Q^* approx 693$ (smaller), $"TRC"^* approx$ \$1732 (12% higher).

  Two effects, both pointing the right way:
  + *Order smaller batches* (693 vs 775) so less stock sits long enough to spoil.
  + *Total cost rises* — decay is a real cost you can't optimize away, only minimize.

  For higher $theta$ (e.g., fresh produce with $theta gt.eq 1\/$year), the small-$theta$ approximation breaks down and the exact transcendental form is needed; in practice, perishable inventory is more often modeled with a fixed shelf life $L$ rather than continuous decay.
]
