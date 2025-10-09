#let eg(title: none, content) = stack(
  block(
    fill: luma(200),
    inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
    radius: ("top-left": 4pt, "top-right": 4pt),
    width: 100%,
    text(size: 16pt, weight: "semibold")[
      #if title != none [
        Example: #title
      ] else [
        Example
      ]
    ]
  ),
  block(
    fill: luma(230),
    inset: 10pt,
    radius: ("bottom-left": 4pt, "bottom-right": 4pt),
    width: 100%,
    [
      #set heading(numbering: "1.1.")

      #show heading.where(level: 1): it => [
        #set text(size: 16pt, weight: "semibold")
        #it
      ]

      #show heading.where(level: 2): it => [
        #set text(size: 14pt, weight: "semibold")
        #it
      ]

      #show heading.where(level: 3): it => [
        #set text(size: 12pt, weight: "semibold")
        #it
      ]

      #content
    ]
  )
)