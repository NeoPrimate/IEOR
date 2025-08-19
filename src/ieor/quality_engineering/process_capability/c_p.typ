#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": *
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/distributions/gaussian.typ": gaussian_pdf

#import "@preview/suiji:0.3.0": *

== $C_p$ (Process Capability Index)

Measure how well a process can produce outputs within specified limits

$
C_p = ("USL" - "LSL") / (6 sigma)
$

*Assumption*: Process is *centered* within the specification limits

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(
      axes: (
        x: (stroke: 1pt),
        // tick: (stroke: 1pt),
        y: (stroke: 0pt, tick: (label: (offset: 1em))),
        // padding: 0pt,
        shared-zero: false
      )
    )

    let mu = 0
    let sigma = 1
    let lsl = -2
    let usl = 2
    let process_mean = 0

    plot.plot(
      size: (12,5),
      axis-style: "scientific",
      x-tick-step: none, 
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-ticks: ((lsl, "LSL"), (process_mean, $mu$), (usl, "USL")),
      x-min: -4, x-max: 4,
      y-min: 0, y-max: 0.5,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {
      plot.add(
        domain: (-4, 4),
        x => gaussian_pdf(x, mu, sigma),
        style: (stroke: 1pt, fill: black),
      )

      plot.add-vline(usl, style: (stroke: (thickness: 1pt, paint: red)))
      plot.add-vline(process_mean, style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")))
      plot.add-vline(lsl, style: (stroke: (thickness: 1pt, paint: red)))

      plot.add-fill-between(
        domain: (usl, 4),
        x => gaussian_pdf(x, mu, sigma),
        x => 0,
        style: (fill: blue.lighten(80%), stroke: none),
      )
      plot.add-fill-between(
        domain: (-4, lsl),
        x => gaussian_pdf(x, mu, sigma),
        x => 0,
        style: (fill: blue.lighten(80%), stroke: none),
      )
    }
  )
  })
]

#align(center)[
  #table(
    columns: 3,
    inset: 10pt,
    stroke: none,
    align: left,
    [*$C_p$ Value*], [*Meaning*], [*Quality Impact*],
    table.hline(),
    [$C_p < 1$], [Process variation\ exceeds specs], [Defects likely,\ even if centered],
    [$C_p = 1$], [Process barely\ fits within specs], [OK if perfectly\ centered],
    [$C_p gt 1$], [Process well\ within specs], [Robust,\ fewer defects],
    [$C_p = 2$], [Six Sigma level], [World-class\ performance],
    table.hline(),
  )
]

