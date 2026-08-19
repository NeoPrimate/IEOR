#import "/lib/imports.typ": *

#fletcher.diagram(
	node-corner-radius: 4pt,
	node((0,0), [President], name: "president"),
	node((2,0), [Prime\ Minister], name: "prime_minister"),
	node((1,2), [Ministers], name: "ministers"),

	edge(<president>, <prime_minister>, "-|>", label: text(8pt, [appoints]), label-anchor: "center", label-pos: 50%),
	edge(<president>, "d,r", <ministers>, "-|>", label: text(8pt, [appoints]), label-anchor: "center", label-pos: 50%),
	edge(<prime_minister>, "d,l", <ministers>, "-|>", label: text(8pt, [appoints]), label-anchor: "center", label-pos: 50%),

	{
		let tint(c) = (stroke: c, fill: rgb(..c.components().slice(0,3), 5%), inset: 8pt)
		node(enclose: (<president>, <prime_minister>, <ministers>), ..tint(teal), name: <government>)
	},
)


- *Exectutive*

  - President



  - Government

    - Prime Minister

    Prime Minister's proposal appoints the other members of the government. Ministries can be created, merged, split, or renamed by decree

    - Ministers

- *Assemblée nationale* (577 deputies) 

Elected directly, in single-member constituencies, by a two-round runoff. Five-year terms. The President can dissolve it.

Assemblée nationale: 577 seats, direct, two rounds

Deputies are elected for five years in single-member constituencies (scrutin uninominal majoritaire à deux tours) — 539 in metropolitan France, 27 overseas, and 11 for French citizens resident abroad, a category added in 2012. The whole chamber renews at once.

- *Sénat* (348 senators)

Elected indirectly, by a college of roughly 160,000 local officials — mostly municipal councillors. Six-year terms, half renewed every three years. It cannot be dissolved, which makes it structurally more conservative and more rural in flavour than the Assembly.

Sénat: 348 seats, indirect, staggered

They're chosen by roughly 162,000 grands électeurs, an electoral college convened per department: 
- deputies
- regional and departmental councillors
- delegates of municipal councils (95% of the total)

#let node-width = 10em

#align(center)[
  #fletcher.diagram(
    edge-stroke: 1pt,
    node-corner-radius: 5pt,
    edge-corner-radius: 8pt,
    mark-scale: 80%,
    node(
      (0,0), 
      [
        Bill Introduced \
        #text(size: 8pt)[Government or Parliament]
      ], 
      fill: gray.transparentize(75%),
      stroke: black + 0.5pt,
      width: node-width,
      name: "bill"
    ),
    node(
      (0,1), 
      [
        National Assembly \
        #text(size: 8pt)[577 Deputies, direct vote]
      ], 
      fill: blue.transparentize(75%),
      stroke: black + 0.5pt,
      width: node-width,
      name: "assembly_1"
    ),
    node(
      (0, 2), 
      [
        Senate \
        #text(size: 8pt)[348 Senators, indirect vote]
      ], 
      fill: blue.transparentize(75%),
      stroke: black + 0.5pt,
      width: node-width,
      name: "senate"
    ),
    node(
      (0, 3), 
      [
        Joint Committee \
        #text(size: 8pt)[7 Deputies, 7 Senators]
      ], 
      fill: red.transparentize(75%),
      stroke: black + 0.5pt,
      width: node-width,
      name: "committee"
    ),
    node(
      (0, 4), 
      [
        Assembly \
        #text(size: 8pt)[If government asks]
      ], 
      fill: red.transparentize(75%),
      stroke: black + 0.5pt,
      width: node-width,
      name: "assembly_2"
    ),
    node(
      (0, 5), 
      [
        Promulgation \
        #text(size: 8pt)[Signed then published]
      ], 
      fill: gray.transparentize(75%),
      stroke: black + 0.5pt,
      width: node-width,
      name: "promulgation"
    ),

    edge(<bill>, <assembly_1>, "-|>"),
    edge(<assembly_1>, <senate>, "-|>"),
    edge(<senate>, "r,u", <assembly_1>, "-|>"),
    edge(<senate>, <committee>, "-|>"),
    edge(<committee>, <assembly_2>, "-|>"),
    edge(<assembly_2>, <promulgation>, "-|>"),
  )
]

