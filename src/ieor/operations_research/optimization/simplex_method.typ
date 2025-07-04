#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Simplex Method

=== Linear Algebra Review

$
  colorMath(&x + y = 5, #red) \
  colorMath(2&x - y = 4, #green) \
$

*Row* View

Solution: Intersection of $n$ lines or (hyper)planes

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(
      size: (7,7),
      axis-style: "school-book",
      x-tick-step: 2, 
      y-tick-step: 2, 
      x-label: [$$],
      y-label: [$$],
      x-min: -1, x-max: 9,
      y-min: -6, y-max: 6,
      axes: (
        stroke: black,
        tick: (stroke: black),
      ),
    {
      plot.add(
        domain: (-1, 10),
        x => 5 - x,
        style: (stroke: (thickness: 1pt, paint: green)),
        label: none,
      )
      plot.add(
        domain: (-1, 10),
        x => 2*x - 4,
        style: (stroke: (thickness: 1pt, paint: red)),
        label: none,
      )

      plot.annotate({
        content((10, -4.5), [$colorMath(x + y = 5, #green)$])
      })

      plot.annotate({
        content((6, 6.5), [$colorMath(2x - y = 4, #red)$])
      })
      
      plot.annotate({
        content((4, 2), text(size: 7.5pt, $(3, 2)$))
      })
      plot.add(
        ((3,2),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
      plot.annotate({
        content((1.5, 0.5), text(size: 7.5pt, $(2, 0)$))
      })
      plot.add(
        ((2,0),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
      plot.annotate({
        content((5.5, 0.5), text(size: 7.5pt, $(5, 0)$))
      })
      plot.add(
        ((5,0),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
      plot.annotate({
        content((1, 5.5), text(size: 7.5pt, $(0, 5)$))
      })
      plot.add(
        ((0,5),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
      plot.annotate({
        content((1, -4), text(size: 7.5pt, $(0, -4)$))
      })
      plot.add(
        ((0,-4),),
        mark: "o",
        mark-size: 0.15,
        mark-style: (fill: black, stroke: 2pt)
      )
      
    }
  )
  })
]

*Column* View

Solution: Combination of LHS column vectors to form the RHS vector

$
  x colorMath(vec(1, 2), #red) + y colorMath(vec(1, -1), #green) = colorMath(vec(5, 4), #blue)
$

#align(center)[
  #cetz.canvas({

    import cetz.draw: *
    import cetz-plot: *
    
    plot.plot(
      size: (7,7),
      x-tick-step: 2,
      y-tick-step: 2,
      x-minor-tick-step: 1,
      y-minor-tick-step: 1,
      x-min: -1,
      y-min: -2,
      x-max: 6,
      y-max: 7,
      axis-style: "school-book",
      x-label: $$,
      y-label: $$,
      {
        plot.add-anchor("o", (0,0))

        plot.add-anchor("a", (1,2))
        plot.add-anchor("a1", (3,6))
        
        plot.add-anchor("b", (1,-1))
        plot.add-anchor("b1", (2,-2))
        
        plot.add-anchor("c", (5,4))

        plot.annotate({
          content((1.5, 2), text(size: 7.5pt, $(1, 2)$))
        })
        plot.add(
          ((1, 2),),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        
        plot.annotate({
          content((3.5, 6), text(size: 7.5pt, $(3, 6)$))
        })
        plot.add(
          ((3, 6),),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        
        plot.annotate({
          content((5.5, 4), text(size: 7.5pt, $(5, 4)$))
        })
        plot.add(
          ((5, 4),),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        
        plot.annotate({
          content((2.5, -2), text(size: 7.5pt, $(2, -2)$))
        })
        plot.add(
          ((2, -2),),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        
        plot.annotate({
          content((0.5, -1.25), text(size: 7.5pt, $(1, -1)$))
        })
        plot.add(
          ((1, -1),),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        
      }, name: "plot")

      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.o", "plot.a", stroke: red, mark: (fill: black))

      cetz.draw.line("plot.o", "plot.a1", stroke: (thickness: 0.25pt, paint: black), mark: (fill: black))

      cetz.draw.line("plot.o", "plot.b", stroke: green, mark: (fill: black))
      cetz.draw.line("plot.o", "plot.b1", stroke: (thickness: 0.25pt, paint: black), mark: (fill: black))
      
      cetz.draw.line("plot.a1", "plot.c", stroke: (dash: "dashed", paint: black), mark: (fill: black))
      cetz.draw.line("plot.b1", "plot.c", stroke: (dash: "dashed", paint: black), mark: (fill: black))

      cetz.draw.line("plot.o", "plot.c", stroke: blue, mark: (fill: black))

  })
]

A linear system is *singluar* if there is no unique solution
- Row view: the $n$ (hyper)planes do not intersect at exactly one point
- Column view: the $n$ vectors do not span a complete $n$-dimensional space

=== Gaussian Elimination

Given a system $A x = b$, or augmented matrix $mat(augment: #1, A, b)$, use the following 3 rules:

- Row Swapping: $R_i arrow.l.r.long R_j$
- Row Scaling: $k dot R_i arrow.long R_i$
- Row Replacement: $R_i - k dot R_j arrow.long R_i$

To solve the system:

1. Transform the augmented matrix into row echelon form (REF) using these operations:
  - The first nonzero entry (pivot) in each row is to the right of the pivot in the row above
  - All entries below a pivot are zero
  - Rows of all zeros (if any) are at the bottom
2. Back-substitute starting from the last nonzero row to find the solution

#eg[
  *Non-singular Case*

  System of equations

  $
    && 2&y = 4 \
    1&x& + 1&y = 3 \
  $

  Augmented matrix

  $
    mat(
      augment: #2,
      0, 2, 4;
      1, 1, 3
    )
  $

  Swapping ($R_1 arrow.l.r.long R_2$)

  $
    mat(
      augment: #2,
      1, 1, 3;
      0, 2, 4;
    )
  $

  Scaling ($1/2 R_2 arrow.long R_2$)

  *Row Echelon Form (REF)*

  $
    mat(
      augment: #2,
      1, 1, 3;
      0, 1, 2;
    )
  $ 

  Replacement ($R_1 - R_2 arrow.long R_1$)

  *Reduced Row Echelon Form (RREF)*

  $
    mat(
      augment: #2,
      1, 0, 1;
      0, 1, 2;
    )
  $

  Result

  $
    x = 1, quad y = 2
  $

]

#eg[
  *Singular Case*

  System of equations

  $
    &x + &y = 2 \
    2&x + 2&y = 4 \
  $

  Augmented matrix

  $
    mat(
      augment: #2,
      1, 1, 2;
      2, 2, 4;
    )
  $

  Replacement ($R_2 - 2R_1 arrow.long R_2$)

  $
    mat(
      augment: #2,
      1, 1, 2;
      0, 0, 0;
    )
  $

  Infinitely many solutions 
  E.g.
  - $x = 0, quad y = 2$
  - $x = 1, quad y = 1$
  - $x = 2, quad y = 0$
  - etc.

  Rows are *linearly dependent*

  The coefficient matrix

  $
    A = mat(
      1, 1;
      2, 2;
    )
  $

  $A$ has *determinant* 0, so it's *not invertible*
]

=== Inverse

$
  A^(-1) A = I quad and quad A A^(-1) A = I 
$

$A^(-1)$ is *unique*

Finding $A^(-1)$: Gauss-Jordan Elimination

A square matrix is *nonsingular* iif it is *invertible*

$
  mat(
    augment: #1,
    A, I;
  ) 
  arrow.long
  mat(
    augment: #1,
    I, A^(-1)
  )
$

#eg[
  $
    A = mat(
      1, 2;
      2, 1;
    )
  $

  $
    mat(
      augment: #1,
      A, I;
    )
    =
    mat(
      augment: #2,
      1, 2, 1, 0;
      2, 1, 0, 1;
    )
  $

  Replacement ($R_2 - 2 R_1 arrow.long R_2$)

  $
    mat(
      augment: #2,
      1, 2, 1, 0;
      0, -3, -2, 1;
    )
  $

  Scale ($-1/3 R_2 arrow.long R_2$)

  $
    mat(
      augment: #2,
      1, 2, 1, 0;
      0, 1, 2/3, -1/3;
    )
  $

  Replacement ($R_1 - 2 R_2 arrow.long R_1$)

  $
    mat(
      augment: #2,
      1, 0, -1/3, 2/3;
      0, 1, 2/3, -1/3;
    )
  $

  Result

  $
    A^(-1) = mat(
      -1/3, 2/3;
      2/3, -1/3;
    )
  $

]

=== Linear Dependence and Independence

A set of $m$ $n$-dimensional vectors $x_1, x_2, dots, x_m$ are *linearly dependent* if there exists a non-zero vector $w in RR^m$ such that:

$
  w_1 x_1 + w_2 x_2 + dots + w_m x_m = 0
$

That is, at least one of the vectors can be written as a linear combination of the others.

#eg[
  *Dependent*

  Let:

  $
    x_1 = vec(1, 2), quad x_2 = vec(2, 4)
  $

  Augmented:

  $
    mat(
      augment: #2,
      1, 2, 0;
      2, 4, 0;
    )
  $

  Elimination ($R_2 - 2 R_1 arrow.long R_2$)

  $
    mat(
      augment: #2,
      1, 2, 0;
      0, 0, 0;
    )
  $

  *Independent*

  Let:

  $
    x_1 = vec(1, 2), quad x_2 = vec(3, 1)
  $

  Augmented:

  $
    mat(
      augment: #2,
      1, 3, 0;
      2, 1, 0;
    )
  $

  Elimination ($R_2 - 2 R_1 arrow.long R_2$)

  $
    mat(
      augment: #2,
      1, 2, 0;
      0, -5, 0;
    )
  $

  Back-substitute

  - $-5 w_2 = 0 arrow.double w_2 = 0$
  - $w_1 + 3 w_2 = 0 arrow.double w_1 = 0$

  Only solution is $w_1 = w_2 = 0$

]

In Gaussian elimination, a *row of all zeros *

1. *Homogeneous* System (RHS = 0)

$
  mat(
    augment: #2,
    1, 2, 0;
    0, 0, 0;
  )
$

$
  x_1 + 2 x_2 = 0 \
  0 = 0
$

- ✅ Represents a *redundant* equation (i.e., no new information) *dependent* set of vectors
- ✅ Does not affect consistency: the system is always *consistent*
- ✅ The system has fewer pivots than variables, hence *infinitely many solutions*

2. *Inconsistent* System (Nonzero RHS)

$
  mat(
    augment: #2,
    1, 2, 3;
    0, 0, 5;
  )
$

$
  x_1 + 2 x_2 = 3 \
  0 = 5
$

- ❌ The second row leads to a *contradiction*
- ❌ The system is *inconsistent* (*no solution*)

=== Extreme Points

Given that $x$, $x_1$, and $x_2$ are points in the set $S$:
- If you can find two different points $x_1$ and $x_2$ in $S$ such that $x$ lies somewhere strictly between them on the straight line connecting $x_1$ and $x_2$, then $x$ is not an extreme point
- If no such pair of points exists—meaning you cannot place $x$ anywhere strictly between two other points in $S$ on a straight line—then $x$ is an extreme point

Formal Definition

For a set $S in RR^n$, a point $x$ is an extreme point if there does not exist a three-tuple $(x_1, x_2, lambda)$ such that $x_1 in S$, $x_2 in S$, $lambda in (0, 1)$, and

$
  x = lambda x_1 + (1 - lambda) x_2
$

A point $x$ in set $S subset.eq RR^n$ is extreme if it cannot be written as a strict *convex combination* of two different points $x_1, x_2 in S$.

#align(center)[
  #let a = (1,1)
  #let b = (3,1)
  #let c = (5,3)
  #let d = (2,5)
  #let e = (1,3)
  
  #let x_e = d
  #let x_ne = (2,2)

  #cetz.canvas({

    import cetz.draw: *
    import cetz-plot: *
    
    plot.plot(
      size: (7,7),
      x-tick-step: 2,
      y-tick-step: 2,
      x-minor-tick-step: 1,
      y-minor-tick-step: 1,
      x-min: 0,
      y-min: 0,
      x-max: 6,
      y-max: 6,
      axis-style: "school-book",
      x-label: $$,
      y-label: $$,
      plot-style: (stroke: 1pt),
      {
        plot.add-anchor("a", a)
        plot.add-anchor("b", b)
        plot.add-anchor("c", c)
        plot.add-anchor("d", d)
        plot.add-anchor("e", e)
        
        plot.add-anchor("x_e", x_e)
        plot.add-anchor("x_ne", x_ne)

        let m_e = 0.5
        let delta_e = 1

        let x_e1 = (x_e.at(0) - delta_e, x_e.at(1) - delta_e * m_e)
        let x_e2 = (x_e.at(0) + delta_e, x_e.at(1) + delta_e * m_e)
        
        let m_ne = 3
        let delta_ne = 0.2

        let x_ne1 = (x_ne.at(0) - delta_ne, x_ne.at(1) - delta_ne * m_ne)
        let x_ne2 = (x_ne.at(0) + delta_ne, x_ne.at(1) + delta_ne * m_ne)

        plot.add((a, b, c, d, e, a))

        plot.add((x_e1, x_e2,))
        
        plot.add((x_ne1, x_ne2,))

        plot.add(
          (a,),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          (b,),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          (c,),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          (d,),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        plot.add(
          (e,),
          mark: "o",
          mark-size: 0.1,
          mark-style: (fill: black, stroke: 2pt)
        )
        
        plot.add(
          (x_e,),
          mark: "o",
          mark-size: 0.25,
          mark-style: (fill: red, stroke: 0pt)
        )
        
        plot.add(
          (x_ne,),
          mark: "o",
          mark-size: 0.25,
          mark-style: (fill: red, stroke: 0pt)
        )
        

        plot.annotate({
          content((a.at(0)-0.25, a.at(1)-0.25), text(size: 7.5pt, repr(a)))
        })
        plot.annotate({
          content((b.at(0)+0.25, b.at(1)-0.25), text(size: 7.5pt, repr(b)))
        })
        plot.annotate({
          content((c.at(0)+0.25, c.at(1)-0.25), text(size: 7.5pt, repr(c)))
        })
        plot.annotate({
          content((d.at(0)-0.25, d.at(1)+0.25), text(size: 7.5pt, $x_e$))
        })
        plot.annotate({
          content((e.at(0)-0.25, e.at(1)+0.25), text(size: 7.5pt, repr(e)))
        })

        plot.add(
          (x_e1,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: red, stroke: 0pt)
        )
        plot.annotate({
          content((x_e1.at(0)-0.3, x_e1.at(1)+0.25), text(size: 7.5pt, $x_(e 1)$))
        })
        
        plot.add(
          (x_e2,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: red, stroke: 0pt)
        )
        plot.annotate({
          content((x_e2.at(0)+0.3, x_e2.at(1)+0.25), text(size: 7.5pt, $x_(e 2)$))
        })

        plot.add(
          (x_ne1,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: red, stroke: 0pt)
        )
        plot.annotate({
          content((x_ne1.at(0)-0.3, x_ne1.at(1)+0.25), text(size: 7.5pt, $x_(n e 1)$))
        })
        
        plot.add(
          (x_ne2,),
          mark: "o",
          mark-size: 0.15,
          mark-style: (fill: red, stroke: 0pt)
        )
        plot.annotate({
          content((x_ne2.at(0)+0.3, x_ne2.at(1)+0.25), text(size: 7.5pt, $x_(n e 2)$))
        })

        
        
      }, name: "plot")
  })
]

Convex Combination

Let $x_1, x_2, dots, x_k in RR^n$. A convex combination of these vectors is any point of the form:

$
  x = lambda_1 x_1 + lambda_2 x_2 + dots + lambda_k x_k
$

where:
- $lambda_i gt.eq 0 quad forall i$
- $sum^k_(i=1) lambda_i = 1$

$x$ lies strictly between $x_1$ and $x_2$ on the line segment connecting them, not equal to either one


=== Slack and Suplus

*1. Slack*

Unused capacity

#eg[
  Given a constraint:
  
  $
    x_1 + x_2 colorMath(lt.eq, #red) 5
  $

  The total *must not exceed* 5. To convert this into an equation, we *add* a slack variable $s gt.eq 0$:

  $
    x_1 + x_2 colorMath(+ s, #red) = 5
  $

  - If $x_1 + x_2 = 3$, then $s = 2$
  - If $x_1 + x_2 = 5$, then $s = 0$ 

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: 2, 
        y-tick-step: 2, 
        x-label: [$$],
        y-label: [$$],
        x-min: -1, x-max: 6,
        y-min: -1, y-max: 6,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("a", (1,2))
        plot.add-anchor("b", (1,4))

        plot.add(
          domain: (-1, 10),
          x => 5 - x,
          style: (stroke: (thickness: 1pt, paint: green)),
          label: [$x_1 + x_2 = 5$],
        )
        
        plot.add(
          domain: (-1, 10),
          x => 3 - x,
          style: (stroke: (thickness: 1pt, paint: red)),
          label: [$x_1 + x_2 = 3$],
        )

        plot.add(
          ((1, 2),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: black, stroke: none),
        )

        plot.annotate({
          content((1.3, 2.9), text(size: 12pt, $s$))
        })

        plot.add-fill-between(
          domain: (0, 6),
          x => 5 - x,
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

      }, name: "plot")
      
      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.a", "plot.b", stroke: (dash: "dashed", paint: black), mark: (fill: black))
    })
  ]
]

*2. Surplus*

Excess above the required amount

#eg[
  Given a constraint:

  $
    x_1 + x_2 colorMath(gt.eq, #red) 5
  $

  The total *must be at least* 5. To convert this into an equation, we *subtract* a surplus variable $s gt.eq 5$:

  $
    x_1 + x_2 colorMath(- s, #red) = 5
  $

  - If $x_1 + x_2 = 7$, then $s = 2$
  - If $x_1 + x_2 = 5$, then $s = 0$

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (5,5),
        axis-style: "school-book",
        x-tick-step: 2, 
        y-tick-step: 2, 
        x-label: [$$],
        y-label: [$$],
        x-min: -1, x-max: 8,
        y-min: -1, y-max: 8,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("a", (4,3))
        plot.add-anchor("b", (4,1))

        plot.add(
          domain: (-1, 10),
          x => 5 - x,
          style: (stroke: (thickness: 1pt, paint: green)),
          label: [$x_1 + x_2 = 5$],
        )
        
        plot.add(
          domain: (-1, 10),
          x => 7 - x,
          style: (stroke: (thickness: 1pt, paint: red)),
          label: [$x_1 + x_2 = 7$],
        )

        plot.add(
          ((4, 3),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: black, stroke: none),
        )

        plot.annotate({
          content((4.5, 2), text(size: 12pt, $s$))
        })

        plot.add-fill-between(
          domain: (0, 6),
          x => 5 - x,
          x1 => 0,
          style: (fill: rgb(200, 200, 255, 80), stroke: none),
          label: none
        )

      }, name: "plot")
      
      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.a", "plot.b", stroke: (dash: "dashed", paint: black), mark: (fill: black))
    })
  ]
]



#line(length: 100%)

#align(center)[
  #table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.cell(colspan: 3)[*Objective Function*],
    [Max], [✅], [$max z = c^T x$],
    [Min $arrow.long$ Max], [$- z$], [$
      min z = c^T bold(x) \
      arrow.l.r.long.double \
      max z = colorMath(-, #red)c^T bold(x) \
      \
    $],
    table.cell(colspan: 3)[*Constraint Forms*],
    [$lt.eq$], [Slack], [$
      a_1 x_1 + a_2 x_2 lt.eq b \
      a_1 x_1 + a_2 x_2 colorMath(+ s, #red) eq b \                               
    $],
    [$gt.eq$], [Surplus + Artificial], [$
      a_1 x_1 + a_2 x_2 gt.eq b \
      a_1 x_1 + a_2 x_2 colorMath(- s + A, #red) eq b \                               
    $],
    [$eq$], [Artificial], [$
      a_1 x_1 + a_2 x_2 eq b \                         
      a_1 x_1 + a_2 x_2 colorMath(+ A, #red) eq b \                         
    $],
    table.cell(colspan: 3)[*Variable Bounds*],
    [Non-negativity], [], [$
      x_i, s_i, A_i gt.eq 0 quad forall i
    $],
    [Lower Bound ≠ 0], [Substitution], [$
      x_1 gt.eq 5 \
      y_1 = x_1 - 5 \
      x_1 = y_1 + 5 \
      y_1 gt.eq 0
    $],
    table.cell(colspan: 3)[*Variable Roles*],
    [Basic Variables], [Usually non-zero], [Part of the current solution (solved from the constraints)],
    [Non-Basic Variables], [Always zero], [Temporarily set to 0 so basic variables can be solved],
  )
]

#eg[
  $
    max quad  &z = 3x_1 + 2x_2 \
    s.t. quad &x_1 + x_2 lt.eq 4 \
              &x_1 lt.eq 2 \
              &x_2 lt.eq 3 \
              &x_1, x_2 gt.eq 0 \
  $

  *Step 1*: Convert to Standard Form

  $
    max quad  &z = 3x_1 + 2x_2 \
    s.t. quad &x_1 + x_2 colorMath(+ s_1, #red) eq 4 \
              &x_1 colorMath(+ s_2, #red) eq 2 \
              &x_2 colorMath(+ s_3, #red) eq 3 \
              &x_1, x_2, colorMath(s_1, #red), colorMath(s_2, #red), colorMath(s_3, #red) gt.eq 0 \
  $

  Objective

  $
    z - 3x_1 - 2x_2 = 0
  $

  *Step 2*: Initial Tableau

  #align(
    center,
    table(
      // fill: (x, y) =>
      // if x == 5 and y in (0, 4) {
      //   red.lighten(70%)
      // },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [1], [1], [1], [0], [0], [4],
      [$s_2$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [0], [0], [0],

    )
  )

  - Basic Variables: $s_1 = 4$, $s_2 = 2$, $s_3 = 3$
  - Non-basic variables: $x_1 = 0$, $x_2 = 0$
    - $V_0 = (0, 0)$
    - Objective: $z = 3x_1 + 2x_2 = 3(0) + 2(0) = 0$

  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (7.5,7.5),
        axis-style: "school-book",
        x-tick-step: 1, 
        y-tick-step: 1, 
        x-label: [$x_1$],
        y-label: [$x_2$],
        x-min: -0.5, x-max: 4.5,
        y-min: -0.5, y-max: 4.5,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("V_1", (0,0))

        plot.add(
          domain: (-1, 10),
          x => 4 - x,
          style: (stroke: (thickness: 1pt, paint: purple)),
          label: [$x_1 + x_2 lt.eq 4$],
        )

        plot.add-vline(
          2,
          style: (stroke: (thickness: 1pt, paint: green)),
          label: [$x_1 lt.eq 2$],
        )
        plot.add-hline(
          3, 
          style: (stroke: (thickness: 1pt, paint: blue)),
          label: [$x_2 lt.eq 3$],
        )

        plot.add(
          ((0, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        
        plot.annotate({
          content((0.25, 0.25), text(size: 12pt, $V_0$))
        })
       

      }, name: "plot")
    })
  ]

  *Step 3*: Choose entering variable

  - Look at the bottom row ($z$):
    - Coefficients of $x_1 = -3$, $x_2 = -2$
  - Most negative: $x_1$ $arrow.long$ Enter the basis

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 1 and y in (0, 4) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [1], [1], [1], [0], [0], [4],
      [$s_2$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [0], [0], [0],

    )
  )

  *Step 4*: Determine leaving variable

  Look at ratios of $b \/ x_1$:
  
  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (1, 6, 8) and y in (0, 1, 2, 3) {
        red.lighten(70%)
      },
      columns: range(9).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$], [], [$b \/ x_1$],
      table.hline(),
      [$s_1$], [1], [1], [1], [0], [0], [4], [], [$4 \/ 1 = 4$],
      [$s_2$], [1], [0], [0], [1], [0], [2], [], [$2 \/ 1 = 2$],
      [$s_3$], [0], [1], [0], [0], [1], [3], [], [$3 \/ 0 = infinity$],
      table.hline(),
      [$z$], [-3], [-2], [0], [0], [0], [0], [], [],

    )
  )

  - Minimum Ratio
    - $s_2$ leaves, $x_1$ enters

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (0, 6) and y in (2,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [1], [1], [1], [0], [0], [4],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [3], [0], [0],
    )
  )



  *Step 5*: Pivot on row 2, column $x_1$
  

  Now eliminate $x_1$ from other rows:

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (1,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [1], [1], [1], [0], [0], [4],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [3], [0], [0],
    )
  )

  $R_(s_1) := R_(s_1) - R_(x_1)$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (1, 2) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [1], [1], [1], [0], [0], [4],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [3], [0], [0],
    )
  )


  $
    R_(s_1) := R_(s_1) - R_(x_1)
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &1 - 1 = 0,
      x_2& \: quad &1 - 0 = 1,
      s_1& \: quad &1 - 0 = 1,
      s_2& \: quad &0 - 1 = -1,
      s_3& \: quad &0 - 0 = 0,
      b& \: quad   &4 - 2 = 2,
    )
  $

  Update $R_(s_1)$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (1,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [3], [0], [0],
    )
  )

  $R_z := R_z - 3R_(x_1)$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (2, 4) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [-3], [-2], [0], [3], [0], [0],
    )
  )
  
  $
    R_z := R_z - 3R_(x_1)
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &-3 + 3(1) = 0,
      x_2& \: quad &-2 + 3(0) = -2,
      s_1& \: quad &0 + 3(0) = 0,
      s_2& \: quad &0 + 3(1) = 3,
      s_3& \: quad &0 + 3(0) = 0,
      b& \: quad   &0 + 3(2) = 6,
    )
  $

  Update $R_z$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (4,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  

  - Basic Variables: $x_1 = 2$, $s_1 = 2$, $s_3 = 3$
  - Non-basic variables: $x_2 = 0$
    - $V_1 = (2, 0)$
    - Objective: $z = 3x_1 + 2x_2 = 3(2) + 2(0) = 6$

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (0, 6) and y == 2 {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )
  
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (7.5,7.5),
        axis-style: "school-book",
        x-tick-step: 1, 
        y-tick-step: 1, 
        x-label: [$x_1$],
        y-label: [$x_2$],
        x-min: -0.5, x-max: 4.5,
        y-min: -0.5, y-max: 4.5,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("V_1", (0,0))
        plot.add-anchor("V_2", (2,0))

        plot.add(
          domain: (-1, 10),
          x => 4 - x,
          style: (stroke: (thickness: 1pt, paint: purple)),
          label: [$x_1 + x_2 lt.eq 4$],
        )

        plot.add-vline(
          2,
          style: (stroke: (thickness: 1pt, paint: green)),
          label: [$x_1 lt.eq 2$],
        )
        plot.add-hline(
          3, 
          style: (stroke: (thickness: 1pt, paint: blue)),
          label: [$x_2 lt.eq 3$],
        )

        plot.add(
          ((0, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        
        plot.annotate({
          content((0.35, 0.35), text(size: 12pt, $V_0$))
        })
        
        plot.add(
          ((2, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        
        plot.annotate({
          content((2.35, 0.35), text(size: 12pt, $V_1$))
        })
       

      }, name: "plot")
      
      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.V_1", "plot.V_2", stroke: (dash: "dashed", paint: red, thickness: 3pt), mark: (fill: black))
    })
  ]

  *Step 3*: Choose entering variable

  - Look at the bottom row ($z$):
    - Coefficients of $x_2 = -2$
  - Most negative: $x_2$ $arrow.long$ Enter the basis

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 2 and y in (0, 4) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$s_1$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  *Step 4*: Determine leaving variable

  Look at ratios of $b \/ x_2$:
  
  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (2, 6, 8) and y in (0, 1, 2, 3) {
        red.lighten(70%)
      },
      columns: range(9).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$], [], [$b \/ x_2$],
      table.hline(),
      [$s_1$], [0], [1], [1], [-1], [0], [2], [], [$2 \/ 1 = 2$],
      [$x_1$], [1], [0], [0], [1], [0], [2], [], [$2 \/ 0 = infinity$],
      [$s_3$], [0], [1], [0], [0], [1], [3], [], [$3 \/ 1 = 3$],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6], [], [],
    )
  )

  - $s_1$ leaves, $x_2$ enters

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 0 and y in (1,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  *Step 5*: Pivot on row 1, column $x_2$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (1,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  Now eliminate $x_2$ from other rows:

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 2 {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  $R_(s_3) := R_(s_3) - R_(x_2)$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (1,3) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [1], [0], [0], [1], [3],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  $
    R_(s_3) := R_(s_3) - R_(x_2)
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &0 - 0 = 0,
      x_2& \: quad &1 - 1 = 0,
      s_1& \: quad &0 - 1 = -1,
      s_2& \: quad &0 - (-1) = 1,
      s_3& \: quad &1 - 0 = 1,
      b& \: quad   &3 - 2 = 1,
    )
  $

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (3,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [0], [-1], [1], [1], [1],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )

  $R_z = R_z - (-2)R_(x_2) = R_z + 2R_(x_2)$

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (1,4) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [0], [-1], [1], [1], [1],
      table.hline(),
      [$z$], [0], [-2], [0], [3], [0], [6],
    )
  )
  
  $
    R_z = R_z + 2R_(x_2)
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &0 + 2(0) = 0,
      x_2& \: quad &-2 + 2(1) = 0,
      s_1& \: quad &0 + 2(1) = 2,
      s_2& \: quad &3 + 2(-1) = 1,
      s_3& \: quad &0 + 2(0) = 0,
      b& \: quad   &6 + 2(2) = 10,
    )
  $

  #align(
    center,
    table(
      fill: (x, y) =>
      if y in (4,) {
        red.lighten(70%)
      },
      columns: range(7).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$s_3$], [$b$],
      table.hline(),
      [$x_2$], [0], [1], [1], [-1], [0], [2],
      [$x_1$], [1], [0], [0], [1], [0], [2],
      [$s_3$], [0], [0], [-1], [1], [1], [1],
      table.hline(),
      [$z$], [0], [0], [2], [1], [0], [10],
    )
  )

  - Basic Variables: $x_1 = 2$, $x_2 = 2$, $s_3 = 1$
  - Non-basic variables: $s_1 = 0$, $s_2 = 0$
    - $V_2 = (2, 2)$
    - Objective: $z = 3x_1 + 2x_2 = 3(2) + 2(2) = 10$
  
  #align(center)[
    #cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        size: (7.5,7.5),
        axis-style: "school-book",
        x-tick-step: 1, 
        y-tick-step: 1, 
        x-label: [$x_1$],
        y-label: [$x_2$],
        x-min: -0.5, x-max: 4.5,
        y-min: -0.5, y-max: 4.5,
        axes: (
          stroke: black,
          tick: (stroke: black),
        ),
      {
        plot.add-anchor("V_1", (2,0))
        plot.add-anchor("V_2", (2,2))

        plot.add(
          domain: (-1, 10),
          x => 4 - x,
          style: (stroke: (thickness: 1pt, paint: purple)),
          label: [$x_1 + x_2 lt.eq 4$],
        )

        plot.add-vline(
          2,
          style: (stroke: (thickness: 1pt, paint: green)),
          label: [$x_1 lt.eq 2$],
        )
        plot.add-hline(
          3, 
          style: (stroke: (thickness: 1pt, paint: blue)),
          label: [$x_2 lt.eq 3$],
        )

        plot.add(
          ((0, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        
        plot.annotate({
          content((0.35, 0.35), text(size: 12pt, $V_0$))
        })
        
        plot.add(
          ((2, 0),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        
        plot.annotate({
          content((2.35, 0.35), text(size: 12pt, $V_1$))
        })
        
        plot.add(
          ((2, 2),),
          mark: "o",
          mark-size: 0.2,
          mark-style: (fill: red, stroke: 1pt),
        )
        
        plot.annotate({
          content((2.35, 2.35), text(size: 12pt, $V_2$))
        })
       

      }, name: "plot")
      
      cetz.draw.set-style(line: (mark: (end: ">", size: .25)))

      cetz.draw.line("plot.V_1", "plot.V_2", stroke: (dash: "dashed", paint: red, thickness: 3pt), mark: (fill: black))
    })
  ]
]

