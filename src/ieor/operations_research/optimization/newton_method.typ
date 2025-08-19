#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1"
#import "@preview/cetz:0.4.0": canvas, draw, tree
#import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge


#import "../../../utils/examples.typ": eg
#import "../../../utils/code.typ": code
#import "../../../utils/color_math.typ": colorMath
#import "../../../utils/definition.typ": definition
#import "../../../utils/titles.typ": *

#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Newton's Method

Prerquisites:
- #link("hassian_matrix")[Hassian Matrix]

Iterative numerical technique to find local minima or maxima of a function

#title_1[Hassian Matrix]

Square matrix of second-order partial derivatives

Describes the local curvature of a multivariable function

$
  f: RR^n arrow RR
$

Input: $bold("x") = vec(x_1, x_2, dots.v, x_n)$

Output: Scalar

#set math.mat(gap: 1em)
$
  H_f (bold("x")) = mat(
    (diff^2 f) / (diff x_1^2), (diff^2 f) / (diff x_1 diff x_2), dots, (diff^2 f) / (diff x_1 diff x_n);
    (diff^2 f) / (diff x_2 diff x_1), (diff^2 f) / (diff x_2^2), dots, (diff^2 f) / (diff x_2 diff x_n);
    dots.v, dots.v, dots.down, dots.v;
    (diff^2 f) / (diff x_n diff x_1), (diff^2 f) / (diff x_n^2 diff x_2), dots, (diff^2 f) / (diff x_n^2);
  )
$

*Diagonal entries: $(diff^2 f) / (diff x_i^2)$*

Second derivative of $f$ with respect to a single variable twice

How the slope of $f$ changes as you move along the $x_1$ direction

*Off-diagonal entries: $(diff^2 f) / (diff x_i diff x_j)$ where $i eq.not j$*

How the slope in one direction changes when you move in a different direction

$(diff^2 f) / (diff x_1 diff x_2)$: How the rate of change of $f$ along $x_1$ changes as you move in the $x_2$ direction


#eg[
  
]