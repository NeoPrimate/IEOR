#import "/lib/imports.typ": *

== Periodogram

Estimate the *power spectral density* (PSD) of a time series — i.e., how much variance is at each frequency. The simplest spectrum estimator; built directly from the Fourier transform.

=== Definition

For a series $y_0, y_1, ..., y_(N-1)$ with DFT $Y_k$ (see [fourier.typ](fourier.typ)):

$ I(k\/N) = 1/N |Y_k|^2, quad k = 0, 1, ..., N-1 $

The periodogram is the function $I$ evaluated at the discrete frequencies $k\/N$. For a real-valued series, $I(k\/N) = I(1 - k\/N)$ (symmetric around 0.5), so you only plot the first $N\/2$ bins.

=== What it tells you

- *Peaks at frequency $k\/N$*: the series has a strong cyclic component with period $N\/k$.
- *Flat spectrum*: white noise (no preferred frequency).
- *$1\/f$-shaped spectrum*: low-frequency power dominates → trending or persistent series.

The *area* under the periodogram equals the variance of the series (Parseval's theorem). So peaks tell you what *fraction of variance* is explained by each frequency.

=== Why raw periodograms are noisy

The periodogram is *not consistent*: even with infinite data, its variance at each frequency does *not* decrease. So the raw periodogram is a *jagged* estimate — peaks are real, but their estimated heights are noisy.

Two standard fixes:

==== 1. Smoothing the periodogram

Average the periodogram over a small window of nearby frequencies (a *spectral window*). Trades resolution for variance reduction.

$ hat(f)(k\/N) = sum_(j = -m)^m W_j dot I((k+j)\/N) $

with weights $W_j$ summing to 1 (e.g., Bartlett, Hann, Tukey windows).

==== 2. Welch's method

Split the series into overlapping segments. Compute the periodogram of each segment. Average. Reduces variance at the cost of resolution; the standard implementation in `scipy.signal.welch`.

=== Significance test

How big does a peak need to be before we believe it?

For Gaussian white noise input, $2 I(k\/N) \/ sigma^2 tilde chi^2_2$ at each frequency. So a peak with $I > c sigma^2$ has a known $p$-value.

Rule of thumb: peaks more than 2-3× the surrounding noise floor are likely real; smaller peaks often vanish under significance testing.

=== Workflow

+ Detrend the series (subtract a linear trend, or take first differences). Trend dominates the low-frequency spectrum and hides cycles.
+ Apply a *windowing function* (Hann, Hamming) before FFT to reduce edge artifacts.
+ Compute periodogram via FFT.
+ Smooth (or use Welch's method) to get a stable estimate.
+ Plot $log(I)$ vs frequency — log scale reveals weak peaks.
+ Identify peaks; period = $1\/$frequency.

=== Comparison to autocorrelation analysis

Periodogram and *autocorrelation function* (ACF) contain *equivalent information* (Wiener-Khinchin theorem):

$ "Autocorrelation"(tau) = "inverse Fourier transform of " I(f) $

A peak in the periodogram at frequency $f$ corresponds to oscillating autocorrelation at period $1\/f$. Use whichever is easier to read for your data:
- *Periodogram*: better for finding *unknown* periodicities.
- *ACF*: better for confirming and characterizing a *known* periodicity.

Most time-series analyses use both.


#example(title: "Periodogram of daily energy demand")[
  *Given*: 2 years (730 days) of daily electricity demand.

  *Step 1 — preprocess*

  - Detrend: subtract a linear regression line (removes long-term load growth).
  - Apply a Hann window: $w_t = 0.5 (1 - cos(2 pi t \/ N))$.

  *Step 2 — FFT and periodogram*

  ```python
  from scipy.signal import periodogram
  freq, psd = periodogram(y_detrended, fs=1.0, window='hann')
  period = 1 / freq[1:]  # skip DC
  ```

  *Step 3 — read peaks*

  Suppose `psd` peaks at:
  - $f = 1\/7$ (period = 7 days) → strong weekly cycle (weekday vs weekend pattern)
  - $f = 1\/365$ (period = 365 days) → annual cycle (heating/cooling load)
  - $f = 1\/3.5$ (period = 3.5 days) → secondary peak; possibly mid-week vs end-of-week subdivision

  *Step 4 — interpret*

  Two clear seasonalities (weekly and annual) — confirms what you'd see in classical / STL decomposition, but reveals them *quantitatively* without imposing a seasonal period in advance.

  *Step 5 — use*

  - For *forecasting*: include Fourier features at periods 7 and 365.
  - For *decomposition*: STL with two seasonal components, or MSTL.
  - For *anomaly detection*: a day with unusual frequency content (e.g., a power outage) shows up in the residuals after removing the dominant frequencies.

  The periodogram is the *diagnostic step* that tells you which seasonal periods to model.
]
