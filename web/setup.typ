// HTML-only show rules. Applied via #show: web_setup in book.typ.
//
// Most of these are workarounds for Typst's HTML export (still gated behind
// `--features html` on 0.14.2). See typst/typst#5512 for the master tracking
// issue — it lists which built-in elements have HTML support, at what level.
// Per-rule pointers below indicate when each workaround can be deleted.

#import "@preview/elembic:1.1.1" as e

// One elembic element wrapping both cetz canvases and fletcher diagrams,
// so we can attach a `show` rule that frames them via `html.frame` in HTML
// and passes through in PDF. cetz.canvas / fletcher.diagram return generic
// block content with no addressable element type, so we can't write
// `show cetz.canvas: ...` directly.
//
// Source files write `#frame(cetz.canvas({...}))` and
// `#frame(fletcher.diagram(...))`.
//
// REMOVE WHEN typst/typst#147 ships — user/package-defined elements
// addressable by `show <element>: ...`. At that point cetz / fletcher can
// declare their own elements and this whole block collapses to:
//     show cetz.canvas: it => html.frame(it)
//     show fletcher.diagram: it => html.frame(it)
// and call sites drop the `#frame(...)` wrapper.
//     https://github.com/typst/typst/issues/147
#let frame = e.element.declare(
  "frame",
  prefix: "ieor-book",
  display: it => it.body,
  fields: (e.field("body", content, required: true),),
)

#let web_setup(body) = {
  // Inline math → wrap as inline SVG inside <span role="math">.
  //
  // REMOVE WHEN: typst/typst#7436 lands. Laurenz (typst/typst#8230, May 2026):
  // "the goal is to land MathML before the next release, so it's likely not
  // needed." Next release = 0.15 (no RC yet as of 2026-05). When that ships,
  // math.equation in HTML mode will emit MathML natively and these two show
  // rules can be deleted. (Caveat: it's a stated goal, not a commitment — PR
  // could slip past 0.15.)
  show math.equation.where(block: false): it => {
    if target() == "html" {
      html.elem("span", attrs: (role: "math"), html.frame(it))
    } else { it }
  }

  // Block math → same fallback, wrapped in <figure role="math">.
  // REMOVE WHEN: see inline-math rule above (typst/typst#7436).
  show math.equation.where(block: true): it => {
    if target() == "html" {
      html.elem("figure", attrs: (role: "math"), html.frame(it))
    } else { it }
  }

  // cetz canvases (`#frame(cetz.canvas(...))`) and fletcher diagrams
  // (`#frame(fletcher.diagram(...))`) — frame the body as inline SVG in
  // HTML, pass through unchanged in PDF. See the comment block at the top
  // of this file for the rationale (and the typst#147 cleanup path).
  show: e.show_(frame, it => context if target() == "html" {
    html.frame(e.fields(it).body)
  } else { e.fields(it).body })

  // Standalone grids (not inside a figure) — needed because html.frame has no
  // page width, so a fractional `columns: 2` collapses to its content
  // minimum and stacks vertically. Wrap the grid in a fixed-width box, then
  // emit a <figure> so `article figure svg { max-width: 100%; height: auto }`
  // in web/style.css scales it to the article column width.
  //
  // REMOVE WHEN: typst/typst#5512 — grid lands in HTML export. Not listed in
  // the milestone as of Typst 0.14.2; no timeline.
  show grid: it => context if target() == "html" {
    html.elem("figure", html.frame(box(width: 1000pt, it)))
  } else { it }

  // Pagebreaks are meaningless in HTML. Suppress.
  //
  // REMOVE WHEN: optional now — Typst 0.14.1 downgraded "pagebreak in HTML"
  // from an error to a warning (typst/typst#6238). Keep this rule only to
  // silence those warnings; dropping it is safe.
  show pagebreak: it => if target() == "html" { none } else { it }

  // align(center)[…] drops its body in HTML export. Strip the wrapper so the
  // body still renders. We lose the centering in HTML — acceptable for v1.
  //
  // REMOVE WHEN: typst/typst#5512 — `align` gets an HTML mapping (likely
  // emits a wrapper with text-align CSS). Not listed in the milestone yet.
  show align: it => if target() == "html" { it.body } else { it }

  body
}
