// Single source of truth for utils + package versions.
// Every content file should do: #import "/src/imports.typ": *
// Update versions HERE — never per-file — to avoid drift.

// === Packages (modules) ===
#import "@preview/cetz:0.5.0"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/numty:0.1.0"
#import "@preview/numty:0.1.0" as nt
#import "@preview/oxifmt:1.0.0"
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/suiji:0.5.1"
#import "@preview/suiji:0.5.1": (
  choice, discrete, gen-rng, gen-rng-f, integers, normal, normal-f, shuffle, uniform, uniform-f,
)
#import "@preview/plotsy-3d:0.2.1"
#import "@preview/plotsy-3d:0.2.1": *
#import "@preview/ribbony:0.1.0"
#import "@preview/ribbony:0.1.0": *
#import "@preview/modpattern:0.1.0": modpattern

// === Convenience names (used inside cetz.canvas blocks etc.) ===
#import "@preview/cetz:0.5.0": canvas, draw, tree
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node, shapes

// === Utils ===
#import "/src/utils/example.typ": example
#import "/src/utils/code.typ": code, code_output
#import "/src/utils/result.typ": result
#import "/src/utils/color_math.typ": colorMath
#import "/src/utils/color_mat.typ": colorMat
#import "/src/utils/definition.typ": definition
#import "/src/utils/titles.typ": title_1, title_2
#import "/src/utils/title_page.typ": title_page
#import "/src/utils/blob.typ": draw-blob
#import "/src/utils/cancelto.typ": cancelto
#import "/src/utils/proof.typ": proof
#import "/src/utils/prerequisites.typ": prerequisites
#import "/src/utils/resources.typ": resources
#import "/src/utils/matvec_mult.typ": matvec_mult

// === Distribution helpers ===
#import "/src/utils/distributions/gaussian.typ": gaussian_cdf, gaussian_pdf
#import "/src/utils/distributions/exponential.typ": exponential_pdf
#import "/src/utils/distributions/poisson.typ": poisson_pmf
#import "/src/utils/distributions/t.typ": t_pdf
