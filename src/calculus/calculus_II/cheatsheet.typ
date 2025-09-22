#import "../../utils/color_math.typ": colorMath

#set math.mat(gap: 0.75em)
#set math.vec(gap: 1em)
#set math.vec(delim: "[")
#set math.mat(delim: "[")

== Derivative Objects

#table(
  columns: (auto, auto, auto, auto),
  inset: 1em,
  align: horizon,

  [*Gradient*], 
  [$f: RR^n arrow RR$], 
  [$n times 1$], 
  [Vector of first derivatives; special case of Jacobian (scalar output)],

  [*Jacobian*], 
  [$F: RR^n arrow RR^m$], 
  [$m times n$], 
  [Matrix of first derivatives; general case for vector-valued functions],

  [*Hessian*], 
  [$f: RR^n arrow RR$], 
  [$n times n$], 
  [Matrix of second derivatives; Jacobian of the gradient],
)


#{
  show table.cell: set text(size: 8pt)
  table(
    columns: range(5).map(_ => auto),
    inset: 1.5em,
    align: horizon,
    
    [], [*Input/Output*], [*Derivatives*], [*Notation*], [*Example*],
    [*Gradient*\ (Derivative)\ ($1 times 1$)], 
    [
      $f: RR arrow RR$\
      One Input\ 
      *One Output*\ 
      Scalar Function
    ], [*First*\ Order], [
      $
        gradient f(x) = f'(x) = vec((diff f) / (diff x))
      $
    ], [],

    [*Jacobian*\ ($m times 1$)], 
    [
      $f: RR arrow RR^m$\
      One Input\ 
      *Multiple Output*\ 
      Vector Function
    ], [*First*\ Order], [
      $
        J_f (x) = vec(
          (diff f_colorMath(1, #red)) / (diff x),
          (diff f_colorMath(2, #red)) / (diff x),
          dots.v,
          (diff f_colorMath(m, #red)) / (diff x),
        )
      $
    ], [],
    [*Gradient*\ ($n times 1$)], 
    [
      $f: RR^n arrow RR$\
      Multiple Input\ 
      *One Output*\ 
      Scalar Function
    ], [*First*\ Order], [
      $
        gradient f(bold("x")) = vec(
          (diff f) / (diff x_colorMath(1, #red)),
          (diff f) / (diff x_colorMath(2, #red)),
          dots.v,
          (diff f) / (diff x_colorMath(n, #red)),
        )
      $
    ], [],
    [*Jacobian*\ ($m times n$)], 
    [
      $f: RR^n arrow RR^m$\
      Multiple Input\ 
      *Multiple Output*\ 
      Vector Function
    ], [*First*\ Order], [
      $
        J_f (bold("x")) = mat(
          (diff f_colorMath(1, #red)) / (diff x_colorMath(1, #red)), dots, (diff f_colorMath(1, #red)) / (diff x_colorMath(n, #red));
          dots.v, dots.down, dots.v;
          (diff f_colorMath(m, #red)) / (diff x_colorMath(1, #red)), dots, (diff f_colorMath(m, #red)) / (diff x_colorMath(n, #red));
        )
      $
    ], [],
    [], [], [], [], [],

    [*Hessian*\ ($n times n$)], 
    [
      $f: RR^n arrow RR$\ 
      Multiple Input\ 
      One Output\ 
      Scalar Function
    ], [*Second*\ Order], [
      $
        H_f (bold("x")) = mat(
          (diff^2 f) / (diff x_1^2), dots, (diff^2 f) / (diff x_1 diff x_n);
          dots.v, dots.down, dots.v;
          (diff^2 f) / (diff x_n diff x_1), dots, (diff^2 f) / (diff x_n^2);
        )
      $
    ], [],
    [*Laplacian*], [], [], [
      $
        tr(H_f (bold("x"))) = sum_(i=1)^n (diff^2 f) / (diff x_colorMath(i, #red)^2) (x)
      $
    ], [
      $
        H_f (bold("x")) = mat(
          colorMath((diff^2 f) / (diff x_1^2), #red), dots, (diff^2 f) / (diff x_1 diff x_n);
          dots.v, colorMath(dots.down, #red), dots.v;
          (diff^2 f) / (diff x_n diff x_1), dots, colorMath((diff^2 f) / (diff x_n^2), #red);
        )
      $
    ],
  )
}

#table(
  columns: (auto, auto, auto),
  inset: 1em,
  align: horizon,
  [*Gradient*], [$1^"st"$ derivative], [$n times 1$],
  [*Hessian*], [$2^"nd"$ derivative], [$n times n$],
  [*$3^"rd"$ Order Tensor*], [$3^"rd"$ derivative], [$n times n times n$],
  table.cell(colspan: 3, align: center, [$dots.v$]),
  [*$k$-th Order Tensor*], [$k^"th"$ derivative], [$n times n times dots times n quad (k "times")$],
)
