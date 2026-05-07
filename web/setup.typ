// HTML-only show rules. Applied via #show: web_setup in book.typ.
//
// Math + figures don't render natively in HTML export — they fall back to
// inline SVG via `html.frame`, wrapped in semantic HTML elements. Pattern
// from Krasjet's comment on typst/typst#721.

#let web_setup(body) = {
  show math.equation.where(block: false): it => {
    if target() == "html" {
      html.elem("span", attrs: (role: "math"), html.frame(it))
    } else { it }
  }

  show math.equation.where(block: true): it => {
    if target() == "html" {
      html.elem("figure", attrs: (role: "math"), html.frame(it))
    } else { it }
  }

  show figure: it => {
    if target() == "html" {
      html.elem("figure", attrs: (class: "typst"), html.frame(it))
    } else { it }
  }

  show pagebreak: it => if target() == "html" { none } else { it }

  // align(center)[…] drops its body in HTML export. Strip the wrapper so the
  // body still renders. We lose the centering in HTML — acceptable for v1.
  show align: it => if target() == "html" { it.body } else { it }

  body
}
