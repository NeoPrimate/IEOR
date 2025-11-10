#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

#show math.equation.where(block: false): set text(12pt)
#set math.vec(delim: "[")
#set math.mat(delim: "[")
#set math.mat(gap: 1em)
#set math.vec(gap: 1em)


== Convex Analysis

Difficulties of NLP

- A local minimum is not always a global minimum


#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    let f(x) = (x + 2)*(x + 1)*(x - 1)*(x - 2)*(x - 3)*(x - 4)

    plot.plot(
      size: (8,6),
      axis-style: "scientific",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: ((-0.75, $x_1$), (1.457, $x_2$), (3.655, $x^*$),),
      x-label: [$$],
      y-label: [$$],
      x-min: -1, x-max: 4,
      y-min: -75, y-max: 75,
      axes: (
        stroke: none,
        tick: (stroke: none),
      ),
    {        
      
      plot.add(
        domain: (-1, 4),
        f,
        style: (stroke: (paint: black))
      )

      plot.add-vline(
        -0.75,
        style: (stroke: (paint: black, dash: "dashed"))
      )
      plot.add(
        ((-0.75,f(-0.75)),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )

      plot.add-vline(
        1.457,
        max: f(1.457),
        style: (stroke: (paint: black))
      )
      plot.add(
        ((1.457,f(1.457)),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
      plot.add-vline(
        3.655,
        max: f(3.655),
        style: (stroke: (paint: black))
      )
      plot.add(
        ((3.655,f(3.655)),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )

    }, name: "plot")
  })
]

- An optimal solution may not be an extreme point optimal solution

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    set-style(axes: (shared-zero: false))

    let f_top(x) = calc.sqrt(calc.pow(2.5, 2) - calc.pow(x, 2))
    let f_bot(x) = -calc.sqrt(calc.pow(2.5, 2) - calc.pow(x, 2))
    let g_top(x) = calc.sqrt(calc.pow(1, 2) - calc.pow(x, 2))
    let g_bot(x) = -calc.sqrt(calc.pow(1, 2) - calc.pow(x, 2))
    let c(x) = 4 - x

    plot.plot(
      size: (8,8),
      axis-style: "school-book",
      x-tick-step: none, 
      y-tick-step: none, 
      // x-ticks: ((-0.75, $x_1$), (1.457, $x_2$), (3.655, $x^*$),),
      x-label: [$$],
      y-label: [$$],
      x-min: -6, x-max: 6,
      y-min: -6, y-max: 6,
      axes: (
        stroke: none,
        tick: (stroke: none),
      ),
    {        
      
      plot.add(
        domain: (-2.5, 2.5),
        f_top,
        style: (stroke: (paint: black, dash: "dashed"))
      )
      plot.add(
        domain: (-2.5, 2.5),
        f_bot,
        style: (stroke: (paint: black, dash: "dashed"))
      )

      plot.add(
        domain: (-1, 1),
        g_top,
        style: (stroke: (paint: black, dash: "dashed"))
      )
      plot.add(
        domain: (-1, 1),
        g_bot,
        style: (stroke: (paint: black, dash: "dashed"))
      )

      plot.add(
        domain: (-6, 6),
        c,
        style: (stroke: (paint: black))
      )

      plot.add-fill-between(
        domain: (0, 6),
        x => calc.max(c(x), 0),
        x1 => 6,
        style: (fill: rgb(200, 200, 255, 80), stroke: none),
        label: none
      )

      plot.add(
        ((2,2),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )

      plot.annotate({
        content((2.5, 2.5), $x^*$)
      })
    }, name: "plot")
  })
]

=== Convexity

Convex Set

If for whatever two points you select in the set, the line segment connecting them also lies in the set, then the set is convex

A set $F$ is convex if

$
  lambda x_1 + (1 - lambda) x_2 in F   
$

for all $lambda in [0, 1]$ and $x_1, x_2 in F$

#grid(
  columns: (auto, auto),
  align: horizon + center,
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

Convex Function

For a convex domain $F subset.eq RR^n$, a function $f: RR^n arrow RR$ is convex over $F$ if

$
  f(lambda x_1 + (1 - lambda) x_2) lt.eq lambda f(x_1) + (1 - lambda) f(x_2)
$

for all $lambda in [0, 1]$ and $x_1, x_2 in F$