#eg[

  *Problem Statement*

  $
    min quad  &z = 3x_1 +2x_2 \
    s.t. quad &x_1 +2x_2 lt.eq 4 quad quad &("slack") \
              &2x_1 +x_2 gt.eq 3 quad quad &("surplus + artificial") \
              &x_1 -x_2 = 1 quad quad &("artifical") \
              &x_1, x_2 gt.eq 0 \
  $

  *1. Convert Minimize to Maximize*

  $
    min z = 3x_1 + 2x_2 arrow.double.long max z' = -3x_1 -2x_2
  $

  *2. Convert constraints to equalities with slack, surplus, and artificial variables*

  - $x_1 +2x_2 lt.eq 4$

    Add slack variable $s_1 gt.eq 0$:

  $
    x_1 + 2x_2 + s_1 = 4
  $

  - $2x_1 +x_2 gt.eq 3$

    Subreact surplus $s_2 gt.eq 0$ and add artificial variable $A_1 gt.eq 0$:

  $
    2x_1 + x_2 - s_2 + A_1 = 3
  $

  - $x_1 -x_2 = 1$

    Add artificial variable $A_2 gt.eq 0$:

  $
    x_1 - x_2 + A_2 = 1
  $

  *Final standard form ready for two-phase simplex*

  $
    min quad  &z = colorMath(-, #red)3x_1 colorMath(-, #red) 2x_2 \
    s.t. quad &x_1 + 2x_2 colorMath(+ s_1, #red) eq 4 \
              &2x_1 + x_2 colorMath(- s_2 + A_1, #red) eq 3 \
              &x_1 - x_2 colorMath(+ A_2, #red) = 1 \
              &x_1, x_2, colorMath(s_1\, s_2\, A_1\, A_2, #red) gt.eq 0 \
  $

  *Phase I*

  *Step 1*: Setup

  We want to find a feasible solution by minimizing the sum of artificial variables

  $
    min quad &colorMath(w = A_1 + A_2, #red) \
    s.t. quad &x_1 + 2x_2 + s_1 eq 4 \
              &2x_1 + x_2 - s_2 + A_1 eq 3 \
              &x_1 - x_2 + A_2 = 1 \
              &x_1, x_2, s_1\, s_2\, A_1\, A_2 gt.eq 0 \
  $

  Write Phase I objective in terms of all variables

  *Step 2*: Set initial basis

  - Basic variables: $s_1, A_1, A_2$ (slack and artifical variables)
  - Non-basic variables: $x_1, x_2, s_2$

  *Step 3*: Express Phase I objective row

  We want to express $w = A_1 + A_2$ in terms of the non-basic variables

  - Second constraint:

  $
    A_1 = 3 - 2x_1 - x_2 + s_2
  $

  - Third constraint:

  $
    A_2 = 1 - x_1 + x_2
  $

  So, 

  $
    w 
    &= A_1 + A_2 \
    &= (3 - 2x_1 - x_2 + s_2) + (1 - x_1 + x_2) \
    &= 4 - 3x_1 + s_2 \
  $

  Formulation

  $
    min quad  &4 - 3x_1 + s_2 \
    s.t. quad &x_1 + 2x_2 + s_1 eq 4 \
              &2x_1 + x_2 - s_2 + A_1 eq 3 \
              &x_1 - x_2 + A_2 = 1 \
              &x_1, x_2, s_1\, s_2\, A_1\, A_2 gt.eq 0 \
  $

  *Step 4*: Initial Phase I Simplex Tableau

   #align(
    center,
    table(
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4],

    )
  )

  *Step 4*: Remove Artificial Variables

  1. $A_1$

  We want to eliminate the coefficient of $A_1$ in the objective row $w$. But right now it's already 0 — because we rewrote $w$ in terms of $x_1$ and $s_2$.

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 5 and y in (0, 4) {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4],

    )
  )

  1. $A_2$

  We want to eliminate the coefficient of $A_2$ in the objective row $w$. But right now it's already 0 — because we rewrote $w$ in terms of $x_1$ and $s_2$.

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 6 and y in (0, 4) {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4],

    )
  )


  *Step 5*: Phase I pivoting 

  We look for the most positive coefficient in the $w$-row, because we are minimizing.

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 1 and y in (0, 4) {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4],

    )
  )

  Now we perform the *minimum ratio* test to determine which row $x_1$ will replace:

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (1,7,9) and y in (1,2,3) {
        red.lighten(70%)
      },
      columns: range(10).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$], [], [Ratio $b \/ x_1$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4], [], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3], [], [1.5],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1], [], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4], [], [],

    )
  )

  Minimum ratio is 1 $arrow.long$ pivot on $x_1$ in row 3 (A₂)

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (1, 9) and y in (3,) {
        red.lighten(70%)
      },
      columns: range(10).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$], [], [Ratio $b \/ x_1$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4], [], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3], [], [1.5],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1], [], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4], [], [],

    )
  )
  

  *Step 6*: Step 3: Pivot on $x_1$ in row $A_2$ 

  We now make $x_1$ the basic variable in that row. We'll perform row operations to:
  - Make the pivot element (currently 1) into 1
  - Zero out $x_1$ in other rows

  We pivot on the third row, first column (value = 1):

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 1 and y == 3 {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [1], [2], [1], [0], [0], [0], [4],
      [$A_1$], [2], [1], [0], [-1], [1], [0], [3],
      [$A_2$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [3], [0], [0], [-1], [0], [0], [4],

    )
  )

  New Row 3: make pivot = 1

  Already 1 ✅, so we use it as the pivot row.

  Update other rows

  Row 1:

  $
    R_1 := R_1 - 1 dot R_3 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &1 - 1 = 0,
      x_2& \: quad &2 - (-1) = 3,
      s_1& \: quad &1 - 0 = 1,
      s_2& \: quad &0 - 0 = 0,
      A_1& \: quad &0 - 0 = 0,
      A_2& \: quad &0 - 1 = -1,
      b& \: quad &4 - 1 = 3,
    )
  $

  Row 2:

  $
    R_2 := R_2 - 2 dot R_3 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &2 - 2 = 0,
      x_2& \: quad &1 - (-2) = 3,
      s_1& \: quad &0 - 0 = 0,
      s_2& \: quad &-1 - 0 = -1,
      A_1& \: quad &1 - 0 = 1,
      A_2& \: quad &0 - 2 = -2,
      b& \: quad &3 - 2 = 1,
    )
  $
  
  Row $w$:

  $
    R_w := R_w - 3 dot R_3 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &3 - 3 = 0,
      x_2& \: quad &0 - (-3) = 3,
      s_2& \: quad &-1 - 0 = -1,
      b& \: quad &4 - 3 = 1,
    )
  $

  Updated Tableau

  #align(
    center,
    table(
      fill: (x, y) =>
      if x == 1 {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [0], [3], [1], [0], [0], [-1], [3],
      [$A_1$], [0], [3], [0], [-1], [1], [-2], [1],
      [$x_1$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [0], [3], [0], [-1], [0], [-3], [1],

    )
  )

  *Step 1*: Identify entering variable

  Largest positive coefficient

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (2,) and y in (0, 4) {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [0], [3], [1], [0], [0], [-1], [3],
      [$A_1$], [0], [3], [0], [-1], [1], [-2], [1],
      [$x_1$], [1], [-1], [0], [0], [0], [1], [1],
      table.hline(),
      [$w$], [0], [3], [0], [-1], [0], [-3], [1],

    )
  )

  Entering variable: $x_2$

  *Step 2*: Minimum ratio test to find leaving variable

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (2,7,9) and y in (1,2,3) {
        red.lighten(70%)
      },
      columns: range(10).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$], [], [Ratio $b \/ x_1$],
      table.hline(),
      [$s_1$], [0], [3], [1], [0], [0], [-1], [3], [], [1],
      [$A_1$], [0], [3], [0], [-1], [1], [-2], [1], [], [$1/3$],
      [$x_1$], [1], [-1], [0], [0], [0], [1], [1], [], [N/A],
      table.hline(),
      [$w$], [0], [3], [0], [-1], [0], [-3], [1], [], [],
    )
  )

  Leaving variable: $A_1$ (smallest positive ratio 
  
  *Step 3*: Pivot on $x_2$ in row $A_1$ (2nd row)

  
  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (2,9) and y in (2,) {
        red.lighten(70%)
      },
      columns: range(10).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$], [], [Ratio $b \/ x_1$],
      table.hline(),
      [$s_1$], [0], [3], [1], [0], [0], [-1], [3], [], [1],
      [$A_1$], [0], [3], [0], [-1], [1], [-2], [1], [], [$1/3$],
      [$x_1$], [1], [-1], [0], [0], [0], [1], [1], [], [N/A],
      table.hline(),
      [$w$], [0], [3], [0], [-1], [0], [-3], [1], [], [],
    )
  )

  *Step 4*: Perform pivot

  Row $A_1$:

  $
    R_(A_1) := 1/3 R_(A_1) 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &1/3 dot 0 = 0,
      x_2& \: quad &1/3 dot 3 = 1,
      s_1& \: quad &1/3 dot 0 = 0,
      s_2& \: quad &1/3 dot -1 = -1/3,
      A_1& \: quad &1/3 dot 1 = 1/3,
      A_2& \: quad &1/3 dot -2 = -2/3,
      b& \:   quad &1/3 dot 1 = 1/3,
    )
  $

  Row $s_1$

  $
    R_(s_1) := R_(s_1) - 3 R_(A_1) 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &0 - 3(0) = 0,
      x_2& \: quad &3 - 3(1) = 0,
      s_1& \: quad &1 - 3(0) = 0,
      s_2& \: quad &0 - 3(-1/3) = 0 + 1 =1,
      A_1& \: quad &0 - 3(1/3) = 0 - 1 = -1,
      A_2& \: quad &-1 - 3(-2/3) = -1 + 2 = 1,
      b& \:   quad &3 - 3(1/3) = 3 - 1 = 2,
    )
  $
  
  
  Row $x_1$

  $
    R_(x_1) := R_(x_1) + 1 R_(A_1) 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &1 + 0 = 1,
      x_2& \: quad &-1 + 1 = 0,
      s_1& \: quad &0 + 0 = 0,
      s_2& \: quad &0 + (-1/3) = -1/3,
      A_1& \: quad &0 + 1/3 = 1/3,
      A_2& \: quad &1 + (-2/3) = 1/3,
      b& \:   quad &1 + 1/3 = 4/3,
    )
  $

  Row $w$

  $
    R_(w) := R_(w) - 3 R_(A_1) 
    quad
    arrow.double.long 
    quad
    cases(
      delim: #none,
      x_1& \: quad &0 - 3(0) = 0,
      x_2& \: quad &3 - 3(1) = 0,
      s_1& \: quad &0 - 3(0) = 0,
      s_2& \: quad &-1 - 3(-1/3) = -1 + 1 = 0,
      A_1& \: quad &0 - 3(1/3) = 0 - 1 = -1,
      A_2& \: quad &-3 - 3(-2/3) = -3 + 2 = -1,
      b& \:   quad &1 - 3(1/3) = 1 - 1 = 0,
    )
  $

  Updated Tableau

  #align(
    center,
    table(
      fill: (x, y) =>
      if x in (7,) and y in (4,) {
        red.lighten(70%)
      },
      columns: range(8).map(n => auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      [Basis], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [$A_1$], [$A_2$], [$b$],
      table.hline(),
      [$s_1$], [0], [0], [1], [1], [-1], [1], [2],
      [$x_2$], [0], [1], [0], [-1/3], [1/3], [-2/3], [1/3],
      [$x_1$], [1], [0], [0], [-1/3], [1/3], [1/3], [4/3],
      table.hline(),
      [$w$], [0], [0], [0], [0], [-1], [-1], [0],

    )
  )

  *Step 5*: Interpretation

  Feasibility Achieved
  
  - He value of $w = 0$

  No Artificial Variables in the Basis

  - Basic variables: $s_1$, $x_1$, $x_2$
  - Non-basic variables: $A_1 = 0$, $A_2 = 0$

  *Phase II*



]


