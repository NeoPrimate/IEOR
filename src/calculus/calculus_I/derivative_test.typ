#import "/lib/imports.typ": *
#show: formatting

Find critical points by solving $f'(x) = 0$

#align(center)[
  #table(
    columns: (auto, auto, auto, auto),
    align: horizon,
    inset: 10pt,
    table.cell(
      rowspan: 2,
      [$1^"st"$ Derivative],
    ),
    [$+ arrow.long -$], [Local Max], [Concave Down],
    [$- arrow.long +$], [Local Min], [Concave Up],
    table.cell(
      rowspan: 2,
      [$2^"nd"$ Derivative],
    ),
    [$f''(c) < 0$], [Local Max], [Concave Down],
    [$f''(c) > 0$], [Local Min], [Concave Up],
  )
]

=== First Derivative Test

If $f'(x)$ changes sign around a critical point $c$, we can determine if $f(c)$ is a local maximum or minimum:

- If $f'(x)$ changes from *positive to negative* at $c$, then $f(c)$ is a *local maximum*

- If $f'(x)$ changes from *negative to positive* at $c$, then $f(c)$ is a *local minimum*

- If $f'(x)$does *not* change sign, $f(c)$ is *not* a local extremum

#example[
  If $f'(x)$ changes from *negative to positive* at $c$, then $f(c)$ is a *local minimum*

  Suppose:
  $
    f(x) = x^2, quad quad f'(x) = 2x
  $

  *Step 1.* Find critical point

  Solve $f'(x) = 0$:

  $
    2x = 0 quad arrow.double.long quad x = 0
  $

  So, $x = 0$ is the only critical point

  *Step 2.* Test sign of $f'(x)$ around $x = 0$

  - *Left*: $x = -1$

  $
    f'(-1) = 2(-1) = -2 lt 0 quad arrow.long.double quad f "is" bold("decreasing")
  $

  - *Right*: $x = 1$:

  $
    f'(1) = 2(1) = 2 gt 0 quad arrow.long.double quad f "is" bold("increasing")
  $

  #align(center)[
    #grid(
      columns: (1fr, 1fr),
      [
        #let xs = lq.linspace(-1.5, 1.5, num: 200)
        #lq.diagram(
          width: 4cm,
          height: 4cm,
          xlim: (-1.5, 1.5),
          ylim: (-0.5, 1.5),
          xaxis: (ticks: none),
          yaxis: (tick-args: (tick-distance: 1)),
          lq.plot(xs, x => calc.pow(x, 2), mark: none, stroke: black),
          lq.hlines(0, stroke: black),
          lq.plot((0,), (0,), mark: "o", stroke: none, mark-color: black),
        )
      ],
      [
        #let xs = lq.linspace(-1.5, 1.5, num: 200)
        #lq.diagram(
          width: 4cm,
          height: 4cm,
          xlim: (-1.5, 1.5),
          ylim: (-7.5, 7.5),
          xaxis: (ticks: none),
          yaxis: (tick-args: (tick-distance: 5)),
          lq.plot(xs, x => 2 * x, mark: none, stroke: black),
          lq.hlines(0, stroke: black),
          lq.plot((0,), (0,), mark: "o", stroke: none, mark-color: black),
        )
      ],
    )
  ]

  *Step 3.* Interpretation

  Since $f'(x)$ changes from *negative *to* positive* at $x = 0$,

  $
    f(0) = 0 quad arrow.double.long quad bold("local minimum")
  $
]

