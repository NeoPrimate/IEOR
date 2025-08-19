#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

== Differential Equations

A differential equation specifies a relationship between an unknown function and its derivatives

Solving for (an) unknow function(s) that satisfy this relationship

Initial or boundary conditions to select a unique solution

=== Linearity

The *dependent* variable and its derivatives each appear only to the first power, are not multiplied together, and are not inside any other function

#eg[
  Linear

  $
    (dif y) / (dif t) + y = 0
  $

  Non-Linear

  $
    (dif y) / (dif t) + y^colorMath(2, #red) = 0 \
    (dif y) / (dif t) + colorMath(sin\(, #red)y colorMath(\), #red) = 0 \
    (dif y) / (dif t) + colorMath(e, #red)^y = 0 \
  $
]

=== Homogeneity

  - *Homogeneous*: No terms with just the *independent* varible of *constant*

  - *Nonhomogeneous*: Has term(s) with just the *independent* variable or *constants*

#eg[
  Homogeneous

  $
    (dif y) / (dif t) + y = 0
  $

  Non-Homogeneous

  $
    (dif y) / (dif t) + y = colorMath(1, #red) \
    (dif y) / (dif t) + y = colorMath(sin\(, #red)t colorMath(\), #red) \
    (dif y) / (dif t) + y = colorMath(e, #red)^t \
  $

]

=== Order & Degree

  - Order: highest derivative

  - Degree: exponent on highest derivative

#eg[
  Order

  $
    (dif y) / (dif x) + y = x quad quad &"1st order" \
    (dif^colorMath(2, #red) y) / (dif x^colorMath(2, #red)) + y = x quad quad &"2st order" \
  $

  Degree

  $
    ((dif^2 y) / (dif x^2))^colorMath(3, #red) + y = x quad quad "3rd degree" \
  $
]

=== Autonomous

The *independent* variable does not appear explicitly in the equation (rate of change depends only on the dependent variable)

#eg[
  
  - Autonomous
  
  $
    (dif y) / (dif t) = y
  $

  - Non-Autonomous

  $
    (dif y) / (dif colorMath(t, #red)) = y + colorMath(t, #red)
  $
]

=== Ordinary Differential Equation (ODE)
- *One* independent variable
- Involves *ordinary derivatives* with respect to that variable

=== Partial Differential Equation (PDE)
- *Multiple* independent variables
- Involves *partial derivatives* with respect to those variables

=== Summary

- Inputs 
  - Equation itself
  - Initial/boundary conditions (optional)
- Outputs
  - Function(s) that satisfy it
- Defined for *continuous variables*

#eg[
  #text(size: 16pt, weight: "semibold")[Non-coupled ODE]
  
  #text(size: 14pt, weight: "semibold")[Exponential Population Growth]

  $
    dif / (dif t) P(t) = r dot P(t)
  $

  - $P(t)$: population at time $t$

  - $dif / (dif t) P(t)$: rate of change of the population at time $t$

  - $r$: growth rate constant

  - $r dot P(t)$: growth contribution proportional to the current population

  #align(center)[
    #cetz.canvas(length: 10cm, {
      import cetz.draw: *
      import cetz-plot: *
      import math: exp

      let min = 0      // t-axis
      let max = 10
      let Pmin = 0     // population axis
      let Pmax = 20
      let L = 0.75

      // Initial condition
      let t0 = 0
      let P0 = 1

      // Growth rate
      let r = 0.3

      // Step size for Euler
      let h = 0.1

      // Slope field function
      let slope = (t,P) => r*P

      // Euler solver
      let euler = (f, t0, P0, h, n) => {
        let pts = ((t0,P0),)
        let t = t0
        let P = P0
        for i in range(0,n) {
          P = P + h * f(t,P)
          t = t + h
          pts.push((t,P))
        }
        pts
      }

      // number of steps forward/backward
      let n_forward = int((max - t0)/h)
      let n_backward = int((t0 - min)/h)

      let forward = euler(slope, t0, P0, h, n_forward)
      let backward = euler(slope, t0, P0, -h, n_backward)
      let sol = backward.rev() + forward

      plot.plot(
        x-tick-step: 2, 
        y-tick-step: 2,
        y-min: Pmin,
        y-max: Pmax,
        x-min: min,
        x-max: max,
        x-grid: true,
        y-grid: true,
        axis-style: "scientific",
        {
          // slope field
          for t in range(min, max+1) {
            for P in range(Pmin, Pmax+1) {
              let m = slope(t,P)
              let norm = calc.sqrt(1 + m*m)
              let dx = (L/2) * (1 / norm)
              let dy = (L/2) * (m / norm)

              let p1 = (t - dx, P - dy)
              let p2 = (t + dx, P + dy)

              plot.add((p1, p2), style: (stroke: black))
            }
          }

          // numerical solution curve
          plot.add(sol, style: (stroke: (paint: red, thickness: 2pt)))

          // mark initial condition
          plot.add(((t0,P0),),
            mark: "o",
            mark-size: 0.05,
            mark-style: (fill: red, stroke: black)
          )
        }
      )
    })
  ]

]

#eg[
  #text(size: 16pt, weight: "semibold")[Coupled ODE]
  
  #text(size: 14pt, weight: "semibold")[Lotka-Volterra ODEs (predator-prey)]

  

  $
    (dif) / (dif t) x(t) &= alpha x(t) - beta x(t) y(t) \
    (dif) / (dif t) y(t) &= delta x(t) y(t) - gamma y(t) \
  $

  - $x(t)$ = prey population

  - $y(t)$ = predator population

  - $(dif) / (dif t) x(t)$: The rate of change of the prey population at time $t$
  
  - $(dif) / (dif t) y(t)$: The rate of change of the predator population at time $t$

  - $alpha$: Prey growth rate — how fast the prey multiply in the absence of predators

  - $beta$: Predation rate — how effectively predators consume prey

  - $delta$: Predator growth rate — how much predator population increases when consuming prey

  - $gamma$: Predator death rate — how fast predators die without enough food

  - $alpha x(t)$: prey naturally reproduce at a rate proportional to how many exist now

  - $- beta x(t) y(t)$: prey lost to predation, proportional to encounters with predators

  - $delta x(t) y(t)$: predators grow in number based on how much prey they consume  
  
  - $- gamma y(t)$: predators die naturally when there isn't enough food

  #align(center)[
    #cetz.canvas(length: 12cm, {
      import cetz.draw: *
      import cetz-plot: *

      let minX = 0
      let maxX = 20
      let minY = 0
      let maxY = 20
      let L = 0.5  // length of slope vectors

      // Lotka-Volterra parameters
      let alpha = 1.1
      let beta = 0.4
      let gamma = 0.4
      let delta = 0.1

      // Initial condition
      let x0 = 10
      let y0 = 5

      // Step size for numerical integration
      let h = 0.05
      let n = 1000

      let x_eq = gamma/delta
      let y_eq = alpha/beta

      // Vector field function
      let LV = (x,y) => ((alpha*x - beta*x*y), (delta*x*y - gamma*y))

      // Euler solver for vector system
      let euler2D = (f, x0, y0, h, n) => {
        let pts = ((x0,y0),)
        let x = x0
        let y = y0
        for i in range(0,n) {
          let (dx, dy) = f(x,y)
          x = x + h*dx
          y = y + h*dy
          pts.push((x,y))
        }
        pts
      }

      // Compute trajectory
      let traj = euler2D(LV, x0, y0, h, n)

      plot.plot(
        x-tick-step: 5,
        y-tick-step: 5,
        x-min: minX,
        x-max: maxX,
        y-min: minY,
        y-max: maxY,
        x-grid: true,
        y-grid: true,
        axis-style: "scientific",
        {
          // slope field (phase plane)
          for x in range(minX, maxX+1) {
            for y in range(minY, maxY+1) {
              let (dx, dy) = LV(x,y)
              let norm = calc.sqrt(dx*dx + dy*dy)
              if norm != 0 {
                let p1 = (x - L/2 * dx/norm, y - L/2 * dy/norm)
                let p2 = (x + L/2 * dx/norm, y + L/2 * dy/norm)
                plot.add((p1,p2), style: (stroke: black))
              }
            }
          }

          // trajectory from initial condition
          plot.add(traj, style: (stroke: (paint: red, thickness: 2pt)))

          // mark initial condition
          plot.add(((x0,y0),),
            mark: "o",
            mark-size: 0.05,
            mark-style: (fill: red, stroke: black)
          )

          plot.add(((x_eq, y_eq),),
            mark: "o",
            mark-size: 0.025,
            mark-style: (fill: red, stroke: black)
          )
        }
      )
    })
  ]

]

== Slope Field (Direction Field)

#eg[
  IVP (Initial Value Problem)

  // Initial condition
  #let x1 = 2
  #let y1 = 1

  $
    cases(
      (dif y) / (dif x) = y,
      y(#x1) = #y1
    )
  $

  #align(center)[
    #cetz.canvas(length: 10cm, {
      import cetz.draw: *
      import cetz-plot: *

      let min = -10
      let max = 10
      let L = 0.75

      // Step size
      let h = 0.1

      // Define slope field function dy/dx = f(x,y)
      let slope = (x,y) => y   // try changing to: x - y, x*y, y*(1-y), etc.

      // ---------------------------
      // Euler solver (forward or backward)
      // ---------------------------
      let euler = (f, x0, y0, h, n) => {
        let pts = ((x0,y0),)
        let x = x0
        let y = y0
        for i in range(0,n) {
          y = y + h * f(x,y)
          x = x + h
          pts.push((x,y))
        }
        pts
      }

      // number of steps forward/backward
      let n_forward = int((max - x1)/h)
      let n_backward = int((x1 - min)/h)

      // integrate forward
      let forward = euler(slope, x1, y1, h, n_forward)

      // integrate backward (negative step size)
      let backward = euler(slope, x1, y1, -h, n_backward)

      // combine (backward reversed + forward)
      let sol = backward.rev() + forward

      plot.plot(
        x-tick-step: 5, 
        y-tick-step: 5,
        y-min: min,
        y-max: max,
        x-min: min,
        x-max: max,
        x-grid: true,
        y-grid: true,
        axis-style: "scientific",
        {
          // slope field
          for x in range(min, max+1) {
            for y in range(min, max+1) {
              let m = slope(x,y)
              let norm = calc.sqrt(1 + m*m)
              let dx = (L/2) * (1 / norm)
              let dy = (L/2) * (m / norm)

              let p1 = (x - dx, y - dy)
              let p2 = (x + dx, y + dy)

              plot.add((p1, p2), style: (stroke: black))
            }
          }

          // full numerical solution curve
          plot.add(sol, style: (stroke: (paint: red, thickness: 2pt)))

          // mark initial condition
          plot.add(((x1,y1),),
            mark: "o",
            mark-size: 0.05,
            mark-style: (fill: red, stroke: black)
          )
        }
      )
    })
  ]
]

