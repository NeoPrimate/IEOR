#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#set text(font: "Helvetica", size: 8pt)

= Analytical Methods

- Demand
- Capacity
- Lead Time
- Yield
- Multiple Products
- Bundling
- Discounts

#let y-offset = 0.5
#let tint(c) = (stroke: c, fill: rgb(..c.components().slice(0,3), 5%), inset: 8pt)

#diagram(
	node-corner-radius: 4pt,

	node((0,y-offset * 1), $a$, name: <a>),
	node((0,y-offset * 2), $b$, name: <b>),
	node((0,y-offset * 3), $c$, name: <c>),
	node((0,y-offset * 4), $d$, name: <d>),
	
  node((1,y-offset * 1), $1$, name: <1>),
  node((1,y-offset * 2), $2$, name: <2>),
  node((1,y-offset * 3), $3$, name: <3>),
  node((1,y-offset * 4), $4$, name: <4>),

  node(enclose: (<a>, <b>, <c>, <d>), align(top + left)[$X$], ..tint(teal), name: <X>),
  node(enclose: (<1>, <2>, <3>, <4>), align(top + right)[$Y$], ..tint(teal), name: <Y>),

  edge(<a>, <1>, "-|>"),
  edge(<b>, <2>, "-|>"),
  edge(<c>, <3>, "-|>"),
)

Profit margin

$
  max quad &80 a + 100 b - 20 a - 25 b \
  s.t. quad 
  &0.1 a + 0.5 b lt.eq 60 \
  &0 lt.eq a \
  &0 lt.eq b \
  &a lt.eq 200 \
  &b lt.eq 110 \

$