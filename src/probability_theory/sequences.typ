== Sequences

$
  a_1, a_2, a_3, dots
$

$
  S = {a_i} quad i in NN = {1, 2, 3, dots}
$

Formal definition:

$
  f: NN arrow S
$

$
  f(i) = a_i
$

Convergence

$
  lim_(i arrow infinity) a_i = a
$

$
  forall epsilon gt 0 exists N in NN quad forall n gt.eq N: abs(a_n - a) lt epsilon
$

For every $epsilon > 0$, there exists $N in NN$ such that for all $n gt.eq N$, $abs(a_n - a) lt epsilon$

Combination of Sequences

#align(center)[
  #grid(
    columns: 3,
    align: center + horizon,
    inset: (x: 1em),
    [
      #set math.cases(reverse: true)
      $
        cases(
          a_i arrow a, 
          b_i arrow b,
        ) 
      $
    ],
    [
      $
        arrow.double
      $
    ],
    [
      $
        a_i + b_i &arrow a + b \
        a_i b_i &arrow a b
      $
      
    ]
  )
]

$
  g: "continuous" 
  quad arrow.double quad
  g(a_i) arrow g(a)
$
  
When does a sequence converge?

1. Increasing sequnce

$
  a_i lt.eq a_(i + 1) quad forall i
$

Then eiher:
- Sequence vonverges to $infinity$
- Sequence converges to some real number $a$

2. 

If

$abs(a_i - a) lt.eq b_i quad forall i$

and

$b_i arrow 0$

then 

$a_i arrow a$