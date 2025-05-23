#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

= Limits & Continuity

#let color = black
#let style = (stroke: 2pt, color: color)
#let mark-size = 0.03
#let mark-style-white = (fill: white)



= Properties of Limits

== Continuous

=== Addition, Substraction, Multiplication, Division

$
lim_(x arrow c) (colorMath(f(x), #red) * colorMath(g(x), #blue)) = lim_(x arrow c) colorMath(f(x), #red) * lim_(x arrow c) colorMath(g(x), #blue) \
* in {+, -, times, div}
$

=== Constant

$
lim_(x arrow c) colorMath(k, #blue) colorMath(f(x), #red) = colorMath(k, #blue) lim_(x arrow c) colorMath(f(x), #red)
$

== Non-continuous

Even though the limit for either function may not exist, their $*$ can exist as long as
  
$
lim_(x arrow colorMath(c^-, #red)) (f(x) * g(x)) quad quad = quad quad lim_(x arrow colorMath(c^+, #red)) (f(x) * g(x)) \
* in {+, -, times, div}
$

#let f = cetz.canvas(length: 6cm, {
  import cetz.draw: *
  import cetz-plot: *
  plot.plot(
    x-tick-step: 1, 
    y-tick-step: 1,
    y-min: -4,
    y-max: 4,
    x-min: -4,
    x-max: 4,
    x-grid: true,
    y-grid: true,
    axis-style: "school-book",
    mark-style: (fill: black, stroke: color),
    plot-style: (stroke: 2pt, color: red),
    {
      plot.add(((-4,4), (-2,1),))
      plot.add(((-2,3), (1,2),))
      plot.add(((1,-1), (4,2),))

      plot.add(
        ((-2,1),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white
      )
      plot.add(
        ((-2,3),),
        mark: "o",
        mark-size: mark-size,
      )
      plot.add(
        ((1,2),),
        mark: "o",
        mark-size: mark-size,
      )
      plot.add(((1,-1),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white
      )
    }
  )
})

#let g = cetz.canvas(length: 6cm, {
  import cetz.draw: *
  import cetz-plot: *
  plot.plot(
    x-tick-step: 1, 
    y-tick-step: 1,
    y-min: -4,
    y-max: 4,
    x-min: -4,
    x-max: 4,
    x-grid: true,
    y-grid: true,
    axis-style: "school-book",
    mark-style: (fill: black, stroke: color),
    plot-style: (stroke: 2pt, color: red),
    {
      plot.add(((-4,-2), (-2, 3),))
      plot.add(((-2,1), (0,1), (2,-1), (4,-1)))

      plot.add(
        ((-2,3),),
        mark: "o",
        mark-size: mark-size,
      )
      plot.add(
        ((-2,1),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white,
      )
    }
  )
})



#eg[
  #figure(
      grid(
          columns: (auto, auto),
          rows:    (auto, auto),
          column-gutter: 5em,
          row-gutter: 1em,
          [ #f ], [ #g ],
          [$f(x)$], [$g(x)$]
      ),
  )
  

  *Problem 1:* Limit Exists

  $
  lim_(x arrow -2) (f(x) + g(x))
  $

  1. Left-hand limit ($x arrow -2^-$)
  
  $
  lim_(x arrow -2^-) f(x) = 1
  quad quad quad
  lim_(x arrow -2^-) g(x) = 3
  $

  Adding these

  $
  lim_(x arrow -2^-) (f(x) + g(x)) 
  &= lim_(x arrow -2^-) f(x) + lim_(x arrow -2^-) g(x) \
  &= 1 + 3 \ 
  &= 4 \
  $

  2. Right-hand limit ($x arrow -2^+$)
  
  $
  lim_(x arrow -2^+) f(x) = 3
  quad quad quad
  lim_(x arrow -2^+) g(x) = 1
  $

  Adding these
  
  $
  lim_(x arrow -2^+) (f(x) + g(x)) 
  &= lim_(x arrow -2^+) f(x) + lim_(x arrow -2^+) g(x) \
  &= 3 + 1 \ 
  &= 4 \
  $

  3. Since both the left-hand and right-hand limits agree

  $
    lim_(x arrow -2) (f(x) + g(x)) = 4
  $

  *Problem 2:* Limit Does Not Exist

  $
  lim_(x arrow 1) (f(x) + g(x))
  $

  1. Left-hand limit ($x arrow 1^-$)

  $
  lim_(x arrow 1^-) f(x) = 2
  quad quad quad
  lim_(x arrow 1^-) g(x) = 0
  $

  Adding these

  $
  lim_(x arrow 1^-) (f(x) + g(x)) 
  &= lim_(x arrow 1^-) f(x) + lim_(x arrow 1^-) g(x) \
  &= 2 + 0 \ 
  &= 2 \
  $

  2. Right-hand limit ($x arrow 1^+$)

  $
  lim_(x arrow 1^+) f(x) = -1
  quad quad quad
  lim_(x arrow 1^+) g(x) = 0
  $

  Adding these

  $
  lim_(x arrow 1^+) (f(x) + g(x)) 
  &= lim_(x arrow 1^+) f(x) + lim_(x arrow 1^+) g(x) \
  &= -1 + 0 \ 
  &= -1 \
  $

  3. Since both the left-hand and right-hand limits do not agree, the limit $lim_(x arrow c) (f(x) + g(x))$ does not exist

]

== Composite Functions

$
lim_(x arrow c) f(g(x)) = f(lim_(x arrow c) g(x))
$

For this to hold true, two important conditions must be satisfied:

- *Inner limit exists*: The limit $lim_(x arrow c)$ must exist and equal some value $L$. That is, as $x$ gets arbitrarily close to $c$, $g(x)$ approaches a well-defined number $L$

- *Continuity of the outer function*: The function $f$ must be continuous at the point $L$. Continuity ensures that $f$ behaves predictably near $L$, without any jumps, gaps, or undefined points


#let f = cetz.canvas(length: 6cm, {
  import cetz.draw: *
  import cetz-plot: *
  plot.plot(
    x-tick-step: 1, 
    y-tick-step: 1,
    y-min: -4,
    y-max: 4,
    x-min: -4,
    x-max: 4,
    x-grid: true,
    y-grid: true,
    axis-style: "school-book",
    mark-style: (fill: black, stroke: color),
    plot-style: (stroke: 2pt, color: red),
    {
      plot.add(((-4,-1), (-2, 2), (0, 3), (1, 2),))
      plot.add(((1,1), (4,-2),))

      plot.add(
        ((2,3),),
        mark: "o",
        mark-size: mark-size,
      )
      plot.add(
        ((1,2),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white
      )
      plot.add(
        ((1,1),),
        mark: "o",
        mark-size: mark-size,
      )
      plot.add(((2,0),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white
      )
    }
  )
})

#let g = cetz.canvas(length: 6cm, {
  import cetz.draw: *
  import cetz-plot: *
  plot.plot(
    x-tick-step: 1, 
    y-tick-step: 1,
    y-min: -4,
    y-max: 4,
    x-min: -4,
    x-max: 4,
    x-grid: true,
    y-grid: true,
    axis-style: "school-book",
    mark-style: (fill: black, stroke: color),
    plot-style: (stroke: 2pt, color: red),
    {
      plot.add(((-4,3), (-2, 3), (0, 2), (2, -2),))
      plot.add(((2,0), (3,1), (4,0),))

      plot.add(
        ((-3,3),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white,
      )
      plot.add(
        ((-3,-2),),
        mark: "o",
        mark-size: mark-size,
      )
      plot.add(
        ((2,-2),),
        mark: "o",
        mark-size: mark-size,
        mark-style: mark-style-white
      )
      plot.add(
        ((2,0),),
        mark: "o",
        mark-size: mark-size
      )
    }
  )
})

#eg[
  #figure(
      grid(
          columns: (auto, auto),
          rows:    (auto, auto),
          column-gutter: 5em,
          row-gutter: 1em,
          [ #f ], [ #g ],
          [$f(x)$], [$g(x)$]
      ),
  )

  *Problem 1:* Inner Limit & Continuity Exist
  
  $
  lim_(x arrow -3) f(g(x))
  $

  1. Inner limit $lim_(x arrow -3) g(x)$

  Observing $g(x)$, as $x arrow -3$, $g(x) arrow 3$. The inner limit $L = 3$ exists

  $
  lim_(x arrow -3) g(x) = 3
  $

  2. Continuity of $f(x)$ at $x = 3$

  Observing $f(x)$, $f(3) = -1$. Since $f(x)$ is continuous at $x = 3$, the composite limit holds

  $
  f(lim_(x arrow -3) g(x)) 
  &= f(3) \
  &= -1
  $

  *Problem 2:* Inner Limit Does Not Exist

  $
    lim_(x arrow 2) f(g(x))
  $

  1. Inner limit $lim_(x arrow 2) g(x)$

  Observing $g(x)$, as $x arrow 2$, $g(x) arrow 2$. The inner limit does not exist

  *Problem 3:* Continuity Does Not Exist

  $
    lim_(x arrow 0.5) f(g(x))
  $

  1. Inner limit $lim_(x arrow 0.5) g(x)$

  Observing $g(x)$, as $x arrow 0.5$, $g(x) arrow 1$. The inner limit $L = 1$ exists

  $
    lim_(x arrow 0.5) g(x) = 1
  $

  2. Continuity of $f(x)$ at $x = 1$

  Observing $f(x)$, $f(1)$ is not continuous. Since $f(x)$ is not continuous at $x = 1$, the composite limit does not hold

]

== Limits by Direct Substitution

#eg[

  Limit exists

  $
    lim_(x arrow -1) (6x^2 +5x -1)
    & = 6 (-1)^2 + 5 (-1) - 1 \
    &= 6 - 5 - 1 \
    &= 0
  $

  Limit does not exist (Undefined)
  
  $
    lim_(x arrow 1) x / ln(x)
    & = 1 / ln(1) \
    &= 1 / 0 \
  $
]