#line(length: 100%)

=== Standard Form

- *Equalities*: Convert inequalities (using slack, surplus, or artificial variables)

- *Non-negative variables*: If a variable is unrestricted or can be negative, replace it with the difference of two non-negative variables

#eg[
  $
    2x_1 + 3x_2 colorMath(lt.eq, #red) colorMath(-, #red)4 \ 
    arrow.l.r.double.long \
    -2x_1 -3x_2 colorMath(gt.eq, #red) 4
  $

  #linebreak()

  *Nonpositive*

  $
    2x_1 + 3x_2 lt.eq 4, quad
    x_1 lt.eq 0 \
    arrow.l.r.double.long \
    -2x_1 + 3x_2 lt.eq 4, quad
    x_1 gt.eq 0 \
  $

  *Free* (Unrestricted)

  $
    2x_1 + 3x_2 lt.eq 6, quad 
    x_1 "urs" \
    arrow.l.r.double.long \
    2x'_1 - 2x''_1 + 3x_2 lt.eq 4, quad 
    x'_1, x''_1 gt.eq 0
    
  $
]

=== Simplex Method

#eg[
  $
    max   quad  &7x_1 + 6x_2 \
    s.t.  quad  &2x_1 + 4x_2 lt.eq 16 \
                &3x_1 + 2x_2 lt.eq 12 \
                &x_1, x_2 gt.eq 0 \
  $ 

  $
    max   quad  &7x_1 + 6x_2 colorMath(+ 0&s_1&, #red) colorMath(+ 0&s_2&, #red) & \
    s.t.  quad  &2x_1 + 4x_2 colorMath(+ &s_1&, #red) & & colorMath(&=, #red) 16 \
                &3x_1 + 2x_2 & & colorMath(+ &s_2&, #red) colorMath(&=, #red) 12 \
                #place($&x_1, x_2, colorMath(s_1, #red), colorMath(s_2, #red) gt.eq 0 $)
  $

  #linebreak()

  #align(
    center,
    table(
      columns: (auto, auto, auto, auto, auto, auto, auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      table.vline(x: 2, start: 0),
      table.vline(x: 6, start: 0),
      [], [], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [],
      [Basis], [$c_B$], [7], [6], [0], [0], [$b$],
      table.hline(),
      [$s_1$], [0], [2], [4], [1], [0], [16],
      [$s_2$], [0], [3], [2], [0], [1], [12],
      table.hline(),
      [], [$z_j$], [$
        0 times 2\ +\ 0 times 3\ = 0
      $], [0], [0], [0], [0],
      [], [$c_j - z_j$], [7], [6], [0], [0], [],
    )
  )

  $
    x_1 = 0, x_2 = 0, s_1 = 16, s_2 = 12
  $

  #align(
    center,
    table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto),
      inset: (x: 0.5em, y: 0.5em),
      align: horizon,
      stroke: none,
      table.vline(x: 2, start: 0),
      table.vline(x: 6, start: 0),
      [], [], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [], [],
      [Basis], [$c_B$], [7], [6], [0], [0], [$b$], [Ratio],
      table.hline(),
      [$s_1$], [0], [#text(fill: red)[2]], [4], [1], [0], [#text(fill: red)[16]], [#text(fill: red)[16/2 = 8]],
      [$s_2$], [0], [#text(fill: red)[3]], [2], [0], [1], [#text(fill: red)[12]], [#text(fill: red)[12/3 = 4]],
      table.hline(),
      [], [$z_j$], [0], [0], [0], [0], [0], [],
      [], [$c_j - z_j$], [7], [6], [0], [0], [], [],
    )
  )

  

]

#line(length: 100%)

1. Formulation

*Objective Function* 

$
Z &= c_1 x_1 + c_2 x_2 + dots + c_n x_n \ &= c^T x
$

*Constraints*

$
a_11 x_1 + a_12 x_2 + dots + a_(1 n) x_n #text(fill: red)[$lt.eq$] b_1 \
a_21 x_1 + a_22 x_2 + dots + a_(2 n) x_n #text(fill: red)[$gt.eq$] b_2 \
dots.v \
a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n #text(fill: red)[$eq$] b_m \
x_1, x_2, dots, x_n gt.eq  0
$

Or,

$
A x #text(fill: red)[$lt.eq$],#text(fill: red)[$eq$],#text(fill: red)[$gt.eq$] b \
x gt.eq 0
$

- #text(fill: red)[$lt.eq$] for maximization
- #text(fill: red)[$gt.eq$] for minimization

2. Convert to Canonical Form

In *slack variable form*

$
a_11 + x_1 + a_12 x_2 + dots + a_(1 n) x_n #text(fill: red)[$+ s_1$] eq b_1 \
a_21 + x_1 + a_22 x_2 + dots + a_(2 n) x_n #text(fill: red)[$+ s_2$] eq b_2 \
dots.v \
a_(m 1) x_1 + a_(m 2) x_2 + dots + a_(m n) x_n #text(fill: red)[$+ s_m$] eq b_m \
$

$
x_1, x_2, dots, x_n gt.eq  0
$

$
#text(fill: red)[$s_1, s_2, dots, s_m gt.eq 0$]
$

Or *matrix notation*,


$
  "max" quad  &z = c^T x \
  s.t.  quad  &A x  #text(fill: red)[$+ I s$] = b_i \
              &x gt.eq  0 \
              &#text(fill: red)[$s gt.eq 0$]
$

#align(center)[
  #table(
    stroke: none,
    columns: range(4).map(i => auto),
    align: horizon,
    [$max quad z$], [$=$], [$c^T$], [$x$], 
    [], [$=$], [$[c_1, c_2, dots, c_n]$], [$vec(x_1, x_2, dots.v, x_n)$], 
  )
]

