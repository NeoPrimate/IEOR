#let cnt = counter("definition")

#let definition(concept, definition) = stack(
  block(
    fill: luma(200),
    inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
    outset: 0pt,
    radius: ("top-left": 4pt, "top-right": 4pt),
    width: 100%,
    text(size: 16pt, weight: "semibold")[Definition #context(cnt.display()): #concept]
  ),
  block(
    fill: luma(230),
    inset: 10pt,
    outset: 0pt,
    radius: ("bottom-left": 4pt, "bottom-right": 4pt),
    width: 100%,
    emph(definition)
  )
)