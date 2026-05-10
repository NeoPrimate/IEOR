#import "/lib/imports.typ": *

#set math.mat(delim: "[")

When you reduce an #link(<linear-algebra-augmented-matrix>)[augmented matrix] $[A | accent(b, arrow)]$ to #link(<linear-algebra-row-echelon-form>)[REF], rows of all zeros (or zero coefficients with non-zero RHS) signal one of three structural situations.

== 1. Dependent equations

One equation is a linear combination of others — they carry the same information.

$
  2 x + 4 y = 8 \
  x + 2 y = 4
$

The second equation is half the first — same line. After row reduction:

$
  mat(
    augment: #2,
    1, 2, 4;
    0, 0, 0;
  )
$

The zero row means one equation was redundant. The system has *infinitely many solutions* (a whole line in $RR^2$).

== 2. Underdetermined systems

More variables than independent equations — fewer constraints than unknowns.

$
  x + y + z = 2 \
  2 x + 3 y + z = 5
$

Two equations in three unknowns. After row reduction:

$
  mat(
    augment: #3,
    1, 1, 1, 2;
    0, 1, -1, 1;
  )
$

Both equations are independent, but $z$ is a free variable. *Infinitely many solutions* (a line in $RR^3$).

== 3. Inconsistent systems

A zero coefficient row with a *non-zero* RHS — translates to $0 = c$ for $c eq.not 0$, which is impossible.

$
  x + y = 3 \
  2 x + 2 y = 7
$

(Same left-hand side scaled by $2$, but right-hand side doesn't scale to match.)

$
  mat(
    augment: #2,
    1, 1, 3;
    0, 0, 1;
  )
$

The second row reads $0 = 1$. *No solution*.

== See also

- *#link(<linear-algebra-row-echelon-form>)[Row Echelon Form]*
- *#link(<linear-algebra-linear-system-solutions>)[Linear System Solutions]* — Rouché–Capelli summary
- *#link(<linear-algebra-rank>)[Rank]* — diagnoses dependence
