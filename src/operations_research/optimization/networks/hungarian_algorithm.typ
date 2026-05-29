#import "/lib/imports.typ": *
#show: formatting

The classical $O(n^3)$ algorithm for the #link(<operations-research-optimization-assignment-problem>)[assignment problem]. Kuhn (1955), based on work by Hungarian mathematicians Egerváry & König.

== Algorithm (intuition)

Given an $n times n$ cost matrix $C$:

1. *Row reduction*: subtract each row's minimum from that row
2. *Column reduction*: subtract each column's minimum from that column
3. *Cover all zeros* using the minimum number of horizontal / vertical lines
4. *If lines = $n$*: an optimal assignment exists among the zeros — extract it
5. *If lines < $n$*: adjust the matrix (subtract the minimum uncovered value from uncovered entries, add it to entries at line intersections) and go back to step 3

Repeat until step 4 succeeds. Termination in $O(n^3)$.

== Why it works

Each step preserves the *relative cost structure*: subtracting a constant from a row doesn't change which assignment is optimal. The reductions create zeros — and an assignment using only zero-cost cells (when one exists) is necessarily optimal because all assignments have the same total constant subtracted.

The "cover" check finds when enough zeros exist to form a complete assignment. The adjustment step exposes more zeros without changing optimal-assignment structure.

== Worked example

$
  C = mat(delim: "[",
    9, 2, 7, 8;
    6, 4, 3, 7;
    5, 8, 1, 8;
    7, 6, 9, 4;
  )
$

After row reduction (subtract row mins $2, 3, 1, 4$):
$
  mat(delim: "[",
    7, 0, 5, 6;
    3, 1, 0, 4;
    4, 7, 0, 7;
    3, 2, 5, 0;
  )
$

After column reduction (subtract column mins $3, 0, 0, 0$):
$
  mat(delim: "[",
    4, 0, 5, 6;
    0, 1, 0, 4;
    1, 7, 0, 7;
    0, 2, 5, 0;
  )
$

Cover all zeros: rows 2, 4 and column 3 cover all zeros — 3 lines for an $n = 4$ matrix → need to adjust.

(Continue iterations…)

Final assignment: agent 1 → task 2, agent 2 → task 1, agent 3 → task 3, agent 4 → task 4. Total cost $= 2 + 6 + 1 + 4 = 13$.

== Why $O(n^3)$

Each "augmenting path" step (finding more zeros to expose) costs $O(n^2)$ via a labeling procedure. At most $n$ augmenting paths needed (each adds at least one matched pair). Total $O(n^3)$.

Modern variants:
- *Jonker–Volgenant* — $O(n^3)$ with smaller constants
- *Auction algorithm* (Bertsekas) — different paradigm, also $O(n^3)$ but parallelizable
- *Sparse Hungarian* — $O(m sqrt(n))$ for sparse graphs

== See also

- *#link(<operations-research-optimization-assignment-problem>)[Assignment Problem]* — the problem being solved
- *#link(<operations-research-optimization-transportation-problem>)[Transportation Problem]* — generalization
