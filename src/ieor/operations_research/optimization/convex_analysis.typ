#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition

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

Suppose a local minimum $x'$ is not a global minimum and there exists $x''$ such that $f(x'') lt f(x')$. Consider a small enough $lambda gt 0$ such that $overline(x) = lambda x'' + (1 - lambda) x'$ satisfies $f(overline(x)) gt f(x')$. Such $overline(x)$ exists because $x'$ is a local minimum. Now, note that

$
  f(overline(x)) 
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
      x-ticks: ((1.457, $x'$), (1.8, $overline(x)$), (3.655, $x''$),),
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

