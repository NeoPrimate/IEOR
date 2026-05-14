// Accepts either `#code[body]` or `#code("file.py")[body]` —
// the trailing content block is appended to the positional args list.
#let code(..args) = {
  let p = args.pos()
  let (file_name, file_content) = if p.len() >= 2 { (p.at(0), p.at(1)) } else { (none, p.at(0)) }
  let title = if file_name != none { file_name } else [Code]
  context if target() == "html" {
    html.elem(
      "details",
      attrs: (class: "code"),
      {
        html.elem("summary", title)
        html.elem("div", attrs: (class: "code-body"), file_content)
      },
    )
  } else {
    stack(
      block(
        fill: luma(200),
        inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
        outset: 0pt,
        radius: ("top-left": 4pt, "top-right": 4pt),
        width: 100%,
        text(size: 16pt, weight: "semibold")[#title],
      ),
      block(
        fill: luma(230),
        inset: 10pt,
        outset: 0pt,
        radius: ("bottom-left": 4pt, "bottom-right": 4pt),
        width: 100%,
        file_content,
      ),
    )
  }
}

#let code_output(output) = context if target() == "html" {
  [
    #html.elem("h4", attrs: (class: "code-output-title"))[Output:]
    #output
  ]
} else {
  stack(
    block(
      fill: luma(200),
      inset: 10pt,
      outset: 0pt,
      radius: ("bottom-left": 4pt, "bottom-right": 4pt),
      width: 100%,
      [
        #text(size: 16pt, weight: "semibold")[Output:]
      ],
    ),
    block(
      fill: luma(230),
      inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
      outset: 0pt,
      radius: ("top-left": 4pt, "top-right": 4pt),
      width: 100%,
      output,
    ),
  )
}
