#import "/lib/imports.typ": *
#show: formatting

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
  #let mu = 0
  #let sigma = 1
  #let lsl = -2
  #let usl = 2
  #let process_mean = 0

  #let xs = lq.linspace(-4, 6, num: 200)
  #let xs_hi = lq.linspace(usl, 4, num: 200)
  #let xs_lo = lq.linspace(-4, lsl, num: 200)

  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 6),
    ylim: (0, 0.5),
    yaxis: (ticks: none),
    xaxis: (ticks: ((lsl, [LSL]), (process_mean, $mu$), (usl, [USL]))),
    lq.fill-between(
      xs_hi,
      xs_hi.map(x => norm.pdf(x, mean: mu, std_dev: sigma)),
      y2: xs_hi.map(x => 0),
      fill: blue.lighten(80%),
      stroke: none,
    ),
    lq.fill-between(
      xs_lo,
      xs_lo.map(x => norm.pdf(x, mean: mu, std_dev: sigma)),
      y2: xs_lo.map(x => 0),
      fill: blue.lighten(80%),
      stroke: none,
    ),
    lq.plot(xs, x => norm.pdf(x, mean: mu, std_dev: sigma), mark: none, stroke: black),
    lq.vlines(usl, stroke: (paint: red, thickness: 1pt)),
    lq.vlines(process_mean, stroke: (paint: black, thickness: 1pt, dash: "dashed")),
    lq.vlines(lsl, stroke: (paint: red, thickness: 1pt)),
  )

  #let offset = 1.25
  #let xs2 = lq.linspace(-4, 6, num: 200)
  #let xs2_hi = lq.linspace(usl, 6, num: 200)
  #let xs2_lo = lq.linspace(-4, lsl, num: 200)

  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 6),
    ylim: (0, 0.5),
    yaxis: (ticks: none),
    xaxis: (ticks: ((lsl, [LSL]), (process_mean + offset, $mu$), (usl, [USL]))),
    lq.fill-between(
      xs2_hi,
      xs2_hi.map(x => norm.pdf(x - offset, mean: mu, std_dev: sigma)),
      y2: xs2_hi.map(x => 0),
      fill: blue.lighten(80%),
      stroke: none,
    ),
    lq.fill-between(
      xs2_lo,
      xs2_lo.map(x => norm.pdf(x - offset, mean: mu, std_dev: sigma)),
      y2: xs2_lo.map(x => 0),
      fill: blue.lighten(80%),
      stroke: none,
    ),
    lq.plot(xs2, x => norm.pdf(x - offset, mean: mu, std_dev: sigma), mark: none, stroke: black),
    lq.vlines(usl, stroke: (paint: red, thickness: 1pt)),
    lq.vlines(process_mean + offset, stroke: (paint: black, thickness: 1pt, dash: "dashed")),
    lq.vlines(lsl, stroke: (paint: red, thickness: 1pt)),
  )
]