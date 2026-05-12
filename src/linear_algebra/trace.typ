#import "/lib/imports.typ": *
#show: formatting


The *trace* of a square matrix $A$ is the sum of its main diagonal entries:

$
  "tr"(A) = sum_(i=1)^n a_(i i)
$

#example[
  $
    A = mat(2, 7, 1; 0, -3, 5; 4, 6, 8) #h(2em) "tr"(A) = 2 + (-3) + 8 = 7
  $
]

== Properties

- *Linearity*: $"tr"(A + B) = "tr"(A) + "tr"(B)$ and $"tr"(c #h(0.2em) A) = c #h(0.2em) "tr"(A)$
- *#link(<linear-algebra-transpose>)[Transpose]*: $"tr"(A^T) = "tr"(A)$
- *Cyclic property*: $"tr"(A B) = "tr"(B A)$
  - More generally: $"tr"(A B C) = "tr"(B C A) = "tr"(C A B)$
- *Similarity invariance*: $"tr"(P^(-1) A P) = "tr"(A)$
  - The trace doesn't change under #link(<linear-algebra-change-of-basis>)[change of basis]
- *Sum of eigenvalues*: $"tr"(A) = sum_(i=1)^n lambda_i$ (counted with multiplicity, including complex)
- *#link(<linear-algebra-identity-matrix>)[Identity]*: $"tr"(I_n) = n$

== Trace as inner product

For matrices, the *Frobenius inner product* is defined via the trace:

$
  ⟨ A, B ⟩_F = "tr"(A^T B) = sum_(i, j) A_(i j) B_(i j)
$

It induces the *Frobenius norm* $||A||_F = sqrt("tr"(A^T A))$.

== Where it shows up

- *Sum of eigenvalues* — quick check via $"tr"(A)$
- *Variance / covariance*: $"tr"("Cov")$ = total variance across all dimensions
- *Loss functions* in machine learning — $||y - X beta||^2 = "tr"((y - X beta)(y - X beta)^T)$
- *Quantum mechanics* — expectation values: $⟨ hat(O) ⟩ = "tr"(rho hat(O))$
- *#link(<linear-algebra-eigenvectors-eigenvalues>)[Characteristic polynomial]*: trace appears as a coefficient
