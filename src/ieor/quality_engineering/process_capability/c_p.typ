#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

#import "@preview/suiji:0.3.0": *

== $C_p$ (Process Capability Index)

Measure how well a process can produce outputs within specified limits

$
C_p = ("USL" - "LSL") / (6 sigma)
$

- $C_p > 1$: The process variation is smaller than the specification range (good capability).
- $C_p = 1$: The process variation matches the specification range (barely acceptable).
- $C_p < 1$: The process variation exceeds the specification range (poor capability).

*Assumption*: Process is *centered* within the specification limits

#eg[

  A manufacturing process produces metal rods with a target diameter of 10.0 mm. The specification limits are:
  - Lower Specification Limit (LSL): 9.7 mm
  - Upper Specification Limit (USL): 10.3 mm

  Let's analyze three different processes with varying levels of capability.

  #let n_samples = 1000

  // Process 1: Good capability (Cp ≈ 1.5)
  #let (rng1, process1) = normal(gen-rng(10), loc: 10.0, scale: 0.1, size: n_samples)

  // Process 2: Marginal capability (Cp ≈ 1.0)  
  #let (rng2, process2) = normal(gen-rng(20), loc: 10.0, scale: 0.15, size: n_samples)

  // Process 3: Poor capability (Cp ≈ 0.67)
  #let (rng3, process3) = normal(gen-rng(30), loc: 10.0, scale: 0.25, size: n_samples)

  #let target = 10
  #let lsl = 9.7
  #let usl = 10.3
  #let tolerance = usl - lsl

  #let calc_cp(data) = {
    let mean = data.sum() / data.len()
    let variance = data.map(x => calc.pow(x - mean, 2)).sum() / (data.len() - 1)
    let std_dev = calc.sqrt(variance)
    let cp = tolerance / (6 * std_dev)
    (mean: mean, std_dev: std_dev, cp: cp)
  }

  #let stats1 = calc_cp(process1)
  #let stats2 = calc_cp(process2)  
  #let stats3 = calc_cp(process3)

  #align(center)[
    #table(
      columns: 5,
      inset: 10pt,
      stroke: none,
      align: center,
      [*Process*], [*Mean*], [*Std Dev*], [*$C_p$*], [*Assessment*],
      table.hline(),
      [Process 1], [#calc.round(stats1.mean, digits: 3)], [#calc.round(stats1.std_dev, digits: 3)], [#calc.round(stats1.cp, digits: 2)], [Good],
      [Process 2], [#calc.round(stats2.mean, digits: 3)], [#calc.round(stats2.std_dev, digits: 3)], [#calc.round(stats2.cp, digits: 2)], [Marginal],
      [Process 3], [#calc.round(stats3.mean, digits: 3)], [#calc.round(stats3.std_dev, digits: 3)], [#calc.round(stats3.cp, digits: 2)], [Poor],
      table.hline(),
    )
  ]

  #let create_histogram(data, bins: 20) = {
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

  #align(center)[
    #cetz.canvas(
      length: 64pt,
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
        let x-min = 9
        let x-max = 11

        plot.plot(
          name: "g1",
          x: 4,
          y: 4,
          size: (4, 2),
          x-min: x-min,
          x-max: x-max,
          x-tick-step: none,
          y-tick-step: none, 
          x-label: [],
          y-label: [],
          asix-style: "scientific",
          {
            plot.add(domain: (0, 0), x => 0)
            let hist = create_histogram(process1, bins: bins)

            for (val, freq) in hist {
              plot.annotate({
                rect((val + 0.02, 0), (val, freq), fill: green.lighten(75%), stroke: green)
              })
            }

            plot.add-anchor("lsl_t", (lsl, calc.max(..hist.map(k_v => k_v.at(1)))))
            plot.add-anchor("target_t", (target, calc.max(..hist.map(k_v => k_v.at(1)))))
            plot.add-anchor("usl_t", (usl, calc.max(..hist.map(k_v => k_v.at(1)))))
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
              x-label: [],
              y-label: align(center)[Frequency],
              x-tick-step: none,
              y-tick-step: none, 
              size: (4, 2),
              asix-style: "scientific",
              {

                plot.add(domain: (0, 0), x => 0)
                let hist = create_histogram(process2, bins: bins)

                for (val, freq) in hist {
                  plot.annotate({
                    rect((val + 0.03, 0), (val, freq), fill: orange.lighten(75%), stroke: orange)
                  })
                }
              },
            )
          },
        )
        
        group(
          name: "g3",
          {
            set-origin((0, -4.2))
            plot.plot(
              name: "plot",
              x: 4,
              y: 4,
              x-min: x-min,
              x-max: x-max,
              x-label: align(center)[Diameter\ (mm)],
              y-label: [],
              x-tick-step: none,
              y-tick-step: none, 
              x-ticks: (lsl, target, usl),
              size: (4, 2),
              asix-style: "scientific",
              {

                plot.add(domain: (0, 0), x => 0)
                let hist = create_histogram(process3, bins: bins)

                for (val, freq) in hist {
                  plot.annotate({
                    rect((val + 0.05, 0), (val, freq), fill: red.lighten(75%), stroke: red)
                  })
                }


                plot.add-anchor("lsl_b", (lsl, 0))
                plot.add-anchor("target_b", (target, 0))
                plot.add-anchor("usl_b", (usl, 0))
              },
            )
          },
        )

        line("g1.lsl_t", "g3.plot.lsl_b", stroke: (dash: "dashed"))
        line("g1.target_t", "g3.plot.target_b", stroke: (dash: "dashed"))
        line("g1.usl_t", "g3.plot.usl_b", stroke: (dash: "dashed"))
      },
    )
  ]
]

#eg[
  Suppose a company manufactures metal rods, and the specification limits for the diameter of the rods are:

  - Upper Specification Limit (*USL*): 10.2 mm
  - Lower Specification Limit (*LSL*): 9.8 mm

  The process has a standard deviation *$sigma$* of 0.05 mm.

  *Step 1*: Determine the Specification Width

  The specification width is the difference between the USL and LSL.

  $ "Specification Width" = "USL" - "LSL" = 10.2 "mm" - 9.8 "mm" $

  *Step 2*: Calculate the Process Capability Index $C_p$

  The formula for $C_p$ is:

  $ C_p = "Specification Width" / (6 sigma) = ("USL" - "LSL") / (6 sigma) $

  Substitute the values:

  $ C_p = (0.4 "mm") / (6 times 0.05 "mm") = (0.4 "mm") / (0.3 "mm") = 1.33 $

  Interpretation:

  $C_p$ = 1.33 means the process spread (6 $sigma$) fits 1.33 times within the tolerance range (the distance between the Upper Specification Limit and Lower Specification Limit.

  - $C_p$ = 1.00: Process variation fits exactly within the specification limits. 99.73% of the output will be within specifications *if the process is centered* (3 sigma process).
  - $C_p > 1.00$: Process variation is narrower than the specification limits. The higher the $C_p$, the more capable the process is, meaning it can produce parts within the tolerance more consistently.
  - $C_p < 1$: Process variation is wider than the specification limits. Significant portion of the output will fall outside the specification limits.

  Limitations:

  Since *$C_p$ does not account for the centering of the process*, it may give a false sense of security if the process mean is off-center (*see $C_(p k)$*).

  Use:

  When you are interested in understanding the *potential capability* of a process under ideal conditions, typically in a short-term study where the process is stable and controlled.
]