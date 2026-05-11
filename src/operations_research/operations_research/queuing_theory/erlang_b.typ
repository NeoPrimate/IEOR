#import "/lib/imports.typ": *

The *Erlang B formula*: probability that all servers in an M/M/c/c queue (Poisson arrivals, exponential service, $c$ servers, $c$ capacity = no queue) are busy. Arriving customers facing all-busy are *blocked / lost*.

== Formula

$
  B(c, a) = (a^c / c!) / (sum_(k=0)^c a^k / k!)
$

where $a = lambda / mu$ is the *offered load* (in Erlangs).

$B(c, a)$ is the *blocking probability* — proportion of arrivals turned away.

== Telephony origin

Developed by A. K. Erlang for telephone networks (1917). $c$ servers = trunk lines; blocked calls are dropped (no queue — caller hears busy signal).

Used for over a century to *size phone networks*: how many trunk lines do I need to keep blocking probability below some threshold (typically 1% or 0.1%)?

== Worked example

$lambda = 50$ calls/hour, average call lasts $3$ minutes = $0.05$ hr. So $a = 50 dot 0.05 = 2.5$ Erlangs.

How many trunks to keep blocking below 1%?

#table(
  columns: 2,
  align: (center, center),
  stroke: none,
  table.header([$c$], [$B(c, a) approx$]),
  [3], $35%$,
  [5], $9%$,
  [7], $1.3%$,
  [8], $0.4%$,
)

Need $c = 8$ trunks for $<1%$ blocking with offered load 2.5 Erlangs.

== Recursive formula (numerically stable)

$
  B(c, a) = (a B(c-1, a)) / (c + a B(c-1, a)), #h(1em) B(0, a) = 1
$

This recursion avoids the factorials that overflow in direct computation. Standard implementation.

== Erlang B vs Erlang C

#table(
  columns: 3,
  align: (left, center, center),
  stroke: none,
  table.header([Model], [System], [Blocked customer]),
  [Erlang B (M/M/c/c)], [c servers, no queue], [lost (dropped)],
  [Erlang C (M/M/c)], [c servers, infinite queue], [waits],
)

Erlang B is the *blocking probability* (proportion lost).
Erlang C is the *waiting probability* (proportion who must wait > 0).

For the same parameters, Erlang B < Erlang C.

== Where it shows up

- *Telephone trunk sizing* (historical, but still relevant for VoIP gateways)
- *Connection limits* on servers (max concurrent connections)
- *Hospital bed capacity* (refused-admission probability)
- *Parking lot sizing* (turn-away rate)
- *Toll booth design*

== Insensitivity to service distribution

Surprisingly: Erlang B is *insensitive* to the service-time distribution — only the *mean* matters. So even if call durations are highly variable, Erlang B's blocking probability formula stays exact. Holds because of *PASTA* (Poisson Arrivals See Time Averages) + reversibility.

== See also

- *#link(<operations-research-queuing-theory-erlang-c>)[Erlang C]* — with queue
- *#link(<operations-research-queuing-theory-m-m-1>)[M/M/1]* — single-server with queue
- *#link(<operations-research-queuing-theory-m-m-c>)[M/M/c]* — multi-server with queue
- *#link(<operations-research-queuing-theory-mmc-abandonment>)[Erlang A]* — with abandonment
