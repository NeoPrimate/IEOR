#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/result.typ": result
#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0": plot, chart
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



#figure(image("../../../vis/c_p.png", width: 80%))

#let mu = 10.0
#let sigma = 0.05

#let usl = 10.2
#let lsl = 9.8

#let rng = gen-rng(42)

#let (_, c) = normal(rng, loc: mu, scale: sigma, size: 1000)

// #c

// #let data2 = (
//   ([15-25], 18.0, 20.1, 23.0, 17.0),
//   ([25-29], 16.3, 17.6, 19.4, 15.3),
//   ([30-34], 14.0, 15.3, 13.9, 18.7),
//   ([35-44], 35.5, 26.5, 29.4, 25.8),
//   ([45-54], 25.0, 20.6, 22.4, 22.0),
//   ([55+],   19.9, 18.2, 19.2, 16.4),
// )

// #canvas({
//   draw.set-style(legend: (fill: white))
//   chart.barchart(
//                  size: (9, auto),
//                  label-key: 0,
//                  value-key: (..range(1, 5)),
//                  bar-width: .8,
//                  x-tick-step: 2.5,
//                  data2,
//                  labels: ([Low], [Medium], [High], [Very high]),
//                  legend: "inner-north-east",)
// })


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