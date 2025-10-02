#let formatting(body) = {

  set heading(numbering: "1.1.")
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