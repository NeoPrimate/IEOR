#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
#import "@preview/suiji:0.4.0": gen-rng, uniform



#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath


== M/M/1

- Arrival rate ($lambda$): Average number of customers arriving per unit of time

- Service rate ($mu$): Average number of customers served per unit of time

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

#text(14pt)[*Key Relationship*]

Both distributions share the same rate parameter $lambda$ = #λ

- If inter-arrival $times ~ "Exponential"(lambda)$, then arrivals in time $t ~ "Poisson"(lambda t)$
- Mean inter-arrival time = $1/lambda$ = #calc.round(1/λ, digits: 2)
- Mean arrivals per unit time = $lambda$ = #λ
- Mean arrivals in time period #time_period = $lambda$t = #lambda_t





1. Utilization ($rho$)

Fraction of time the server is busy

$
rho = lambda / mu
$

2. Average Number of Customers in the System ($L$)

Average number of customers (both waiting and being served) in the system

$
L = rho / (1 - rho)
$

3. Average Number of Customers in the Queue ($L_q$)

Average number of customers waiting in the queue

$
L_q = rho^2 / (1 - rho)
$

4. Average Time a Customer Spends in the System ($W$)

Average time a customer spends in the system (from arrival until they are done being served) 

$
W = 1 / (mu - lambda)
$

5. Average Waiting Time in the Queue ($W_q$)

Average time a customer spends just waiting in line before being served

$
W_q = rho / (mu - lambda)
$

6. Probability that the System is Empty ($P_0$)

Probability that there are zero customers in the system (no one is being served and no one is waiting)

$
P_0 = 1 - rho
$

7. Probability that n Customers are in the System ($P_n$)

Probability that there are n customers in the system (either waiting or being served)

$
P_n = (1 - rho) dot rho^n
$

8. Probability the Queue is Full (if the Queue has Limited Capacity) ($P_n_"max"$)

Probability that the system is at full capacity

$
P_n_"max" = (1 - rho) dot p^(n_"max")
$

9. System Throughput

Rate at which customers are served and leave the system

$
"Throughput" = lambda
$

10. Expected Time in Service ($W_s$)

Average time a customer spends actually being served (not including waiting time)

$
W_s = 1 / mu
$

11. Idel Time ($1 - rho$)

Fraction of time that the server is idle (i.e., not serving any customers)

$
"Idle Time" = 1 - rho
$

12. Probability of Having to Wait in the Queue ($P_w$)

Probability that an arriving customer will have to wait before being served, i.e., that the server is busy when the customer arrives

$
P_w = rho
$

13. Variance of the Number of Customers in the System ($"Var"(L)$)

Variance of the number of customers in the system

$
"Var"(L) = rho / (1 - rho)^2
$

#eg[
A bank with a single teller

- *Arrival rate ($lambda$)*: On average, 4 customers arrive every 10 minutes ($lambda = 4$ custommers per 10 minutes)

-  *Service Rate ($mu$)*: The teller can serve 6 customers every 10 minutes ($mu = 6$ customers per 10 minutes)

1. *Utilization ($rho$)*

$
rho = lambda / mu = 4 / 6 = 0.67
$

The teller is busy 67% of the time. The remaining 33% of the time, the teller is idle, waiting for the next customer

2. Average Number of Customers in the System ($L$)

$
L = rho / (1 - rho) = 0.67 / (1 - 0.67) = 2
$

On average, there are 2 customers in the coffee shop at any given time, either being served or waiting in line

3. Average Number of Customers in the Queue ($L_q$)

$
L_q = rho^2 / (1 - rho) = 0.67^2 / (1 - 0.67) = 1.33
$

On average, about 1.33 customers are waiting in line at any time

4. Average Time a Customer Spends in the System ($W$)

$
W = 1 / (mu - lambda) = 1 / 6 - 4 = 0.5
$

On average, a customer spends 5 minutes ($0.5 times 10$ minutes) in the shop (including both waiting in line and getting served)

5. Average Waiting Time in the Queue ($W_q$)

$
W_q = rho / (mu - lambda) = 0.67 / (6 - 4) = 0.33
$

On average, a customer waits 3.3 minutes ($0.33 times 10$ minutes) in line before being served by the teller

6. Probability that the System is Empty ($P_0$)

$
P_0 = 1 - rho = 1 - 0.67 = 0.33
$

There is a 33% chance that the coffee shop is empty, meaning there is no customer in the queue or being served

7. Probability that n Customers are in the System ($P_n$)

$
P_n = (1 - rho) dot rho^n = (1 - 0.67) dot 0.67^2 = 0.148
$

There is a 14.8% chance that exactly 2 customers are either in line or being served

8. Probability the Queue is Full (if the Queue has Limited Capacity) ($P_n_"max"$)

$
P_n_"max" = (1 - rho) dot p^(n_"max") = (1 - 0.67) dot 0.67^5 = 0.028
$

There is a 2.8% chance that the system is full, and no new customers can enter

9. System Throughput

$
"Throughput" = lambda = 4
$

The coffee shop serves 4 customers every 10 minutes, on average

10. Expected Time in Service ($W_s$)

$
W_s = 1 / mu = 1 / 6 = 0.167
$

On average, a customer spends 1.67 minutes being served by the teller

11. Idel Time ($1 - rho$)

$
"Idle Time" = 1 - rho = 1 - 0.67 = 0.33
$

The teller is idle 33% of the time

12. Probability of Having to Wait in the Queue ($P_w$)

$
P_w = rho = 0.67
$

There is a 67% chance that a customer will have to wait when they arrive

13. Variance of the Number of Customers in the System ($"Var"(L)$)

$
"Var"(L) = rho / (1 - rho)^2 = 0.67 / (1 - 0.67)^2 = 6.12^2
$

The queue length varies significantly, with a variance of 6.12 customers
]

Costs

- *Cost per Waiting Customer per Unit Time ($C_w$)*: cost incurred per customer for each unit of time they spend waiting in the queue

$
"Total Waiting Cost" = L_q times C_w times "Unit Time"
$

- *Cost per Idle Server per Unit Time ($C_s$)*: cost incurred per unit time when the server is not serving customers

$
"Total Idle Cost" = (1 - rho) times C_s times "Unit Time"
$

Total Cost

$
"Total Cost" = "Total Waiting Cost" + "Total Idle Cost"
$

#eg[

  - Arrival Rate ($lambda$): 4 customers per 10 minutes
  - Service Rate ($mu$): 6 customers per 10 minutes
  - Cost per Waiting Customer per Hour ($C_w$): \$10
  - Cost per Idle Server per Hour ($C_s$): \$20
  - Operational Time: 1 hour 

  1. Utilization

  $
  rho = lambda / mu = 4 / 6 = 0.67
  $

  2. Average Number of Customers in Queue ($L_q$)

  $
  L_q = rho^2 / (1 - rho) = 0.67^2 / (1 - 0.67) = 1.33 "cusommers"
  $

  3. Total Waiting Cost

  $
  "Total Waiting Cost" = L_q times C_w times "Unit Time" = 1.33 times 10 times 1 = \$13.33
  $

  4. Idle Time

  $
  "Idle Time" = 1 - rho = 1 - 0.67 = 0.33
  $

  5. Total Idle Cost

  $
  "Total Idle Cost" = (1 - rho) times C_s times "Unit Time" = 0.33 times 20 times 1 = \$6.67
  $

  6. Total Cost

  $
  "Total Cost" = "Total Waiting Cost" + "Total Idle Cost" = 13.33 + 6.67 = \$20
  $
]




