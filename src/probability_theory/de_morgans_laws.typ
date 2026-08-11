#import "/lib/imports.typ": *
#show: formatting

= De Morgan's Laws <probability_theory_de_morgans_laws>

Allows going back and forth between unions and intersections

#let c-out = rgb("#f1efe8")
#let c-in = rgb("#7f77dd")
#let c-edge = rgb("#3c3489")
#let c-text = rgb("#26215c")

#let inside(s, x, y) = {
  let dx = x - s.at(0)
  let dy = y - s.at(1)
  dx * dx + dy * dy < s.at(2) * s.at(2)
}

#let family(n) = {
  let (r, d, a0) = if n == 2 { (1.25, 0.62, 180deg) } else if n == 3 {
    (1.25, 0.68, 90deg)
  } else { (1.32, 0.74, 45deg) }
  range(n).map(i => {
    let a = a0 + i * 360deg / n
    (d * calc.cos(a), d * calc.sin(a), r)
  })
}

#let lhs-union(f, x, y) = not f.any(s => inside(s, x, y))
#let rhs-union(f, x, y) = f.all(s => not inside(s, x, y))
#let lhs-inter(f, x, y) = not f.all(s => inside(s, x, y))
#let rhs-inter(f, x, y) = f.any(s => not inside(s, x, y))

#let differ(p, q) = (f, x, y) => p(f, x, y) != q(f, x, y)

#let res = 150
#let xr = (-2.6, 2.6)
#let yr = (-2.0, 2.0)

#let panel(f, pred, w: 4.4cm, labels: true) = lq.diagram(
  width: w,
  height: w * 2.0 / 2.6,
  xaxis: none,
  yaxis: none,
  xlim: xr,
  ylim: yr,
  margin: 0%,

  lq.colormesh(
    lq.linspace(..xr, num: res),
    lq.linspace(..yr, num: res),
    (x, y) => if pred(f, x, y) { 1.0 } else { 0.0 },
    map: (c-out, c-in),
    min: 0,
    max: 1,
  ),

  ..f.map(s => lq.ellipse(
    s.at(0),
    s.at(1),
    width: 2 * s.at(2),
    height: 2 * s.at(2),
    align: center + horizon,
    fill: none,
    stroke: 0.5pt + c-edge,
  )),

  ..if labels {
    f.enumerate().map(((i, s)) => {
      let m = calc.max(calc.sqrt(s.at(0) * s.at(0) + s.at(1) * s.at(1)), 1e-9)
      let k = (s.at(2) - 0.38) / m
      lq.place(
        s.at(0) * (1 + k),
        s.at(1) * (1 + k),
        text(8pt, fill: c-text)[$S_#(i + 1)$],
      )
    })
  } else { () },
)

#let cell(caption, body) = align(center, stack(
  spacing: 4pt,
  text(9pt, caption),
  body,
))

== Complement of a union

#v(2pt)
#grid(
  columns: (1fr, auto, 1fr),
  align: horizon + center,
  column-gutter: 6pt,
  cell($(S_1 union S_2)^c$, panel(family(2), lhs-union)),
  text(11pt)[$=$],
  cell($S_1^c inter S_2^c$, panel(family(2), rhs-union)),
)

== Complement of an intersection

#v(2pt)
#grid(
  columns: (1fr, auto, 1fr),
  align: horizon + center,
  column-gutter: 6pt,
  cell($(S_1 inter S_2)^c$, panel(family(2), lhs-inter)),
  text(11pt)[$=$],
  cell($S_1^c union S_2^c$, panel(family(2), rhs-inter)),
)

== Scaling

The general statement quantifies over an arbitrary index set:

$ 
  (union.big_(n in I) S_n)^c = inter.big_(n in I) S_n^c
  #h(5em)
  (inter.big_(n in I) S_n)^c = union.big_(n in I) S_n^c 
$

Two circles cannot show why $I$ may be infinite, but two, three and four can
show the *direction of travel*. Only the family changes below; the predicates
are untouched.

#v(4pt)

#grid(
  columns: (auto, 1fr, 1fr),
  rows: 3,
  align: horizon + center,
  column-gutter: 8pt,
  row-gutter: 7pt,

  [], cell($(union.big_n S_n)^c = inter.big_n S_n^c$, []), cell($(inter.big_n S_n)^c = union.big_n S_n^c$, []),

  ..(2, 3, 4)
    .map(n => (
      text(9pt)[$n = #n$],
      panel(family(n), lhs-union, w: 4.7cm),
      panel(family(n), lhs-inter, w: 4.7cm),
    ))
    .flatten(),
)