#table(
  columns: (auto, auto, auto, auto, auto, auto),
  gutter: 0em,
  inset: 10pt,
  fill: (x, y) => if x == 0 or y == 0 or x == 3 { gray.lighten(60%) },
  align: horizon,
  table.header(
    [Test Type], [Purpose], [Assumptions], [Non-Parametric Equivalent], [Non-Parametric Test Purpose], [Non-Parametric Test Assumptions]
  ),

  [One-Sample t-Test], [Compare sample mean to a known value], [Normality of the sample distribution], [Wilcoxon Signed-Rank Test], [Compare median of a sample to a known value], [Distribution-free; does not assume normality], 
  [Independent t-Test], [Compare means between two independent groups], [Normality, equal variances in groups], [Mann-Whitney U Test], [Compare distributions between two independent groups], [Distribution-free; does not assume normality or equal variances], 
  [Paired t-Test], [Compare means between two related groups], [Normality of the difference scores], [Wilcoxon Signed-Rank Test], [Compare the median of paired differences], [Distribution-free; does not assume normality], 
  [Two-Sample t-Test], [Compare means between two independent groups], [Normality, equal variances in groups], [Mann-Whitney U Test], [Compare distributions between two independent groups], [Distribution-free; does not assume normality or equal variances], 
  [One-Way ANOVA], [Compare means across three or more groups], [Normality, equal variances among groups], [Kruskal-Wallis Test], [Compare distributions across three or more independent groups], [Distribution-free; does not assume normality or equal variances], 
  [Repeated Measures ANOVA], [Compare means across multiple related groups], [Normality, sphericity (equal variances of differences)], [Friedman Test], [Compare distributions across multiple related groups], [Distribution-free; does not assume normality], 
  [ANCOVA], [], [], [], [], [], 
)
