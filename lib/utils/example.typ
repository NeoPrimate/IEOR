// Accepts `#example[body]`, `#example("title")[body]`, or the legacy
// `#example(title: "title")[body]`. The trailing content block is appended
// to the positional args list, so we read off `args.pos()` and fall back
// to the named `title:` for the 48 existing callsites that still use it.
#let example(..args) = {
  let p = args.pos()
  let (pos_title, content) = if p.len() >= 2 { (p.at(0), p.at(1)) } else { (none, p.at(0)) }
  let title = if pos_title != none { pos_title } else { args.named().at("title", default: none) }
  context if target() == "html" {
  // Collapsible <details> in HTML — default closed.
  html.elem(
    "details",
    attrs: (class: "example"),
    {
      html.elem(
        "summary",
        if title != none [Example: #title] else [Example],
      )
      html.elem("div", attrs: (class: "example-body"), content)
    },
  )
} else {
  stack(
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
      ],
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
      ],
    ),
  )
  }
}
