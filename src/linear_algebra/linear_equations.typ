#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath

#set math.vec(delim: "[")
#set math.mat(delim: "[")


== Solving Systems of Linear Equations

Linear Equation

$
y = a_1 x_1 + a_1 x_2 + ... + a_n x_n
$

1. Consistency 

Whether a system of linear equations has at least one solution

#eg[

  *Consistent System*
  
  $
  x + y = 3 \
  x - y = 1 \
  $
  
  This system has a unique solution 
  
  $
  (x, y) = (2, 1)
  $

  *Inconsistent System*

  $
  x + y = 3 \
  x + y = 5 \
  $

  This system is inconsistent (equations contradict each other, no solution can satisfy both)
]

2. Independence

Whether the equations in the system provide unique and non-redundant information about the variables

#eg[
  *Independent Equations*

  $
  x + y = 3 \
  x - y = 1 \
  $

  Neither equation can be derived from the other (they provide unique information and intersect at a single point)

  *Dependent Equations*

  $
  x + y = 3 \
  2 x + 2 y = 6 \
  $

  Second equation is just a multiple of the first equation (they describe the same line)

]

3. Recognizing Systems with No Solution or Infinite Solutions

#eg[
  $
  3 x + 2 y = 6 quad quad ("Equation" 1) \
  6 x + 4 y = 12 quad quad ("Equation" 2) \
  $

  Unique Solution (Consistent and Independent):

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x$],
        y-label: [$y$],
        x-min: 0, x-max: 1,
        y-min: 0, y-max: 1,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        
        
        plot.add(
          domain: (0, 50),
          x => 1*x + 0,
          style: (stroke: 1pt + red),
        )

        plot.add(
          domain: (0, 50),
          x => -1*x + 1,
          style: (stroke: 1pt + blue),
        )
        
      }
    )
    })
  ]

  No Solution (Inconsistent):

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x$],
        y-label: [$y$],
        x-min: 0, x-max: 1,
        y-min: 0, y-max: 1,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        
        
        plot.add(
          domain: (0, 50),
          x => 1*x + -0.1,
          style: (stroke: 1pt + red),
        )

        plot.add(
          domain: (0, 50),
          x => 1*x + 0.1,
          style: (stroke: 1pt + blue),
        )
      }
    )
    })
  ]

  
  
  Infinitely Many Solutions (Consistent and Dependent): 
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: none, 
        y-tick-step: none, 
        x-label: [$x$],
        y-label: [$y$],
        x-min: 0, x-max: 1,
        y-min: 0, y-max: 1,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        
        
        plot.add(
          domain: (0, 50),
          x => 1*x + 0,
          style: (stroke: 1pt + red),
        )

        plot.add(
          domain: (0, 50),
          x => 1*x + 0,
          style: (stroke: (dash: "dashed")),
        )
      }
    )
    })
  ]

  
  

]






2. Matrix Respresentation 

System of Equations 

$
a_(1 1) x_1 + a_(1 2) x_2 + dots + a_(1 n) x_n = b_1 \
a_(2 1) x_1 + a_(2 2) x_2 + dots + a_(2 n) x_n = b_2 \
dots.v \
a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n = b_m \
$

Matrix Respresentation

Coefficient vector ($Alpha$)

$
A = mat(
  a_(1 1), a_(1 2), dots, a_(1 n);
  a_(2 1), a_(2 2), dots, a_(2 n);
  dots.v, dots.v, dots.down, dots.v;
  a_(2m 1), a_(m 2), dots, a_(m n);
)
$

Variable vector ($x$)

$
x = vec(x_1, x_2, dots.v, x_n) \
$

Constant vector ($b$)

$
b = vec(b_1, b_2, dots.v, b_m)
$

Matrix equation

$
A x = b
$

#code(
  "linear_eq.py",
  ```py
  from scipy.linalg import solve

  X = np.array([
    [1, 1, 1],
    [2, -1, 3],
    [3, 4, -1]
  ])

  Y = np.array([6, 14, 1])

  intersection_point = solve(X, Y)
  ```
)