#eg[
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

  A manufacturing process produces metal rods with a target diameter of 10.0 mm. The specification limits are:
  - Target: #target mm
  - Lower Specification Limit (LSL): #lsl mm
  - Upper Specification Limit (USL): #usl mm
  - Specification Width (Tolerance): #calc.round(tolerance, digits: 3) mm

  Let's analyze three different processes with varying levels of capability.

  #align(center)[
    #table(
      columns: 5,
      inset: 10pt,
      stroke: none,
      align: center,
      [*Process*], [*Mean*], [*Std Dev*], [*$C_p$*], [*Assessment*],
      table.hline(),
      [Process 1], [#calc.round(stats1.mean, digits: 3)], [#calc.round(stats1.std_dev, digits: 3)], [#calc.round(stats1.cp, digits: 3)], [Good],
      [Process 2], [#calc.round(stats2.mean, digits: 3)], [#calc.round(stats2.std_dev, digits: 3)], [#calc.round(stats2.cp, digits: 3)], [Marginal],
      [Process 3], [#calc.round(stats3.mean, digits: 3)], [#calc.round(stats3.std_dev, digits: 3)], [#calc.round(stats3.cp, digits: 3)], [Poor],
      table.hline(),
    )
  ]
  
  #align(center)[
    #table(
      columns: 4,
      inset: 10pt,
      stroke: none,
      align: center,
      [*Process 1*], [*Process 2*], [*Process 3*], [*Six Sigma*],
      table.hline(),
      [
        $ 
          C_p 
          &= ("USL" - "LSL") / (6 sigma) \
          \
          &= (#usl - #lsl) / (6 times #calc.round(stats1.std_dev, digits: 3)) \ 
          \
          &= (#calc.round(tolerance, digits: 3)) / (#(calc.round(6 * stats1.std_dev, digits: 1))) \
          \
          &= #calc.round(stats1.cp, digits: 3)
        $
      ], 
      [
        $ 
          C_p 
          &= ("USL" - "LSL") / (6 sigma) \
          \
          &= (#usl - #lsl) / (6 times #calc.round(stats2.std_dev, digits: 3)) \ 
          \
          &= (#calc.round(tolerance, digits: 3)) / (#(calc.round(6 * stats2.std_dev, digits: 1))) \
          \
          &= #calc.round(stats2.cp, digits: 3)
        $
      ], 
      [
        $ 
          C_p 
          &= ("USL" - "LSL") / (6 sigma) \
          \
          &= (#usl - #lsl) / (6 times #calc.round(stats3.std_dev, digits: 3)) \ 
          \
          &= (#calc.round(tolerance, digits: 3)) / (#(calc.round(6 * stats3.std_dev, digits: 1))) \
          \
          &= #calc.round(stats3.cp, digits: 3)
        $
      ],
      [
        $ 
          C_p 
          &= ("USL" - "LSL") / (6 sigma) \
          \
          &= (#usl - #lsl) / (6 times 0.05) \ 
          \
          &= (#calc.round(tolerance, digits: 3)) / (0.30) \
          \
          &= 2
        $
      ],
      table.hline(),
    )
  ]


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
        let x-min = 9
        let x-max = 11

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
                rect((val + 0.02, 0), (val, freq), fill: green.lighten(40%), stroke: none)
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
                    rect((val + 0.05, 0), (val, freq), fill: orange.lighten(40%), stroke: none)
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
                    rect((val + 0.06, 0), (val, freq), fill: red.lighten(40%), stroke: none)
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

  *Step 3:* Interpretation

  #align(center)[
    #table(
      columns: 5,
      inset: 10pt,
      stroke: none,
      align: center,
      [*Process*], [*$C_p$*], [*Within Spec*], [*Defective*], [*DPMO*], 
      table.hline(),
      [Process 1], [#calc.round(stats1.cp, digits: 3)], [$96.64%$], [$3.36%$], [$33600$],
      [Process 2], [#calc.round(stats2.cp, digits: 3)], [$84.13%$], [$15.87%$], [$159700$],
      [Process 3], [#calc.round(stats3.cp, digits: 3)], [$50.00%$], [$50.00%$], [$500000$],
      [Six Sigma], [2.0], [$99.9999998%$], [$0.0000002%$], [$0.002$],
      table.hline(),
    )
  ]
  
  Higher $C_p$ means fewer defects and better process quality. and lower defects per million opportunities (DPMO)
]

#code(
  "c_p.py",
  ```py

  cp_values = [2, 1, 0.1]

  for cp in cp_values:
      z = 3 * cp  # spec limit in standard deviations
      prob_defective = 2 * (1 - norm.cdf(z))
      within_specs = 1 - prob_defective
      dpmo = prob_defective * 1_000_000

      print({
        "Cp": cp,
        "Sigma limit (±z)": z,
        "Percent within specs": within_specs * 100,
        "Percent defective": prob_defective * 100,
        "DPMO": dpmo
      })
  ```
)

#code_output(
  ```py
  [{'Cp': 2,
    'Sigma limit (±z)': 6,
    'Percent within specs': 99.99999980268245,
    'Percent defective': 1.9731754008489588e-07,
    'DPMO': 0.001973175400848959},
  {'Cp': 1,
    'Sigma limit (±z)': 3,
    'Percent within specs': 99.73002039367398,
    'Percent defective': 0.2699796063260207,
    'DPMO': 2699.796063260207},
  {'Cp': 0.1,
    'Sigma limit (±z)': 0.30000000000000004,
    'Percent within specs': 23.582284437790534,
    'Percent defective': 76.41771556220947,
    'DPMO': 764177.1556220946}]
    ```
)