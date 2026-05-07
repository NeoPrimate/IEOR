#let result(content) = context if target() == "html" {
  content
} else {
  align(center)[
    #block(
      stroke: red,
      inset: 8pt,
      radius: 2pt,
      content,
    )
  ]
}
