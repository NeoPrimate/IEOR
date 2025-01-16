#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code

== XYZ Analysis

Categorization based on variability

- X: Low variability

- Y: Moderate variability

- Z: High variability

Coefficient of Variation:

$
C V = sigma / mu
$

- X Items: Low CV 

  - CV < $k_1$, where $k_1$ is the threshold value indicating low variability

- Y Items: Moderate CV 

  - CV < $k_2$, where $k_2$ is the moderate value indicating low variability

- Z Items: High CV

  - CV < $k_3$, where $k_3$ is the threshold value indicating high variability

#eg[

*Step 1*: Collect Historical D../ata (12 months)

- Product A: [100, 105, 98, 102, 101, 104, 103, 100, 99, 100, 101, 102]

- Product B: [150, 155, 145, 160, 140, 150, 155, 150, 165, 155, 150, 140]

- Product C: [200, 180, 220, 190, 210, 240, 180, 230, 220, 210, 250, 190]

*Step 2*: Calculate the Mean and Standard Deviation
- Product A: 
  - $mu = 101$
  - $sigma = 2$
- Product B: 
  - $mu = 150$
  - $sigma = 8$
- Product C: 
  - $mu = 210$
  - $sigma = 25$

*Step 3*: Calculate the Coefficient of Variation (CV)

- $C V = 2 / 101 = 0.0198$
- $C V = 8 / 150 = 0.0533$
- $C V = 25 / 210 = 0.1190$

*Step 4*: Categorization

- X: Product A (Low variability)
- Y: Product B (Moderate variability)
- Z: Product C (High variability)

]