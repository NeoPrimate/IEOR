import numpy as np
import matplotlib.pyplot as plt

# Sampling settings
fs = 100          # Sampling frequency (Hz)
T = 1             # Duration (1 second)
t = np.linspace(0, T, fs, endpoint=False)  # Time vector

# Signal: sum of 5 Hz and 10 Hz sine waves
signal = np.sin(2 * np.pi * 5 * t) + 0.5 * np.sin(2 * np.pi * 10 * t)

# Compute FFT
fft_result = np.fft.fft(signal)
freqs = np.fft.fftfreq(len(t), 1/fs)

# Take only the positive frequencies
half = len(t) // 2
fft_magnitude = np.abs(fft_result[:half])
positive_freqs = freqs[:half]

# Plot signal and spectrum
plt.figure(figsize=(12, 4))

# Time domain
plt.subplot(1, 2, 1)
plt.plot(t, signal, color='black')
plt.title("Original Signal (Time Domain)")
plt.xlabel("Time (s)")
plt.ylabel("Amplitude")

# Frequency domain
plt.subplot(1, 2, 2)
plt.stem(positive_freqs, fft_magnitude, basefmt=" ", linefmt='black', markerfmt='ko')
plt.title("Frequency Domain (FFT)")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Magnitude")

plt.tight_layout()
plt.show()
