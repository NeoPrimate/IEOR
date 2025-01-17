#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== $C_(p k)$ (Process Capability Index with Centering)

$
C_(p k) = "Min" (("USL" - overline(x)) / (3 sigma), (overline(x) - "USL") / (3 sigma))
$

#figure(image("../../../vis/c_pk.png", width: 80%))

#eg[
Suppose a company manufactures metal rods, and the specification limits for the diameter of the rods are:

- Upper Specification Limit (*USL*): 10.2 mm
- Lower Specification Limit (*LSL*): 9.8 mm

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