#align(center)[
  #table(
    stroke: none,
    columns: range(7).map(i => auto),
    align: horizon,
    [$A$], [$x$], [$+$], [$I$], [$s$], [$=$], [$b$], 
    [$
      mat(
        a_(11), a_(12), dots, a_(1 n);
        a_(21), a_(22), dots, a_(2 n);
        dots.v, dots.v, dots.down, dots.v;
        a_(m 1), a_(m 2), dots, a_(m n);
      )
    $], 
    [$
      vec(x_1, x_2, dots.v, x_n)
    $], 
    [$
      +   
    $], 
    [$
      mat(
        1, 0, dots, 0;
        0, 1, dots, 0;
        dots.v, dots.v, dots.down, dots.v;
        0, 0, dots, 1;
      )
    $], 
    [$
      vec(s_1, s_2, dots.v, s_m) 
    $], 
    [$
      =
    $], 
    [$
      vec(b_1, b_2, dots.v, b_m)
    $], 
  )
]






3. Set up Simplex Tableau

#align(
  center,
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
    inset: (x: 0.5em, y: 0.5em),
    align: horizon,
    stroke: none,
    table.vline(x: 1, start: 0),
    table.vline(x: 5, start: 0),
    table.vline(x: 9, start: 0),
    table.header(
      [], [$x_1$], [$x_2$], [$dots$], [$x_n$], [$s_1$], [$s_2$], [$dots$], [$s_m$], [RHS],
    ),
    table.hline(),
    [Constraint 1], [$a_11$], [$a_12$], [$dots$], [$a_1n$], [1], [0], [$dots$], [0], [$b_1$], 
    [Constraint 2], [$a_21$], [$a_22$], [$dots$], [$a_2n$], [0], [1], [$dots$], [0], [$b_2$],
    [$dots.v$], [$dots.v$], [$dots.v$], [$dots.down$], [$dots.v$], [$dots.v$], [$dots.v$], [$dots.down$], [$dots.v$], [$dots.v$],
    [Constraint $n$], [$a_(m 1)$], [$a_(m 2)$], [$dots$], [$a_(m n)$], [0], [0], [$dots$], [1], [$b_m$],
    table.hline(),
    [Objective Function], [$#text(fill: red)[$-$]c_1$], [$#text(fill: red)[$-$]c_2$], [$dots$], [$#text(fill: red)[$-$]c_n$], [0], [0], [$dots$], [0], [0],
  )
)

