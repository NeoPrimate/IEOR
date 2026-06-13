#import "/lib/imports.typ": *
#show: formatting

Defects per unit (variable unit size)

$
  "UCL"_u = macron(u) + 3 sqrt(macron(u) / n_i) \
  "LCL"_u = macron(u) - 3 sqrt(macron(u) / n_i) \
$

Where:

- $c_i$: number of defects in sample $i$
- $n_i$: sample size of group $i$
- $u_i$: defects per unit

$
  u_i = c_i / n_i
$

- $macron(u)$:

$
  (sum c_i) / (sum n_i)
$

#align(center)[
  #let k = 25
  #let rng = gen-rng(42)

  // Variable sample sizes (e.g., units inspected)
  #let (_, n) = integers(rng, low: 20, high: 100, size: k)
  #let (_, c) = integers(rng, low: 0, high: 12, size: k)

  #let u = c.zip(n).map(cn => cn.at(0) / cn.at(1))

  #let c_sum = c.sum()
  #let n_sum = n.sum()
  #let u_bar = c_sum / n_sum

  #let ucl = range(0, k).map(i => u_bar + 3 * calc.sqrt(u_bar / n.at(i)))
  #let lcl = range(0, k).map(i => calc.max(0, u_bar - 3 * calc.sqrt(u_bar / n.at(i))))

  #let samples = range(1, k)
  #let m = samples.len()

  #lq.diagram(
    width: 8cm,
    height: 3.5cm,
    xlabel: [Sample],
    ylabel: [Defects\ per Unit],
    xaxis: (tick-args: (tick-distance: 5)),
    lq.plot(samples, u.slice(0, m), stroke: blue, mark: "o"),
    lq.plot(samples, ucl.slice(0, m), mark: none, stroke: red, label: $"UCL"_u$),
    lq.hlines(u_bar, label: $macron(u)$, stroke: green),
    lq.plot(samples, lcl.slice(0, m), mark: none, stroke: red, label: $"LCL"_u$),
  )
]
