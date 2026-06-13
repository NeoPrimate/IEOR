#import "/lib/imports.typ": *
#show: formatting

Used to model the number of events that occur within a fixed interval of time or space, given a constant mean rate and assuming that these events occur independently of each other

$
P(X = k) = (lambda^k e^(- lambda)) / k!
$

#align(center)[
  #let n = 13
  #let lambda = 3
  #let ks = range(n)
  #lq.diagram(
    width: 5cm,
    height: 5cm,
    xlim: (0, n),
    ylim: (0, 0.4),
    xaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    yaxis: (position: 0, tip: tiptoe.triangle, ticks: none),
    lq.stem(ks, ks.map(k => poisson.pmf(k, lambda)), mark: "o", color: gray),
  )
]
