// Single source of truth for utils + package versions.
// Every content file should do: #import "/lib/imports.typ": *
// Update versions HERE — never per-file — to avoid drift.

// === Packages (modules) ===
#import "@preview/cetz:0.5.0"
#import "@preview/cetz-plot:0.1.3"
// #import "@preview/cetz:0.4.2"
// #import "@preview/cetz-plot:0.1.3"
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/numty:0.1.0"
#import "@preview/numty:0.1.0" as nt
#import "@preview/oxifmt:1.0.0"
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/suiji:0.5.1"
#import "@preview/suiji:0.5.1": (
  choice, discrete, gen-rng, gen-rng-f, integers, normal, normal-f, shuffle, uniform, uniform-f,
)
// plotsy-3d / ribbony: explicit imports only. Wildcard `*` brought
// cetz 0.4.1's `canvas` into scope (plotsy-3d uses cetz 0.4.1
// internally), which conflicted with cetz 0.5.0's canvas under
// nested cetz-plot calls. List the symbols actually used here.
#import "@preview/plotsy-3d:0.2.1": plot-3d-surface
#import "@preview/ribbony:0.1.0": (
  ribbony-diagram, sankey-diagram, chord-diagram,
  layout, ribbon-stylizer, tinter, label,
)
// Local replacement for @preview/modpattern:0.1.0, whose only function wraps
// the `pattern` builtin — removed in Typst 0.15 (renamed to `tiling` in 0.13).
// `tiling` exists in 0.13–0.15, so this is version-robust. Same signature.
#let modpattern(size, body, dx: 0pt, dy: 0pt, background: none) = tiling(
  size: size,
  {
    if background != none {
      place(box(width: 100%, height: 100%, fill: background))
    }
    move(dx: -size.at(0) + dx, dy: -size.at(1) + dy, grid(
      columns: 3 * (size.at(0),),
      rows: 3 * (size.at(1),),
      body, body, body,
      body, body, body,
      body, body, body,
    ))
  },
)

// === Convenience names (used inside cetz.canvas blocks etc.) ===
#import "@preview/cetz:0.5.0": draw, tree
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/fletcher:0.5.8" as fletcher: edge, node, shapes

// `frame` is the elembic wrapper for cetz canvases / fletcher diagrams —
// see web/setup.typ. Call sites: `#frame(cetz.canvas({...}))` and
// `#frame(fletcher.diagram(...))`.
#import "/web/setup.typ": web_setup, frame

// === Utils ===
#import "/lib/utils/example.typ": example
#import "/lib/utils/code.typ": code, code_output
#import "/lib/utils/result.typ": result
#import "/lib/utils/color_math.typ": colorMath
// NOTE: lib/utils/colors.typ defines a semantic palette (highlight, focus,
// accent, support, ok, muted) but we don't re-export it — `accent` collides
// with typst's built-in math.accent function (used for v⃗ etc) and would
// shadow it across all 372 callsites. To use the palette, import the file
// directly in the leaf that needs it.
#import "/lib/utils/color_mat.typ": colorMat
#import "/lib/utils/definition.typ": definition
#import "/lib/utils/titles.typ": title_1, title_2
#import "/lib/utils/title_page.typ": title_page
#import "/lib/utils/blob.typ": draw-blob
#import "/lib/utils/cancelto.typ": cancelto
#import "/lib/utils/proof.typ": proof
#import "/lib/utils/prerequisites.typ": prerequisites
#import "/lib/utils/resources.typ": resources
#import "/lib/utils/matvec_mult.typ": matvec_mult

// === Document-wide formatting ===
#import "/lib/formatting.typ": formatting

// === Distribution helpers ===
#import "/lib/utils/distributions/gaussian.typ": gaussian_cdf, gaussian_pdf
#import "/lib/utils/distributions/exponential.typ": exponential_pdf
#import "/lib/utils/distributions/poisson.typ": poisson_pmf
#import "/lib/utils/distributions/t.typ": t_pdf
