#import "/lib/imports.typ": *
#show: formatting

#let f(x) = 0.1 * (x * x * x) + 0.5

#align(center)[
  #let xs = lq.linspace(-3, 3, num: 200)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (-3.2, 3.2),
    ylim: (-3.2, 3.2),
    xaxis: (position: 0, tip: tiptoe.triangle, filter: (value, distance) => value != 0, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.plot(xs, f, mark: none, stroke: black),
    lq.vlines(-3, min: f(-3), max: 0, stroke: (paint: black, dash: "dotted")),
    lq.hlines(f(-3), min: -3, max: 0, stroke: (paint: black, dash: "dotted")),
    lq.vlines(3, min: 0, max: f(3), stroke: (paint: black, dash: "dotted")),
    lq.hlines(f(3), min: 0, max: 3, stroke: (paint: black, dash: "dotted")),
    lq.hlines(f(1.1), min: 1.1, max: 1.1 + 1, stroke: black),
    lq.vlines(1.1 + 1, min: f(1.1), max: f(1.1 + 1), stroke: black),
    lq.plot((-3,), (f(-3),), mark: "o", stroke: none, mark-color: black),
    lq.plot((3,), (f(3),), mark: "o", stroke: none, mark-color: black),
    lq.place(-3, 0.3, [$a$]),
    lq.place(0.3, f(-3), [$c$]),
    lq.place(3, -0.3, [$b$]),
    lq.place(-0.3, f(3), [$d$]),
    lq.place(1.6, 0.39, [$d x$]),
    lq.place(2.4, 1, [$d y$]),
    lq.place(1.4, 1.3, [$d s$]),
  )
]

$
  d s = sqrt((d x)^2 + (d y)^2)
$

$
  s = integral d s = integral sqrt((d x)^2 + (d y)^2)
$

$
  integral^b_a sqrt(1 + ((d y) / (d x))^2) quad d x
$

$
  integral^d_c sqrt(((d y) / (d x))^2 + 1) quad d y
$
