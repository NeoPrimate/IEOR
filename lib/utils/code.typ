#let code(file_name, file_content) = context if target() == "html" {
  [
    #html.elem("h4", attrs: (class: "code-title"), file_name)
    #file_content
  ]
} else {
  stack(
    block(
      fill: luma(200),
      inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
      outset: 0pt,
      radius: ("top-left": 4pt, "top-right": 4pt),
      width: 100%,
      text(size: 16pt, weight: "semibold")[#file_name],
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
