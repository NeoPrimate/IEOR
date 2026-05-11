#import "/lib/imports.typ": *

A simple #link(<system-dynamics-system-dynamics>)[SD] model of new-product adoption. Frank Bass (1969). Predicts the characteristic *S-shaped* adoption curve from two parameters.

== Model

Let $A(t)$ = cumulative adopters, $N$ = total market size. Adoption rate:

$
  dot A = (p + q A / N) (N - A)
$

Two parameters:
- $p$: *coefficient of innovation* — adoption driven by external influence (advertising, news, intrinsic appeal)
- $q$: *coefficient of imitation* — adoption driven by word-of-mouth (existing adopters influencing potential adopters)

== Structure

Two interpreting terms:

- $p (N - A)$: *innovation* — fraction of remaining non-adopters who'd adopt based on external info
- $q (A/N) (N - A)$: *imitation* — non-adopters influenced by the proportion $A/N$ of current adopters; total imitation pressure proportional to remaining market

Together: a *limits-to-growth* archetype with reinforcing word-of-mouth and balancing market exhaustion.

== Behavior

Early on ($A << N$): adoption is mostly $p N$ — small, driven by innovation only.

Middle: $A$ approaches $N/2$; imitation term peaks, growing very fast.

Late: $N - A$ shrinks; growth slows.

*Peak adoption rate* at:
$
  A^* = (N (q - p)) / (2 q)
$

*Time of peak adoption*:
$
  t^* = ln(q / p) / (p + q)
$

For typical $p approx 0.01-0.05$, $q approx 0.3-0.5$: peak around 5-10 years after launch.

== Empirical fit

Bass fit the model to historical sales of color TVs, washing machines, and dozens of other durables. Excellent S-curve fits with just $p, q$ as parameters.

Common parameter values:
- *Consumer electronics*: $p approx 0.03$, $q approx 0.4$
- *Pharmaceuticals*: $p approx 0.001$, $q approx 0.5$
- *Software platforms*: $p approx 0.01-0.05$, $q approx 0.5-0.7$

== Generalizations

- *Generalized Bass*: include effect of price, advertising → $p(t), q(t)$ time-varying
- *Repeat purchase*: cumulative installed base $!=$ cumulative purchases
- *Substitute / next-generation* products: previous-generation forms downstream pool

== Why it matters

The Bass model is *the* default for:

- *New-product launch* forecasting
- *Marketing budget* allocation across product lifecycle stages
- *Technology adoption* studies (Rogers' *Diffusion of Innovations*)

Most consumer-electronics product launches use Bass as the baseline forecast.

== See also

- *#link(<system-dynamics-logistic-growth>)[Logistic Growth]* — similar S-curve, simpler model
- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]* — R + B = S-curve archetype
- *#link(<system-dynamics-system-dynamics>)[System Dynamics overview]*
