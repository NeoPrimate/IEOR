#import "/lib/imports.typ": *
#show: formatting

- Variance decomposition formula
- Conditional variance formula
- Eve's law

$
  "Var"(X) = underbrace(EE["Var"(X | Y)], "within-group") + underbrace("Var"(EE[X | Y]), "between-group")
$

