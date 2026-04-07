import polars as pl
import numpy as np

# --------------------
# Random helpers
# --------------------
def positive_normal(mean, sd):
    x = np.random.normal(mean, sd)
    return max(0.01, x)

def lognormal(mean, sigma):
    return np.random.lognormal(mean, sigma)

def bounded_uniform(low, high):
    return np.random.uniform(low, high)

def beta_distribution(a, b, scale=1.0):
    return np.random.beta(a, b) * scale

# --------------------
# Supply chain simulation returning Polars DataFrames
# --------------------
def simulate_supply_chain_polars(
    n_suppliers=3,
    n_plants=4,
    n_dcs=6,
    n_retailers=10,
    p_connect=0.6,
):
    
    # --------------------
    # Nodes
    # --------------------

    suppliers = pl.DataFrame([{
        "node": f"S{i}",
        "type": "supplier",
        "supply": positive_normal(200, 50),
        "reliability": beta_distribution(8, 2),
    } for i in range(n_suppliers)])

    plants = pl.DataFrame([{
        "node": f"P{i}",
        "type": "plant",
        "capacity": positive_normal(300, 80),
        "processing_cost": lognormal(2.5, 0.3),
        "lead_time": bounded_uniform(3, 7),
    } for i in range(n_plants)])

    dcs = pl.DataFrame([{
        "node": f"D{i}",
        "type": "dc",
        "lead_time": bounded_uniform(1, 4),
        "storage_capacity": positive_normal(500, 120),
        "holding_cost": bounded_uniform(0.5, 1.5),
    } for i in range(n_dcs)])

    retailers = pl.DataFrame([{
        "node": f"R{i}",
        "type": "retailer",
        "demand": positive_normal(50, 20),
        "service_level_requirement": beta_distribution(5, 1.5, scale=0.1)
    }
    for i in range(n_retailers)])

    nodes_df = pl.concat([suppliers, plants, dcs, retailers], how="diagonal")

    # --------------------
    # Edges
    # --------------------
    edges_data = []

    # helper to connect layers
    def connect_layers(from_nodes, to_nodes):
        for u in from_nodes:
            for v in to_nodes:
                if np.random.rand() < p_connect:
                    edges_data.append({
                        "source": u,
                        "target": v,
                        "transportation_cost": bounded_uniform(1, 10),
                        "transportation_time": bounded_uniform(1, 7),
                        "max_flow": positive_normal(200, 40),
                        "reliability": beta_distribution(7, 3)
                    })

    suppliers = nodes_df.filter(pl.col("type")=="supplier")["node"].to_list()
    plants = nodes_df.filter(pl.col("type")=="plant")["node"].to_list()
    dcs = nodes_df.filter(pl.col("type")=="dc")["node"].to_list()
    retailers = nodes_df.filter(pl.col("type")=="retailer")["node"].to_list()

    connect_layers(suppliers, plants)
    connect_layers(plants, dcs)
    connect_layers(dcs, retailers)

    edges_df = pl.DataFrame(edges_data)

    return nodes_df, edges_df

nodes_df, edges_df = simulate_supply_chain_polars()
nodes_df.write_parquet("./data/nodes.parquet")
edges_df.write_parquet("./data/edges.parquet")
