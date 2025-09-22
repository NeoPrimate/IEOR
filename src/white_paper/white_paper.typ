#import "../utils/title_page.typ": title_page

#import "../utils/examples.typ": eg
#import "../utils/code.typ": code
#import "../utils/color_math.typ": colorMath
#import "../utils/definition.typ": definition
#import "../utils/color_mat.typ": colorMat

#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge, shapes


#title_page("White Paper")

(Project Cybersyn/Synco, Project Red Book, OGAS Project)

- Publicly owned
- Democratically controlled
- Environmentally sustainable
- Fully automated
- Transparent

Supply chain guaranteeing a predefined set of goods and services to all members of society

France is split into 5 strictly nested administrative units:
- National ($cal(N)$)
- Regions ($cal(R)$)
- Departements ($cal(D)$)
- Communes ($cal(C)$)
- IRIS ($cal(I)$)

Objectives:

1. Facility Location

- *Distribution Centers*: Determine optimal locations of distribution centers at the National, Regional, Departement, Commune, and IRIS levels, subject to demographic demand and geographic accessibility.
- *Government Stores*: Determine optimal placement of government stores such that all households have equitable access to essential goods.

2. Flow Allocation

- *Supply Allocation*: Determine how much of each good should be allocated from supply nodes (imports, extraction, or domestic manufacturing plants) to each level of distribution.
- *Demand Fulfillment*: Ensure that each demand node receives sufficient quantities of goods to meet population needs, respecting fairness and prioritization rules (e.g., hospitals and schools may receive priority allocations).
- *Reverse Flows*: Incorporate waste recovery, recycling, and reverse logistics so that outputs from demand nodes (waste, byproducts, returns) are routed to processing or extraction nodes when feasible.

3. Systemic Objectives
- *Equity*: Guarantee universal access across all IRIS units, reducing geographic disparities.
- *Resilience*: Provide redundancy and flexibility in flows to handle shocks (e.g., disruptions to imports or local production).
- *Sustainability*: Minimize environmental impact by favoring local production, renewable inputs, and circular waste loops.
- *Efficiency*: Optimize flows to minimize costs, transport distances, and resource usage, while meeting fairness and sustainability constraints.
- *Transparency* and *Participation*: Make allocation decisions visible, accountable, and open to democratic oversight at all administrative levels.

== Administrative Hierarchy and Demographics


#figure(
  image("./vis/admin/administrative_hierarchy_map.png", width: 50%),
  caption: [Administrative Hierarchy],
) <administrative_hierarchy_map>

#figure(
  image("./vis/admin/communes_population_map.png", width: 50%),
  caption: [Commune Population Map],
) <commune_population_map>

#figure(
  image("./vis/roads/roads.png", width: 50%),
  caption: [Roads],
) <roads_map>

#figure(
  image("./vis/roads/roads_commune_hubs.png", width: 50%),
  caption: [Roads & Commune Hubs],
) <roads_and_commune_hubs_map>

#figure(
  image("./vis/trains/trains.png", width: 50%),
  caption: [Train Network and Hubs],
) <train_network_and_hubs_map>

#figure(
  image("./vis/aero/aero.png", width: 50%),
  caption: [Aeronatic Hubs],
) <aeronautic_hubs_map>

#figure(
  image("./vis/ports/ports.png", width: 50%),
  caption: [Port Hubs],
) <aeronautic_hubs_map>

== Schema

Nodes

#align(center)[
  #table(
    columns: range(5).map(_ => auto),
    inset: 1em,
    align: left,
    [*Category*], [*Type*], [*Attributes*], [*Description*], [*Code*],

    table.cell(rowspan: 3, [Extraction]),
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],

    table.cell(rowspan: 2, [Supply]),
    [Import\ Facility], [], [], [],
    [Manufacturing\ Plant], [], [], [],

    table.cell(rowspan: 4, [Intermediary]),
    [National\ Distribution\ Center (NDC)], [], [], [`NDC_`],
    [Regional\ Distribution\ Center (RDC)], [], [], [`RDC_`],
    [Department\ Distribution\ Center (DDC)], [], [], [`DDC_`],
    [Commune\ Distribution\ Center (CDC)], [], [], [`CDC_`],

    table.cell(rowspan: 4, [Demand]),
    [Store], [], [], [],
    [Household], [], [], [],
    [School], [], [], [],
    [Hospital], [], [], [],

    table.cell(rowspan: 4, [Waste]),
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
  )
]

#align(center)[
  #table(
    columns: range(5).map(_ => auto),
    inset: 1em,
    [*Mode of\ Transport*], [*Type*], [*Attributes*], [*Desciption*], [*Code*],
    [Road], [Highway\ National\ Local], [], [], [],
    [Rail], [Freight\ Regional], [], [], [],
    [Air], [Flight Path\ Cargo Route], [], [], [],
    [Martime], [Shipping\ Coastal], [], [], [],
    [Inland\ Waterway], [River\ Canal], [], [], [],
  )
]

