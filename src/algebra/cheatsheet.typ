#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"

== Arithmetic Operations

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

== Exponents and Radicals

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

== Factoring Special Polynomials

$x^2 - y^2 = (x + y)(x - y)$

$x^3 + y^3 = (x + y)(x^2 - x y + y^2)$

$x^3 - y^3 = (x - y)(x^2 + x y + y^2)$

== Binomial Theorem


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

== Quadratic Formula

If $a x^2 + b x + c = 0$, then $x = (-b plus.minus sqrt(b^2 - 4 a c)) / (2 a)$

== Inequalities and Absolute Value

If $a lt b$ and $b lt c$, then $a lt c$

If $a lt b$, then $a + c lt b + c$

If $a lt b$ and $c gt 0$, then $c a lt c b$

If $a lt b$ and $c lt 0$, then $c a gt c b$

If $a gt 0$, then

$abs(x) = a quad quad "means" quad quad x = a quad "or" quad x = -a$

$abs(x) lt a quad quad "means" quad quad -a lt x lt a$

$abs(x) gt a quad quad "means" quad quad x gt a quad "or" quad x lt -a$
