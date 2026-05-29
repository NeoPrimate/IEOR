#import "/lib/imports.typ": *
#show: formatting

== Leibniz's Rule

*Differentiation under the integral sign.* When the integrand *and* the limits depend on a parameter $Q$, the derivative splits into three pieces: one from the integrand changing, two from the moving limits.

$
  dif / (dif Q) integral_(a(Q))^(b(Q)) h(x, Q) dif x
  = underbrace(integral_(a(Q))^(b(Q)) (partial h) / (partial Q) dif x, "integrand varies")
  + underbrace(h(b(Q), Q) dot b'(Q), "upper limit moves")
  - underbrace(h(a(Q), Q) dot a'(Q), "lower limit moves")
$

Reading the three terms:
- *Integrand term* — freeze the limits, differentiate inside.
- *Upper-limit term* — rate the top edge sweeps out new area: $h$ at $x = b(Q)$ times $b'(Q)$.
- *Lower-limit term* — area lost at the bottom edge, subtracted.

=== Special cases

- *Fixed limits* ($a, b$ constant) — only the integrand term survives:
$
  dif / (dif Q) integral_a^b h(x, Q) dif x = integral_a^b (partial h) / (partial Q) dif x
$
- *Constant integrand, moving upper limit* (the fundamental theorem):
$
  dif / (dif Q) integral_a^Q h(x) dif x = h(Q)
$

#example[
  The newsvendor overage term $integral_0^Q (Q - x) f(x) dif x$ has $h(x, Q) = (Q - x) f(x)$, upper limit $b(Q) = Q$, lower limit fixed:
  $
    dif / (dif Q) integral_0^Q (Q - x) f(x) dif x
    = integral_0^Q f(x) dif x + underbrace((Q - Q) f(Q), = 0)
    = F(Q)
  $
  The boundary term vanishes because the integrand is zero at $x = Q$.
]
