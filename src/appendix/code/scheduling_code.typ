#import "/lib/imports.typ": *
#show: formatting

= Scheduling Code <appendix_code_scheduling_code>

#let code = read("../../../code/mathematical_programming/linear_programming/scheduling/model.py")
#raw(code, lang: "python", block: true)

#let data = read("../../../code/mathematical_programming/linear_programming/scheduling/data.dat")
#raw(data, lang: "python", block: true)
