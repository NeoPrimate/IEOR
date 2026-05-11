#import "/lib/imports.typ": *



A linear system $A accent(x, arrow) = accent(b, arrow)$ has *exactly* one of three outcomes:

1. *Unique solution* — exactly one $accent(x, arrow)$ satisfies the system
2. *No solution* — the system is *inconsistent*
3. *Infinitely many solutions* — the system is *underdetermined*

The #link(<linear-algebra-row-echelon-form>)[REF] (or #link(<linear-algebra-rref>)[RREF]) of the #link(<linear-algebra-augmented-matrix>)[augmented matrix] $[A | accent(b, arrow)]$ tells you which case you're in.

== 1. Unique solution

Every column of $A$ has a pivot, no free variables, and no inconsistency:

$
  mat(
    augment: #4,
    1, a_(1 2), a_(1 3), a_(1 4), b_1;
    0, 1, a_(2 3), a_(2 4), b_2;
    0, 0, 1, a_(3 4), b_3;
    0, 0, 0, 1, b_4;
  )
$

Equivalently: $"rank"(A) = "rank"([A | accent(b, arrow)]) = n$ (the number of unknowns).

== 2. No solution (inconsistent)

A row of the form $[0, 0, dots, 0 #h(0.5em) | #h(0.5em) c]$ with $c eq.not 0$ — translates to "$0 = c$" which is impossible.

$
  mat(
    augment: #2,
    1, 1, 3;
    0, 0, 1;
  )
$

The second row says $0 x + 0 y = 1$. No $accent(x, arrow)$ satisfies this.

Equivalently: $"rank"(A) < "rank"([A | accent(b, arrow)])$.

== 3. Infinitely many solutions (free variables)

Some columns of $A$ have no pivot — those correspond to *free variables* you can set arbitrarily; the *pivot variables* are determined by them.

$
  mat(
    augment: #4,
    1, a_(1 2), 0, a_(1 4), b_1;
    0, 0, 1, a_(2 4), b_2;
    0, 0, 0, 0, 0;
    0, 0, 0, 0, 0;
  )
$

Columns 2 and 4 have no pivot → $x_2, x_4$ are free.

Equivalently: $"rank"(A) = "rank"([A | accent(b, arrow)]) < n$. The solution set is an *affine subspace* of dimension $n - "rank"(A)$ — see #link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity].

== Rouché–Capelli summary

#table(
  columns: 3,
  align: (left, center, left),
  stroke: none,
  table.header([*Case*], [*Rank condition*], [*Solution set*]),
  [Unique], [$"rank"(A) = "rank"([A | b]) = n$], [single point],
  [None], [$"rank"(A) < "rank"([A | b])$], [empty],
  [Infinite], [$"rank"(A) = "rank"([A | b]) < n$], [affine subspace of dim $n - "rank"(A)$],
)

== See also

- *#link(<linear-algebra-row-echelon-form>)[Row Echelon Form]* — the algorithm
- *#link(<linear-algebra-linear-system-special-cases>)[Linear System Special Cases]* — when zero rows appear
- *#link(<linear-algebra-rank>)[Rank]* and *#link(<linear-algebra-rank-nullity-theorem>)[Rank–Nullity]*
- *#link(<linear-algebra-homogeneous-system>)[Homogeneous System]* — special case $accent(b, arrow) = bold(0)$
