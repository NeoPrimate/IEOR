#import "/lib/imports.typ": *
#show: formatting
#import "@local/tystats:0.1.0": norm, poisson

#let t = range(0, 12)

#for e in t [
  #let d = norm.rvs(mean: 20, std_dev: 8, seed: e)
  #let order = 84
  #(d.at(0) - order)
]
