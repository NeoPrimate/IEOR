#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

== Geometric Formulas

Formulas for: 
- Area $A$
- Circumference $C$
- Volume $V$

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (auto, auto, auto),
  gutter: 3pt,
  [
     #text(weight: "bold")[Triangle]

     $A = 1/2 b h$

     $A = 1/2 a b sin(theta)$

     #cetz.canvas(length: 2cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: none,
        y-tick-step: none,
        x-minor-tick-step: none,
        y-minor-tick-step: none,
        x-min: 0,
        y-min: 0,
        x-max: 3,
        y-max: 3,
        axis-style: none,
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {
          plot.add-anchor("o", (0,0))
          plot.add-anchor("a", (5,0))
          plot.add-anchor("b", (4,2))
          plot.add-anchor("d", (4,0))
        }, name: "plot")

        cetz.draw.set-style(line: (mark: (end: none, size: .25)))

        cetz.draw.line("plot.o", "plot.a", stroke: blue, mark: (fill: blue), name: "a")
        cetz.draw.content("a.mid", $b$, anchor: "north", padding: 0.05, angle: "a.end")

        cetz.draw.line("plot.o", "plot.b", stroke: blue, mark: (fill: blue), name: "b")
        cetz.draw.content("b.mid", $a$, anchor: "south", padding: 0.05, angle: "b.mid")
        
        cetz.draw.line("plot.b", "plot.a", stroke: blue, mark: (fill: blue), name: "c")
        
        cetz.draw.line("plot.b", "plot.d", stroke: black, mark: (fill: black), name: "d")
        cetz.draw.content("d.mid", $h$, anchor: "east", padding: 0.05, angle: "d.mid")

        cetz.angle.angle("a.start", "a.end", "b.end", label: $theta$, radius: 30%, label-radius: 130%, inner: true)
    })
  ],
  [
    #text(weight: "bold")[Circle]

    $A = pi r^2$

    $C = 2 pi r$

    #cetz.canvas(length: 2cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: none,
        y-tick-step: none,
        x-minor-tick-step: none,
        y-minor-tick-step: none,
        x-min: 0,
        y-min: 0,
        x-max: 3,
        y-max: 3,
        axis-style: none,
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {}, name: "plot")

        cetz.draw.set-style(line: (mark: (end: none, size: .25)))

        cetz.draw.circle((0, 0), radius: (0.5, 0.5), fill: none, stroke: blue)
        cetz.draw.line((0, 0), (0.5, 0), stroke: black, name: "c")
        cetz.draw.content("c.mid", $r$, anchor: "south", padding: 0.05, angle: "c.mid")
        
    })

  ],
  [
    #text(weight: "bold")[Sector of Circle]

    $A = 1/2 r^2 theta$

    $s = r theta$ ($theta$ in radians)

    #cetz.canvas(length: 2cm, {
      import cetz.draw: *
      import cetz-plot: *

      plot.plot(
        x-tick-step: none,
        y-tick-step: none,
        x-minor-tick-step: none,
        y-minor-tick-step: none,
        x-min: 0,
        y-min: 0,
        x-max: 3,
        y-max: 3,
        axis-style: none,
        x-label: $x$,
        y-label: $y$,
        x-grid: "both",
        y-grid: "both",
        {}, name: "plot")

        cetz.draw.set-style(line: (mark: (end: none, size: .25)))

        cetz.draw.arc((0,0), stop: 45deg, delta: 45deg, mode: "PIE", stroke: blue)  
    })

  ]
)

== Trigonometric Functions

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header([*Function*], [*Definition*], [*Reciprocal*]),
  $sin(x)$, $"opposite" / "hypothenuse"$, $1 / sin(x) = csc(x)$,
  $cos(x)$, $"adjacent" / "hypothenuse"$, $1 / cos(x) = sec(x)$,
  $tan(x)$, $sin(x) / cos(x) = "opposite" / "adjacent"$, $1 / tan(x) = cot(x)$,
  $csc(x)$, $sin(x) / cos(x) = "hypothenuse" / "opposite"$, $1 / csc(x) = sin(x)$,
  $sec(x)$, $"hypothenuse" / "adjacent"$, $1 / sec(x) = cos(x)$,
  $cot(x)$, $cos(x) / sin(x) = "adjacent" / "opposite"$, $1 / cot(x) = tan(x)$,
)

geometric_formulas
