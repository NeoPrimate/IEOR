#let cancelto(body, to) = {
  let arrow = rotate(-55deg, scale(x: 170%, $-->$))
  context {
    let m = measure(body)
    let (w, h) = (m.width, m.height * 2)
    set place(center + horizon)
    // block(height: h * 2.5, align(horizon, body)) // Add vertical margins.
    body
    place(dx: -w * 0.5, dy: -h * 0.1, arrow)
    place(dx: w * 0.1, dy: -h * 1.2, $to$)
  }
}