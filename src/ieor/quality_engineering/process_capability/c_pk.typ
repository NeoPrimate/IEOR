#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

#import "@preview/suiji:0.3.0": *


== $C_(p k)$ (Process Capability Index with Centering)

Minimum distance from mean to nearest spec limit divided by 3 standard deviations. Process capability considering centering and variation.

If process is centered:

$
  C_(p k) = C_p = ("USL" - "LSL") / (6 sigma)
$

If process mean is off center, the smaller side of the process-to-limit ratio determines $C_(p k)$:

$
C_(p k) = "Min" (("USL" - overline(x)) / (3 sigma), (overline(x) - "LSL") / (3 sigma))
$

If $C_(p k) lt C_p$, process is not centered

#align(center)[
  #table(
    columns: 3,
    inset: 10pt,
    stroke: none,
    align: left,
    [*$C_{p k}$ Value*], [*Meaning*], [*Quality Impact*],
    table.hline(),
    [$C_{p k} < 1$], [Process not capable,\ output falls outside specs], [Many defects,\ poor performance],
    [$C_{p k} = 1$], [Process just meets\ specification limits], [Acceptable only\ if well centered],
    [$C_{p k} > 1$], [Process is capable,\ centered or nearly so], [Fewer defects,\ reliable quality],
    [$C_{p k} = 2$], [Excellent capability,\ Six Sigma level], [Near-perfect\ quality],
    table.hline(),
  )
]


#eg[
#let target = 10
#let lsl = 9.8
#let usl = 10.2
#let tolerance = usl - lsl

#let n_samples = 1000

#let (rng1, process1) = normal(gen-rng(10), loc: 10.0, scale: 0.075, size: n_samples)
#let (rng1, process2) = normal(gen-rng(10), loc: 10.2, scale: 0.075, size: n_samples)

#let calc_mean_std(data) = {
  let mean = data.sum() / data.len()
  let variance = data.map(x => calc.pow(x - mean, 2)).sum() / (data.len() - 1)
  let std = calc.sqrt(variance)
  (mean: mean, std: std)
}

#let calc_cp(data) = {
  let mean = data.sum() / data.len()
  let variance = data.map(x => calc.pow(x - mean, 2)).sum() / (data.len() - 1)
  let std_dev = calc.sqrt(variance)
  let cp = tolerance / (6 * std_dev)
  cp
}

#let calc_cpk(data) = {
  let mean = data.sum() / data.len()
  let variance = data.map(x => calc.pow(x - mean, 2)).sum() / (data.len() - 1)
  let std = calc.sqrt(variance)
  
  let lhs = (usl - mean) / (3 * std)
  let rhs = (mean - lsl) / (3 * std)

  calc.min(lhs, rhs)
}

#let cp_process1 = calc_cp(process1)
#let cpk_process1 = calc_cpk(process1)

#let cp_process2 = calc_cp(process2)
#let cpk_process2 = calc_cpk(process2)

#align(center)[
    #cetz.canvas(
      length: 72pt,
      {
        import cetz.draw: *
        import cetz-plot: *

        set-style(
          axes: (
            x: (stroke: 0pt),
            tick: (stroke: 0pt),
            y: (stroke: 0pt, tick: (label: (offset: 1em))),
            padding: 0pt,
            shared-zero: false
          )
        )

        let bins = 30
        let x-min = 9.5
        let x-max = 10.6

        let create_histogram(data, bins: 20) = {
          let min_val = data.fold(data.first(), calc.min)
          let max_val = data.fold(data.first(), calc.max)
          let bin_width = (max_val - min_val) / bins
          
          let hist = range(bins).map(i => 0)
          
          
          for val in data {
            let bin_idx = calc.min(bins - 1, calc.floor((val - min_val) / bin_width))
            hist.at(bin_idx) += 1
          }
          
          let max_count = hist.fold(0, calc.max)
          let scale_factor = 2.0 / max_count

          let bin_centers = range(bins).map(i => min_val + (i + 0.5) * bin_width)

          
          bin_centers.zip(hist)
        }

        plot.plot(
          name: "g1",
          size: (4, 2),
          x-min: x-min,
          x-max: x-max,
          x-tick-step: none,
          y-tick-step: none, 
          x-label: [],
          y-label: [$C_p = C_(p k)$],
          asix-style: "scientific",
          {
            plot.add(domain: (0, 0), x => 0)
            let hist = create_histogram(process1, bins: bins)

            for (val, freq) in hist {
              plot.annotate({
                rect((val + 0.02, 0), (val, freq), fill: green.lighten(40%), stroke: none)
              })
            }
            
            plot.add-anchor("lsl_t", (lsl, 89))
            plot.add-anchor("usl_t", (usl, 89))
            
          },
        )

        group(
          name: "g2",
          {
            set-origin((0, -2.1))
            plot.plot(
              name: "plot",
              x: 4,
              y: 4,
              x-min: x-min,
              x-max: x-max,
              x-ticks: (lsl, target, usl),
              x-label: [],
              y-label: [$C_p > C_(p k)$],
              x-tick-step: none,
              y-tick-step: none, 
              size: (4, 2),
              asix-style: "scientific",
              {

                plot.add(domain: (0, 0), x => 0)
                let hist = create_histogram(process2, bins: bins)

                for (val, freq) in hist {
                  plot.annotate({
                    rect((val + 0.02, 0), (val, freq), fill: red.lighten(40%), stroke: none)
                  })
                }

                plot.add-anchor("lsl_b", (lsl, 0))
                plot.add-anchor("usl_b", (usl, 0))
              },
            )
          },
        )

        line("g1.lsl_t", "g2.plot.lsl_b", stroke: (dash: "dashed", paint: black, thickness: 2pt))
    
        line("g1.usl_t", "g2.plot.usl_b", stroke: (dash: "dashed", paint: black, thickness: 2pt))
      },
    )
  ]

Suppose a company manufactures metal rods, and the specification limits for the diameter of the rods are:

- Target: #target mm
- Lower Specification Limit (*LSL*): #lsl mm
- Upper Specification Limit (*USL*): #usl mm

The process has: 
- A standard deviation *$sigma$* of 0.05 mm.
- A process mean *$mu$* of 10.1 mm.

*Step 1*: Calculate the distance from the mean to the USL:

$ ("USL" - mu) / (3 sigma) = (10.2 "mm" - 10.1 "mm") / (3 times 0.05 "mm") = (0.1 "mm") / (0.15 "mm") = 0.67 $

*Step 2*: Calculate the distance from the mean to the LSL:

$ (mu - "LSL") / (3 sigma) = (10.1 "mm" - 9.8 "mm") / (3 times 0.05 "mm") = (0.3 "mm") / (0.15 "mm") = 2.00 $

*Step 3*: Determine $C_(p k)$:

$ C_(p k) = min(0.67, 2.00) = 0.67 $

Interpretation:

$C_p$ = 1.33 means the process spread (6 $sigma$) fits 1.33 times within the tolerance range (the distance between the Upper Specification Limit and Lower Specification Limit.

- $C_p$ = 1.00: Process mean is exactly at the midpoint of the specification limits, and the process variation fits exactly within these limits. 99.73% of the output will be within specifications, indicating a capable process (3 sigma process).
- $C_p > 1.00$: The higher the $C_(p k)$, the more capable and stable the process is, meaning it can consistently produce parts within tolerance with minimal risk of defects.
- $C_p < 1$: The process mean is off-center or the variation is wider than the specification limits, or both. A significant portion of the output may fall outside the specification limits.
]

