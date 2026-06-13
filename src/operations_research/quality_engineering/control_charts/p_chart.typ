#import "/lib/imports.typ": *
#show: formatting

The p-chart monitors the proportion of defectives in each sample, accounting for variable sample sizes.

$
  "UCL"_(p_i) = macron(p) + 3 sqrt((macron(p) (1 - macron(p))) / n_i) \
  "LCL"_(p_i) = macron(p) - 3 sqrt((macron(p) (1 - macron(p))) / n_i) \
  
$

Where:

- $d_i$: The number of defective items observed in sample $i$
- $p_i$: sample proportion defective

$
  p_i = d_i / n_i
$

- $macron(p)$: overall proportion defective

$
  macron(p) = (sum d_i) / (sum n_i)
$

- $n_i$: sample size for sample $i$

#align(center)[
  #let k = 25
  #let rng = gen-rng(42)

  // Varying sample sizes per subgroup
  #let (_, n) = integers(rng, low: 40, high: 80, size: k)
  #let (_, d) = integers(rng, low: 0, high: 10, size: k)

  #let p = d.zip(n).map(((dn) => dn.at(0) / dn.at(1)))
  #let total_d = d.sum()
  #let total_n = n.sum()
  #let p_bar = total_d / total_n

  #let ucl = n.map(ni => p_bar + 3 * calc.sqrt(p_bar * (1 - p_bar) / ni))
  #let lcl = n.map(ni => calc.max(0, p_bar - 3 * calc.sqrt(p_bar * (1 - p_bar) / ni)))

  #let samples = range(1, k)
  #let m = samples.len()

  #lq.diagram(
    width: 8cm,
    height: 3.5cm,
    xlabel: [Sample],
    ylabel: [Proportion\ Defective],
    xaxis: (tick-args: (tick-distance: 5)),
    lq.plot(samples, p.slice(0, m), stroke: blue, mark: "o"),
    lq.plot(samples, ucl.slice(0, m), mark: none, stroke: red, label: $"UCL"$),
    lq.hlines(p_bar, label: $macron(p)$, stroke: green),
    lq.plot(samples, lcl.slice(0, m), mark: none, stroke: red, label: $"LCL"$),
  )
]
