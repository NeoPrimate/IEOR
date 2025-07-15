#let cnt = counter("definition")
#let color = silver

#let definition(concept, definition) = block(
    stroke: none,
    inset: 0pt,
    outset: 0pt,
    spacing: 10pt,
    [
      #block(
        inset: 10pt,
        width: 100%,
        fill: color.darken(25%),
        spacing: 0pt,
        [
        #cnt.step()
        #text(14pt, [*Definition #context(cnt.display())*: #concept])
        ]
      )
      #block(
        inset: 10pt,
        width: 100%,
        fill: color,
        spacing: 0pt,
        [
          #definition
        ]
      )
    ]
)