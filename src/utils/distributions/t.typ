// Approximate gamma function using Lanczos approximation
#let gamma(z) = {
  let p = (
    676.5203681218851,
    -1259.1392167224028,
    771.32342877765313,
    -176.61502916214059,
    12.507343278686905,
    -0.13857109526572012,
    9.9843695780195716e-6,
    1.5056327351493116e-7,
  )

  let g = 7
  if z < 0.5 {
    calc.pi / (calc.sin(calc.pi * z) * gamma(1.0 - z))
  } else {
    let z1 = z - 1.0
    let a = 0.99999999999980993
    let sum = range(0, p.len()).fold(a, (acc, i) => acc + p.at(i) / (z1 + i + 1.0))
    let t = z1 + g + 0.5
    calc.sqrt(2.0 * calc.pi) * calc.pow(t, z1 + 0.5) * calc.exp(-t) * sum
  }
}

// Student's t-distribution PDF
#let t_pdf(x, nu) = {
  let coeff = gamma((nu + 1.0) / 2.0) / (
    calc.sqrt(nu * calc.pi) * gamma(nu / 2.0)
  )
  let exponent = -(nu + 1.0) / 2.0
  coeff * calc.pow(1.0 + x * x / nu, exponent)
}