#import "/lib/imports.typ": *



Set $L$ of all points (i.e., line) equal to the set of all vectors $accent(x, arrow)$ plus some scalar $t$ times the vector $accent(v, arrow)$ such that $t$ can be any real number ($RR$)

$
  L = {accent(x, arrow) + t accent(v, arrow) | t in RR }
$

#example[

  #let a = (2, 1)
  #let b = (0, 3)

  #let vec_a = $vec(#str(a.at(0)), #str(a.at(1)))$
  #let vec_b = $vec(#str(b.at(0)), #str(b.at(1)))$

  #let t = 1

  #let ts = range(-15, 15, step: 2).map(i => i * 0.1)

  #let diff_ba = (b.at(0) - a.at(0), b.at(1) - a.at(1))
  #let t_times_diff_ba = (t * diff_ba.at(0), t * diff_ba.at(1))

  #let b_plus_t_times_diff_ba = (b.at(0) + t * diff_ba.at(0), b.at(1) + t * diff_ba.at(1))

  $
    accent(a, arrow) = #vec_a
  $

  $
    accent(b, arrow) = #vec_b
  $

  $
    t = #t
  $

  The line $L$ can be defined as:

  $
    accent(b, arrow) + t (accent(b, arrow) - accent(a, arrow))
    &= #vec_b + #t (#vec_b - #vec_a) \
    &= #vec_b + #t vec(#str(b.at(0) - a.at(0)), #str(b.at(1) - a.at(1))) \
    &= vec(#str(b.at(0) + t * (b.at(0) - a.at(0))), #str(b.at(1) + t * (b.at(1) - a.at(1)))) \
  $

  #let vecs = ts.map(t => {
    (
      b.at(0) + t * (b.at(0) - a.at(0)),
      b.at(1) + t * (b.at(1) - a.at(1)),
    )
  })

  #align(center)[
    #frame(cetz.canvas(length: 10cm, {
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -6,
        y-min: -6,
        x-max: 6,
        y-max: 6,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("o", (0, 0))
          plot.add-anchor("a", (a.at(0), a.at(1)))
          plot.add-anchor("b", (b.at(0), b.at(1)))
          plot.add-anchor("L", (diff_ba.at(0), diff_ba.at(1)))

          for (i, z) in vecs.enumerate() {
            plot.add-anchor(str(i), (z.at(0), z.at(1)))
          }
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.01)

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$accent(b, arrow)$], anchor: "west", padding: 0.025)

      cetz.draw.line("plot.o", "plot.L", stroke: green, mark: (fill: green), name: "line")
      cetz.draw.content("line.end", text(green)[$accent(b, arrow) - accent(a, arrow)$], anchor: "east", padding: 0.03)

      for (i, z) in vecs.enumerate() {
        cetz.draw.line("plot.L", "plot." + str(i), stroke: purple, mark: (fill: purple), name: "line")
      }
    }))
  ]

  The line $L$ can also be defined as:

  $
    accent(a, arrow) + t (accent(b, arrow) - accent(a, arrow))
    &= #vec_a + #t (#vec_b - #vec_a) \
    &= #vec_a + #t vec(#str(b.at(0) - a.at(0)), #str(b.at(1) - a.at(1))) \
    &= vec(#str(a.at(0) + t * (b.at(0) - a.at(0))), #str(a.at(1) + t * (b.at(1) - a.at(1))))
  $

  #let vecs = ts.map(t => {
    (
      a.at(0) + t * (b.at(0) - a.at(0)),
      a.at(1) + t * (b.at(1) - a.at(1)),
    )
  })

  #align(center)[
    #frame(cetz.canvas(length: 10cm, {
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(
        x-tick-step: 1,
        y-tick-step: 1,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -6,
        y-min: -6,
        x-max: 6,
        y-max: 6,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("o", (0, 0))
          plot.add-anchor("a", (a.at(0), a.at(1)))
          plot.add-anchor("b", (b.at(0), b.at(1)))
          plot.add-anchor("L", (diff_ba.at(0), diff_ba.at(1)))

          for (i, z) in vecs.enumerate() {
            plot.add-anchor(str(i), (z.at(0), z.at(1)))
          }
        },
        name: "plot",
      )

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: red), name: "line")
      cetz.draw.content("line.end", text(red)[$accent(a, arrow)$], anchor: "south", padding: 0.01)

      cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "line")
      cetz.draw.content("line.end", text(blue)[$accent(b, arrow)$], anchor: "west", padding: 0.025)

      cetz.draw.line("plot.o", "plot.L", stroke: green, mark: (fill: green), name: "line")
      cetz.draw.content("line.end", text(green)[$accent(b, arrow) - accent(a, arrow)$], anchor: "east", padding: 0.03)

      for (i, z) in vecs.enumerate() {
        cetz.draw.line("plot.L", "plot." + str(i), stroke: purple, mark: (fill: purple), name: "line")
      }
    }))
  ]
]