#grid(
  columns: (auto, auto),
  align: center,
  column-gutter: 1em,
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
        size: (8,8),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-ticks: ((x1, $x_1$), (x2, $x_2$)),
        x-label: [$$],
        y-label: [$$],
        x-min: -0.8, x-max: 0.6,
        y-min: -0, y-max: 0.75,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("o", p1)
        plot.add-anchor("a", p2)

        plot.add-anchor("oo", (0, 0))
        plot.add-anchor("f0", (0, f(0)))
        plot.add-anchor("fx", (0, f1(0)))



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
          ((0, f(0)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

        plot.add(
          ((0, f1(0)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )

      }, name: "plot"
    )
    cetz.draw.line("plot.o", "plot.a", stroke: black, mark: (fill: blue), name: "a")

    cetz.decorations.flat-brace("plot.oo", "plot.f0", amplitude: -0.5, name: "f", style: (stroke: (paint: red)))
    cetz.decorations.flat-brace("plot.oo", "plot.fx", amplitude: 0.5, name: "l")

    cetz.draw.content(
      "f",
      text(size: 7pt)[$f(lambda x_1 + (1 - lambda) x_2)$],
      anchor: "west",
      dx: 1em,
      padding: 1em,
    )
    cetz.draw.content(
      "l",
      text(size: 7pt)[$lambda f(x_1) + (1 - lambda) f(x_2)$],
      anchor: "east",
      padding: 1em,
    )
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
        size: (8,8),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-ticks: ((x1, $x_1$), (x2, $x_2$)),
        x-label: [$$],
        y-label: [$$],
        x-min: -1.5, x-max: 1.5,
        y-min: 0, y-max: 1.5,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("o", p1)
        plot.add-anchor("a", p2)


        plot.add-anchor("oo", (0, 0))
        plot.add-anchor("f0", (0, f(0)))
        plot.add-anchor("fx", (0, f1(0)))

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

      cetz.decorations.flat-brace("plot.oo", "plot.f0", amplitude: -0.5, name: "f", style: (stroke: (paint: red)))
      cetz.decorations.flat-brace("plot.oo", "plot.fx", amplitude: 0.5, name: "l")

      cetz.draw.content(
        "f",
        text(size: 7pt)[$f(lambda x_1 + (1 - lambda) x_2)$],
        anchor: "west",
        dx: 1em,
        padding: 1em,
      )
      cetz.draw.content(
        "l",
        text(size: 7pt)[$lambda f(x_1) + (1 - lambda) f(x_2)$],
        anchor: "east",
        padding: 1em,
      )
    })
  ]
)

Concave Function

For a convex domain $F in RR^n$, a function $f: RR^n arrow RR$ is concave over $F$ if $-f$ is convex

Global Optimality of Convext Functions

*Proposition 1.* For a convex (concave) function $f$ over a convex doain $F$, a local minimum (maximum) is a global minimum (maximum)

Two conditions:
- Function needs to be convex
- Domain (feasible region) need to be convex

Proof

Suppose a local minimum $x'$ is not a global minimum and there exists $x''$ such that $f(x'') lt f(x')$. Consider a small enough $lambda gt 0$ such that $macron(x) = lambda x'' + (1 - lambda) x'$ satisfies $f(macron(x)) gt f(x')$. Such $macron(x)$ exists because $x'$ is a local minimum. Now, note that

