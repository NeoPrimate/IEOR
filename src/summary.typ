#table(
  columns: (auto, auto, auto, auto, auto, auto),
  gutter: 0em,
  inset: 10pt,
  fill: (x, y) => if x == 0 or y == 0 or x == 3 { gray },
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
)




// #table(
//   columns: (auto, auto, auto, auto, auto),
//   inset: 10pt,
//   align: horizon,
//   // table.header(
//   //   [], [], [*Use*], [*Dependent*], [*Independent*],
//   // ),

//   table.cell(
//     rowspan: 3,
//     align: horizon,
//     [*t-Test*],
//   ),

//   [*One-sample*], [Compares the mean of a single sample to a known or hypothesized population mean], [Continuous], [], 
  
//   [*Independent*], [Compares the means of two independent groups to see if they are significantly different], [Continuous], [Categorical], 

//   [*Paired*], [Compares means from the same group at two different times or under two different conditions], [Continuous], [Categorical], 

//   table.cell(
//     rowspan: 2,
//     align: horizon,
//     [*Chi-Square*],
//   ),

//   [*Goodness of Fit*], [Tests whether the observed frequencies of a single categorical variable match expected frequencies], [Categorical], [], 
//   [*Test of Independence*], [Tests whether two categorical variables are independent of each other in a contingency table], [Categorical], [Categorical], 

//   table.cell(
//     rowspan: 2,
//     align: horizon,
//     [*ANOVA*],
//   ),

//   [*One-way*], [Compares the means of three or more independent groups based on one independent variable], [Continuous], [Categorical], 
//   [*Two-way*], [Compares the means across two independent variables, also assessing interaction effects], [Continuous], [Categorical], 

//   table.cell(
//     rowspan: 6,
//     align: horizon,
//     [*Regression*],
//   ),

//   [*Simple*], [Assesses the relationship between one independent variable and one dependent variable], [Continuous], [Continuous],
//   [*Multiple*], [Assesses the relationship between two or more independent variables and one dependent variable], [Continuous], [Continuous / Categorical],
//   [*Logistic*], [Predicts the probability of a binary outcome based on one or more independent variables], [Categorical], [Continuous / Categorical],
//   [*Multinomial Logistic*], [Predicts the probability of outcomes for a categorical dependent variable with three or more unordered categories], [Categorical], [Continuous / Categorical],
//   [*Ordinal Logistic*], [Predicts the probability of outcomes for a categorical dependent variable with three or more ordered categories], [Categorical], [Continuous / Categorical],
//   [*Polynomial*], [Models the relationship between the independent variable(s) and the dependent variable as an nth-degree polynomial], [Continuous], [Continuous],


// )