#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== $P_p$ (Process Performance Index)

$
P_p = ("USL" - "LSL") / (6 sigma_"overall")
$

#figure(image("../../../vis/p_p.png", width: 80%))

#eg[

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

