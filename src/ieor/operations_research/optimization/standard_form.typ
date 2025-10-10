#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/numty:0.0.5" as nt

#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath

== Standard Form

$
  min quad &c^T x \
  s.t. quad &A x = b \
  &x gt.eq 0 \
$

#align(center)[
  #table(
    columns: 3,
    inset: 1em,
    align: horizon,
    [*Original\ Constraint*], [*Conversion\ to Equaliy*], [*Variable*],
    [$a_i^T x lt.eq b_i$], [$a_i^T x + s_i = b_i$], [Slack $s_i gt.eq 0$],
    [$a_i^T x gt.eq b_i$], [$a_i^T x - s_i = b_i$], [Surplus $s_i gt.eq 0$],
    [$a_i^T x = b_i$], [no change], [---],
  )
]

#eg[
  $
    max   quad 4&x_1& quad &+& quad 3&x_2& \
    s.t.  quad 2&x_1& quad &+& quad  &x_2& quad &lt.eq quad &8 \
                &x_1& quad &+& quad 2&x_2& quad &lt.eq quad &6 \
                &#place($x_1, x_2 gt.eq 0$)
  $

  *Step 1.* Convert inequality ($lt.eq$) to equality ($=$)

  Add slack variables $s_1, s_2 gt.eq 0$

  $
    max   quad 4&x_1& quad &+& quad 3&x_2& \
    s.t.  quad 2&x_1& quad &+& quad  &x_2& quad colorMath(&+ quad &s_1&, #red) & quad &       &   & quad &eq quad &8 \
                &x_1& quad &+& quad 2&x_2& quad &  quad &   & &      colorMath(&+ quad &s_2&, #red) quad &eq quad &6 \
                &#place($x_1, x_2, colorMath(s_1, #red), colorMath(s_2, #red) gt.eq 0$)
  $

  *Step 2.* Convert Max to Min

  Multiply the objective by -1:

  $
    colorMath(&min&   quad -4&x_1& quad &-& quad 3&x_2&, #red) \
    &s.t.&  quad 2&x_1& quad &+& quad  &x_2& quad colorMath(&+ quad &s_1&, #red) & quad &       &   & quad &eq quad &8 \
            &&    &x_1& quad &+& quad 2&x_2& quad &  quad &   & &      colorMath(&+ quad &s_2&, #red) quad &eq quad &6 \
           &&     &#place($x_1, x_2, colorMath(s_1, #red), colorMath(s_2, #red) gt.eq 0$)
  $

  #linebreak()
]

#eg[
   $
    min   quad 4&x_1& quad &+& quad 3&x_2& \
    s.t.  quad 2&x_1& quad &+& quad  3&x_2& quad &gt.eq quad &6 \
                &x_1& quad &+& quad 4&x_2& quad &gt.eq quad &8 \
                &#place($x_1, x_2 gt.eq 0$)
  $

  *Step 1.* Convert inequality ($gt.eq$) to equality ($=$)

  Add slack variables $s_1, s_2 gt.eq 0$

  $
    min   quad 4&x_1& quad &+& quad 3&x_2& \
    s.t.  quad 2&x_1& quad &+& quad  3&x_2& quad colorMath(&- quad &s_1&, #red) & quad &       &   & quad &eq quad &6 \
                &x_1& quad &+& quad 4&x_2& quad &  quad &   & &      colorMath(&- quad &s_2&, #red) quad &eq quad &8 \
                &#place($x_1, x_2, colorMath(s_1, #red), colorMath(s_2, #red) gt.eq 0$)
  $

  #linebreak()
]