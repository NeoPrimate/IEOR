#import "/lib/imports.typ": *
#show: formatting



A *quadratic form* is a polynomial expression in $n$ variables where every term has total degree exactly $2$:

$
  Q(accent(x, arrow)) = sum_(i, j) a_(i j) x_i x_j
$

It can always be written compactly using a #link(<linear-algebra-symmetric-matrix>)[symmetric matrix] $A$:

$
  Q(accent(x, arrow)) = accent(x, arrow)^T A accent(x, arrow)
$

The matrix $A$ is assumed symmetric without loss of generality — if $B$ isn't symmetric, replacing it with $(B + B^T)/2$ gives the same quadratic form.

#example[
  $
    Q(x, y) = 3 x^2 + 5 x y + 2 y^2
  $

  As a matrix product (split the $5 x y$ symmetrically as $5/2 x y + 5/2 y x$):

  $
    A = mat(3, 5/2; 5/2, 2), #h(1em) Q(accent(x, arrow)) = accent(x, arrow)^T A accent(x, arrow)
  $
]

== Definiteness

Quadratic forms are classified by the sign of $Q(accent(x, arrow))$ over all non-zero $accent(x, arrow)$:

#table(
  columns: 3,
  align: (left, left, left),
  stroke: none,
  table.header([*Type*], [*Sign of $Q$*], [*All eigenvalues of $A$*]),
  [Positive definite], $> 0 #h(0.5em) "always"$, [$> 0$],
  [Positive semi-definite], $>= 0 #h(0.5em) "always"$, [$>= 0$],
  [Negative definite], $< 0 #h(0.5em) "always"$, [$< 0$],
  [Negative semi-definite], $<= 0 #h(0.5em) "always"$, [$<= 0$],
  [Indefinite], [takes both signs], [mixed],
)

The eigenvalue characterization comes from the #link(<linear-algebra-spectral-theorem>)[Spectral Theorem]: diagonalizing $A = Q D Q^T$ and changing variables $accent(y, arrow) = Q^T accent(x, arrow)$ gives

$
  Q(accent(x, arrow)) = sum_(i=1)^n lambda_i y_i^2
$

— a sum of squares weighted by eigenvalues. The signs of the eigenvalues determine the signs of $Q$.

== Tests for positive definiteness

For a symmetric $A$, equivalent conditions:

1. All eigenvalues $> 0$
2. All #link(<linear-algebra-leading-principal-minor>)[leading principal minors] $> 0$ (*Sylvester's criterion*)
3. $A = L L^T$ admits a #link(<linear-algebra-cholesky-decomposition>)[Cholesky decomposition]
4. $accent(x, arrow)^T A accent(x, arrow) > 0$ for all $accent(x, arrow) eq.not bold(0)$

== Geometric pictures (2D)

For $Q(x, y) = accent(x, arrow)^T A accent(x, arrow)$, the level sets $Q(accent(x, arrow)) = c$ are conic sections aligned with the eigenvectors of $A$:

- *Positive definite*: ellipse — closed, bounded, axes are eigenvectors with lengths $1/sqrt(lambda_i)$
- *Negative definite*: ellipse (with negative $c$)
- *Indefinite*: hyperbola — open curves with asymptotes
- *Positive semi-definite (rank 1)*: parallel lines

== Where they show up

- *#link(<calculus-calculus-ii-semi-definiteness>)[Semi-definiteness] / Hessian*: the second-order Taylor approximation of a function near a critical point is a quadratic form. Definiteness classifies the critical point as min / max / saddle.
- *#link(<linear-algebra-norm>)[Norms]*: $||accent(x, arrow)||_2^2 = accent(x, arrow)^T accent(x, arrow) = accent(x, arrow)^T I accent(x, arrow)$ — a quadratic form with $A = I$
- *Mahalanobis distance*: $(accent(x, arrow) - accent(mu, arrow))^T Sigma^(-1) (accent(x, arrow) - accent(mu, arrow))$ — a quadratic form using the inverse covariance
- *Multivariate Gaussian density*: $exp(-1/2 #h(0.2em) accent(x, arrow)^T Sigma^(-1) accent(x, arrow))$
- *Quadratic programming*: optimize $1/2 accent(x, arrow)^T Q accent(x, arrow) + c^T accent(x, arrow)$ subject to linear constraints
- *Kinetic energy / potential energy* in mechanics
- *Variance* of a linear combination: $"Var"(a^T X) = a^T "Cov"(X) a$

== Diagonalization (principal axis theorem)

Every quadratic form can be brought to *diagonal form* by an orthogonal change of variables — equivalently, by rotating the coordinate axes to align with the eigenvectors of $A$:

$
  accent(y, arrow) = Q^T accent(x, arrow) #h(2em) arrow.r.double #h(2em) Q(accent(x, arrow)) = lambda_1 y_1^2 + lambda_2 y_2^2 + dots + lambda_n y_n^2
$

This is the "principal axes" of the conic / quadric.

== See also

- *#link(<linear-algebra-symmetric-matrix>)[Symmetric Matrix]*
- *#link(<linear-algebra-spectral-theorem>)[Spectral Theorem]*
- *#link(<linear-algebra-leading-principal-minor>)[Leading Principal Minor]* — Sylvester's criterion
- *#link(<linear-algebra-cholesky-decomposition>)[Cholesky Decomposition]*
- *#link(<calculus-calculus-ii-semi-definiteness>)[Semi-Definiteness]* in Calculus II
