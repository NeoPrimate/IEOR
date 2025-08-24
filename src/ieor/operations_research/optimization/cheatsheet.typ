#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

#set page(margin: (
  right: 0.5cm,
  left: 0.5cm,
  top: 0.5cm,
  bottom: 0.5cm,
))

= Linear Programming

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Function\ Type*], [*Method*], [*Example*],
  ),

  [Maximization to\ Minimization], [$
    &max& &f(x)& arrow.l.r.double.long\ 
    &min& -&f(x)&       
  $], [$
    &max &3x + &2y arrow.l.r.double.long\ 
    &min -&3x - &2y
  $],
  
  [$gt.eq$ Constraint\ to $lt.eq$], [$
    &g_i (x) &gt.eq& &b_i& arrow.l.r.double.long\ 
    - &g_i (x) &lt.eq& -&b_i&
  $], [$
    &x + &y &gt.eq& &5& arrow.l.r.double.long\ 
    -&x - &y &lt.eq& -&5&
  $],

  [Equality Constraint], [$
    g_i (x) &= b_i arrow.l.r.double.long\ 
    g_i (x) &gt.eq b_i and\ 
    g_i (x) &lt.eq b_i
  $], [$
    x + y &= 4 arrow.l.r.double.long\ 
    x + y &gt.eq 4 and\
    x + y &lt.eq 4
  $],

  [Slack Variable], [$

  $], [
    $
      x + y lt.eq 6
    $
    Add slack variable $s gt.eq 0$:
    $
      x + y + s = 6
    $
    $s$ is how much less is being used than the maximum limit of 6
  ],
  
  [Surplus Variable], [$

  $], [
    $
      x + y gt.eq 6
    $
    Add slack variable $s gt.eq 0$:
    $
      x + y - s = 6
    $
    $s$ is the amount above the minimum required level 6
  ],

)

= Integer Programming

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Function\ Type*], [*Method*], [*Example*],
  ),
  [At *least* $k$ of the items in $S$], [$
    sum_(i in S) x_i gt.eq k
  $], [
    Produce at least 3 products:
    $
      sum_(i in S) x_i gt.eq 3
    $
  ],

  [At *most* $k$ of the items in $S$], [$
    sum_(i in S) x_i lt.eq k
  $], [
    Open at most 2 facilities:
    $
      sum_(i in S) x_i lt.eq 2
    $
  ],

  [*Exactly* $k$ of the items in $S$], [$
    sum_(i in S) x_i eq k
  $], [
    Choose exactly one location:
    $
      sum_(i in S) x_i eq 1
    $
  ],

  [If $x_a = 1$, then $x_b = 1$], [$
    x_a lt.eq x_b
  $], [If project A is done, project B must also be done],

  [If $x_a = 1$, then $x_b = 0$], [$
    x_a + x_b lt.eq 1
  $], [Projects A and B are mutually exclusive],

  [If $x_a = 1$, then $x_b + x_c lt.eq 0$], [$
    x_b + x_c lt.eq M(1 - x_a)
  $], [If project A is selected, neither project B nor C can be selected],

  [If $x_j = 0$, then at least $k$\ items in $S$ must be selected], [$
    sum_(i in S) x_i gt.eq k(1 - x_j)
  $], [You have a main server represented by $x_j$. If it is down or not used ($x_j = 0$), then at least $k$ backup servers (in set $S$) must be activated],

  [At least $k$ of $m$\ constraints satisfied],  [$
    z_i = cases(
      1 "if" g_i (x) lt.eq b_i "enforced",
      0 "if" g_i (x) lt.eq b_i "relaxed"
    )\ "for" i = 1, dots, m \
    \
    g_i (x) - b_i lt.eq M_i (1 - z_i) quad forall i = 1, dots, m \
    sum_(i=1)^m z_i gt.eq k \
    \
    M_i gt.eq max_x (g_i (x) - b_i)
   $], [Enforce any $k$ of the $m$ constraints by relaxing up to $m - k$ of them],

  [Fixed (Setup) Costs], [
    $
      y = cases(
        1 "if"  "is used",
        0 "if" "not used"
      )
    $
    
    $
      x &gt.eq 0 \
      x &lt.eq M dot y \
    $
  ], [If facility is used ($y = 1$), then allow production up to $M$; else $x = 0$],
  
  [Balanced Flow], [$
    sum_(i in V\ i eq.not k) x_(i k) = d_k \
    sum_(i in V\ i eq.not k) x_(j k) = d_k \
  $], [
    Each node $k$ receives and sends exactly $d_k$ units of flow. If $d_k = 1$, this is a TSP or assignment
  ],
  
  [Unbalanced Flow], [$
    sum_(i in V\ i eq.not k) x_(i k) - 
    sum_(i in V\ i eq.not k) x_(j k) = b_k
  $], [
    Each node $k$ has net inflow minus outflow equal to $b_k$:
      - $b_k gt 0$: demand
      - $b_k lt 0$: supply
      - $b_k = 0$: transshipment
  ],

  [Subtours (MTZ)], [$
    1 lt.eq u_i lt.eq n - 1 quad forall i = 2, dots, n \
    \
    u_i - u_j + (n - 1) x_(i j) lt.eq n - 2 \ forall i eq.not j, i, j in {2, dots, n}
  $], [],

  [Subtours (SEC)], [$
    sum_(i in S, j in S\ j eq.not j) x_(i j) lt.eq abs(S) - 1 quad forall S subset.eq V, abs(S) gt.eq 2
  $], [
    For every subset $S$ of the nodes $V$ that has at least 2 nodes, the total number of arcs (or paths) within that subset — from node $i$ to node $j$, where $i eq.not j$ must be less than or equal to $abs(S) - 1$
  ],
  
)

