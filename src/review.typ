#import "@preview/cetz:0.2.2"

#set page(
  "us-letter",
  margin: 1em,
)

#show heading.where(
  level: 1
): it => text(
  size: 13pt,
  weight: "bold",
  fill: red,
  font: "Helvetica Neue",
  it
)

#show heading.where(
  level: 2
): it => text(
  size: 11pt,
  weight: "semibold",
  fill: blue,
  font: "Helvetica Neue",
  it,
)

#let arithmetic_operations = [
  == Arithmetic Operations \ \

  #grid(
    columns: (1fr, 1fr),
    rows: (auto, auto),
    gutter: 3pt,
    [
       $a (b + c) = a b + a c$

       $(a + c) / b = a / b + c / b$
    ],
    [
      $a / b + c / d = (a d + b c) / (d b)$

      $(a / b) / (c / d) = a / b times d / c = (a d) / (b c)$ 
    ]
  )
]

#let exponents_and_radicals = [
  == Exponents and Radicals \ \

  #grid(
    columns: (1fr, 1fr),
    rows: (auto, auto),
    gutter: 3pt,
    [
      $x^m x^n = x^(m + n)$

      $(x^m)^n = x^(m n)$

      $(x y)^n = x^n + y^n$

      $x^(1/n) = root(n, x)$

      $root(n, x y) = root(n, x) root(n, y)$
    ],
    [
      $x^m / x^n = x^(m - n)$

      $x^(-n) = 1 / x^n$

      $(x / y)^n = x^n / y^n$

      $x^(m / n) = root(n, x^m) = (root(n, x))^m$

      $root(n, x / y) = root(n, x) / root(n, y)$
    ]
  )
]

#let factoring_special_polynomials = [
  == Factoring Special Polynomials \ \
  $x^2 - y^2 = (x + y)(x - y)$

  $x^3 + y^3 = (x + y)(x^2 - x y + y^2)$
  
  $x^3 - y^3 = (x - y)(x^2 + x y + y^2)$
]

#let binomial_theorem = [
  == Binomial Theorem \ \

  $(x + y)^n = sum^n_(k=0) vec(n, k) x^(n - k) y^k$ \ \

  #grid(
  columns: (1fr, 1fr),
  rows: (auto, auto),
  gutter: 3pt,
  [
    $(x + y)^2 = x^2 + 2 x y + y^2$

    $(x + y)^3 = x^3 + 3 x^2 y + 3 x y^2 + y^3$
  ],
  [
    $(x - y)^2 = x^2 - 2 x y + y^2$

    $(x - y)^3 = x^3 - 3 x^2 y + 3 x y^2 - y^3$
  ]
)

]

#let quadratic_formula = [
  == Quadratic Formula \ \

  If $a x^2 + b x + c = 0$, then $x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a)$
]

#let inequalities_and_absolute_value = [
  == Inequalities and Absolute Value \ \

  If $a lt b$ and $b lt c$, then $a lt c$
  
  If $a lt b$, then $a + c lt b + c$

  If $a lt b$ and $c gt 0$, then $c a lt c b$
  
  If $a lt b$ and $c lt 0$, then $c a gt c b$

  If $a gt 0$, then

    $abs(x) = a quad quad "means" quad quad x = a quad "or" quad x = -a$
    
    $abs(x) lt a quad quad "means" quad quad -a lt x lt a$

    $abs(x) gt a quad quad "means" quad quad x gt a quad "or" quad x lt -a$
]

#let geometric_formulas = [
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
      cetz.plot.plot(
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
          cetz.plot.add-anchor("o", (0,0))
          cetz.plot.add-anchor("a", (5,0))
          cetz.plot.add-anchor("b", (4,2))
          cetz.plot.add-anchor("d", (4,0))
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
      cetz.plot.plot(
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
      cetz.plot.plot(
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
        // cetz.draw.content("c.mid", $r$, anchor: "south", padding: 0.05, angle: "c.mid")
        
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



]

#grid(
  columns: (1fr, 1fr),
  rows: (auto, auto),
  gutter: 3pt,
  [
    = ALGEBRA
    #arithmetic_operations
    #exponents_and_radicals
    #factoring_special_polynomials
    #binomial_theorem
    #quadratic_formula
    #inequalities_and_absolute_value
  ],
  [
    = GEOMENTRY
    #geometric_formulas
  ]
)
