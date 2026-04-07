import numpy as np
import polars as pl

import torch
from torch_geometric.data import Data
import torch.nn as nn
import torch.nn.functional as F
from torch_geometric.nn import GCNConv

import matplotlib.pyplot as plt

nodes = pl.read_parquet("./data/nodes.parquet")
edges = pl.read_parquet("./data/edges.parquet")

class SupplyChainGNN(nn.Module):
    def __init__(self, in_feats, hidden=32, out_feats=1):
        super().__init__()
        self.conv1 = GCNConv(in_feats, hidden)
        self.conv2 = GCNConv(hidden, hidden)
        self.fc = nn.Linear(hidden, out_feats)
    
    def forward(self, data):
        x, edge_index = data.x, data.edge_index
        x = F.relu(self.conv1(x, edge_index))
        x = F.relu(self.conv2(x, edge_index))
        x = self.fc(x)  # e.g., node-level prediction
        return x
    
model = SupplyChainGNN()
optimizer = torch.optim.Adam(model.parameters(), lr=0.01)
criterion = nn.MSELoss()

# ----------------------
# 4. Train for node-level target
# ----------------------
model.train()
for epoch in range(100):
    optimizer.zero_grad()
    out = model(data)
    loss = criterion(out, data.y)
    loss.backward()
    optimizer.step()
    if (epoch+1)%20==0:
        print(f"Epoch {epoch+1}: Loss={loss.item():.4f}")

# ----------------------
# 5. Evaluate
# ----------------------
model.eval()
with torch.no_grad():
    pred = model(data)
    print(pred)