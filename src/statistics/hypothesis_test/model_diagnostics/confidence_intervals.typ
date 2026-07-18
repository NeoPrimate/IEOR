#import "/lib/imports.typ": *
#show: formatting

Range within which we can be confident that the true value (population parameter) lies, based on the sample data

1. Known population standard deviation ($sigma$):

$
C I = macron(x) plus.minus z sigma / sqrt(n)
$

Where:
- $macron(x)$: sample mean
- $z$: z-score corresponding to the desired confidence level
- $sigma$: population standard deviation
- $n$: sample size

2. Unknown population standard deviation ($sigma$):

$
C I = macron(x) plus.minus t s / sqrt(n)
$

Where:
- $macron(x)$: sample mean
- $t$: critical value from t-distribution
- $s$: sample standard deviation
- $n$: sample size

// #let n_samples   = 20
// #let sample_size = 20
// #let mu    = 10.0
// #let sigma = 5.0
// #let zcrit = 1.96                       // 95% interval (use a t value for small n)

// #let samples = range(n_samples).map(i => {
//   let data = tystats.norm.rvs(mean: mu, std_dev: sigma, size: sample_size, seed: float(i))
//   let m        = data.sum() / data.len()
//   let variance = data.map(x => calc.pow(x - m, 2)).sum() / (data.len() - 1)
//   let half     = zcrit * calc.sqrt(variance) / calc.sqrt(data.len())   // z * SE
//   (data: data, mean: m, half: half, hit: (m - half <= mu and mu <= m + half))
// })

// #let xs-all = samples.map(s => s.data).flatten()
// #let xmin = calc.min(mu - 4 * sigma, ..xs-all)
// #let xmax = calc.max(mu + 4 * sigma, ..xs-all)
// #let xpad = (xmax - xmin) * 0.03
// #let xlim = (xmin - xpad, xmax + xpad)

// #let W = 12cm
// #let mu-line  = lq.line((mu, 0%), (mu, 100%), stroke: (paint: black, dash: "dashed"))
// #let no-marks = (stroke: none)          // hides tick dashes via tick-args

// #stack(
//   // ===== sampling distribution ==========================================
//   {
//     let gx = lq.linspace(xlim.at(0), xlim.at(1), num: 300)
//     lq.diagram(
//       width: W, height: 2.6cm,
//       xlim: xlim, margin: 0%, grid: none,
//       // a hidden 2-char label reserves the SAME left gutter as the row numbers
//       yaxis: (
//         stroke: none, tick-args: no-marks,
//         ticks: (0,), format-ticks: (t, ..a) => t.map(_ => hide[20]),
//       ),
//       xaxis: (ticks: none),
//       lq.plot(gx, tystats.norm.pdf(gx, mean: mu, std_dev: sigma), mark: none, stroke: black),
//       mu-line,
//       lq.place(mu, 0%, align: top, pad(bottom: 3pt, text(size: 1.1em, $mu$))),
//     )
//   },
//   // ===== the 20 intervals ===============================================
//   {
//     let dots = samples.enumerate().map(((i, s)) => lq.plot(
//       s.data, s.data.map(_ => i + 1),
//       stroke: none, color: luma(60%), mark: "o", mark-size: 2.2pt,
//     ))
//     let cis = samples.enumerate().map(((i, s)) => {
//       let c = if s.hit { blue } else { red }
//       lq.plot(
//         (s.mean,), (i + 1,), xerr: (s.half,),
//         stroke: c + 1.4pt, color: c, mark: "d", mark-size: 6pt,
//       )
//     })
//     lq.diagram(
//       width: W, height: 12cm,
//       xlim: xlim, ylim: (0.5, n_samples + 0.5), margin: 0%,
//       yaxis: (
//         inverted: true, stroke: none, tick-args: no-marks,
//         ticks: range(1, n_samples + 1),
//       ),
//       xaxis: (ticks: none, stroke: none),
//       mu-line, ..dots, ..cis,
//     )
//   },
// )