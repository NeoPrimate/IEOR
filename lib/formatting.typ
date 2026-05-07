#let formatting(body) = {

  set heading(numbering: "1.1.")

  show heading.where(level: 1): it => [
    #set text(size: 24pt, weight: "semibold")
    #it
  ]
  show heading.where(level: 2): it => [
    #set text(size: 18pt, weight: "semibold")
    #it
  ]

  show heading.where(level: 3): it => [
    #set text(size: 14pt, weight: "semibold")
    #it
  ]

  set text(font: "Helvetica")

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