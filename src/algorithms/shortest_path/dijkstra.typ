#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code

== Dijkstra's

*Step 1*: Initialize

- Mark all nodes as unvisited
- Set the distance to the source as 0
- Set the distance to all other nodes as $infinity$
- Create a priority queue (or a simple list) to keep track of unvisited nodes and their distances.

#eg[
  Graph nodes: A, B, C, D
  
  Start node: A

  Distances:
  - $A = 0$
  - $B = infinity$
  - $C = infinity$
  - $D = infinity$
]

*Step 2*: Select the Unvisited Node with the Smallest Distance

Among all unvisited nodes, pick the one with the smallest known distance. Let's call this the current node.

*Step 3*: Update Neighboring Distances

For each neighbor of the current node:
1. Calculate the tentative distance:
  
  distance(current) + weight(current → neighbor)

2. If this tentative distance is less than the known distance, update it.

#eg[
  If $A arrow.long  B$ has weight 4 and distance to A is 0:
  
  Tentative distance to B = 0 + 4 = 4

  If current distance to B is ∞, update to 4

]

*Step 4*: Mark the Current Node as Visited

- Once all neighbors are checked, mark the current node as visited
- Visited nodes are not checked again

*Step 5*: Repeat Until All Nodes Are Visited

- Go back to Step 2 and repeat.
- Stop when all nodes have been visited or the smallest tentative distance among the unvisited nodes is $infinity$ (meaning unreachable)

*Step 6*: Reconstruct the Shortest Paths (Optional)

- To find the actual shortest path, track the previous node for each visited node
- Starting from the destination, backtrack through the previous nodes

#eg[
  
]