#example[
  If $f'(x)$ changes from *positive to negative* at $c$, then $f(c)$ is a *local maximum*

  Suppose:

  $
    f(x) = -x^2, quad quad f'(x) = -2x
  $

  *Step 1.* Find critical point

  Solve $f'(x) = 0$

  $
    -2x = 0 quad arrow.long.double quad x = 0
  $

  So, $x = 0$ is the only critical point

  *Step 2.* Test sign of $f'(x)$ around $x = 0$

  - *Left*: $x = -1$

  $
    f'(-1) = -2(-1) = 2 gt 0 quad arrow.long.double quad f "is" bold("increasing")
  $

  - *Right*: $x = 1$

  $
    f'(1) = -2(1) = -2 lt 0 quad arrow.long.double quad f "is" bold("decreasing")
  $

  #align(center)[
    #grid(
      columns: (1fr, 1fr),
      [
        #let xs = lq.linspace(-1.5, 1.5, num: 200)
        #lq.diagram(
          width: 4cm,
          height: 4cm,
          xlim: (-1.5, 1.5),
          ylim: (-1.5, 0.5),
          xaxis: (ticks: none),
          yaxis: (tick-args: (tick-distance: 1)),
          lq.plot(xs, x => -calc.pow(x, 2), mark: none, stroke: black),
          lq.hlines(0, stroke: black),
          lq.plot((0,), (0,), mark: "o", stroke: none, mark-color: black),
        )
      ],
      [
        #let xs = lq.linspace(-1.5, 1.5, num: 200)
        #lq.diagram(
          width: 4cm,
          height: 4cm,
          xlim: (-1.5, 1.5),
          ylim: (-7.5, 7.5),
          xaxis: (ticks: none),
          yaxis: (tick-args: (tick-distance: 5)),
          lq.plot(xs, x => -2 * x, mark: none, stroke: black),
          lq.hlines(0, stroke: black),
          lq.plot((0,), (0,), mark: "o", stroke: none, mark-color: black),
        )
      ],
    )
  ]

  *Step 3.* Interpretation

  Since $f'(x)$ changes from *positive *to* negative* at $x = 0$,

  $
    f(0) = 0 quad arrow.long.double bold("local maximum")
  $
]

#example[
  If $f'(x)$does *not* change sign, $f(c)$ is *not* a local extremum

  Suppose

  $
    f(x) = x^3, quad quad f'(x) = 3x^2
  $

  *Step 1.* Find critical point

  Solve $f'(x) = 0$

  $
    3x^2 = 0 quad arrow.long.double quad x = 0
  $

  So, $x = 0$ is the only critical point

  *Step 2.* Test sign of $f'(x)$ around $x = 0$

  - *Left*: $x = -1$

  $
    f'(-1) = 3(-1)^2 = 3 gt 0 quad arrow.long.double quad f "is" bold("increasing")
  $

  - *Right*: $x = 1$

  $
    f'(1) = 3(1)^2 = 3 gt 0 quad arrow.long.double quad f "is" bold("increasing")
  $

  #align(center)[
    #grid(
      columns: (1fr, 1fr),
      [
        #let xs = lq.linspace(-1.5, 1.5, num: 200)
        #lq.diagram(
          width: 4cm,
          height: 4cm,
          xlim: (-1.5, 1.5),
          ylim: (-1.5, 1.5),
          xaxis: (ticks: none),
          yaxis: (tick-args: (tick-distance: 1)),
          lq.plot(xs, x => calc.pow(x, 3), mark: none, stroke: black),
          lq.hlines(0, stroke: black),
          lq.plot((0,), (0,), mark: "o", stroke: none, mark-color: black),
        )
      ],
      [
        #let xs = lq.linspace(-1.5, 1.5, num: 200)
        #lq.diagram(
          width: 4cm,
          height: 4cm,
          xlim: (-1.5, 1.5),
          ylim: (-7.5, 7.5),
          xaxis: (ticks: none),
          yaxis: (tick-args: (tick-distance: 5)),
          lq.plot(xs, x => 3 * calc.pow(x, 2), mark: none, stroke: black),
          lq.hlines(0, stroke: black),
          lq.plot((0,), (0,), mark: "o", stroke: none, mark-color: black),
        )
      ],
    )
  ]

  *Step 3.* Interpretation

  Since $f'(x)$ *does not change sign* at $x = 0$,

  $
    f(0) = 0 quad arrow.double.long quad bold("not a local extremum")
  $

  but rather a point of inflection
]

=== Second Derivative Test

If $f''(x)$ is continuous near a critical point $c$, and $f'(c) = 0$, then:

- If $f''(c) > 0$, then $f(c)$ is a *local minimum* (concave up)

- If $f''(c) < 0$, then $f(c)$ is a *local maximum* (concave down)

- If $f''(c) = 0$, the test is *inconclusive* — use the first derivative test or other methods