$
  f(macron(x)) 
  &= f(lambda x'' + (1 - lambda) x') \
  &gt f(x') \
  &= lambda f(x') + (1 - lambda) f(x') \
  &gt lambda f(x'') + (1 - lambda) f(x')
$

Which violates the fact that $f(dot)$ is convex. Therefore, by contradiction, the local minimum $x'$ must be a global minimum.

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    let f(x) = (x + 2)*(x + 1)*(x - 1)*(x - 2)*(x - 3)*(x - 4)

    let l = 0.1

    let xp = 1.457
    let xpp = 3.655

    let yp = f(xp)
    let ypp = f(xpp)

    let p1 = (xp, yp)
    let p2 = (xpp, ypp)

    let m = (ypp - yp) / (xpp - xp)
    let b = yp - m * xp

    let f1(x) = m*x + b

    let xbar = 1.8
    let fxbar = f(l * xpp + (1 - l) * xp)

    plot.plot(
      size: (8,6),
      axis-style: "scientific",
      x-tick-step: none, 
      y-tick-step: none, 
      x-ticks: ((1.457, $x'$), (1.8, $macron(x)$), (3.655, $x''$),),
      x-label: [$$],
      y-label: [$$],
      x-min: -0, x-max: 4,
      y-min: -75, y-max: 75,
      axes: (
        stroke: none,
        tick: (stroke: none),
      ),
    {        
      plot.add-anchor("0xp", (xp, 0))
      plot.add-anchor("0xpp", (xpp, 0))
      plot.add-anchor("fxp", (xp, f(xp)))
      plot.add-anchor("fxpp", (xpp, f(xpp)))
      
      plot.add(
        domain: (0, 4),
        f,
        style: (stroke: (paint: black))
      )
      plot.add(
        domain: (xp, xpp),
        f1,
        style: (stroke: (paint: red))
      )

      plot.add(
        ((xp,f(xp)),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      plot.add-vline(xp, max: f(xp), style: (stroke: (paint: black, dash: "dashed")))
      
      plot.add(
        ((xpp,f(xpp)),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      plot.add-vline(xpp, max: f(xpp), style: (stroke: (paint: black, dash: "dashed")))
      
      plot.add(
        ((xbar,f(xbar)),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
      // plot.add(
      //   ((xbar ,fxbar),),
      //   mark: "o",
      //   mark-size: 0.15,
      //   mark-style: (fill: black, stroke: 2pt)
      // )

      plot.add-vline(1.8, max: f(1.8), style: (stroke: (paint: black, dash: "dashed")))

    }, name: "plot")

    // cetz.decorations.flat-brace("plot.0xp", "plot.fxp", amplitude: -0.5, name: "f", style: (stroke: (paint: red)))
    // cetz.decorations.flat-brace("plot.oo", "plot.fx", amplitude: 0.5, name: "l")

    // cetz.draw.content(
    //   "f",
    //   text(size: 7pt)[$f(lambda x_1 + (1 - lambda) x_2)$],
    //   anchor: "west",
    //   dx: 1em,
    //   padding: 1em,
    // )
    // cetz.draw.content(
    //   "f",
    //   text(size: 7pt)[$lambda f(x_1) + (1 - lambda) f(x_2)$],
    //   anchor: "east",
    //   padding: 1em,
    // )
  })
]

Minimize a concave function

*Proposition 2*: For a concave function that has a global minimum over a convex feasible region, there exists a global minimum that is an extreme point

Extreme point: In convex analysis, an extreme point of a convex set $C$ is a point in $C$ that cannot be expressed as a strict convex combination of two other distinct points in $C$

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *
    
    plot.plot(
      size: (8,8),
      axis-style: "scientific",
      x-tick-step: none, 
      y-tick-step: none, 
      x-label: [$$],
      y-label: [$$],
      x-min: -3, x-max: 3,
      y-min: -3, y-max: 3,
      axes: (
        stroke: none,
        tick: (stroke: none),
      ),
    {      

      plot.add-contour(
        x-domain: (-3, 3), 
        y-domain: (-3, 3),
        style: (
          fill: rgb(189, 21, 21, 30),
          stroke: none
        ),
        fill: true,
        op: "<",
        z: range(10).map(i => i*0.5),
        (x, y) => calc.sqrt(x * x + y * y)
      )  
    }, name: "plot")
  })
]

Special Case: LP

When we minimize $f(dot)$ over a convez feasible region $F$:
- If $f(dot)$ is *convex*, search for a *local minimum*
- If $f(dot)$ is *concave*, search among *extreme points* of $F$

For any LP we have both

#grid(
  columns: (auto, auto, auto),
  align: center,
  [
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = x*x

      let l_root = (0.1 - calc.sqrt(0.1*0.1 + 4)) / 2
      let r_root = (0.1 + calc.sqrt(0.1*0.1 + 4)) / 2

      plot.plot(
        size: (5,5),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$$],
        y-label: [$$],
        x-min: -2, x-max: 2,
        y-min: -0.1, y-max: 2,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
      {        
        plot.add(
          domain: (-2, 2),
          f,
          style: (stroke: (paint: black))
        )

        plot.add(
          domain: (-2, 2),
          x => 0.1*x+1,
          style: (stroke: (paint: black))
        )
        
        plot.add(
          domain: (l_root, r_root),
          x => 0.1*x + 1,
          style: (stroke: (paint: red, thickness: 2pt))
        )

        plot.add(
          ((l_root,f(l_root)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          ((r_root,f(r_root)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
      }, name: "plot")
    })
  ],
  [
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = -x*x

      let l_root = (0.1 - calc.sqrt(0.1*0.1 + 4)) / 2
      let r_root = (0.1 + calc.sqrt(0.1*0.1 + 4)) / 2

      plot.plot(
        size: (5,5),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$$],
        y-label: [$$],
        x-min: -2, x-max: 2,
        y-min: -2, y-max: 0.1,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
      {        
        plot.add(
          domain: (-2, 2),
          x => f(x),
          style: (stroke: (paint: black))
        )
        plot.add(
          domain: (-2, 2),
          x => -0.1*x - 1,
          style: (stroke: (paint: black))
        )

        plot.add(
          domain: (l_root, r_root),
          x => -0.1*x - 1,
          style: (stroke: (paint: red, thickness: 2pt))
        )

        plot.add(
          ((l_root,f(l_root)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          ((r_root,f(r_root)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
      }, name: "plot")
    })
  ],
  [
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let f(x) = 0.1*x - 1

      let l_root = (0.1 - calc.sqrt(0.1*0.1 + 4)) / 2
      let r_root = (0.1 + calc.sqrt(0.1*0.1 + 4)) / 2

      plot.plot(
        size: (5,5),
        axis-style: "scientific",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$$],
        y-label: [$$],
        x-min: -2, x-max: 2,
        y-min: -2, y-max: 0.1,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
      {        
        plot.add(
          domain: (-2, 2),
          f,
          style: (stroke: (paint: black))
        )

        plot.add(
          domain: (l_root, r_root),
          x => 0.1*x - 1,
          style: (stroke: (paint: red, thickness: 2pt))
        )

        plot.add(
          ((l_root,f(l_root)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          ((r_root,f(r_root)),),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: black, stroke: 2pt)
        )
      }, name: "plot")
    })
  ]
)

*Proposition 3.* The feasible region of an LP is convex

The intersections of convex sets are convex

*Proposition 4.* A linear function $f: RR^n arrow RR$ is both convex and concave

Proof:

$
  f(lambda x_1 + (1 - lambda) x_2) colorMath(=, #red) lambda f(x_1) + (1 - lambda) f(x_2)
$

Let $f(x) = c^T x + b$ be a linear function, $c in RR^n, b in RR$, then:

$
  f(lambda x_1 + (1 - lambda) x_2) 
  &= c^T (lambda x_1 + (1 - lambda) x_2) + b \
  &= lambda (c^T x_1 + b) + (1 - lambda) (c^T x_2 + b) \
  &= lambda f(x_1) + (1 - lambda) f(x_2)
$

Convex Programming

Consider a general NLP

$
  min_(x in RR^n)& quad f(x) \
  s.t.& quad g_i(x) lt.eq b_i quad forall i = 1, dots, m
$

If:
- The feasible region $F = {x in RR^n bar g_i (x) lt.eq b_i forall i = 1, dots, m}$ (intersection of all the regions satisfying the constraints)
- $f$ is convex over $F$
A local minimum is a global minimum

#definition(
  [Convex Program (CP)],
  [An NLP is convex if its feasible region is convex and its objective function is convex over the feasible region]
)

Convex Programming:
- Minimizing convex function
- Maximizing concave function
Subject to a convex feasible region

Local min = Global min

For an NLP

$
  min_(x in RR^n) {f(x) | g_i (x) lt.eq b_i forall i - 1, dots, m}
$

if $f$ and $g_i$s are all convex functions, the NLP is a Convex Program

Proof:

We only need to prove that the feasible region is convex, which is implied if $F_i = {x in RR^n | g_i (x) lt.eq b_i}$ is convex for all $i$. For two points $x_1, x_2 in F_i$ and an arbitrary $lambda in [0, 1]$, we have

$
  g_i (lambda x_1 + (1 - lambda) x_2) 
  &lt.eq lambda g_i (x_1) + (1 - lambda) g_i (x_2) \
  &lt.eq lambda b_i + (1 - lambda) b_i = b_i
$

Which implies that $F_i$ is convex. repeating this argument for all $i$ completes the proof

If each constraint independently given a convex feasible region, then their intersection is convex

#definition(
  [Affine Combination],
  [
    An affine combination of points $x_1, x_2, dots, x_k in RR^n$, is any point of the form:

    $
      alpha_1 x_1 + alpha_2 x_2 + dots + alpha_k x_1 + x_k
    $

    where the coefficients sum to 1:

    $
      alpha_1 + alpha_2 + dots + alpha_k = 1
    $

    This is like a linear combination, but with the extra condition that the weights add up to 1.
  ]
) 

#line(length: 100%)

For a twice differentiable function $f: RR arrow RR$ over an interval $(a, b)$:
- $f$ is convex over $(a, b)$ iif $f''(x) gt 0$ for all $x in (a, b)$
- $macron(x)$ is a local minimum over $(a, b)$, iif $f'(x) = 0$
- If $f$ is concave over $(a, b)$, $x^*$ is a global minimum over $(a, b)$ iif $f'(macron(x)) = 0$

First order condition (FOC) $f'(x) = 0$
- FOC is necessary for local optimality
- FOC is sufficient for global optimality if $f$ is convex

#eg[
  Economic Order Quantity (EOQ)

  Determine the order quantity in each order
  - Demand is deterministic and occurs at a constant rate
  - Each order incurs a fixed cost (independent of the order size)
  - No shortage allowed
  - Lead time is zero
  - Holding cost is proportional to the average inventory
  - Constant holding cost  

  Parameters:

  - $D$: annual demand (units/year)
  - $K$: unit ordering cost (\$/order)
  - $h$: annual holding cost (\$/unit/year)
  - $p$: unit purchase cost (\$/unit)

  Decision Variable:
  - $q$: order quantity (units/order)

  Objective:
  - Minimize the total annual cost

  Average inventory level:

  $
    q/2
  $

  Annual holding cost:

  $
    H = h (q/2) = (h q) / 2
  $

  Annual purchase cost:

  $
    p D
  $

  Annual ordering cost:

  $
    O = (D/q) K = (D K) / q
  $

  NLP, since $p D$ does not depend on $q$ it does not affect the minimizer:

  $
    min_(q gt 0) f(q) 
    &= (D/q) K + (q/2) h \
    &= (D K)/q + (q h)/2 \
  $

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      let D = 1000
      let K = 50
      let h = 2

      let TC(q) = (K * D) / q + (h * q) / 2
      let H(q) = (h * q) / 2
      let O(q) = (K * D) / q

      plot.plot(
        size: (12,8),
        axis-style: "scientific",
        x-tick-step: 100, 
        y-tick-step: 100, 
        // x-ticks: ((-0.75, $x_1$), (1.457, $x_2$), (3.655, $x^*$),),
        x-label: [Order Quantity],
        y-label: [Cost],
        x-min: 0, x-max: 500,
        y-min: 0, y-max: 1000,
        axes: (
          stroke: none,
          tick: (stroke: none),
        ),
        legend: "inner-north-east",
        legend-style: (
          padding: 1em,
          offset: (x: -1em, y: -1em)
        ),
      {        
        plot.add(
          domain: (1, 500),
          TC,
          style: (stroke: (paint: red)),
          label: "Total Cost"
        )
        plot.add(
          domain: (1, 500),
          H,
          style: (stroke: (paint: blue)),
          label: "Holding Cost"
        )
        plot.add(
          domain: (1, 500),
          O,
          style: (stroke: (paint: green)),
          label: "Ordering Cost"
        )
      }, name: "plot")
    })
  ]

  For:

  $
    T C(q) = (K D)/q + (h q)/2
  $

  we have

  $
    T C'(q) = - (K D)/q^2 + h/2
  $

  and

  $
    T C''(q) = (2 K D) / q^3
  $

  Since a twice differentiable function is convex If

  $
    f''(x) gt 0 quad forall x in (a, b)
  $

  and

  $
    K gt 0, quad D gt 0, quad q gt 0
  $

  we have

  $
    T C''(q) = (2 K D) / q^3  gt 0
  $

  Therefore, $T C(q)$ is convex

  Let $q^*$ be the quantity satifying the FOC:

  $
    T C' (q^* ) = - (K D) / (q^* )^2 + h/2 = 0 
    quad arrow.double quad
    q^* = sqrt((2 K D) / h)
  $

  Implications:
  - If order cost $K$ increases, order quantity $q^*$ increases
  - If demand $D$ increases, order quantity $q^*$ increases
  - If holding cost $h$ increases, order quantity $q^*$ decreases
]

