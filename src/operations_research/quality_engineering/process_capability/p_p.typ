#import "/lib/imports.typ": *
#show: formatting

== $P_p$ (Process Performance Index)

$
  P_p = ("USL" - "LSL") / (6 sigma_"overall")
$

#align(center)[
  #let mu = 0
  #let sigma = 1
  #let lsl = -3
  #let usl = 1
  #let process_mean = 0

  #let xs = lq.linspace(-4, 4, num: 200)
  #let xs_tail = lq.linspace(usl, 4, num: 200)

  #lq.diagram(
    width: 6cm,
    height: 3cm,
    xlim: (-4, 4),
    ylim: (0, 0.5),
    yaxis: (ticks: none),
    xaxis: (ticks: ((lsl, [LSL]), (process_mean, $mu$), (usl, [USL]))),
    lq.fill-between(
      xs_tail,
      xs_tail.map(x => norm.pdf(x, mean: mu, std_dev: sigma)),
      y2: xs_tail.map(x => 0),
      fill: blue.lighten(80%),
      stroke: none,
    ),
    lq.plot(xs, x => norm.pdf(x, mean: mu, std_dev: sigma), mark: none, stroke: black),
    lq.vlines(usl, stroke: (paint: red, thickness: 1pt)),
    lq.vlines(process_mean, stroke: (paint: black, thickness: 1pt, dash: "dashed")),
    lq.vlines(lsl, stroke: (paint: red, thickness: 1pt)),
  )
]

#example[

  Suppose a company manufactures metal rods, and the specification limits for the diameter of the rods are:

  - Upper Specification Limit (*USL*): 10.2 mm
  - Lower Specification Limit (*LSL*): 9.8 mm
  - Overall standard deviation ($sigma_"overall"$): 0.06 mm

  *Step 1*: Determine the Specification Width

  The specification width is the difference between the USL and LSL.

  $ "Specification Width" = "USL" - "LSL" = 10.2 "mm" - 9.8 "mm" = 0.4 $

  *Step 2*: Calculate the Process Performance Index $P_p$

  The formula for $P_p$ is:



  $ P_p = "Specification Width" / (6 sigma_"overall") = ("USL" - "LSL") / (6 sigma_"overall") $

  Substitute the values:

  $ P_p = (0.4 "mm") / (6 times 0.06 "mm") = (0.4 "mm") / (0.36 "mm") = 1.11 $

  Interpretation:

  - A $P_p$ of 1.11 indicates that the process performance, considering all sources of variation over time, is capable but less so than the potential capability indicated by $C_p$. The value being slightly above 1 suggests that the process can generally produce rods within specifications, but there might be more variability in the process compared to the short-term capability measured by $C_p$
  - Decrease from the $C_p$ value (1.33 to 1.11) reflects the impact of additional variability when evaluating the process over a longer time or under different conditions.

  Use:

  When you need to evaluate the *actual performance* of a process over a longer period, considering all sources of variation, including shifts, drifts, and other long-term factors.

]