Generalization

$
  P_1 = vec(x_1, x_2, dots.v, x_n) quad quad quad P_2 = vec(x_1, x_2, dots.v, x_n)
$

$
  L = P_1 + t (P_1 - P_2) | t in RR
$

#example[

  #let p1 = (-1, 2, 7)
  #let p2 = (0, 3, 4)

  #let p1_vec = $vec(#str(p1.at(0)), #str(p1.at(1)))$
  #let p2_vec = $vec(#str(p2.at(0)), #str(p2.at(1)))$

  #let p1_minus_p2 = $vec(#str(p1.at(0) - p2.at(0)), #str(p1.at(1) - p2.at(1)))$
  #let p2_minus_p1 = $vec(#str(p2.at(0) - p1.at(0)), #str(p2.at(1) - p1.at(1)))$

  $
    accent(P_1, arrow) = #p1_vec quad quad quad accent(P_2, arrow) = #p2_vec
  $

  $
    accent(P_1, arrow) - accent(P_2, arrow) = #p1_minus_p2
  $

  - $L$ starts at $P_1$ and moves toward $P_2$ as $t$ decreases
  $
    L & = P_1 + t (P_1 - P_2) = #p1_vec + t #p1_minus_p2
  $

  $
    x & = -1 + t (-1) \
    y & = 2 + t (-1) \
  $

  - $L$ starts at $P_2$ and moves toward $P_1$ as $t$ increases

  $
    L = P_2 + t (P_1 - P_2) = #p2_vec + t #p1_minus_p2
  $

  $
    x & = 0 + t (-1) \
    y & = 3 + t (-1) \
  $

  - $L$ starts at $P_1$ and moves toward $P_2$ as $t$ increases

  $
    L = P_1 + t (P_2 - P_1) = #p1_vec + t #p2_minus_p1
  $

  $
    x & = -1 + t (1) \
    y & = 2 + t (1) \
  $

  - $L$  starts at $P_2$ and moves toward $P_1$ as $t$ decreases

  $
    L = P_2 + t (P_2 - P_1) = #p2_vec + t #p2_minus_p1
  $

  $
    x & = 0 + t (1) \
    y & = 3 + t (1) \
  $

  #let line1_x(t) = -1 + t * (-1)
  #let line1_y(t) = 2 + t * (-1)

  #let line2_x(t) = 0 + t * (-1)
  #let line2_y(t) = 3 + t * (-1)

  #let line3_x(t) = -1 + t * 1
  #let line3_y(t) = 2 + t * 1

  #let line4_x(t) = 0 + t * 1
  #let line4_y(t) = 3 + t * 1

  // P_1 t + P_2 (1-t)
  #let line_luis_1_x(t) = (-1) * t + 0 * (1 - t)
  #let line_luis_1_y(t) = 2 * t + 3 * (1 - t)

  #let line_luis_2_x(t) = 0 * t + (-1) * (1 - t)
  #let line_luis_2_y(t) = 3 * t + 2 * (1 - t)

  #align(center)[
    #frame(cetz.canvas(length: 10cm, {
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(
        x-tick-step: 2,
        y-tick-step: 2,
        x-minor-tick-step: 1,
        y-minor-tick-step: 1,
        x-min: -3,
        y-min: -3,
        x-max: 3,
        y-max: 3,
        axis-style: "school-book",
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add(
            t => (line1_x(t), line1_y(t)),
            domain: (-0.25, 0),
          )
          plot.add(
            t => (line2_x(t), line2_y(t)),
            domain: (0, 0.25),
          )
          plot.add(
            t => (line3_x(t), line3_y(t)),
            domain: (0.25, 0.5),
          )
          plot.add(
            t => (line4_x(t), line4_y(t)),
            domain: (-0.25, -0.5),
          )
        },
        name: "plot",
      )
    }))
  ]

]