== Multivariate Convex Analysis

An optimal solution either:
- Satisfies the FOC
- Lies on the boundary of the feasible region

If a NLP is a CP, a feasible point satifying the FOC is optimal (any local minimum is a global minimum)

For a function $f: RR^n arrow RR$, its $i$th partial derivative is $(diff f(x)) / (diff x_i)$

For a twice differentiable function $f: RR^n arrow RR$, if all second order partial derivatives are continuous:

$
  (diff^2 f(x)) / (diff x_i diff x_j) = (diff^2 f(x)) / (diff x_j diff x_i)
$

for all $i = 1, dots, n$ and $j = 1, dots, n$.

Single variate case:

- For $f: RR arrow RR$, $f$ is convex iif $f''(x) gt.eq 0$ for all $x$

Multivariate case:

$
  gradient f(x) = vec((diff f(x)) / (diff x_1), dots.v, (diff f(x)) / (diff x_n))
  quad quad gradient^2 f(x) = H_f = mat(
    (diff^2 f(x)) / (diff x_1^2), dots, (diff^2 f(x)) / (diff x_1 diff x_n);
    dots.v, dots.down, dots.v;
    (diff^2 f(x)) / (diff x_n diff x_1), dots, (diff^2 f(x)) / (diff x_n^2);
  )
