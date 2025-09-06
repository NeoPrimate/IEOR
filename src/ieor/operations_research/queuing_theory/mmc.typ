#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/suiji:0.4.0": gen-rng, uniform, random
#import "@preview/oxifmt:0.2.1": strfmt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath


== M/M/c

- M: Memoryliss interarrival times
- M: Memoryless service times
- c: number of servers


*Input parameters*:

- $c$: number of parallel servers in the system

- $mu$: average service rate of μ (mu) per server 
  - Exponential distribution: $mu$ customers per unit of time

- $lambda$: average rate of arrivals per unit of time
  - Poisson process: number of arrivals in a given time period
  - Exponential distribution: time between successive arrivals


// Common rate parameter - this links the two distributions
#let λ = 2
#let time_period = 2  // Time window for counting arrivals

// Poisson distribution: number of arrivals in time period t
#let poisson = (lambda_t, k) => (calc.pow(lambda_t, k) * calc.exp(-lambda_t)) / calc.fact(k)

// For Poisson: λt where t is the time period
#let lambda_t = λ * time_period
#let max_k = 12
#let k_vals = range(0, max_k + 1)
#let poisson_probs = k_vals.map(k => poisson(lambda_t, k))

// Normalize (though they should already sum to ~1)
#let sum_poisson = poisson_probs.sum()
#let poisson_probs = poisson_probs.map(p => p / sum_poisson)
#let max_poisson = calc.max(..poisson_probs)

// Exponential distribution: inter-arrival times
#let exponential_pdf = (lambda, t) => lambda * calc.exp(-lambda * t)

// Generate time values for continuous plot
#let max_t = 6
#let t_step = 0.1
#let t_vals = range(0, int(max_t / t_step) + 1).map(i => i * t_step)
#let exp_probs = t_vals.map(t => exponential_pdf(λ, t))
#let max_exp = calc.max(..exp_probs)

#let pois_dist = cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *
  
  set-style(
    axes: (
      x: (stroke: 0pt),
      tick: (stroke: 0pt),
      y: (stroke: 0pt, tick: (label: (offset: 1em))),
      padding: 0pt,
      shared-zero: false
    )
  )
  
  plot.plot(
    size: (5, 5),
    axis-style: "school-book",
    x-tick-step: none,
    y-tick-step: max_poisson / 5,
    x-label: text(size: 0.75em)[Number of\ Arrivals ($k$)],
    y-label: text(size: 0.75em)[Probability\ $P(X = k)$],
    x-ticks: k_vals.enumerate().map(((i, k)) => (i + 0.5, str(k))),
    x-min: 0,
    x-max: k_vals.len() * 1.1,
    y-min: 0,
    y-max: max_poisson * 1.1,
    axes: (
      stroke: black,
      tick: (stroke: black),
    ),
    {
      plot.add(domain: (0, 0), x => 0)
      for (i, prob) in poisson_probs.enumerate() {
        plot.annotate({
          rect((i + 0.1, 0), (i + 0.9, prob), fill: blue.lighten(75%), stroke: blue)
        })
      }
      
    }
  )
})

#let exp_dist = cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *

  set-style(
    axes: (
      x: (stroke: 0pt),
      tick: (stroke: 0pt),
      y: (stroke: 0pt, tick: (label: (offset: 1em))),
      padding: 0pt,
      shared-zero: false
    )
  )
  
  plot.plot(
    size: (5, 5),
    axis-style: "school-book",
    x-tick-step: 1,
    y-tick-step: max_exp / 5,
    x-label: text(size: 0.75em)[Time\ Between\ Arrivals ($t$)],
    y-label: text(size: 0.75em)[Probability\ Density $f(t)$],
    x-min: 0,
    x-max: max_t * 1.1,
    y-min: 0,
    y-max: max_exp * 1.1,
    axes: (
      stroke: black,
      tick: (stroke: black),
    ),
    {
      // Plot the exponential curve
      plot.add(
        t_vals.zip(exp_probs),
        style: (stroke: red + 2pt)
      )
      
      // Fill area under curve for visualization
      let fill_points = ((0, 0),) + t_vals.zip(exp_probs) + ((max_t, 0),)
      plot.annotate({
        line(..fill_points, fill: red.lighten(85%), stroke: none)
      })
    }
  )
})

