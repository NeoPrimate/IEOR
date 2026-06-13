#import "/lib/imports.typ": *
#show: formatting

$
  accent(v, arrow) = vec(x_1, dots.v, x_n)
$

#lq.diagram(
  width: 5cm,
  height: 5cm,
  xlim: (-3, 3),
  ylim: (-3, 3),
  yaxis: (
    position: 0,
    // ticks: 1,
    tick-args: (tick-distance: 2),
    tip: tiptoe.triangle,
    // filter: no-zero,
    subticks: none,
  ),
  xaxis: (
    position: 0,
    tick-args: (tick-distance: 2),
    tip: tiptoe.triangle,
    filter: (value, distance) => value != 0,
    subticks: none,
  ),
  lq.line(
    (0, 0), (2, 2),
    tip: tiptoe.triangle,
    stroke: blue + 1.5pt,
  ),
)