$

#eg[
  $
    f(x_1, x_2, x_3) = x_1^2 + x_2 x_3 + x_3^3
  $

  $
    gradient f(x) 
    = vec((diff f(x)) / (diff x_1), (diff f(x)) / (diff x_2), (diff f(x)) / (diff x_3))
    = vec(2 x_1, x_3, x_2 + 3 x_3^2)
  $

  $
    gradient^2 f(x) = 
    mat(
      (diff^2 f(x)) / (diff x_1^2), (diff^2 f(x)) / (diff x_1 diff x_2), (diff^2 f(x)) / (diff x_1 diff x_3);
      (diff^2 f(x)) / (diff x_2 diff x_1), (diff^2 f(x)) / (diff x_2^2), (diff^2 f(x)) / (diff x_2 diff x_3);
      (diff^2 f(x)) / (diff x_3 diff x_1), (diff^2 f(x)) / (diff x_3 diff x_2), (diff^2 f(x)) / (diff x_3^2)
    )
    = mat(
      2, 0, 0;
      0, 0, 1;
      0, 1, 6 x_3
    )
  $

  You may ask:

  - What is the gradient at a point: $gradient f(3, 2, 1)$
  - What is the Hessian at a point: $gradient^2 f(3, 2, 1)$
]


#table(
  columns: (auto, auto),
  align: left,
  inset: 1em,
  [
    Single Variate Function \
    $
      f: RR arrow RR
    $
  ], [
    - $f$ is convex in $[a, b]$ if $f''(x) gt.eq 0$ for all $x in [a, b]$
    - $macron(x)$ is an interior local minimum if $f'(macron(x)) = 0$
    - If $f$ is convex in $[a, b]$, $x^*$ is a global minimum iif $f'(x^*) = 0$
  ],
  [
    Multi Variate Function \
    $
      f: RR^n arrow RR
    $
  ],
  [
    - $f$ is convex in a convex set $F subset.eq RR^n$ if $gradient^2 f(x)$ is positive semi-definite for all $x in F$
    - $macron(x)$ is an interior local minimum if $gradient f(macron(x)) = bold(0)$
    - If $f$ is convex in a convex set $F$, $x^*$ is a global minimum iif $gradient f(x^*) = 0$
  ]
)