= Non-Linear Programming

#table(
  columns: (auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Function\ Type*], [*Example*], [*Linearization\ Method*], [*Example*],
    [Binary $times$ Binary\ Constraint], [$
      z = x dot y \
      \
      x, y in {0, 1}
    $], [$
      z &lt.eq x \
      z &lt.eq y \
      z &gt.eq x + y - 1 \
      x &in {0, 1} \
    $], [$
      z = 1 arrow.l.r.double.long\ x = y = 1     
    $],

    [Binary $times$ Continuous\ Constraint], [$
      z &= x dot y \
      \
      x &in {0, 1} \
      y &in [L, U] \
    $], [$
      z &lt.eq U x \
      z &gt.eq L x \
      z &lt.eq y - L(1 - x) \
      z &gt.eq y - U(1 - x) \
    $], [$
      
    $],

    [Continuous $times$ Continuous\ Constraint], [$
      z = x dot y \
      \
      x in [L_x, U_x] \
      y in [L_y, U_y] \
    $], [$
      z gt.eq L_x y + L_y x - L_x L_y \ 
      z gt.eq U_x y + U_y x - U_x U_y \ 
      z gt.eq L_x y + U_y x - L_x U_y \ 
      z gt.eq U_x y + L_y x - U_x L_y \ 
    $], [],

    [Absolute Value], [$
      z = abs(x)
    $], [
      $
        z gt.eq x \
        z gt.eq -x
      $
    ], [
      $
        z = |x_1 - x_2| \
        arrow.l.r.double.long \
        z gt.eq x_1 - x_2 \
        z gt.eq x_2 - x_1
      $
    ],

    [Max\ Constraint], [$y gt.eq max(x_1, dots, x_n)$], [$y gt.eq x_1 quad forall i = 1, dots, n$], [
      $
        colorMath(y + x_1 + 3, #red) gt.eq max(colorMath(x_1 - x_3, #blue), colorMath(2 x_2 + 4, #green))
        \ 
        arrow.l.r.double.long 
        \ 
        cases(
          colorMath(y + x_1 + 3, #red) gt.eq colorMath(x_1 - x_3, #blue),
          colorMath(y + x_1 + 3, #red) gt.eq colorMath(2x_2 + 4, #green),
        )       
      $
    ],
    
    [Min\ Constraint], [$y lt.eq min(x_1, dots, x_n)$], [$y lt.eq x_1 quad forall i = 1, dots, n$], [
      $
        colorMath(y + x_1, #red) lt.eq min(colorMath(x_1 - x_3, #blue), colorMath(2x_2 + 4, #green), colorMath(0, #purple)) 
        \
        arrow.l.r.double.long 
        \
        cases(
          colorMath(y + x_1, #red) lt.eq colorMath(x_1 - x_3, #blue),
          colorMath(y + x_1, #red) lt.eq colorMath(2x_2 + 4, #green),
          colorMath(y + x_1, #red) lt.eq colorMath(0, #purple)
        )
      $
    ],
    
    [Max Min\ Objective], [$max min(x_1, dots, x_n)$], [$
      y &= min(x_1, dots, x_n) \
      y &lt.eq x_i quad forall i = 1, dots, n
    $], [],

    [Min Max\ Objective], [$min max(x_1, dots, x_n)$], [$
      y &= max(x_1, dots, x_n) \
      y &gt.eq x_i quad forall i = 1, dots, n
    $], [],
    
    [Min Min\ Objective], [$min min(x_1, dots, x_n)$], [$
      
    $], [$$],

    [Max Max\ Objective], [$max max(x_1, dots, x_n)$], [$
      
    $], [$$],
  ),
)

= Algorithms

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Algorithm*], [*Update Rule*], [],
  ),
  [Gradient\ Descent], [
    $
      x_(k+1) = x_k - colorMath(alpha, #red) gradient f(x_k)
    $
  ], [],
  [Newton's\ Method], [
    $
      x_(k+1) = x_k - colorMath([gradient^2 f(k)]^(-1), #red) gradient f(x_k)
    $
  ], [],
  [], [], [],
  [], [], [],

)

Newton's Method

#table(
  columns: (auto, 1fr, auto),
  [Approximation], [Taylor\ Expansion], [Newton\ Update],
  [Linear (1D)], [
    $
      f'(x_(k+1)) approx f'(x_k) + f''(x_k)(x_(k+1) - x_k)
    $
  ], [
    $
      x_(k+1) = x_k - (f'(x_k)) / (f''(x_k))
    $
  ],
  [Linear (nD)], [
    $
      gradient f(bold("x")_(k+1)) approx gradient f(bold("x")_k) + H_k (bold("x")_(k+1) - bold("x")_k)
    $
  ], [
    $
      bold("x")_(bold("k")+1) = bold("x")_k - H_k^(-1) gradient f(bold("x")_k)
    $
  ],
  [Quadratic (1D)], [
    $
      f_Q (x) =\ f(x_k) + f'(x_k)(x - x_k) + 1/2 f''(x_k)(x - x_k)^2
    $
  ], [
    $
      x_(k+1) = x_k - (f'(x_k)) / (f''(x_k))
    $
  ],
  [Quadratic (nD)],  [
    $
      m_k (bold("p")) = f(bold("x")_k) + gradient f(bold("x")_k)^T bold("p") + 1/2 bold("p")^T H_k bold("p")\
      bold("p") = bold("x") - bold("x")_k
    $
  ], [
    $
      bold("x")_(bold("k")+1) = bold("x")_k - H_k^(-1) gradient f(bold("x")_k)
    $
  ],
)
