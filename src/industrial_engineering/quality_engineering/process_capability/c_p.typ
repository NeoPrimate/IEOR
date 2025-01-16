#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== $C_p$ (Process Capability Index)

$
C_p = ("USL" - "LSL") / (6 sigma)
$

#figure(image("../../../vis/c_p.png", width: 80%))

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