#definition(
  [Positive Semi-Definite (PSD) Matrix],
  [
    A symmetric matrix $A$ is positive semi-definite if $bold("x")^T A bold("x") gt.eq 0$ for all $bold("x") in RR^n$
  ]
)

#eg[

  Semi-Definite Matrix

  $
    A = mat(2, 1; 1, 2)
  $

  $
    x^T A x 
    &= mat(x_1, x_2) mat(2, 1; 1, 2) vec(x_1, x_2) \
    \
    &= 2 x_1^2 + 2 x_1 x_2 + 2 x_2^2 \
    \
    &= 2(x_1 + x_1)^2 + x_1^2 + x_2^2 gt.eq 0 \
  $
]

Given a function $f$, when is its Hessian $gradient^2 f$ PSD?

For a symmetric matrix $A$, the following statements are equivalent:
- $A$ is *positive semi-definite*
- All *eigenvalues* of $A$ are non-negative
- All *principal minors* of $A$ are non-negative

$A$'s level-$k$ principal minors is the determinant of a $k times k$ submatrix whose diagonal is a subset of $A$'s diagonal.

A sufficient condition is for $A$'s *leading* principl minors to all *positive*

For a function $f$:
1. Find *Hessian* $gradient^2 f(x)$
2. Find *eigenvalues* or *principal minors* of $gradient^2 f(x)$
3. Determine over what region $gradient^2 f(x)$ is *PSD*

