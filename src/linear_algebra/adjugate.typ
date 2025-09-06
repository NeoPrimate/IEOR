#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition
#import "../utils/color_mat.typ": colorMat

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Adjugate

$
  "adj"(A)
$

1. Compute *Minor* $M_(i j)$

For each entry $A_(i j)$ of $A$, take the determinant of the submatrix that remains when row $i$ and column $j$ are removed

#align(center)[
  #grid(
    columns: (auto, auto, auto),
    inset: 1em,
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (0, 3)), red),
            (((0,0), (3, 0)), red),
          )
        )
        \
        det(
          mat(
            a_22, a_23;
            a_32, a_33;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((1,0), (1, 3)), red),
            (((0,0), (3, 0)), red),
          )
        )
        \
        det(
          mat(
            a_12, a_13;
            a_32, a_33;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((2,0), (2, 3)), red),
            (((0,0), (3, 0)), red),
          )
        )
        \
        det(
          mat(
            a_12, a_13;
            a_22, a_23;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (0, 3)), red),
            (((0,1), (3, 1)), red),
          )
        )
        \
        det(
          mat(
            a_21, a_23;
            a_31, a_33;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((1,0), (1, 3)), red),
            (((0,1), (3, 1)), red),
          )
        )
        \
        det(
          mat(
            a_11, a_13;
            a_31, a_33;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((2,0), (2, 3)), red),
            (((0,1), (3, 1)), red),
          )
        )
        \
        det(
          mat(
            a_11, a_13;
            a_21, a_23;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((0,0), (0, 3)), red),
            (((0,2), (3, 2)), red),
          )
        )
        \
        det(
          mat(
            a_21, a_22;
            a_31, a_32;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((1,0), (1, 3)), red),
            (((0,2), (3, 2)), red),
          )
        )
        \
        det(
          mat(
            a_11, a_12;
            a_31, a_32;
          )
        )
      $
    ],
    [
      $
        #colorMat(
          (
            ($a_11$, $a_12$, $a_13$),
            ($a_21$, $a_22$, $a_23$),
            ($a_31$, $a_32$, $a_33$),
          ),
          (
            (((2,0), (2, 3)), red),
            (((0,2), (3, 2)), red),
          )
        )
        \
        det(
          mat(
            a_11, a_12;
            a_21, a_22;
          )
        )
      $
    ],
  )
]

2. Compute *Cofactor* $C_(i j)$

Multiply the minor by a sign depending on position

$
  C_(i j) = (-1)^(i + j) M_(i j)
$

3. *Adjugate* (Adjoint)

Take the transpose:

$
  "adj"(A) = C^T
$



