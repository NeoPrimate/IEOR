#import "/lib/imports.typ": *

Operators that compute smoothed (averaged) versions of input signals. Implemented as #link(<system-dynamics-delays>)[exponential delays] but used to model *perception* rather than physical transit.

== First-order smoothing (exponential smoothing)

$
  d hat(X) / d t = (X - hat(X)) / tau
$

$hat(X)$ tracks $X$ with smoothing time $tau$ — equivalent to single-exponential smoothing.

In discrete time: $hat(X)_t = alpha X_t + (1 - alpha) hat(X)_(t-1)$ with $alpha = Delta t / tau$.

In Vensim: `SMOOTH(input, tau)`.

== Higher-order smoothing

$n$ first-order smooths in series — each one smoother. `SMOOTH3` is third-order (very common default in SD models). Removes more noise but adds more phase lag.

== TREND function

Computes a smoothed *fractional rate of change*:

$
  text("TREND")(X, tau_p, tau_t) = (X - hat(X)_p) / (hat(X)_p dot tau_t)
$

where $hat(X)_p$ is $X$ smoothed with time $tau_p$. Gives "perceived growth rate" — used to model planners' expectations.

In Vensim: `TREND(input, perception_time, trend_time)`.

== FORECAST function

Extrapolates the input forward using TREND:

$
  text("FORECAST")(X, h) = X dot (1 + h dot text("TREND"))
$

Forecast $h$ time units ahead based on current trend.

Used to model planning under expectations — what someone *thinks* future demand will be.

== Why smoothing models decision-making

People (and organizations) don't react to raw data; they react to *smoothed* versions:

- *Expected demand*: smoothed over weeks / months
- *Perceived inflation*: long-term average, not daily news
- *Expected supply lead time*: averaged over past orders

Smoothing operators in SD capture this *adaptive expectation* behavior. Combined with delays and stocks, they generate the "policy resistance" and stability problems that define Sterman's beer-game style dynamics.

== Phase lag

Smoothing introduces a *delay* in perception:

- *First-order smooth*: lag is approximately $tau$
- *Third-order smooth*: lag approximately $3 tau / 3 = tau$ but with much sharper response
- Higher orders: tighter pulse, slower mean response

Phase lag = part of why supply-chain bullwhip happens: each echelon's reaction is *delayed* relative to actual demand.

== See also

- *#link(<system-dynamics-delays>)[Delays]* — same mechanism, different framing
- *#link(<system-dynamics-stock-management>)[Stock Management]* — uses smoothing for expected demand
- *#link(<time-series-exponential-smoothing-ets-summary>)[Exponential Smoothing (ETS)]* — discrete-time analog
