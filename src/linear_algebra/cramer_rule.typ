#import "/lib/imports.typ": *

#set math.mat(delim: "[")
#set math.vec(delim: "[")

For a square system $A accent(x, arrow) = accent(b, arrow)$ where $A$ is $n times n$ and #link(<linear-algebra-matrix-inverse>)[invertible] (i.e., $det(A) eq.not 0$), each component of the solution is a ratio of #link(<linear-algebra-determinant>)[determinants]:

$
  x_i = det(A_i) / det(A)
$

where $A_i$ is the matrix $A$ with its $i$-th column replaced by $accent(b, arrow)$.

#example[
  Solve

  $
    2 x + y = 5 \
    x + 3 y = 10
  $

  Then $A = mat(2, 1; 1, 3)$, $accent(b, arrow) = vec(5, 10)$, and $det(A) = 6 - 1 = 5$.

  Replace column 1:
  $
    A_1 = mat(5, 1; 10, 3) #h(2em) det(A_1) = 15 - 10 = 5
  $

  Replace column 2:
  $
    A_2 = mat(2, 5; 1, 10) #h(2em) det(A_2) = 20 - 5 = 15
  $

  $
    x = 5/5 = 1, #h(2em) y = 15/5 = 3
  $
]

== Why it works (sketch)

Let $E_i$ be the identity with the $i$-th column replaced by $accent(x, arrow)$. Then $A E_i = A_i$ (column-by-column), so

$
  det(A_i) = det(A E_i) = det(A) det(E_i) = det(A) #h(0.2em) x_i
$

(since $E_i$ is upper triangular with $x_i$ on its $i$-th diagonal entry).

== Practical remarks

Cramer's rule is *theoretically beautiful* but *computationally awful* for $n > 3$:
- Computes $n + 1$ determinants of $n times n$ matrices
- Cost: $O(n!)$ via cofactor expansion, or $O(n^4)$ even with row reduction
- Standard methods (#link(<linear-algebra-gaussian-elimination>)[Gaussian elimination], #link(<linear-algebra-lu-decomposition>)[LU decomposition]) cost $O(n^3)$

Use Cramer's rule for:
- Symbolic solutions (small systems with parameters)
- Theoretical proofs
- Closed-form expressions in $2 times 2$ or $3 times 3$ cases

Don't use it for serious numerical work.

== When it fails

If $det(A) = 0$, the formula divides by zero — meaning $A$ is singular and the system either has no solution or infinitely many (depending on $accent(b, arrow)$). See #link(<linear-algebra-linear-system-solutions>)[Linear System Solutions].

== See also

- *#link(<linear-algebra-determinant>)[Determinant]*
- *#link(<linear-algebra-matrix-inverse>)[Matrix Inverse]* — Cramer's rule is essentially $A^(-1) accent(b, arrow)$ with the inverse expanded via cofactors
- *#link(<linear-algebra-adjugate>)[Adjugate]* — alternative inverse formula
- *#link(<linear-algebra-gaussian-elimination>)[Gaussian Elimination]* — the practical alternative
