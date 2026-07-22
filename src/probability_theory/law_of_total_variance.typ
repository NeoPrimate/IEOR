#import "/lib/imports.typ": *
#show: formatting

= Law of Total Variance <probability_theory_law_of_total_variance>

- Variance decomposition formula
- Conditional variance formula
- Eve's law

$
  "Var"(X) = underbrace(EE["Var"(X | Y)], "within-group") + underbrace("Var"(EE[X | Y]), "between-group")
$

