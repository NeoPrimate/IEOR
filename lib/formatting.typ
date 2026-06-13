#import "@preview/lilaq:0.6.0" as lq
#import "@preview/elembic:1.1.1" as e

#let formatting(body) = {

  set heading(numbering: "1.1.")

  // House style: every lilaq legend sits just outside the plot's top-right
  // corner. `top + left` anchored then shifted right by the full data-area
  // width (100%) lands the box outside the right edge, top-aligned. This is
  // the single source of truth — diagrams need no per-plot `legend:` key.
  show: e.set_(lq.legend, position: top + left, dx: 100% + 0.5em)

  show heading.where(level: 1): it => [
    #set text(size: 24pt, weight: "semibold")
    #it
  ]
  show heading.where(level: 2): it => [
    #set text(size: 18pt, weight: "semibold")
    #it
  ]

  show heading.where(level: 3): it => [
    #set text(size: 14pt, weight: "semibold")
    #it
  ]

  set text(font: "Helvetica")

  show table: it => align(center, block(breakable: false, it))

  // Gracefully degrade #link(<label>)[body] when the label isn't in scope —
  // e.g. when previewing a chapter in isolation, where labels created by
  // main.typ's render() recursion don't exist. The user `show link:` rule
  // runs before typst's built-in LINK_RULE (typst-layout/src/rules.rs),
  // which is what calls resolve_early() and emits the "label does not exist"
  // diagnostic. Returning `it.body` instead of `it` for missing labels means
  // no LinkElem reaches the built-in rule, so no diagnostic fires. In the
  // full-book compile every label resolves and the rule falls through to it.
  // Revisit when https://github.com/typst/typst/issues/4035 lands — typst
  // is adding first-class support for optional/soft links that would make
  // this manual fallback unnecessary.
  show link: it => context {
    if type(it.dest) == label and query(it.dest).len() == 0 {
      it.body
    } else {
      it
    }
  }

  set list(indent: 30pt)
  show strong: set text(blue.darken(25%))
  set math.cases(gap: 1em)
  show math.equation.where(block: false): set text(12pt)
  set math.vec(delim: "[")
  set math.mat(delim: "[")
  set math.mat(gap: 1em)
  set math.vec(gap: 1em)

  body
}