- #text(fill: red)[$-$] for maximization
- #text(fill: red)[$+$] for minimization

4. Perform Pivot Operation

- *Identify the Pivot Column*: Choose the column with the most: 

  - Maximization: Negative coefficient 

  - Minimization: Positive coefficient (or multiply the objective by -1 and treat it as a maximization)

in the objective function row (this indicates which variable will enter the basis).

- *Identify the Pivot Row*: Calculate the ratio of RHS to the pivot column's coefficients (only where coefficients are positive). The row with the smallest ratio determines the variable to leave the basis.

- *Pivot*: Perform row operations to change the pivot element to 1 and other elements in the pivot column to 0. This involves dividing the pivot row by the pivot element and then adjusting the other rows to zero out the pivot column.

5. Iterate

Repeat the pivot operations until there are no more negative coefficients in the objective function row, indicating that the current solution is optimal.

6. Read the Solution

The final tableau will give the values of the variables at the optimal solution. The basic variables are the variables corresponding to the columns with the identity matrix in the final tableau, while non-basic variables are set to zero.

#eg[
$"Maximize": quad quad Z = 3 x_1 + 2 x_2$

s.t.

#h(10mm) $x_1 + x_2 lt.eq 4$

#h(10mm) $2x_1 + x_2 lt.eq 5$

