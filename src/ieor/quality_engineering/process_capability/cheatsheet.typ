#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/distributions/gaussian.typ": gaussian_pdf

#table(
  columns: range(5).map(_ => auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Index*], [*Formula*], [*Variation\ Used*], [*Assumes\ Process\ Centering*], [*Measures*],
  ),
  [$C_p$], [
    $
      ("USL" - "LSL") / (6 sigma_"within")
    $
  ], [Short-term\ ($sigma_"within"$)], [Yes], [
    #text(size: 8pt)[
      Pure "noise" under stable conditions (same machine, same operator, same material, no maintenance events)
    ]
  ],
  [$C_(p k)$], [
    $
      min(("USL"- mu) / (3 sigma_"within"), (mu - "LSL") / (3 sigma_"within"))
    $
  ], [Short-term\ ($sigma_"within"$)], [No], [
    #text(size: 8pt)[
      Pure "noise" under stable conditions (same machine, same operator, same material, no maintenance events)
    ]
  ],
  [$P_p$], [
    $
      ("USL" - "LSL") / (6 sigma_"overall")
    $
  ], [Long-term\ ($sigma_"overall"$)], [Yes], [
    #text(size: 8pt)[
      Real-life variability from all causes (data across multiple shifts, operators, material batches, maintenance)
    ]
  ],
  [$P_(p k)$], [
    $
      min(("USL"- mu) / (3 sigma_"overall"), (mu - "LSL") / (3 sigma_"overall"))
    $
  ], [Long-term\ ($sigma_"overall"$)], [No], [
    #text(size: 8pt)[
      Real-life variability from all causes (data across multiple shifts, operators, material batches, maintenance)
    ]
  ],
  [$C_(p m)$], [
    $
      ("USL" - "LSL") / (6 sqrt(sigma_"within" + (mu - T)^2))
    $
  ], [
    #text(size: 8pt)[
      - Short-term\ ($sigma_"within"$)\
      - Deviation\ from target\ ($T$)
    ]
  ], [No], [
    #text(size: 8pt)[
      Penalizes deviation from target ($T$); reflects capability under stable conditions when target matters
    ]
  ],
)

#align(center)[
  #text(size: 16pt)[
    Centered v. Decentered Process
  ]
]

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
      x-min: -4, x-max: 6,
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

  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(
      axes: (
        x: (stroke: 1pt),
        y: (stroke: 0pt, tick: (label: (offset: 1em))),
        shared-zero: false
      )
    )

    let mu = 0
    let sigma = 1
    let lsl = -2
    let usl = 2
    let process_mean = 0

    let offset = 1.25

    plot.plot(
      size: (12,5),
      axis-style: "scientific",
      x-tick-step: none, 
      y-tick-step: none, 
      x-label: [],
      y-label: [],
      x-ticks: ((lsl, "LSL"), (process_mean + offset, $mu$), (usl, "USL")),
      x-min: -4, x-max: 6,
      y-min: 0, y-max: 0.5,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {
      plot.add(
        domain: (-4, 6),
        x => gaussian_pdf(x - offset, mu, sigma),
        style: (stroke: 1pt, fill: black),
      )

      plot.add-vline(usl, style: (stroke: (thickness: 1pt, paint: red)))
      plot.add-vline(process_mean + offset, style: (stroke: (thickness: 1pt, paint: black, dash: "dashed")))
      plot.add-vline(lsl, style: (stroke: (thickness: 1pt, paint: red)))

      plot.add-fill-between(
        domain: (usl, 6),
        x => gaussian_pdf(x - offset, mu, sigma),
        x => 0,
        style: (fill: blue.lighten(80%), stroke: none),
      )
      plot.add-fill-between(
        domain: (-4, lsl),
        x => gaussian_pdf(x - offset, mu, sigma),
        x => 0,
        style: (fill: blue.lighten(80%), stroke: none),
      )
    }
  )
  })
]