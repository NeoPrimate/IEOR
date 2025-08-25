#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath

#set math.vec(delim: "[")
#set math.mat(delim: "[")

#set math.mat(gap: 1em)

== Matrix Inverse

$
  A dot A^(-1) = A^(-1) dot A = I
$

Where $I$ is the identity matrix (like the number $1$ in regular multiplication)

- For scalars: $2 times 1/2 = 1$
- For matrices: $A times A-1 = I$

A matrix $A$ is invertible (nonsingluar) if:
- It is square ($n times n$)
- $det(A) eq.not 0$

=== Calculating inverse

Row Reduction (Gauss-Jordan Elimination)

Augment $A$ with the identity matrix $I$, and perform row operations until the left side becomes $I$. The right side will then be $A^(-1)$

$
  mat(
    augment: #1,
    A, I
  ) 
  quad quad 
  arrow.long 
  quad quad 
  mat(
    augment: #1,
    I, A^(-1)
  )
$

#eg[
  $
    A = mat(
      2, 1;
      5, 3
    )
  $

  Step 1. Set up augmented matrix 
  
  $
    [A | I] = mat(
      augment: #2,
      2, 1, 1, 0;
      5, 3, 0, 1
    )
  $

  Step 2. Make the pivot of the first column equal to 1 
  
  $
    (R_1 arrow 1/2 R_1)
  $

  $
    mat(
      augment: #2,
      1, 0.5, 0.5, 0;
      5, 3, 0, 1
    )
  $

  Step 3: Eliminate the first column in row 2

  $
    R_2 arrow R_2 - 5 R_1
  $

  $
    mat(
      augment: #2,
      1, 0.5, 0.5, 0;
      0, 0.5, -2.5, 1
    )
  $

  Step 4: Make the pivot in row 2 a 1

  $
    R_2 arrow 2 R_2
  $

  $
    mat(
      augment: #2,
      1, 0.5, 0.5, 0;
      0, 1, -5, 2
    )
  $

  Step 5: Eliminate the 0.5 above the pivot

  $
    R_1 arrow R_1 - 0.5 R_2
  $

  $
    mat(
      augment: #2,
      1, 0, 3, -1;
      0, 1, -5, 2
    )
  $

  So the inverse is:

  $
    A^(-1) = mat(
      3, -1;
      -5, 2
    )
  $

]