#eg[
  $
    A = mat(
      1, 2, 3;
      0, 4, 5;
      1, 0, 6;
    )
  $

  *Step 1.* Compute minors and cofactors

  - *Entry (1, 1)*: remove row 1 and column 1

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((0,0), (0, 3)), red),
        (((0,0), (2, 0)), red),
      )
    )
    \
    det(
      mat(
        4, 5;
        0, 6;
      )
    ) = 24
  $

  Cofactor: 

  $
    C_11 
    &= (-1)^(1 + 1) dot 24 \
    &= 1 dot 24 \
    &= 24 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, #hide[5], #hide[-4] ;
      #hide[-12], #hide[3], #hide[2] ;
      #hide[-2], #hide[-5], #hide[4] ;
    )
  $

  - *Entry (1, 2)*: remove row 1 and column 2

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((0,0), (0, 3)), red),
        (((0,1), (2, 1)), red),
      )
    )
    \
    det(
      mat(
        0, 5;
        1, 6;
      )
    ) = -5
  $

  Cofactor: 

  $
    C_12 
    &= (-1)^(1 + 2) dot -5 \
    &= -1 dot -5 \
    &= 5 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, #hide[-4] ;
      #hide[-12], #hide[3], #hide[2] ;
      #hide[-2], #hide[-5], #hide[4] ;
    )
  $
  
  - *Entry (1, 3)*: remove row 1 and column 3

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((0,0), (0, 3)), red),
        (((0,2), (2, 2)), red),
      )
    )
    \
    det(
      mat(
        0, 4;
        1, 0;
      )
    ) = -4
  $

  Cofactor: 

  $
    C_13 
    &= (-1)^(1 + 3) dot -4 \
    &= 1 dot -4 \
    &= -4 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      #hide[-12], #hide[3], #hide[2] ;
      #hide[-2], #hide[-5], #hide[4] ;
    )
  $
  
  - *Entry (2, 1)*: remove row 2 and column 1

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((1,0), (1, 3)), red),
        (((0,0), (2, 0)), red),
      )
    )
    \
    det(
      mat(
        2, 3;
        0, 6;
      )
    ) = 12
  $

  Cofactor: 

  $
    C_21 
    &= (-1)^(2 + 1) dot 12 \
    &= -1 dot 12 \
    &= -12 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      -12, #hide[3], #hide[2] ;
      #hide[-2], #hide[-5], #hide[4] ;
    )
  $
  
  - *Entry (2, 2)*: remove row 2 and column 2

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((1,0), (1, 3)), red),
        (((0,1), (2, 1)), red),
      )
    )
    \
    det(
      mat(
        1, 3;
        1, 6;
      )
    ) = 3
  $

  Cofactor: 

  $
    C_22 
    &= (-1)^(2 + 2) dot 3 \
    &= 1 dot 3 \
    &= 3 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      -12, 3, #hide[2] ;
      #hide[-2], #hide[-5], #hide[4] ;
    )
  $
  
  - *Entry (2, 3)*: remove row 2 and column 3

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((1,0), (1, 3)), red),
        (((0,2), (2, 2)), red),
      )
    )
    \
    det(
      mat(
        1, 2;
        1, 0;
      )
    ) = -2
  $

  Cofactor: 

  $
    C_22 
    &= (-1)^(2 + 3) dot -2 \
    &= -1 dot -2 \
    &= 2 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      -12, 3, 2 ;
      #hide[-2], #hide[-5], #hide[4] ;
    )
  $
  
  - *Entry (3, 1)*: remove row 3 and column 1

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((2,0), (2, 3)), red),
        (((0,0), (2, 0)), red),
      )
    )
    \
    det(
      mat(
        2, 3;
        4, 5;
      )
    ) = -2
  $

  Cofactor: 

  $
    C_31 
    &= (-1)^(3 + 1) dot -2 \
    &= 1 dot -2 \
    &= -2 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      -12, 3, 2 ;
      -2, #hide[-5], #hide[4] ;
    )
  $
  
  - *Entry (3, 2)*: remove row 3 and column 2

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((2,0), (2, 3)), red),
        (((0,1), (2, 1)), red),
      )
    )
    \
    det(
      mat(
        1, 3;
        0, 5;
      )
    ) = 5
  $

  Cofactor: 

  $
    C_32
    &= (-1)^(3 + 2) dot -5 \
    &= -1 dot 5 \
    &= -5 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      -12, 3, 2 ;
      -2, -5, #hide[4] ;
    )
  $
  
  - *Entry (3, 3)*: remove row 3 and column 3

  Minor:
  $
    #colorMat(
      (
        (1, 2, 3),
        (0, 4, 5),
        (1, 0, 6),
      ),
      (
        (((2,0), (2, 3)), red),
        (((0,2), (2, 2)), red),
      )
    )
    \
    det(
      mat(
        1, 2;
        0, 4;
      )
    ) = 4
  $

  Cofactor: 

  $
    C_33
    &= (-1)^(3 + 3) dot 4 \
    &= 1 dot 4 \
    &= 4 \
  $

  Cofactor matrix
  
  $
    C = mat(
      24, 5, -4 ;
      -12, 3, 2 ;
      -2, -5, 4 ;
    )
  $

  *Step 2.* Cofactor matrix

  $
    C = mat(
      24, 5, -4 ;
      -12, 3, 2 ;
      -2, -5, 4 ;
    )
  $

  *Step 3.* Transpose to get adjugate

  $
    "adj"(A) = C^T = mat(
      24, -12, -2;
      5, 3, -5;
      -4, 2, 4;
    )
  $
]

Relation to *inverse*:

$
  A^(-1) = 1 / det(A) "adj"(A) quad quad "if" det(A) eq.not 0
$

Relation to *identity*:

$
  A dot "adj"(A) = "adj"(A) dot A = det(A) I_n
$