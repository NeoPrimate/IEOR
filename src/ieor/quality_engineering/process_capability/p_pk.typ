#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/distributions/gaussian.typ": gaussian_pdf

#import "@preview/suiji:0.3.0": *

== $P_(p k)$ (Process Performance Index with Centering)

$
P_(p k) = "Min" (("USL" - mu_"overall") / (3 sigma), (mu_"overall" - "USL") / (3 sigma))
$

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

    let mu = 1
    let sigma = 1
    let lsl = -2
    let usl = 2
    let process_mean = mu

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

#eg[

Suppose a company manufactures metal rods, and the specification limits for the diameter of the rods are:

- Upper Specification Limit (*USL*): 10.2 mm
- Lower Specification Limit (*LSL*): 9.8 mm
- Overall standard deviation ($sigma_"overall"$): 0.06 mm
- Overall process mean ($mu_"overall"$): 10.1 mm

*Step 1*: Calculate the Distance from the Process Mean to the Specification Limits

Calculate the distance from the overall process mean to both the USL and LSL:

$ "USL" - mu_"overall" = 10.2 "mm" - 10.1 "mm" = 0.1 "mm" $
$ mu_"overall" - "LSL"  = 10.1 "mm" - 9.8 "mm" = 0.3 "mm" $

*Step 2*: Calculate the Process Performance Index $P_k$

The formula for $P_(p k)$ is:

$
P_(p k) = "Min" (("USL" - mu_"overall") / (3 sigma), (mu_"overall" - "USL") / (3 sigma))
$

Substitute the values:

$
P_(p k) = "Min" ((0.1 "mm") / (3 times 0.06 "mm"), (0.3 "mm") / (3 times 0.06 "mm"))
$

$
P_(p k) = "Min" ((0.1 "mm") / (0.18 "mm"), (0.3 "mm") / (0.18 "mm"))
$

$
P_(p k) = min(0.56, 1.67) = 0.56
$

Interpretation:

- A $P_p$ of 1.11 indicates that the process performance, considering all sources of variation over time, is capable but less so than the potential capability indicated by $C_p$. The value being slightly above 1 suggests that the process can generally produce rods within specifications, but there might be more variability in the process compared to the short-term capability measured by $C_p$
- Decrease from the $C_p$ value (1.33 to 1.11) reflects the impact of additional variability when evaluating the process over a longer time or under different conditions.

Use:

When you need to evaluate the *actual performance* of a process over a longer period, considering all sources of variation, including shifts, drifts, and other long-term factors.

]
