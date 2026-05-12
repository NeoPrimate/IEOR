#import "/lib/imports.typ": *
#show: formatting

$
  W_0 = r_b T_0
$

The amount of work-in-process inventory at which a deterministic line just barely achieves its bottleneck throughput.

== Why it's "critical"

- *Below* $W_0$: line is *starved* — bottleneck idle some of the time, throughput limited by WIP rather than capacity
- *At* $W_0$: bottleneck just fully utilized, cycle time = $T_0$
- *Above* $W_0$: bottleneck still at max throughput, but cycle time grows (excess WIP just sits in queues)

For *deterministic* lines, $W_0$ is the *minimum WIP* that achieves maximum throughput. Beyond $W_0$, you're tying up capital without throughput gain.

== Real lines need more WIP

Variability makes the curves wider — to achieve close-to-$r_b$ throughput on a *real* (variable) line, you need WIP somewhat above $W_0$. How much above depends on variability — see #link(<supply-chain-manufacturing-best-worst-pwc>)[best/worst/PWC] curves.

PWC throughput at $w$ WIP:

$
  text("TH"_("PWC")) = (w / (W_0 + w - 1)) r_b
$

For $w = 2 W_0$: TH = $(2 W_0 / (2 W_0 + W_0 - 1)) r_b approx (2/3) r_b$. So real lines need $w >> W_0$ to approach $r_b$.

== Usage

- *CONWIP control*: set WIP cap at $w^* > W_0$, chosen to hit target throughput
- *Lean assessment*: cycle time / $T_0$ ratio tells you how variability-burdened your line is
- *Capacity planning*: increasing $r_b$ (de-bottlenecking) lowers $W_0$ → less WIP needed

== Worked example

Line: bottleneck produces 100 units/hour ($r_b = 100$), raw processing time $T_0 = 3$ hours.

$
  W_0 = 100 dot 3 = 300 #h(0.5em) "units"
$

Need at least 300 units of WIP in the line to keep the bottleneck fed.

For a real (variable) line, set CONWIP cap at $w^* = 400-500$ units to hit close to $r_b$.

== See also

- *#link(<supply-chain-manufacturing-best-worst-pwc>)[Best/Worst/PWC]*
- *#link(<supply-chain-manufacturing-conwip>)[CONWIP]*
- *#link(<supply-chain-manufacturing-factory-physics>)[Factory Physics]*
- *#link(<operations-research-queuing-theory-littles-law>)[Little's Law]*
