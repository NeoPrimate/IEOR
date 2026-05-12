#import "/lib/imports.typ": *
#show: formatting

The classical Toyota Production System formula for sizing kanban (replenishment-authorization cards) between two production stages:

$
  K = ceil((D dot (T_p + T_w) dot (1 + alpha)) / C)
$

where:

- $K$: number of kanban cards needed
- $D$: demand rate (units per period)
- $T_p$: processing lead time (production time for one container)
- $T_w$: waiting lead time (queue, transport)
- $alpha$: safety factor (typically 0.05–0.30)
- $C$: container size (units per card)

== Logic

Each kanban authorizes one container of parts. Total inventory in the loop = $K dot C$ units.

Required inventory must cover:
- Demand during the (processing + waiting) lead time: $D (T_p + T_w)$
- Plus safety: $(1 + alpha)$ multiplier

Round up so $K$ is an integer.

== Example

Assembly line uses gear-boxes at $D = 100$/hour. Supplier has $T_p = 0.5$ hr processing, $T_w = 1$ hr waiting. Container holds $C = 10$ gear-boxes. Safety factor $alpha = 0.2$.

$
  K = ceil((100 dot 1.5 dot 1.2) / 10) = ceil(18) = 18 #h(0.5em) "cards"
$

Total inventory loop: $18 dot 10 = 180$ gear-boxes.

== Two-card kanban (Toyota)

Toyota's classic system uses *two* card types:
- *Production kanban* (P-kanban): authorizes the producer to make a container
- *Withdrawal kanban* (W-kanban): authorizes downstream to pull from producer's output buffer

P-kanban + W-kanban coordinate the pull. Modern simplified versions use just one card type.

== Compared to CONWIP

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([], [*Kanban*], [*#link(<supply-chain-manufacturing-conwip>)[CONWIP]*]),
  [Granularity], [Per-part-type, per-stage], [Global cap on all WIP],
  [Setup], [More cards to manage], [Simpler],
  [Mix flexibility], [Lower (each card is specific)], [Higher (any part can fill cap)],
  [Best for], [Repetitive, stable mix], [Variable mix, fewer-part-types],
)

== When kanban sizing breaks down

The formula assumes:
- *Stationary demand* — varying demand requires resizing $K$ periodically
- *Reliable supplier* — if upstream stations break down, fixed $K$ won't compensate
- *Small mix* — separate kanbans per part-type only practical for moderate part counts
- *Short lead times* — long lead times require many cards, defeating leanness

In practice, $K$ is recalibrated regularly (monthly / quarterly) based on observed performance.

== Lean reduction strategies

The formula highlights levers:
- *Reduce $T_p + T_w$* (faster production, less queueing) → fewer cards needed
- *Smaller $C$* → more cards needed but smaller batches, more flexibility
- *Lower $alpha$* (reduce variability, more reliability) → fewer cards needed

Each improvement reduces inventory while maintaining service.

== See also

- *#link(<supply-chain-manufacturing-conwip>)[CONWIP]* — alternative discipline
- *#link(<supply-chain-manufacturing-takt-time>)[Takt Time]*
- *#link(<supply-chain-manufacturing-heijunka>)[Heijunka]*
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
