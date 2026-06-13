#import "/lib/imports.typ": *
#show: formatting

The Extreme Value Theorem states that if a function $f(x)$ is continuous on a closed interval $[a,b]$, then $f(x)$ must attain both a maximum and a minimum value within that interval. This means there exist points $c, d in [a, b]$ such that:

$
  f(c) gt.eq f(x) quad "and" quad f(d) lt.eq f(x) quad "for all" quad x in [a, b]
$

1. *Continuity*: The function must be continuous on $[a, b]$. Discontinuities (jumps, asymptotes, holes) can prevent the function from attaining an extreme value

#example[
  #let c = 3
  #let f(x) = -x * x + c

  #align(center)[
    #let xs = lq.linspace(-4, 4, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (-4, 4),
      ylim: (-4, 4),
      xaxis: (tick-args: (tick-distance: 2)),
      yaxis: (tick-args: (tick-distance: 2)),
      lq.plot(xs, f, mark: none, stroke: black),
      lq.plot((0,), (c,), mark: "o", stroke: black, mark-color: white),
    )
  ]
]

2. *Closed Interval*: If the function is defined on an open interval $(a,b)$, an extremum may not exist

#example[
  $f(x)=1/x$on $(0,1]$ has no maximum because it keeps increasing as $x arrow 0$.

  #let f(x) = 1 / x

  #align(center)[
    #let xs = lq.linspace(0.001, 1, num: 200)
    #lq.diagram(
      width: 5cm,
      height: 5cm,
      xlim: (0, 1),
      ylim: (0, 100),
      xaxis: (tick-args: (tick-distance: 1)),
      yaxis: (tick-args: (tick-distance: 50)),
      lq.plot(xs, f, mark: none, stroke: black),
    )
  ]
]
