#import "../utils/examples.typ": eg
#import "../utils/result.typ": result
#import "../utils/matvec_mult.typ": matvec_mult
#import "../utils/blob.typ": draw-blob

#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"
#import "@preview/numty:0.0.5" as nt
#import "@preview/numty:0.0.5": c, r

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Eigenvectors

=== Transformation

#let o = (0, 0)
#let i = (1, 0)
#let j = (0, 1)

#let x = (1, 1)

#let A = (
  (3, 1),
  (0, 2),
)

#let Ti = matvec_mult(A, i)
#let Tj = matvec_mult(A, j)

#let Tx = matvec_mult(A, x)

#let domain = cetz.canvas(length: 6cm, {
    cetz-plot.plot.plot(
      x-tick-step: 2,
      y-tick-step: 2,
      x-minor-tick-step: 1,
      y-minor-tick-step: 1,
      x-min: -1,
      y-min: -1,
      x-max: 4,
      y-max: 4,
      axis-style: "school-book",
      x-label: $x$,
      y-label: $y$,
      x-grid: "both",
      y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", o)
        cetz-plot.plot.add-anchor("i", i)
        cetz-plot.plot.add-anchor("j", j)
        cetz-plot.plot.add-anchor("x", x)
      }, 
      name: "plot"
    )

    cetz.draw.line("plot.o", "plot.i", stroke: blue, mark: (fill: blue, end: ">", size: .25), name: "i")
    cetz.draw.content("i.end", text(blue)[$ hat(i) = #nt.print(i) $], anchor: "north", padding: 0.1, angle: "i.end")
    
    cetz.draw.line("plot.o", "plot.j", stroke: red, mark: (fill: red, end: ">", size: .25), name: "j")
    cetz.draw.content("j.end", text(red)[$ hat(j) = #nt.print(j) $], anchor: "south-east", padding: 0.1, angle: "j.end")
    
    cetz.draw.line("plot.o", "plot.x", stroke: green, mark: (fill: green, end: ">", size: .25), name: "j")
    cetz.draw.content("j.end", text(green)[$ arrow(x) = #nt.print(x) $], anchor: "south", padding: 0.1, angle: "j.end")

  })

#let codomain = cetz.canvas(length: 6cm, {
    cetz-plot.plot.plot(
      x-tick-step: 2,
      y-tick-step: 2,
      x-minor-tick-step: 1,
      y-minor-tick-step: 1,
      x-min: -1,
      y-min: -1,
      x-max: 4,
      y-max: 4,
      axis-style: "school-book",
      x-label: $x$,
      y-label: $y$,
      x-grid: "both",
      y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", o)
        cetz-plot.plot.add-anchor("Ti", Ti)
        cetz-plot.plot.add-anchor("Tj", Tj)
        cetz-plot.plot.add-anchor("Tx", Tx)
      }, 
      name: "plot"
    )

    cetz.draw.line("plot.o", "plot.Ti", stroke: blue, mark: (fill: blue, end: ">", size: .25), name: "Ti")
    cetz.draw.content("Ti.end", text(blue)[$ T(hat(i)) = #nt.print(Ti) $], anchor: "south", padding: 0.1, angle: "Ti.end")
    
    cetz.draw.line("plot.o", "plot.Tj", stroke: red, mark: (fill: red, end: ">", size: .25), name: "Tj")
    cetz.draw.content("Tj.end", text(red)[$ T(hat(j)) = #nt.print(Tj) $], anchor: "south", padding: 0.1, angle: "Tj.end")
    
    cetz.draw.line("plot.o", "plot.Tx", stroke: green, mark: (fill: green, end: ">", size: .25), name: "Tx")
    cetz.draw.content("Tx.end", text(green)[$ T(arrow(x)) = #nt.print(Tx) $], anchor: "south", padding: 0.1, angle: "Tx.end")

  })

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    rows: (auto, auto),
    gutter: 3pt,
    domain,
    codomain,
  )
]

$
  A = #nt.print(A)
$

$
  T(hat(i)) 
  &= A hat(i) \
  &= #nt.print(A) #nt.print(i) \
  &= #nt.print(Ti) \
$

$
  T(hat(j)) 
  &= A hat(j) \
  &= #nt.print(A) #nt.print(j) \
  &= #nt.print(Tj) \
$

$
  T(arrow(x)) 
  &= A arrow(x) \
  & =#nt.print(A) #nt.print(x) \
  &= #nt.print(Tx)
$

== Eigenvalues



#eg[

  $
    A = mat(
      2, 1;
      1, 2;
    )
  $
#align(center)[
  #cetz.canvas(length: 6cm, {

    let A = (
        (2.5, -0.5),
        (-0.5, 2.5),
      )

    let i = (1, 0)
    let j = (0, 1)

    let v_1 = (1, 1)
    let v_2 = (1, -1)
    
    let Ai = nt.matmul(A, nt.c(..i)).flatten()
    let Aj = nt.matmul(A, nt.c(..j)).flatten()
    
    let Av_1 = nt.matmul(A, nt.c(..v_1)).flatten()
    let Av_2 = nt.matmul(A, nt.c(..v_2)).flatten()

    cetz-plot.plot.plot(
      x-tick-step: 1,
      y-tick-step: 1,
      // x-minor-tick-step: 1,
      // y-minor-tick-step: 1,
      x-min: -1,
      y-min: -3.1,
      x-max: 3.1,
      y-max: 3.1,
      axis-style: "school-book",
      x-label: $x$,
      y-label: $y$,
      x-grid: "both",
      y-grid: "both",
      {
        cetz-plot.plot.add-anchor("o", o)
        cetz-plot.plot.add-anchor("v_1", v_1)
        cetz-plot.plot.add-anchor("v_2", v_2)
        cetz-plot.plot.add-anchor("Av_1", Av_1)
        cetz-plot.plot.add-anchor("Av_2", Av_2)
        cetz-plot.plot.add-anchor("i", i)
        cetz-plot.plot.add-anchor("j", j)
        cetz-plot.plot.add-anchor("Ai", Ai)
        cetz-plot.plot.add-anchor("Aj", Aj)
      }, 
      name: "plot"
    )

    cetz.draw.line("plot.o", "plot.i", stroke: purple, mark: (fill: purple, end: ">", size: .25), name: "i")
    cetz.draw.content("i.end", text(purple)[$hat(i)$], anchor: "south", padding: 0.025, angle: "i.end")
    cetz.draw.line("plot.o", "plot.Ai", stroke: purple, mark: (fill: purple, end: ">", size: .25), name: "Ai")
    cetz.draw.content("Ai.end", text(purple)[$A hat(i)$], anchor: "north", padding: 0.025, angle: "Ai.end")

    cetz.draw.line("plot.o", "plot.j", stroke: blue, mark: (fill: blue, end: ">", size: .25), name: "j")
    cetz.draw.content("j.end", text(blue)[$hat(j)$], anchor: "south-west", padding: 0.025, angle: "j.end")
    cetz.draw.line("plot.o", "plot.Aj", stroke: blue, mark: (fill: blue, end: ">", size: .25), name: "Aj")
    cetz.draw.content("Aj.end", text(blue)[$A hat(j)$], anchor: "south", padding: 0.025, angle: "Aj.end")

    cetz.draw.line("plot.o", "plot.v_1", stroke: red, mark: (fill: red, end: ">", size: .25), name: "v_1")
    cetz.draw.content("v_1.end", text(red)[$hat(v_1)$], anchor: "south", padding: 0.025, angle: "v_1.end")
    cetz.draw.line("plot.o", "plot.Av_1", stroke: red, mark: (fill: red, end: ">", size: .25), name: "Av_1")
    cetz.draw.content("Av_1.end", text(red)[$A hat(v_1)$], anchor: "south", padding: 0.025, angle: "Av_1.end")

    cetz.draw.line("plot.o", "plot.v_2", stroke: green, mark: (fill: green, end: ">", size: .25), name: "v_2")
    cetz.draw.content("v_2.end", text(green)[$hat(v_2)$], anchor: "north", padding: 0.025, angle: "v_2.end")
    cetz.draw.line("plot.o", "plot.Av_2", stroke: green, mark: (fill: green, end: ">", size: .25), name: "Av_2")
    cetz.draw.content("Av_2.end", text(green)[$A hat(v_2)$], anchor: "south", padding: 0.05, angle: "Av_2.end")
  })
]
]