#h(10mm) $x_1, x_2 gt.eq 0$

*1. Convert to Canonical Form*

Introduce slack variables $s_1$ and $s_2$ to convert inequalities into equalities:

#h(10mm) $x_1 + x_2 + s_1 = 4$

#h(10mm) $2x_1 + x_2 + s_2 = 5$

#h(10mm) $x_1, x_2, s_1, s_2 gt.eq 0$

Initialize Simplex Tableau

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: (x: 0.5em, y: 0.5em),
  align: horizon,
  stroke: none,
  table.vline(x: 1, start: 0),
  table.vline(x: 3, start: 0),
  table.vline(x: 5, start: 0),
  table.header(
    [], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [RHS],
  ),
  table.hline(),
  [Constraint 1], [1], [1], [1], [0], [4], 
  [Constraint 2], [2], [1], [0], [1], [5],
  table.hline(),
  [Objective Function], [-3], [-2], [0], [0], [0],
)

*2. Identify the Pivot Column*

In the objective function row, the coefficients are $[-3, -2, 0, 0]$. The most negative coefficient is $-3$, which is in the $x_1$ column. Therefore, $x_1$ will enter the basis.

*3. Identify the Pivot Row*

Calculate the ratio of RHS to the pivot column's coefficients (where the coefficients are positive):