=== Limits of Piecewise Functions

=== Absolute Value

== Limits by Factoring 

== Limits by Rationalizing

== Continuity & Differentiability at a Point

#eg[

  Piecewise function:

  $
    f(x) = cases(
      x^2 quad &"if" x < 3,
      6x - 9 quad &"if" x gt.eq 3,
    )
  $

  1. Check for *Continuity*

  - Value of $f(3)$

  $
    f(3) 
    = 6(3) -9
    = #result[9]
  $

  - Left-Hand Limit (LHL)

  $
    lim_(x arrow 3^-) f(x) 
    = 3^2
    = #result[9]
  $

  - Right-Hand Limit (RHL)
  
  $
    lim_(x arrow 3^+) f(x) 
    = 6 (3) - 9
    = #result[9]
  $

  Since $f(3) = lim_(x arrow 3^-) f(x) = lim_(x arrow 3^+) f(x)$, $f(x)$ is *continuous* at $x = 3$

  2. Check for *Differentiability*

  - Left-Hand Derivative (LHD)

  $
    lim_(x arrow 3^-) (f(x) - f(3)) / (x - 3) 
    &= (x^2 - 3^2) / (x - 3) \
    &= (x^2 - 9) / (x - 3) \
    &= ((x + 3)(x - 3)) / (x - 3) \
    &= x + 3 \
    &= #result[6] \
  $

  - Right-Hand Derivative
  
  $
    lim_(x arrow 3^+) (f(x) - f(3)) / (x - 3) 
    &= ((6x - 9) - 3^2) / (x - 3) \
    &= (6x - 9 - 9) / (x - 3) \
    &= (6x - 18) / (x - 3) \
    &= (6(x - 3)) / (x - 3) \
    &= #result[6] \ 
  $

  Since the left-hand and right-hand derivatives are equal, $f(x)$ is *differentiable* at $x = 3$

  *Conclusion*: $f(x)$ is both continuous & differentiable at $x = 3$
]

#eg[

]








