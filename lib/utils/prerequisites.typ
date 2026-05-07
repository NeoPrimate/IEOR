#let prerequisites(prereqs: array, dependents: array) = {
  stack(
    if prereqs.len() > 0 {
      let radius_bottom = if dependents.len() > 0 {
        (:)
      } else {
        ("bottom-left": 4pt, "bottom-right": 4pt)
      }
      stack(
        block(
          fill: luma(200),
          inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
          radius: ("top-left": 4pt, "top-right": 4pt),
          width: 100%,
          text(size: 16pt, weight: "semibold")[Prerequisites]
        ),
        block(
          fill: luma(230),
          inset: 10pt,
          radius: ("bottom-left": 0pt, "bottom-right": 0pt) + radius_bottom,
          width: 100%,
          [
            #list(
              indent: 0pt,
              ..prereqs.map(link => [#link])
            )
          ]
        )
      )
    },
    if dependents.len() > 0 {
      let radius_top = if prereqs.len() > 0 {
        (:)
      } else {
        ("top-left": 4pt, "top-right": 4pt)
      }
      stack(
        block(
          fill: luma(200),
          inset: ("left": 10pt, "top": 10pt, "bottom": 10pt),
          radius: ("top-left": 0pt, "top-right": 0pt) + radius_top,
          width: 100%,
          text(size: 16pt, weight: "semibold")[Leads To]
        ),
        block(
          fill: luma(230),
          inset: 10pt,
          radius: ("bottom-left": 4pt, "bottom-right": 4pt),
          width: 100%,
          [
            #list(
              indent: 0pt,
              ..dependents.map(link => [#link])
            )
          ]
        )
      )
    }
  )
}