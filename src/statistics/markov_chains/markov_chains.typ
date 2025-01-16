#import "../../../../utils/examples.typ": eg
#import "../../../../utils/code.typ": code

#import "@preview/fletcher:0.5.1" as fletcher: diagram, node, edge, shapes

== Markov Chains

=== Checkout Counter Model

- Discrete time ($n = 0, 1, dots$)
- Custommer arrivals: Benoulli($p$)
  - Geometric arrival times
- Custommer service times: Geometric($q$)
- State $X_n$: Number of cusommers at time $n$

#figure(image("../../vis/exponential_interarrival_times_poisson_number_arrivals.png", width: 90%))

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
    // node(pos: (7,0), label: $c+1$, stroke: 0.1em, radius: 1.5em, name: <7>),
    // node(pos: (8,0), label: $dots$, stroke: 0em, radius: 1.5em, name: <8>),

    edge(<0>, <1>, "-|>-", label: $p$, bend: 50deg, label-size: 0.75em),
    edge(<1>, <0>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<0>, <0>, "-|>-", label: $1-p$, bend: 130deg, label-size: 0.75em),
    edge(<1>, <1>, "-|>-", label: $$, bend: 130deg, label-size: 0.75em),

    edge(<1>, <2>, "-|>-", label: $p(1-q)$, bend: 50deg, label-size: 0.75em),
    edge(<2>, <1>, "-|>-", label: $q (1 - p)$, bend: 50deg, label-size: 0.75em),
    edge(<2>, <2>, "-|>-", label: $$, bend: 130deg, label-size: 0.75em),

    edge(<2>, <3>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<3>, <2>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<3>, <3>, "-|>-", label: $p q + (1-p)(1-q)$, bend: 130deg, label-size: 0.75em),

    edge(<3>, <4>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<4>, <3>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),

    edge(<4>, <5>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<5>, <4>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<5>, <5>, "-|>-", label: $$, bend: 130deg, label-size: 0.75em),

    edge(<5>, <6>, "-|>-", label: $$, bend: 50deg, label-size: 0.75em),
    edge(<6>, <5>, "-|>-", label: $q$, bend: 50deg, label-size: 0.75em),
    edge(<6>, <6>, "-|>-", label: $1 - q$, bend: 130deg, label-size: 0.75em),

  )
]

#linebreak()
#linebreak()

Where:
- $p$: Probability of having an arrival
- $q$: Probability of having an departure
- $p q$: Probability of having an arrival and a departure simultaneously 
- $1 - p$: Probability of not having a custommer arrival
- $1 - q$: Probability of not having a custommer departure
- $p (1 - q)$: Probability of custommer arrival without a custommer departure
- $q (1 - p)$: Probability of custommer departure without a custommer arrival

=== $bold(n)$-Step Transition Probabilities

State occupance probabilities given initial state $i$:

$
r_(i j) = P(X_n = j | X_0 = i)
$

#align(center)[
  #diagram(
    node-inset: 0pt,

    node(pos: (-3,0), label: $i$, stroke: 0.1em, radius: 1.5em, name: <i>),
    node(pos: (2,-2), label: $l$, stroke: 0.1em, radius: 1.5em, name: <l>),
    node(pos: (2,0), label: $m$, stroke: 0.1em, radius: 1.5em, name: <m>),
    node(pos: (2,2), label: $k$, stroke: 0.1em, radius: 1.5em, name: <k>),
    node(pos: (4,0), label: $j$, stroke: 0.1em, radius: 1.5em, name: <j>),
    
    node(pos: (-3,-2.75), label: $t_0$, stroke: 0em, radius: 1.5em, name: <t0>),
    node(pos: (-1,-2.75), label: $dots$, stroke: 0em, radius: 1.5em, name: <tn-1>),
    node(pos: (2,-2.75), label: $t_(n - 1)$, stroke: 0em, radius: 1.5em, name: <tn-1>),
    node(pos: (4,-2.75), label: $t_n$, stroke: 0em, radius: 1.5em, name: <tn-1>),

    edge(<i>, <l>, "--|>", label: $r_(i l)(n - 1)$, bend: 0deg, label-size: 0.75em),
    edge(<i>, <m>, "--|>", label: $r_(i m)(n - 1)$, bend: 0deg, label-size: 0.75em),
    edge(<i>, <k>, "--|>", label: $r_(i k)(n - 1)$, bend: 0deg, label-size: 0.75em),
    
    edge(<l>, <j>, "-|>", label: $p_(l j)$, bend: 0deg, label-size: 0.75em),
    edge(<m>, <j>, "-|>", label: $p_(m j)$, bend: 0deg, label-size: 0.75em),
    edge(<k>, <j>, "-|>", label: $p_(k j)$, bend: 0deg, label-size: 0.75em),
    
  )
]

=== Key Recursion

The total probability of ending at with state $j$ is the sum of probabilities of the different paths to get to state $j$

$
r_(i j) = sum_(k = 1)^m r_(i k) (n - 1) p_(k j)
$

=== Random Initial State

$
P(X_n = j) = sum_(i = 1)^m P(X_0 = i) r_(i j) (n)
$

