#import "/lib/imports.typ": *
#show: formatting

Compartmental models of *epidemic spread*. The mathematical foundation of mainstream epidemiology.

== SIR model

Three stocks:
- $S$: Susceptible
- $I$: Infected
- $R$: Recovered (immune)

Equations:

$
  dot S = -beta S I / N
$

$
  dot I = beta S I / N - gamma I
$

$
  dot R = gamma I
$

with:
- $beta$: transmission rate (contacts × probability per contact)
- $gamma$: recovery rate ($1/gamma$ = mean infectious period)
- $N = S + I + R$ (total population, conserved)

== Basic reproduction number $R_0$

The most-cited epidemic metric:

$
  R_0 = beta / gamma
$

Interpretation: average number of secondary infections from one infected person in a fully-susceptible population.

- $R_0 > 1$: epidemic grows
- $R_0 < 1$: epidemic dies out
- $R_0 = 1$: marginal — slow spread

For COVID-19 wild-type: $R_0 approx 2.5-3$. For measles: $R_0 approx 12-18$. For influenza: $R_0 approx 1-2$.

== Herd immunity threshold

The fraction of population that must be immune to halt spread:

$
  1 - 1/R_0
$

For $R_0 = 3$: 67% needs to be immune. For $R_0 = 18$ (measles): 94%.

Vaccines / prior infection drive immune fraction up; once you cross the threshold, sustained transmission is impossible (in this simple model).

== SEIR: add Exposed

Adds an *Exposed* (infected but not yet contagious) compartment:

$
  dot E = beta S I / N - sigma E
$

$
  dot I = sigma E - gamma I
$

with $1/sigma$ = mean incubation period.

For COVID-19, SEIR is more realistic (significant incubation period).

== Behavior

Epidemic curve typically S-shaped (in cumulative cases) and bell-shaped (in new cases per day):

- Exponential growth phase: $I(t) approx I_0 e^((beta - gamma) t)$
- Peak when $S(t) = N / R_0$ (= herd-immunity threshold)
- Decay phase

== Variants

- *SIRS*: lose immunity over time (return $R -> S$); endemic equilibrium possible
- *SIS*: no immunity at all (return $I -> S$); endemic equilibrium with constant $I$
- *Age-structured*: multiple age compartments with different mixing rates
- *Spatial*: include geographic structure
- *Network*: contacts on a graph; heterogeneous mixing

== Where used

- *Public health planning*: vaccination targets, lockdown timing
- *Pharmaceutical R&D*: market size estimation for vaccines / antivirals
- *Risk modeling*: insurance, business continuity
- *Behavioral economics*: viral information spread (memes, news)

== Limitations

- *Well-mixed* assumption: real contacts are heterogeneous
- *Constant parameters*: real $R_0$ changes with seasonality, behavior, variants
- *Deterministic*: small populations need stochastic models (Gillespie, branching processes)

== See also

- *#link(<system-dynamics-logistic-growth>)[Logistic Growth]* — similar S-curve dynamics
- *#link(<system-dynamics-stocks-flows>)[Stocks and Flows]* — modeling language
- *#link(<system-dynamics-feedback-loops>)[Feedback Loops]* — the underlying R+B structure