#eg[
  IVP (Initial Value Problem)

  // Initial condition
  #let x1 = -5
  #let y1 = 1

  $
    cases(
      (dif y) / (dif x) = x - y,
      y(#x1) = #y1
    )
  $

  #align(center)[
    #cetz.canvas(length: 10cm, {
      import cetz.draw: *
      import cetz-plot: *

      let min = -10
      let max = 10
      let L = 0.75

      // Step size
      let h = 0.1

      // Define slope field function dy/dx = f(x,y)
      let slope = (x,y) => x - y   // try changing to: x - y, x*y, y*(1-y), etc.

      // ---------------------------
      // Euler solver (forward or backward)
      // ---------------------------
      let euler = (f, x0, y0, h, n) => {
        let pts = ((x0,y0),)
        let x = x0
        let y = y0
        for i in range(0,n) {
          y = y + h * f(x,y)
          x = x + h
          pts.push((x,y))
        }
        pts
      }

      // number of steps forward/backward
      let n_forward = int((max - x1)/h)
      let n_backward = int((x1 - min)/h)

      // integrate forward
      let forward = euler(slope, x1, y1, h, n_forward)

      // integrate backward (negative step size)
      let backward = euler(slope, x1, y1, -h, n_backward)

      // combine (backward reversed + forward)
      let sol = backward.rev() + forward

      plot.plot(
        x-tick-step: 5, 
        y-tick-step: 5,
        y-min: min,
        y-max: max,
        x-min: min,
        x-max: max,
        x-grid: true,
        y-grid: true,
        axis-style: "scientific",
        {
          // slope field
          for x in range(min, max+1) {
            for y in range(min, max+1) {
              let m = slope(x,y)
              let norm = calc.sqrt(1 + m*m)
              let dx = (L/2) * (1 / norm)
              let dy = (L/2) * (m / norm)

              let p1 = (x - dx, y - dy)
              let p2 = (x + dx, y + dy)

              plot.add((p1, p2), style: (stroke: black))
            }
          }

          // full numerical solution curve
          plot.add(sol, style: (stroke: (paint: red, thickness: 2pt)))

          // mark initial condition
          plot.add(((x1,y1),),
            mark: "o",
            mark-size: 0.05,
            mark-style: (fill: red, stroke: black)
          )
        }
      )
    })
  ]


]