#align(center)[
  #align(center)[
    #diagram(
      node-inset: 0pt,

      node(pos: (0,-0.5), label: {$E$}, stroke: 0.1em, radius: 1em, name: <E>),

      node(pos: (0,0.5), label: {$I$}, stroke: 0.1em, radius: 1em, name: <I>),
      
      node(pos: (1,0), label: {$P$}, stroke: 0.1em, radius: 1em, name: <P>),
      
      node(pos: (2,0), label: {$D C$}, stroke: 0.1em, radius: 1em, name: <DC>),
      
      node(pos: (3,0), label: {$D$}, stroke: 0.1em, radius: 1em, name: <D>),
      
      node(pos: (4,0), label: {$W$}, stroke: 0.1em, radius: 1em, name: <W>),
      
      edge(<I>, <P>, "-|>", label: {}),
      edge(<E>, <P>, "-|>", label: {}),
      edge(<P>, <P>, "-|>", bend: -145deg, label: {}),
      edge(<P>, <DC>, "-|>", label: {}),
      edge(<DC>, <DC>, "-|>", bend: 145deg, label: {}),
      edge(<DC>, <D>, "-|>", label: {}),
      edge(<D>, <W>, "-|>", label: {}),
      edge(<I>, <DC>, "-|>", bend: -75deg, label: {}),
      edge(<W>, <P>, "-|>", bend: -75deg, label: {}),
      edge(<W>, <E>, "-|>", bend: -75deg, label: {}),
      edge(<DC>, <E>, "-|>", bend: -75deg, label: {}),
      edge(<DC>, <P>, "-|>", bend: -75deg, label: {}),
    )
  ]
]

Raw materials are obtained either from Extraction Nodes ($E$) or imported through Import Nodes ($I$). They are then sent to Processing Nodes ($P$), where they undergo one or more processing stages. The resulting products are delivered to Distribution Nodes ($D C$).

Distribution Nodes can also receive finished products directly from Import Nodes. They may transfer goods to other Distribution Nodes (at different administrative levels), directly to Demand Nodes ($D$), or back to Processing and Extraction Nodes—for example, when machinery, spare parts, or energy carriers are required to sustain those activities.

Once products are consumed at Demand Nodes, they generate outputs that flow into Waste Nodes ($W$). Waste Nodes can (1) dispose of waste, (2) redirect it to Processing Nodes for recovery or recycling, or (3) return it to Extraction Nodes through resource recovery activities such as landfill mining or biogas capture.

Data

#align(center)[
  #table(
    columns: range(2).map(_ => auto),
    align: left,
    [IRIS], [
      - https://geoservices.ign.fr/contoursiris
      - https://geoservices.ign.fr/irisge
    ],
    [Adminitrative\ Units], 
    [
      - https://geodatafr.github.io/IGN/ADMIN_EXPRESS_Administrative_boundaries/
    ],
    [Roads], 
    [
      - https://transport.data.gouv.fr/datasets/route-500-r
    ],
    [Rail], 
    [
      - https://www.data.gouv.fr/datasets/fichier-de-formes-des-lignes-du-reseau-ferre-national
      - https://ressources.data.sncf.com/explore/dataset/formes-des-lignes-du-rfn/information/
    ],
    [Train Stations],
    [
      - https://transport.data.gouv.fr/datasets/liste-des-gares?locale=en
    ],
    [Martime Ports],
    [
      - https://www.data.gouv.fr/datasets/ports-espace-maritime-francais/
      - https://data.opendatasoft.com/explore/dataset/caracteristiques-des-ports-en-france-2021%40pndb/
    ],
    [Inland Ports],
    [

    ],
    [Aeroports],
    [
      - https://www.data.gouv.fr/datasets/aeroports-francais-coordonnees-geographiques/
    ]
  )
]

Stack

Safe Rust

#align(center)[
  #table(
    columns: range(2).map(_ => auto),
    align: left,
    [DataBase], 
    [
      - PSQL (`tokio_postgres`, `sqlx`, `bb8`)
      - ScyllaDB (`scylla`)
    ],
    [API], 
    [
      - gRPC (`tonic`)
      - REST (`axum`)
    ],
    [Front End], 
    [
      - `dioxus`
      - `leptos`
      - `bevy`
    ],
  )
]




// Cockshott, P. & Cottrell, A. (1993) _Towards a New Socialism_

// Goods and services would be priced according to the socially necessary labor time required to produce them. People would receive labor vouchers corresponding to their work, ensuring proportionality between effort and reward.