#table(
  columns: (auto, auto),
  inset: 10pt,
  align: horizon,
  stroke: none,
  [#exp_dist], [#pois_dist],
  [
    #align(center)[
      #text(10pt)[*Exponential Distribution:\ Inter-arrival Times*]
    
      #text(10pt)[Rate parameter λ = #λ (same as above)]
    ]
  ], 
  [
    #align(center)[
      #text(10pt)[*Poisson Distribution:\ Number of Arrivals in Time Period $t = #time_period$*]
      
      #text(10pt)[Rate parameter $lambda = #λ$, so $lambda t = #lambda_t$]
    ]
  ],
)

*System Stability*

- $lambda gt c mu$:
  - Arrival rate greater than service rate
  - Queue will grow infinitely
- $lambda lt c mu$: 
  - Without variability: no queue or wait time
  - With variability: may have wait time
- $lambda = c mu$: 

// Random number generator functions
#let gen-rng(seed) = (seed,)
#let random(rng, size: 1) = {
  let (seed,) = rng
  let values = ()
  let current_seed = seed
  for i in range(size) {
    // Simple LCG random number generator
    current_seed = calc.rem(current_seed * 1103515245 + 12345, calc.pow(2, 31))
    let uniform = current_seed / calc.pow(2, 31)
    values.push(uniform)
  }
  ((current_seed,), values)
}

#let λ = 7 // arrival rate
#let μ = 6 // service rate  
#let c = 2 // number of servers
#let n_customers = 50 // number of customers

#let rng = gen-rng(42)

// Generate exponential arrivals using inverse CDF
#let (rng, uniforms) = random(rng, size: n_customers)
#let inter_arrivals = uniforms.map(u => -calc.ln(u)/λ)

// Compute cumulative arrivals
#let arrival_times = ()
#let total = 0.0
#for x in inter_arrivals {
  total = total + x
  arrival_times.push(total)
}

// Generate service times
#let (rng, uniforms) = random(rng, size: arrival_times.len())
#let service_times = uniforms.map(u => -calc.ln(u)/μ)

// Initialize arrays
#let start_service_times = range(arrival_times.len()).map(_ => 0.0)
#let end_service_times = range(arrival_times.len()).map(_ => 0.0)
#let wait_times = range(arrival_times.len()).map(_ => 0.0)
#let servers = range(c).map(_ => 0.0)

// Queue simulation
#for i in range(arrival_times.len()) {
  let arrival = arrival_times.at(i)
  let next_server = calc.min(..servers)
  
  if arrival >= next_server {
    start_service_times.at(i) = arrival
  } else {
    start_service_times.at(i) = next_server
  }
  
  end_service_times.at(i) = start_service_times.at(i) + service_times.at(i)
  wait_times.at(i) = start_service_times.at(i) - arrival
  
  // Find index of minimum server and update it
  let min_idx = 0
  for j in range(servers.len()) {
    if servers.at(j) == next_server {
      min_idx = j
      break
    }
  }
  servers.at(min_idx) = end_service_times.at(i)
}

// Visualization
#cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *
  
  plot.plot(
    size: (15, 10),
    x-tick-step: 1,
    y-tick-step: 5, 
    x-minor-tick-step: none,
    y-minor-tick-step: none,
    x-min: 0,
    y-min: -0.5,
    x-max: calc.max(..end_service_times),
    y-max: n_customers,
    axis-style: "scientific",
    x-label: [Time],
    y-label: [Customer],
    x-grid: "major",
    y-grid: "major",
    {
      // Add rectangles for wait times and service times
      for i in range(arrival_times.len()) {
        let arrival = arrival_times.at(i)
        let start = start_service_times.at(i)
        let service_duration = service_times.at(i)
        let wait_duration = start - arrival
        
        // Wait time rectangle (red)
        if wait_duration > 0 {
          plot.add-anchor(strfmt("wait-start-{}", i), (arrival, i - 0.4))
          plot.add-anchor(strfmt("wait-end-{}", i), (start, i + 0.4))
        }
        
        // Service time rectangle (green)  
        plot.add-anchor(strfmt("service-start-{}", i), (start, i - 0.4))
        plot.add-anchor(strfmt("service-end-{}", i), (start + service_duration, i + 0.4))
      }
    }, 
    name: "plot"
  )
  
  // Draw rectangles after plot is created
  for i in range(arrival_times.len()) {
    let arrival = arrival_times.at(i)
    let start = start_service_times.at(i)
    let service_duration = service_times.at(i)
    let wait_duration = start - arrival
    
    // Wait time rectangle (red)
    if wait_duration > 0 {
      rect(
        strfmt("plot.wait-start-{}", i), 
        strfmt("plot.wait-end-{}", i), 
        fill: red.lighten(60%),
        stroke: red
      )
    }
    
    // Service time rectangle (green)
    rect(
      strfmt("plot.service-start-{}", i), 
      strfmt("plot.service-end-{}", i), 
      fill: green.lighten(60%),
      stroke: green
    )
  }
})


