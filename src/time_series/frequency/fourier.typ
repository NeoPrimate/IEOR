#import "/src/imports.typ": *

== Fourier Transform

A *frequency-domain* representation of a time series. Decompose the series into a sum of sines and cosines at different frequencies. Useful for finding *dominant cycles* that aren't obvious in the time-domain view.

=== Discrete Fourier Transform (DFT)

For a series $y_0, y_1, ..., y_(N-1)$ of length $N$:

$ Y_k = sum_(t=0)^(N-1) y_t dot e^(-2 pi i k t \/ N), quad k = 0, 1, ..., N-1 $

The output $Y_k$ is a complex number. Its magnitude $|Y_k|$ measures how much the *frequency* $k\/N$ (cycles per time unit) is present in the signal. The phase $arg(Y_k)$ tells you where the cycle peaks.

The inverse DFT recovers the original series:

$ y_t = 1/N sum_(k=0)^(N-1) Y_k dot e^(2 pi i k t \/ N) $

=== Frequencies and periods

For a series sampled at one observation per unit time, the DFT covers frequencies $k\/N$ for $k = 0, 1, ..., N-1$:

- $k = 0$: DC component (mean of the series)
- $k = 1$: one cycle over the entire window — period $N$
- $k = 2$: two cycles over the window — period $N\/2$
- ...
- $k = N\/2$: Nyquist frequency — period 2 (highest detectable cycle)
- $k > N\/2$: redundant (mirror of lower frequencies; this is *aliasing*)

So you only look at the first $N\/2$ frequencies for a real-valued series. The *period* corresponding to bin $k$ is $N\/k$.

=== FFT — the fast version

The Fast Fourier Transform (Cooley-Tukey 1965) computes the DFT in $O(N log N)$ rather than the naive $O(N^2)$. It's the standard implementation in every numerical library (NumPy `fft.fft`, MATLAB `fft`, etc.).

Use FFT in practice; conceptually it computes exactly the DFT above.

=== What you can do with the Fourier transform

==== 1. Find dominant cycles

Plot $|Y_k|^2$ (the *power spectrum*) vs frequency. Peaks indicate dominant cycles. Example uses:

- Found a peak at $k = 12$ in 144 months of data → period 12 → annual cycle.
- Found a peak at $k = 1$ in 365 days → period 365 → annual cycle (in daily data).
- Multiple peaks → multiple seasonalities (e.g., daily data has both weekly *and* yearly peaks).

This is the core of [periodogram.typ](periodogram.typ).

==== 2. Filter (frequency-domain)

Remove specific frequencies:
- *Low-pass filter*: keep low frequencies, drop high → smooths the series.
- *High-pass filter*: keep high, drop low → removes trend, isolates noise/cycles.
- *Band-pass filter*: keep a specific range → isolate one cycle.

Procedure: FFT → zero out unwanted frequency bins → inverse FFT.

==== 3. Forecast with Fourier features

Add `sin(2 pi k t \/ m)` and `cos(2 pi k t \/ m)` as regressors in a linear forecasting model, where $m$ is the period. A handful of harmonics ($k = 1, 2, 3$) captures most of a smooth seasonal pattern.

This is how Prophet (Facebook) and many modern forecasting libraries handle seasonality without a fixed seasonal index.

==== 4. Spectral density estimation

Smoothed version of the periodogram → see [periodogram.typ](periodogram.typ).

=== Limitations

- *Stationarity assumption*: standard FFT assumes the series is stationary. For series with changing frequency content (e.g., a chirp), use *short-time Fourier transform* (STFT) or wavelets.
- *Boundary effects*: a finite series treated as periodic introduces artifacts at the edges. Apply a *windowing function* (Hann, Hamming) before FFT to reduce these.
- *Resolution*: frequency resolution is $1\/N$ — you can only distinguish cycles at multiples of this. Low frequencies need long series.

=== Connection to seasonality

If your series has a known seasonal period $m$, you'd expect a peak in the spectrum at $k = N\/m$. Conversely, *unknown* periodicities are *discovered* via the spectrum — perhaps weekly + monthly + yearly all show up in the same series. Fourier analysis is the natural tool for this.


#example(title: "Fourier analysis of monthly retail sales")[
  *Given*: $N = 60$ months of sales data (5 years).

  *Step 1 — apply FFT*

  ```python
  import numpy as np
  Y = np.fft.fft(y)
  power = np.abs(Y[:N//2])**2  # only first half (positive frequencies)
  freq = np.arange(N//2) / N    # cycles per month
  period = 1 / np.where(freq > 0, freq, np.inf)  # months per cycle
  ```

  *Step 2 — find peaks*

  Suppose the power spectrum shows large peaks at:
  - $k = 5$ → frequency $5/60 = 1/12$ → period 12 (monthly cycle = annual)
  - $k = 10$ → frequency $10/60 = 1/6$ → period 6 (semi-annual)
  - $k = 1$ → frequency $1/60$ → period 60 (long-term trend)

  *Step 3 — interpret*

  - The annual peak at $k = 5$ is the dominant seasonality.
  - The semi-annual peak might be a back-to-school spike on top of the holiday spike.
  - $k = 1$ at the lowest frequency captures the multi-year trend.

  *Step 4 — use*

  Pick a few harmonics ($k = 5, 10$, possibly 15) and use them as Fourier features in a regression: forecast = trend + linear combination of $sin(2 pi k t\/12)$ and $cos(2 pi k t\/12)$. The Fourier representation lets you smoothly interpolate seasonal effects between cycles.
]
