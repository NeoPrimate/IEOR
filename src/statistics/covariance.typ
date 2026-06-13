#import "/lib/imports.typ": *
#show: formatting

== Covariance

$
  "Cov"(X, Y) = EE[(X - EE[X])(Y - EE[Y])] = EE[X Y] - EE[X] EE[Y] \
  (sum_(i=1)^n (x_i - obar(x))(y_i - obar(y))) / n
$

#example[
  $
    X = (1, 2, 3) \
    Y = (2, 4, 6) \
  $

  $
    EE[X] = (1 + 2 + 3) / 3 = 2 \
    EE[Y] = (2 + 4 + 6) / 3 = 4 \
  $

  #table(
    columns: 5,
    align: center + horizon,
    [$x_i$], [$y_i$], [$x_i - EE[X]$], [$y_i - EE[Y]$], [product],
    [1], [2], [-1], [-2], [2],
    [2], [4], [0], [0], [0],
    [3], [6], [1], [2], [2],
  )

  $
    "Cov"(X, Y) = (2 + 0 + 2) / 3 = 4 / 3 approx 1.33
  $

  Cross-check with the formula:

  $
    EE[X Y] - EE[X] EE[Y]
  $

  $
    EE[X Y] = ((1)(2) + (2)(4) + (3)(6)) / 3 = (2 + 8 + 18) / 3 = 28 / 3 \

    EE[X] EE[Y] = (2)(4) = 8 \

    EE[X Y] - EE[X] EE[Y] = 28 / 3 - 8 = 4 / 3
  $
]

Covariance is unbounded; correlation is the normalized version:

$
  rho_(X Y) = "Cov"(X, Y) / (sigma_X sigma_Y)
$

== Covariance and Correlation
// #show: lq.theme.schoolbook

#grid(
  columns: 2,
  inset: 1em,
  [
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = lq.vec.jitter(xs, seed: auto, amount: 0, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    
    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_0 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_0 = cov_0 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_0, digits: 2) \
      "Corr" &= #corr_0\
    $
  ],
  [
    
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = xs.map(x => -x)
    #let ys = lq.vec.jitter(ys, seed: auto, amount: 0, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_1 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_1 = cov_1 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_1, digits: 2) \
      "Corr" &= #corr_1\
    $
  ],
  [
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = lq.vec.jitter(xs, seed: auto, amount: 10, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    
    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_2 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_2 = cov_2 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_2, digits: 2) \
      "Corr" &= #calc.round(corr_2, digits: 2) \
    $
  ],
  [
    
    #let xs = lq.linspace(-10, 10, num: 20)
    #let ys = xs.map(x => -x)
    #let ys = lq.vec.jitter(ys, seed: auto, amount: 10, distribution: "normal")

    #let x-bar = xs.sum() / xs.len()
    #let y-bar = ys.sum() / ys.len()

    
    #let x_diff = xs.map(x => x - x-bar)
    #let y_diff = ys.map(y => y - y-bar)

    #let prod = x_diff.zip(y_diff).map(xy => xy.at(0) * xy.at(1))
    #let cov_3 = prod.sum() / prod.len()

    #let std_xs = calc.sqrt(xs.map(x => calc.pow(x - x-bar, 2)).sum() / xs.len())
    #let std_ys = calc.sqrt(ys.map(y => calc.pow(y - y-bar, 2)).sum() / ys.len())

    #let corr_3 = cov_3 / (std_xs * std_ys)

    #let quad-color = (x, y) => if (x - x-bar) * (y - y-bar) >= 0 { blue } else { red }
    #let colors = xs.zip(ys).map(((x, y)) => quad-color(x, y))

    #lq.diagram(
      lq.vlines(x-bar),
      lq.hlines(y-bar),
      lq.scatter(
        xs,
        ys,
        color: colors
      ),
      ..xs.zip(ys).map(((x, y)) => lq.rect(
      x-bar, y-bar,
      width: x - x-bar,
      height: y - y-bar,
      fill: quad-color(x, y).transparentize(80%),
      stroke: none,
      z-index: 1,
    ))
    )
    $
      "Cov" &= #calc.round(cov_3, digits: 2) \
      "Corr" &= #calc.round(corr_3, digits: 2) \
    $
  ],
)