Performance Metrics

1. Utilization ($rho$)

$
rho = lambda / (c dot mu)
$

Where:
- $lambda$: arrival rate (mean number of arrivals per unit of time)
- $mu$: service rate (mean number of services completed per server per unit of time)

2. Probability of Zero Customers in the System (Idle Probability) ($P_0$)

Probability that no customers are in the system

$
P_0 = (sum_(n=0)^(c-1) (lambda / mu)^2 / n! + (lambda / mu)^c / (c!(1 - p)))^(-1) 
$

3. Probability that All Servers are Busy (Blocking Probability or Queueing Probability) ($P_w$)

Probability that all $c$ servers are busy and a customer will have to wait in the queue

$
P_w = ((lambda / mu)^c / c!) / (sum_(n=0)^(c-1) (((lambda / mu)^n) / c!) / n! + (lambda / mu)^c / (c! (1 - p)))
$

4. Average Number of Customers in the System ($L$)

Average number of customers in the system (both in the queue and being served)

$
L = lambda / mu + (P_w dot (lambda / mu)) / (c (1 - p))
$

5. Average Number of Customers in the Queue ($L_q$)

Average number of customers waiting in the queue (not being served)

$
L_q = P_w dot ((rho dot (lambda / mu)) / (1 - rho))
$

6. Average Time a Customer Spends in the System ($W$)

Average time a customer spends in the system (both waiting and being served) (Little's Law)

$
W = L / lambda
$

7. Average Time a Customer Spends in the Queue ($W_q$)

Average waiting time a customer spends in the queue before being served

$
W_q = L_q / lambda = P_w dot 1 / (c mu (1-p))
$

#linebreak()
#linebreak()

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (0,0), label: $0$, stroke: 0.1em, radius: 1.5em, name: <0>),
    node(pos: (1,0), label: $1$, stroke: 0.1em, radius: 1.5em, name: <1>),
    node(pos: (2,0), label: $2$, stroke: 0.1em, radius: 1.5em, name: <2>),
    node(pos: (3,0), label: $3$, stroke: 0.1em, radius: 1.5em, name: <3>),
    node(pos: (4,0), label: $dots$, stroke: 0em, radius: 1.5em, name: <4>),
    node(pos: (5,0), label: $c-1$, stroke: 0.1em, radius: 1.5em, name: <5>),
    node(pos: (6,0), label: $c$, stroke: 0.1em, radius: 1.5em, name: <6>),
    node(pos: (7,0), label: $c+1$, stroke: 0.1em, radius: 1.5em, name: <7>),
    node(pos: (8,0), label: $dots$, stroke: 0em, radius: 1.5em, name: <8>),

    edge(<0>, <1>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<1>, <0>, "-|>", label: {
      place(bottom+center, dy: 2mm, $mu$)
    }, bend: 50deg, label-size: 1em),

    edge(<1>, <2>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<2>, <1>, "-|>", label: {
      place(bottom+center, dy: 2mm, $2mu$)
    }, bend: 50deg, label-size: 1em),

    edge(<2>, <3>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<3>, <2>, "-|>", label: {
      place(bottom+center, dy: 2mm, $3mu$)
    }, bend: 50deg, label-size: 1em),

    edge(<3>, <4>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<4>, <3>, "-|>", label: {
      place(bottom+center, dy: 2mm, $4mu$)
    }, bend: 50deg, label-size: 1em),

    edge(<4>, <5>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<5>, <4>, "-|>", label: {
      place(bottom+center, dy: 2mm, $(c - 1) mu$)
    }, bend: 50deg, label-size: 1em),

    edge(<5>, <6>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<6>, <5>, "-|>", label: {
      place(bottom+center, dy: 2mm, $c mu$)
    }, bend: 50deg, label-size: 1em),
    
    edge(<6>, <7>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<7>, <6>, "-|>", label: {
      place(bottom+center, dy: 2mm, $c mu$)
    }, bend: 50deg, label-size: 1em),

    edge(<7>, <8>, "-|>", label: {
      place(bottom+center, dy: 0mm, $lambda$)
    }, bend: 50deg, label-size: 1em),
    edge(<8>, <7>, "-|>", label: {
      place(bottom+center, dy: 2mm, $c mu$)
    }, bend: 50deg, label-size: 1em),

  )
]

#linebreak()
#linebreak()