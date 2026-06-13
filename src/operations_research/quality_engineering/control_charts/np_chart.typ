#import "/lib/imports.typ": *
#show: formatting

== NP-charts (Number Proportion)

Number of defective items (constant sample size)

$
  "UCL"_(n p) = n macron(p) + 3 sqrt(n macron(p) (1 - macron(p))) \
  "LCL"_(n p) = n macron(p) - 3 sqrt(n macron(p) (1 - macron(p)))
$

Where:
- $n$: count of defective items in each sample
- $p$: proportion of defectives
- $macron(p)$: 

$
  macron(p) 
  &= 1 / k sum^k_(i=1) d_i / n \
  &= (sum^k_(i=1) d_i) / (n dot k)
$

- $macron(n p) = n macron(p)$



#align(center)[
  #let k = 25
  #let n = 50 // fixed sample size

  #let rng = gen-rng(42)
  #let (_, d) = integers(rng, low: 0, high: 10, size: k) // number of defective units

  #let samples = range(1, k)
  #let ds = d.slice(0, samples.len())

  #let d_sum = d.sum()
  #let p_bar = d_sum / (k * n)
  #let np_bar = n * p_bar
  #let sigma_np = calc.sqrt(n * p_bar * (1 - p_bar))
  #let ucl = np_bar + 3 * sigma_np
  #let lcl = calc.max(0, np_bar - 3 * sigma_np)

  #lq.diagram(
    width: 8cm,
    height: 3.5cm,
    xlabel: [Sample],
    ylabel: [Number of\ Defective\ Units],
    xaxis: (tick-args: (tick-distance: 5)),
    lq.plot(samples, ds, stroke: blue, mark: "o"),
    lq.hlines(ucl, label: $"UCL"$, stroke: red),
    lq.hlines(np_bar, label: $macron(n p)$, stroke: green),
    lq.hlines(lcl, label: $"LCL"$, stroke: red),
  )
]

