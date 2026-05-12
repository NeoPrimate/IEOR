#import "/lib/imports.typ": *
#show: formatting



Set of vector

$
  v_1, v_2, dots, v_n in RR^n
$

Where
- $v_1, v_2, dots, v_n$: set of vectors
- $RR^n$: set of all ordered tuples of $n$ real numbers

Linear combination of those vector

$
  #text(red)[$c_1$] v_1 + #text(red)[$c_2$] v_2 + ... + #text(red)[$c_n$] v_n
$

$
  c_1, c_2, dots, c_n in RR
$

Where:
- $c_1, c_2, ..., c_n$: constants or weights

#example[

  $
    accent(a, arrow) = vec(1, 2)
    quad quad quad quad
    accent(b, arrow) = vec(0, 3)
  $

  $
    #text(red)[$0$] accent(a, arrow) + #text(red)[$0$] accent(b, arrow)
  $

  $
    #text(red)[$3$] accent(a, arrow) + #text(red)[$2$] accent(b, arrow)
  $

]
