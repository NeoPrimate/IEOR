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