#example[
  If $f''(c) > 0$, then $f(c)$ is a *local minimum* (concave up)

  Suppose

  $
    f(x) = x^2, quad quad f'(x) = 2x, quad quad f''(x) = 2
  $

  *Step 1.* Find critical points

  Solve $f'(x) = 0$

  $
    2x = 0 quad arrow.long.double quad x = 0
  $

  So, $x = 0$ is the only critical point

  *Step 2.* Evaluate the second derivative at $x = 0$

  $
    f''(0) = 2 gt 0
  $

  Since the second derivative is positive, the function is *concave up* near $x = 0$

  #grid(
    columns: (1fr, 1fr, 1fr),
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-0.5, 1.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 1)),
        lq.plot(xs, x => calc.pow(x, 2), mark: none, stroke: black),
        lq.hlines(0, stroke: black),
      )
    ],
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-7.5, 7.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 5)),
        lq.plot(xs, x => 2 * x, mark: none, stroke: black),
        lq.hlines(0, stroke: black),
      )
    ],
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-7.5, 7.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 5)),
        lq.plot(xs, x => 2, mark: none, stroke: red),
        lq.hlines(0, stroke: black),
      )
    ],
  )

  *Step 3.* Interpretation

  $
    f(0) = 0 quad arrow.long.double quad bold("local minimum")
  $
]
#example[
  If $f''(c) < 0$, then $f(c)$ is a *local maximum* (concave down)

  Suppose

  $
    f(x) = -x^2, quad quad f'(x) = -2x, quad quad f''(x) = -2
  $

  *Step 1.* Find critical points

  Solve $f'(x) = 0$

  $
    -2x = 0 quad arrow.long.double quad x = 0
  $

  So, $x = 0$ is the only critical point

  *Step 2.* Evaluate the second derivative at $x = 0$

  $
    f''(0) = -2 lt 0
  $

  Since the second derivative is negative, the function is *concave down* near $x = 0$

  #grid(
    columns: (1fr, 1fr, 1fr),
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-1.5, 0.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 1)),
        lq.plot(xs, x => -calc.pow(x, 2), mark: none, stroke: black),
        lq.hlines(0, stroke: black),
      )
    ],
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-7.5, 7.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 5)),
        lq.plot(xs, x => -2 * x, mark: none, stroke: black),
        lq.hlines(0, stroke: black),
      )
    ],
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-7.5, 7.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 5)),
        lq.plot(xs, x => -2, mark: none, stroke: red),
        lq.hlines(0, stroke: black),
      )
    ],
  )

  *Step 3.* Interpretation

  $
    f(0) = 0 quad arrow.long.double quad bold("local maximum")
  $
]

#example[
  If $f''(c) = 0$, the test is *inconclusive* — use the first derivative test or other methods

  Suppose

  $
    f(x) = x^3, quad quad f'(x) = 3x^2, quad quad f''(x) = 6x
  $

  *Step 1.* Find critical points

  Solve $f'(x) = 0$

  $
    3x^2 = 0 quad arrow.long.double quad x = 0
  $

  So, $x = 0$ is the only critical point

  *Step 2.* Evaluate the second derivative at $x = 0$

  $
    f''(0) = 6(0) = 0
  $

  Since the second derivative is 0, the test in *inconclusive*

  #grid(
    columns: (1fr, 1fr, 1fr),
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-1.5, 1.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 1)),
        lq.plot(xs, x => calc.pow(x, 3), mark: none, stroke: black),
        lq.hlines(0, stroke: black),
      )
    ],
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-7.5, 7.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 5)),
        lq.plot(xs, x => 3 * calc.pow(x, 2), mark: none, stroke: black),
        lq.hlines(0, stroke: black),
      )
    ],
    [
      #let xs = lq.linspace(-1.5, 1.5, num: 200)
      #lq.diagram(
        width: 4cm,
        height: 4cm,
        xlim: (-1.5, 1.5),
        ylim: (-7.5, 7.5),
        xaxis: (ticks: none),
        yaxis: (tick-args: (tick-distance: 5)),
        lq.plot(xs, x => 6 * x, mark: none, stroke: red),
        lq.hlines(0, stroke: black),
      )
    ],
  )

  *Step 3.* Use another method

  Test sign of $f'(x)$ around $x = 0$

  - *Left*: $x = -1$

  $
    f'(-1) = 3(-1)^2 = 3 gt 0 quad arrow.long.double quad f "is" bold("increasing")
  $

  - *Right*: $x = 1$

  $
    f'(1) = 3(1)^2 = 3 gt 0 quad arrow.long.double quad f "is" bold("increasing")
  $

  *Step 4.* Interpretation

  Since $f'(x)$ *does not change sign* at $x = 0$,

  $
    f(0) = 0 quad arrow.double.long quad bold("not a local extremum")
  $

  but rather a point of inflection
]
