#import "/lib/imports.typ": *
#show: formatting

For $n$ events:

$
  P(inter.big_(i=1)^n A_i) = product_(i=1)^n P(A_i | inter.big_(j=1)^(i-1) A_j)
$

2 events:

$
  P(A_1 inter A_2)
  = P(A_1) P(A_2 | A_1)
$

3 events:

$
  P(A_1 inter A_2 inter A_3)
  = P(A_1) P(A_2 | A_1) P(A_3 | A_1 inter A_2)
$

4 events:

$
  P(A_1 inter A_2 inter A_3 inter A_4)
  = P(A_1) P(A_2 | A_1) P(A_3 | A_1 inter A_2) P(A_4 | A_1 inter A_2 inter A_3)

$