The function is convex over that region

#eg[
  $
    min_(x in RR^2) f(x_1, x_2)
  $

  $
    f(x_1, x_2) = x_1^2 + x_2^2 + x_1 x_2 - 2x_1 - 4x_2
  $

  $
    gradient f(x) = vec(2 x_1 + x_2 - 2, x_1 + 2 x_2 - 4)
    quad quad gradient^2 f(x) = mat(2, 1; 1, 2)
  $

  Find *eigenvalues*

  $
    A x = lambda x 
    quad arrow.l.r.long.double quad
    (A - lambda I) x = 0
    quad arrow.l.r.long.double quad
    det(A - lambda I) = 0
  $

  $
    mat(
      delim: "|",
      2 - lambda, 1;
      1, 2 - lambda;
    ) = 0
    quad arrow.l.r.long.double quad
    3 - 4 lambda + lambda^2 = 0
    quad arrow.l.r.long.double quad
    lambda = 1 "or" 3
  $

  Or find *leading principal minors*

  $
    mat(
      delim: "|",
      2
    ) = 2
    quad "and" quad
    mat(
      delim: "|",
      2, 1;
      1, 2;
    ) = 3
  $

  So $gradient^2 f(x_1, x_2)$ is PSD and thus $min_(x in RR^2) f(x_1, x_2)$ is a CP. 
  
  The FOC requires $2 x_1^* + x_2^* - 2 = 0$ and $x_1^* + 2x_2^* - 4 = 0$
  
  I.e., $(x_1^*, x_2^*) = (0, 2)$

]

#eg[

  $
    min_(x in RR^2) f(x_1, x_2)
  $

  $
    f(x_1, x_2) = x_1^3 + 4x_1 x_2 + 1/2 x_2^2 + x_1 + x_2
  $

  $
    gradient^2 f(x) = mat(6x_1, 4; 4, 1)
  $

  - 1st leading principle minor $6x_1 gt.eq 0$ ($x_1 gt.eq 0$)
  - 2nd leading principal minor $6x_1 - 16 gt.eq 0$ ($x_1 gt.eq 8/3$)
  - $1 gt.eq 0$

  Therefore, the function is convex iif $x_1 gt.eq 8/3$
]

#eg[
  Two-Product Pricing

  A retailer sells product 1 and 2 at prices $p_1$ and $p_2$. For product $i$ the demand $q_i$ is:

  $
    q_1 = a - p_1 + b p_2 \
    q_2 = a - p_2 + b p_1 \
  $

  where $a gt 0$ and $b in [0, 1)$. The retailer sets $p_1$ and $p_2$ to maximize its total profit.

  If $p_1$ and $p_2$ are substitutes of one another then the price of one will affect the demand of the other.

  1. Why $b in [0, 1)$?

  If $b gt.eq 1$: the other product's price will have the equal or greater impact on your own product's price

  If $b lt 0$: Complimentary products (rather than substitutes), the higher the other product's price, the lower our demand

  2. Formulate problem

  $
    max_(p_1, p_2) quad p_1 underbrace((a - p_1 + b p_2), q_1) + p_2 underbrace((a + b p_1 - p_2), q_2)
  $

  Let

  $
    f(p) = - [p_1 (a - p_1 + b p_2) + p_2 (a + b p_1 - p_2)
  $

  3. Is it a CP?

  $
    gradient^2 f(p) = mat(
      2, -2b;
      -2b, 2;
    )
  $

  Which is PSD if $b in [0, 1)$ since

  - 1st leading principle minor $2 gt.eq 0$
  - 2nd leading principle minor $4 - 4b^2$ ($4 (1 - b) (1 + b) gt.eq 0$)

  Therefore $f(p)$ is convex and $-f(p)$, the objective function is concave

  The problem is a CP

  4. Solve problem

  $gradient f(p) = 0$ rquires:
  - $-a + 2p_1 - 2b p_2 = 0$
  - $-a + 2p_2 - 2b p_1 = 0$

  So,

  $
    p_1 = p_2 = a / (2(1 - b))
  $

  5. How does optimal prices change with $a$ and $b$? 

  When 
  - $a$ increases, the two prices increase: price of product increases when demand increases
  - $b$ increases, the two prices increase: effective demand becomes larger
  
]

