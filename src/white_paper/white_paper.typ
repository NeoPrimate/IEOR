#import "../utils/title_page.typ": title_page

#title_page("White Paper")

Project cybersyn
Project red book
OGAS project

- Publicly owned
- Democratically controlled
- Environmentally sustainable
- Fully automated
- Transparent
Supply chain guaranteeing a predefined set of goods and services to all members of society


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

Nodes:
- Households
- Distribution Centers (DCs)
- Ports
- Airports
- Train Stations

Edges:
- Transport: Plane / Drone / Train / Truck / Boat



```sql
user (

)
```

Stack

Safe Rust

- PSQL, ScyllaDB
- tokio_postgres, sqlx
- bb8
- tonic, axum
- tonic
- dioxus, leptos, bevy

Cockshott, P. & Cottrell, A. (1993) _Towards a New Socialism_

Goods and services would be priced according to the socially necessary labor time required to produce them. People would receive labor vouchers corresponding to their work, ensuring proportionality between effort and reward.