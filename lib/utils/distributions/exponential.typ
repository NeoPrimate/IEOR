#let exponential_pdf(x, lambda) = {
  if x < 0.0 {
    0.0
  } else {
    lambda * calc.exp(-lambda * x)
  }
}