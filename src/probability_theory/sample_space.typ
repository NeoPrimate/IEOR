#import "@preview/cetz:0.4.2" 

== Spample Space

Two steps:
1. Describe possible *outcomes*
2. Describe beliefs about *likelihood* of outcomes

- $Omega$: *set* of all possible outcomes
- *Elements* of $Omega$:
  - Mutually *exclusive*
  - Collectively *exhaustive*

#cetz.canvas({
import cetz.draw: * 
    // grid((0,0), (3,2), help-lines: true)
    
    rect((0, 0), (3, 2), name: "sample_space")
    content("sample_space", $ Omega $, anchor: "south-west", padding: (x: 1, y: 0.5))
})