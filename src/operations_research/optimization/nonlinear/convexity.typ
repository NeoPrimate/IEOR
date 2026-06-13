#import "/lib/imports.typ": *
#show: formatting


#set math.mat(gap: 1em)
#set math.vec(gap: 1em)

#grid(
  columns: (auto, auto),
  [
    #frame(cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let p1 = (-0.75, 1)
      let p2 = (0.8, 0.9)

      plot.plot(
        size: (7,7),
        axis-style: "scientific",
        x-tick-step: none,
        y-tick-step: none,
        x-label: [$$],
        y-label: [$$],
        x-min: -1.5, x-max: 1.5,
        y-min: 0, y-max: 3,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
      {

        plot.add-anchor("a", p1)
        plot.add-anchor("b", p2)

        let z(x, y) = x*x + calc.pow(((y - 2*calc.exp(-0.9*x*x)) / 0.7),2) - 1

        plot.add-contour(
          x-domain: (-1.6, 1.5),
          y-domain: (-0.1, 3),
          z,
          z: (.1),
          fill: false,
          style: (stroke: red),
        )

        plot.add(
          (p1,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.add(
          (p2,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

      }, name: "plot")
      cetz.draw.line("plot.a", "plot.b", stroke: black, mark: (fill: blue), name: "a")

    }))
  ],
  [
    #frame(cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let p1 = (-0.5, 0.1)
      let p2 = (0.5, -0.1)

      plot.plot(
        size: (7,7),
        axis-style: "scientific",
        x-tick-step: none,
        y-tick-step: none,
        x-label: [$$],
        y-label: [$$],
        x-min: -1, x-max: 1,
        y-min: -1, y-max: 1,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
      {

        plot.add-anchor("o", (0, 0))
        plot.add-anchor("a", p1)
        plot.add-anchor("b", p2)

        plot.add(
          (p1,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.add(
          (p2,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

      }, name: "plot")
      cetz.draw.line("plot.a", "plot.b", stroke: black, mark: (fill: blue), name: "a")

      circle("plot.o", radius: (2.5, 1.5), stroke: red)
    }))
  ]
)

#grid(
  columns: (auto, auto),
  [
    #{
      let f(x) = x * x + 0.1
      let x1 = -0.75
      let x2 = 0.5
      let y1 = f(x1)
      let y2 = f(x2)
      let m = (y2 - y1) / (x2 - x1)
      let b = y1 - m * x1
      let f1(x) = m * x + b
      let xs = lq.linspace(-1, 1, num: 200)
      lq.diagram(
        width: 5cm,
        height: 5cm,
        xlim: (-1, 1),
        ylim: (0, 1),
        xaxis: (ticks: ((x1, [x]), (x2, [y]), (0, [z]))),
        yaxis: (ticks: none),
        lq.plot(xs, f, mark: none, stroke: (thickness: 1pt, paint: red)),
        lq.vlines(x1, max: f(x1), stroke: (paint: black, dash: "dashed")),
        lq.vlines(x2, max: f(x2), stroke: (paint: black, dash: "dashed")),
        lq.vlines(0, max: f1(0), stroke: (paint: black, dash: "dashed")),
        lq.plot((x1, x2), (y1, y2), mark: none, stroke: black), // secant chord
        lq.plot((x1, x2, 0), (y1, y2, f1(0)), stroke: none, mark: "o", mark-color: black, mark-size: 5pt),
      )
    }
  ],
  [
    #{
      let f(x) = calc.pow(x, 4) - 2 * calc.pow(x, 2) + 1 + 0.1
      let x1 = -1.25
      let x2 = 1.45
      let y1 = f(x1)
      let y2 = f(x2)
      let m = (y2 - y1) / (x2 - x1)
      let b = y1 - m * x1
      let f1(x) = m * x + b
      let xs = lq.linspace(-2, 2, num: 200)
      lq.diagram(
        width: 5cm,
        height: 5cm,
        xlim: (-2, 2),
        ylim: (0, 2),
        xaxis: (ticks: ((x1, [x]), (x2, [y]), (0, [z]))),
        yaxis: (ticks: none),
        lq.plot(xs, f, mark: none, stroke: (thickness: 1pt, paint: red)),
        lq.vlines(x1, max: f(x1), stroke: (paint: black, dash: "dashed")),
        lq.vlines(x2, max: f(x2), stroke: (paint: black, dash: "dashed")),
        lq.vlines(0, max: f(0), stroke: (paint: black, dash: "dashed")),
        lq.plot((x1, x2), (y1, y2), mark: none, stroke: black), // secant chord
        lq.plot((x1, x2, 0, 0), (y1, y2, f1(0), f(0)), stroke: none, mark: "o", mark-color: black, mark-size: 5pt),
      )
    }
  ]
)
