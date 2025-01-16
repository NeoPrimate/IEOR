#import "@preview/numty:0.0.4" as nt

#let matvec_mult(A, x) = {
  let X = x.map(x => (x,))
  let Y = nt.matmul(A, X)
  let y = Y.map(array.first)
  y
}