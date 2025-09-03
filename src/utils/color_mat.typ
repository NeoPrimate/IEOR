#let colorMat(matrix, squares) = {
  let colors = (red.lighten(70%), blue.lighten(70%), green.lighten(70%), yellow.lighten(70%), purple.lighten(70%), orange.lighten(70%))
  set table(
    stroke: (c, r) => {
      let borders = (:);
      for (((r1, c1), (r2,c2)), _) in squares {
        // Left border
        if c == c1 and r >= r1 and r <= r2 {
          borders.insert("left", 1pt)
        }
        // Right border
        if c == c2 and r >= r1 and r <= r2 {
          borders.insert("right", 1pt)
        }
        // Top border
        if r == r1 and c >= c1 and c <= c2 {
          borders.insert("top", 1pt)
        }
        // Bottom border
        if r == r2 and c >= c1 and c <= c2 {
          borders.insert("bottom", 1pt)
        }
      }
      borders
    },
    fill: (c, r) => {
      for (((r1, c1), (r2, c2)), color) in squares {
        if r >= r1 and r <= r2 and c >= c1 and c <= c2 {
          return color.transparentize(75%)
        }
      }
      return none
    }
  )

  $
    mat(
      #table(
        columns: range(matrix.at(0).len()).map(v => auto),
        ..matrix.flatten().map(v => str(v))
      )
    )
  $
}