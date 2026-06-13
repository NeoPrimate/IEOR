#import "/lib/imports.typ": *
#show: formatting

== Log

#let x = lq.linspace(0.001, 10, num: 1000)

#lq.diagram(
  lq.plot(x, x => calc.log(x, base: 2), mark: none)
)

A logarithm turns multiplication into addition. 

$
  log(a · b) = log(a) + log(b)
$


== Ln

#lq.diagram(
  lq.plot(x, x => calc.ln(x), mark: none)
)


