#let gaussian_pdf(x, mu, sigma) = {
  let prefactor = 1.0 / (sigma * calc.sqrt(2.0 * calc.pi))
  let exponent = -(calc.pow((x - mu), 2)) / (2.0 * calc.pow(sigma, 2))
  prefactor * calc.exp(exponent)
}

#let erf(z) = {
  // Abramowitz and Stegun formula 7.1.26 approximation
  let t = 1.0 / (1.0 + 0.3275911 * calc.abs(z))
  let a1 = 0.254829592
  let a2 = -0.284496736
  let a3 = 1.421413741
  let a4 = -1.453152027
  let a5 = 1.061405429
  let poly = a1*t + a2*calc.pow(t, 2) + a3*calc.pow(t, 3) + a4*calc.pow(t, 4) + a5*calc.pow(t, 5)
  let approx = 1.0 - poly * calc.exp(-calc.pow(z, 2))
  if z < 0 { -approx } else { approx }
}

#let gaussian_cdf(x, mu, sigma) = {
  let z = (x - mu) / (sigma * calc.sqrt(2.0))
  0.5 * (1.0 + erf(z))
}