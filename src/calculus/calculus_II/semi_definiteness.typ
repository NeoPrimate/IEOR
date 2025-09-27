#import "../../utils/examples.typ": eg
#import "../../utils/code.typ": code
#import "../../utils/color_math.typ": colorMath
#import "../../utils/result.typ": result

== Positive/Negative Definite/Indefinite/Semidefinite Matrices

Let $bold("x") in RR^n$be any nonzero vector. Look at the quadratic form:

$
  bold("x")^T H bold("x")
$

#table(
  columns: 4,
  inset: 1em,
  align: horizon,
  table.cell(
    colspan: 4,
    [
      $
        q(x) = bold("x")^T H bold("x")
      $
      $
        H bold("x") = lambda bold("x")
      $
    ]
  ),
  [], [*Definition*], [*Eigen Values*], [*Geometry*],
  [Positive\ Definite], [
    $
      q(bold("x")) colorMath(gt, #red) 0 quad forall bold("x") eq.not bold(0) \
    $
  ], [
    $
      lambda_i colorMath(gt, #red) 0\
      H succ 0
    $
  ], [*Min*\ (bowl-shaped)],

  [Negative\ Definite], [
    $
      q(bold("x")) colorMath(lt, #red) 0 quad forall bold("x") eq.not bold(0)
    $
  ], [
    $
      lambda_i colorMath(lt, #red) 0\
      H prec 0
    $
  ], [*Max*\ (inverted bowl)],

  [Positive\ Semidefinite], [
    $
      q(bold("x")) colorMath(gt.eq, #red) 0 quad forall bold("x")
    $
  ], [
    $
      lambda_i colorMath(gt.eq, #red) 0\
      H succ.eq 0
    $
  ], [*Min*\ but *flat* in some directions],

  [Negative\ Semidefinite], [
    $
      q(bold("x")) colorMath(lt.eq, #red) 0 quad forall bold("x")
    $
  ], [
    $
      lambda_i colorMath(lt.eq, #red) 0\
      H prec.eq 0
    $
  ], [*Max*\ but *flat* in some directions],
  [Indefinite],
  [
    some $q(bold("x"_1)) colorMath(gt, #red) 0$ 
    \
    some $q(bold("x"_2)) colorMath(lt, #red) 0$
  ], [
    some $lambda_i colorMath(gt, #red) 0$
    \ 
    some $lambda_j colorMath(lt, #red) 0$
  ], [*Saddle*\ Up in some directions\ Down in others],
)