- For Row 1:  $4 / 1 = 4$  (pivot column coefficient is 1)

- For Row 2:  $5 / 2 = 2.5$  (pivot column coefficient is 2)

The smallest ratio is 2.5, so Row 2 will be the pivot row. This means that $s_2$ will leave the basis.

*4. Pivot*

Perform row operations to make the pivot element 1 and zero out other elements in the pivot column.

Pivot Element: The element at the intersection of Row 2 and $x_1$ column is 2.

Steps:

1. Make Pivot Element 1: Divide all elements in Row 2 by the pivot element (2):

$
"New Row" 2 &= 1 / 2 times "Old Row" 2 \
&= [1, 0.5, 0, 0.5, 2.5]
$

2. Zero Out Pivot Column in Other Rows:

- For Row 1: Subtract 1 times New Row 2 from Row 1:

$
"New Row" 1 &= "Old Row" 1 - [1, 0.5, 0, 0.5, 2.5] \
&= [0, 0.5, 1, -0.5, 1.5]
$

- For Objective Function: Add 3 times New Row 2 to the Objective Function row

$
"New Objective Function" &= "Old Objective Function" + 3 times [1, 0.5, 0, 0.5, 2.5] \
&= [0, -0.5, 0, 1.5, 7.5]
$

Updated Simplex Tableau

#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: (x: 0.5em, y: 0.5em),
  align: horizon,
  stroke: none,
  table.vline(x: 1, start: 0),
  table.vline(x: 3, start: 0),
  table.vline(x: 5, start: 0),
  table.header(
    [], [$x_1$], [$x_2$], [$s_1$], [$s_2$], [RHS],
  ),
  table.hline(),
  [Constraint 1], [0], [0.5], [1], [-0.5], [1.5], 
  [Constraint 2], [1], [0.5], [0], [0.5], [2.5],
  table.hline(),
  [Objective Function], [0], [-0.5], [0], [1.5], [7.5],
)



]