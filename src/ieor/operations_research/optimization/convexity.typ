#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

#set math.vec(delim: "[")
#set math.mat(delim: "[")
#set math.mat(gap: 1em)
#set math.vec(gap: 1em)


== Convexity

#grid(
  columns: (auto, auto),
  [
    #cetz.canvas({
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
      
    })
  ],
  [
    #cetz.canvas({
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
    })
  ]
)




#grid(
  columns: (auto, auto),
  [

    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = x*x + 0.1

      let x1 = -.75
      let x2 = 0.5

      let y1 = f(x1)
      let y2 = f(x2)

      let p1 = (x1, y1)
      let p2 = (x2, y2)

      let m = (y2 - y1) / (x2 - x1)
      let b = y1 - m * x1

      let f1(x) = m*x + b

      plot.plot(
        size: (7,7),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-ticks: ((x1, "x"), (x2, "y"), (0, "z")),
        x-label: [$$],
        y-label: [$$],
        x-min: -1, x-max: 1,
        y-min: -0, y-max: 1,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("o", p1)
        plot.add-anchor("a", p2)

        plot.add(
          domain: (-1, 1),
          f,
          style: (stroke: (thickness: 1pt, paint: red)),
          label: none,
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
        
        plot.add-vline(x1, max: f(x1), style: (stroke: (paint: black, dash: "dashed")))

        plot.add-vline(x2, max: f(x2), style: (stroke: (paint: black, dash: "dashed")))

        plot.add-vline(0, max: f1(0), style: (stroke: (paint: black, dash: "dashed")))

        plot.add(
          ((0, f1(0)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

      }, name: "plot"
    )
    cetz.draw.line("plot.o", "plot.a", stroke: black, mark: (fill: blue), name: "a")
    })
  ],
  [
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = calc.pow(x, 4) - 2 * calc.pow(x, 2) + 1 + 0.1

      let x1 = -1.25
      let x2 = 1.45

      let y1 = f(x1)
      let y2 = f(x2)

      let p1 = (x1, y1)
      let p2 = (x2, y2)

      let m = (y2 - y1) / (x2 - x1)
      let b = y1 - m * x1

      let f1(x) = m*x + b

      plot.plot(
        size: (7,7),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-ticks: ((x1, "x"), (x2, "y"), (0, "z")),
        x-label: [$$],
        y-label: [$$],
        x-min: -2, x-max: 2,
        y-min: 0, y-max: 2,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("o", p1)
        plot.add-anchor("a", p2)
        // plot.add-anchor("b", (4,2))
        // plot.add-anchor("d", (4,0))

        plot.add(
          domain: (-2, 2),
          f,
          style: (stroke: (thickness: 1pt, paint: red)),
          label: none,
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

        plot.add-vline(x1, max: f(x1), style: (stroke: (paint: black, dash: "dashed")))

        plot.add-vline(x2, max: f(x2), style: (stroke: (paint: black, dash: "dashed")))

        plot.add-vline(0, max: f(0), style: (stroke: (paint: black, dash: "dashed")))

        plot.add(
          ((0, f1(0)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        
        plot.add(
          ((0, f(0)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

      }, name: "plot")
    cetz.draw.line("plot.o", "plot.a", stroke: black, mark: (fill: blue), name: "a")
    })
  ]
)