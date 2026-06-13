#import "/lib/imports.typ": *
#show: formatting

== PCA as application


*Covariance Matrix*

Principle components are always perpendicular 

Let $X_j$ denote the $j$-th feature, and $X_1, X_2, dots, X_d$ are your $d$ features:

$
  C = mat(
    "var"(X_1), "cov"(X_1, X_2), dots, "cov"(X_1, X_d);
    "cov"(X_2, X_1), "var"(X_2), dots, "cov"(X_2, X_d);
    dots.v, dots.v, dots.down, dots.v;
    "cov"(X_d, X_1), "cov"(X_d, X_2), dots, "var"(X_d);
  )
$


#example[
  $
    X = {(0, 2), (2, 0), (4, 3), (6, 4), (8, 6)}
  $

  *Step 1* Center

  $
    overline(x) = (0 + 2 + 4 + 6 + 8) / 5 = 5 quad quad quad overline(y) = (2 + 0 + 3 + 4 + 6) / 5 = 3
  $

  Subtract (5, 4) from each point

  $
    obar(X) = {(−4,−1),(−2,−3),(0,0),(2,1),(4,3)} 
  $

  *Step 2* Covariance matrix

  $
    "var"(x) = (16 + 4 + 0 + 4 + 16) / 4 \
    "var"(y) = (1 + 9 + 0 + 1 + 9) / 4 \
    "cov"(x, y) = ((-4)(-1) + (-2)(-3) + 0 + (2)(1) + (4)(3)) / 4 = 6 \
  $

  $
    C = mat(
      10, 6;
      6, 5;
    )
  $

  - top-left = 10 → how much &x& spreads on its own
  - bottom-right = 5 → how much $y$ spreads on its own ($x$ spreads twice as much)
  - off-diagonal = 6 → how $x$ and $y$ move together (positive, so they rise together)

  *Step 3 — Eigenvalues and eigenvectors*

  Each principal component is an eigenvector $v$ of $C$: a direction that $C$ only
  stretches, never rotates.
  $ C v = lambda v quad arrow.double quad (C - lambda I) v = 0 $

  *Eigenvalues* — force a non-trivial solution with $det(C - lambda I) = 0$:
  $
    det(C - lambda I) &= (10 - lambda)(5 - lambda) - 36 \
                      &= lambda^2 - 15 lambda + 14 \
                      &= (lambda - 14)(lambda - 1) = 0
  $
  $ arrow.double quad lambda_1 = 14 quad "or" quad lambda_2 = 1 $

  *Eigenvectors* — substitute each $lambda$ back into $(C - lambda I) v = 0$.

  For $lambda_1 = 14$, with $C - 14 I = mat(-4, 6; 6, -9)$:
  $ -4 v_1 + 6 v_2 = 0 quad arrow.double quad 2 v_1 = 3 v_2 quad arrow.double quad v prop vec(3, 2) $

  For $lambda_2 = 1$, with $C - 1 I = mat(9, 6; 6, 4)$:
  $ 9 v_1 + 6 v_2 = 0 quad arrow.double quad 3 v_1 = -2 v_2 quad arrow.double quad v prop vec(2, -3) $

  Normalise to unit length:
  $ "PC"_1 = 1/sqrt(13) vec(3, 2) quad "PC"_2 = 1/sqrt(13) vec(2, -3) $
  
  #let x = (0, 2, 4, 6, 8)
  #let y = (2, 0, 3, 4, 6)

  #let mean = (4, 3)              // centroid: the means you subtract to center
  #let s = 1 / calc.sqrt(13)
  #let u1 = (3 * s, 2 * s)        // PC1 direction (unit)
  #let u2 = (2 * s, -3 * s)       // PC2 direction (unit)

  #let len1 = calc.sqrt(14) * 2   // length ∝ sqrt(eigenvalue) = std dev
  #let len2 = calc.sqrt(1) * 2

  #let axis(c, u, L) = (
    (c.at(0) - u.at(0) * L, c.at(1) - u.at(1) * L),
    (c.at(0) + u.at(0) * L, c.at(1) + u.at(1) * L),
  )
  #let (a1, b1) = axis(mean, u1, len1)
  #let (a2, b2) = axis(mean, u2, len2)

  #lq.diagram(
    width: 7cm, height: 7cm,         // equal size  +
    xlim: (-3, 11), ylim: (-4, 10),  // equal spans  => true right angles
    lq.scatter(x, y, color: blue),
    lq.line(a1, b1, stroke: (paint: red, thickness: 1.5pt),
            tip: tiptoe.stealth, toe: tiptoe.stealth),
    lq.line(a2, b2, stroke: (paint: purple, thickness: 1.5pt),
            tip: tiptoe.stealth, toe: tiptoe.stealth),
  )
]


