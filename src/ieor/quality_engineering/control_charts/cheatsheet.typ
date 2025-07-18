#table(
  columns: (auto, auto, auto, auto, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header(
    [*Chart*], [*Tracks*], [*Data\ Typse*], [*Sample\ Size*], [*Statistical\ Basis*], [*Use\ Case*], 
  ),
  [c], [Number of defects per unit], [Count (discrete)], [Fixed], [Poisson], [When you count defects per inspection unit (e.g., scratches, cracks) and sample size is constant], 
  [u], [Number of defects per unit (standardized)], [Count per unit (continuous)], [Variable], [Poisson], [Same as c-chart but for variable sample sizes (defects per unit area, time, etc.)], 
  [np], [Number of defective units], [Count (discrete)], [Fixed], [Binomial], [Each item is either defective or not; count how many items fail inspection], 
  [p], [Proportion of defective units], [Proportion (0-1)], [Variable], [Binomial], [Same as np-chart but with variable sample size — tracks percentage defective], 
  [$overline(x)$], [Mean of continuous variable], [Continuous], [Grouped samples], [Normal], [Monitors process average (e.g., length, weight, temperature) over time], 
  [R], [Range of values in a sample], [Continuous], [Grouped samples], [Range distribution (based on Normal)], [Used with x̄-chart to monitor variation in process (spread)], 
  [], [], [], [], [], [], 
)