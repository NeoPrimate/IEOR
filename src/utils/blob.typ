#import "@preview/cetz:0.3.1"

#let rand-consts = (
  a: 1103515245,
  c: 12345,
  m: (1).bit-lshift(31)
)
#let random(seed) = {
  let seed = calc.rem(rand-consts.a * seed + rand-consts.c, rand-consts.m)
  let value = seed / rand-consts.m
  return (seed, value)
}
#let draw-blob(
  seed,
  center,
  radius,
  n-pts: 8,
  curviness: 0.4,
  debug: false,
  ..args
) = {
  let pts = ()
  let angle-step = 360deg / n-pts
  let seed = seed
  let v

  if debug {
    draw.circle(center, radius: radius, stroke: (dash: "dashed"))
  }
  for i in range(n-pts) {
    (seed, v) = random(seed)
    let angle = angle-step * (i + v - 0.5)
    
    (seed, v) = random(seed)
    let f = calc.rem(i, 2) * 2 - 1
    let r = radius * (1 + f * v * curviness)

    let dx = r * calc.cos(angle)
    let dy = r * calc.sin(angle)
    let pt = (center.first() + dx, center.last() + dy)
    pts.push(pt)

    if debug {
      draw.circle(
        pt,
        radius: .1,
        stroke: none,
        fill: black
      )
      draw.line(
        center,
        (rel: center, to: (angle-step * i, radius)),
        stroke: (dash: "dashed")
      )
    }
  }

  let name = args.named().at("name", default: none)
  cetz.draw.group(name: name, {
    cetz.draw.hobby(..pts, close: true, ..args)
    if name != none {
      cetz.draw.copy-anchors(name)
      cetz.draw.anchor("center", center)
    }
  })
}