#eg[

  *Question 1*

  For each of the following sets, select all that are convex:
  1. $S = {(x_1, x_2) in RR^2 | x_1^2 + x_2^2 lt.eq 4, x_1 gt.eq 0, x_2 lt.eq 0}$

  ✅ $x_1^2 + x_2^2 lt.eq 4$, a disk of radius 2, is convex and the $x_1 gt.eq 0, x_2 lt.eq 0$ lines are also convex

  The intersection of convex sets is convex

  2. $S = {(x_1, x_2) in ZZ^2 | x_1^2 + x_2^2 lt.eq 4, x_1 gt.eq 0, x_2 lt.eq 0}$

  ❌ Integer programs are never convex in the usual sense, because the feasible set of integers is discrete

  3. $S = {x in RR^n | sum_(i=1)^n x_i^2 lt.eq 4, x_1 gt.eq 0, x_2 lt.eq 0}$

  ✅ $sum_(i=1)^n x_i^2 lt.eq 4$, a $n$-dimensional sphere (hypersphere) of radius 2, is convex and the $x_1 gt.eq 0, x_2 lt.eq 0$ lines are also convex

  The intersection of convex sets is convex

  4. $S = {x in RR^n | x_1 + x_2 = 10 (x_3 + x_4)} "where" n gt.eq 4$

  ✅ $h(x)$ is a linear function ($h(x) = x_1 + x_2 -10x_3 - 10x_4$) so $h(x)$ is also affine and is therefore convex

  5. $S = {x in RR^n | max_(i=1, dots, n) {x_i} = 10 min_(i=1, dots, m) {x_i}}$

  ❌ $min(x)$ and $max(x)$

  *Question 2*

  For each of the following functions, select all that are convex over the given region: 

  1. $f(x) = 2x^3 - x^2 - 2x + 1$ for $x in RR$

  $f'(x) = 6x^2 - 2x - 2$

  $f''(x) = 12x - 2$

  ❌ 

  2. $f(x) = cases(
    -x quad "if" x lt 1,
    -1 quad "if" x gt.eq 1
  ) quad "for" x in RR$

  ✅ 

  3. $f(x) = x_1^2 - 4x_1 x_2 + 3x_2^2 + 3x_1 + 4x_2$ for $x in RR^2$

  ❌ 

  4. $f(x) = sum_(i=1)^n (x_i - a)^2$ where $a gt 0$, $x in RR^n$

  ✅ 

  5. $f(alpha, beta) = sum_(i=1)^n (alpha + beta x_i - y_i)^2$, where $x_i, y_i, alpha, beta in RR$

  ✅ 

  *Question 3*

  For the NLP

  $
    min& quad 2x^3 - x^2 - 2x + 1 \
    s.t.& quad x gt.eq -1
  $

  which of the following statements is correct?

  1. This is a convex program. 
  
  ❌

  2. There are two local minimizers. 

  ✅

  3. The unique global minimizer is a boundary point. 

  ❌

  4. This program is unbounded. 

  ❌

  5. None of the above.

  ❌

  *Question 4*

  For each of the following matrices, select all that are positive semi-definite:

  1. 

  $
    A = mat(
      1, 1;
      1, 1
    )
  $

  ✅ 

  2. 

  $
    A =mat(
      1, 2, 3;
      2, 3, 1;
      3, 1, 2;
    )
  $

  ❌ 

  3.

  $
    A =mat(
      1, 2, 3;
      0, 3, 1;
      0, 0, 2;
    )
  $

  ✅ 

  4.

  $
    A =mat(
      1, 2, 3, dots, n;
      0, 2, 3, dots, n;
      0, 0, 3, dots, n;
      dots.v, dots.v, dots.v, dots.down, dots.v; 
      0, 0, 0, dots, n;
    )
  $

  ✅ 

  5.

  $
    A =mat(
      0, 0, 1;
      0, 1, 0;
      1, 0, 0;
    )
  $

  ❌ 

  *Question 5*

  For the following statements, select all that are *incorrect*: 
  
  1. An optimal solution to a linear program must be a boundary point. 

  ❌ not guaranteed if the objective is constant over the feasible region

  2. An optimal solution to a linear program must be an extreme point.  

  ✅  

  3. An optimal solution to a nonlinear program can be an interior point. 

  ❌ 

  4. An optimal solution to a nonlinear program must be an interior point.

  ✅  

  5. A global optimal solution to a nonlinear program must be a local optimal solution. 

  ❌ 
]