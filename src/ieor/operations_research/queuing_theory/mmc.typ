#import "../../../../../utils/examples.typ": eg
#import "../../../../../utils/code.typ": code

#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes


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

#figure(image("../../../vis/exponential_interarrival_times_poisson_number_arrivals.png", width: 80%))

*System Stability*

- $lambda gt c mu$:
  - Arrival rate greater than service rate
  - Queue will grow infinitely
- $lambda lt c mu$: 
  - Without variability: no queue or wait time
  - With variability: may have wait time
- $lambda = c mu$: 

#figure(image("../../../vis/queuing.png", width: 50%))


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