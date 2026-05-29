#import "/lib/imports.typ": *
#show: formatting

== MILP Modeling Idioms

Phrasebook of LP/MILP modeling idioms — small algebraic constructs that encode logic, products, piecewise terms, and other structure as linear constraints.

#set text(size: 9pt)
#show table.cell.where(y: 0): strong

#table(
  columns: (auto, 1fr),
  align: (left, left),
  stroke: 0.5pt + gray,
  inset: 5pt,
  table.cell(colspan: 2, fill: luma(230))[*Network / flow*],
  $sum_j x_(i j) - sum_j x_(j i) = b_i$, [conservation: $b_i$ source/sink/0],
  $x_(i j) - x_(j i)$, [net arc flow (single signed var)],
  $0 <= x_(i j) <= u_(i j)$, [arc capacity],
  $sum_(i in S, j in.not S) x_(i j)$, [flow across a cut],
  table.cell(colspan: 2, fill: luma(230))[*Conditional (Big-M)*],
  $a^T x <= b + M(1 - y)$, [active only if $y = 1$],
  [
    $
    a^T x <= b_1 + M y \
    a^T x <= b_2 + M(1 - y)
    $
  ], [either/or],
  [tight $M$], [loose $M$ ruins relaxation],
  table.cell(colspan: 2, fill: luma(230))[*Binary ↔ continuous*],
  $x <= M y$, [fixed-charge on/off],
  $l y <= x <= u y$, [semi-continuous: 0 or $[l, u]$],
  $x >= epsilon y$, [force strictly positive],
  table.cell(colspan: 2, fill: luma(230))[*Binary logic*],
  $sum y_i <= 1$, [at most one],
  $sum y_i = 1$, [exactly one (SOS1)],
  $sum y_i >= 1$, [OR],
  [
    $
    sum y_i <= k \
    sum y_i >= k
    $
  ], [cardinality],
  $y_a <= y_b$, [implication $a => b$],
  table.cell(colspan: 2, fill: luma(230))[*Products*],
  [
    $
    z <= y_1 \
    z <= y_2 \
    z >= y_1 + y_2 - 1
    $
  ], [bin × bin],
  [
    $
    z <= u y \
    z <= x \
    z >= x - u(1 - y) \
    z >= 0
    $
  ], [bin × cont, $x in [0,u]$],
  [McCormick envelope], [cont × cont relaxation],
  table.cell(colspan: 2, fill: luma(230))[*Abs / norms*],
  [
    $
    x = x^+ - x^- \
    x^+, x^- >= 0
    $
  ], [$|x| = x^+ + x^-$ (L1)],
  [
    $
    t >= x \
    t >= -x
    $
  ], [$|x|$, epigraph],
  table.cell(colspan: 2, fill: luma(230))[*Min / max*],
  $t >= f_i (x) forall i$, [min $t$ ⇒ minimax],
  $t <= f_i (x) forall i$, [max $t$ ⇒ maximin],
  table.cell(colspan: 2, fill: luma(230))[*Piecewise-linear*],
  [λ-method + SOS2], [convex combo of breakpoints],
  [δ-method], [incremental encoding],
  table.cell(colspan: 2, fill: luma(230))[*Sequencing*],
  $u_i - u_j + n x_(i j) <= n - 1$, [MTZ subtour elim.],
  $s_j >= s_i + d_i$, [precedence],
  table.cell(colspan: 2, fill: luma(230))[*Covering family*],
  $sum a_(i j) x_j >= 1$, [set covering],
  $sum a_(i j) x_j <= 1$, [set packing],
  $sum a_(i j) x_j = 1$, [partitioning],
  $sum w_i x_i <= W$, [knapsack],
  table.cell(colspan: 2, fill: luma(230))[*Slack / deviation*],
  [
    $
    a^T x + s = b \
    s >= 0
    $
  ], [slack (≤ → =); surplus $-s$],
  $f(x) + d^- - d^+ = "tgt"$, [goal prog. / soft],
  table.cell(colspan: 2, fill: luma(230))[*Temporal*],
  $I_t = I_(t-1) + p_t - d_t$, [inventory balance],
  table.cell(colspan: 2, fill: luma(230))[*Transforms*],
  $sum x = 1, x >= 0$, [unit simplex],
  [Charnes–Cooper], [linear-fractional → LP],
  $y_i >= y_(i+1)$, [symmetry breaking],
)
