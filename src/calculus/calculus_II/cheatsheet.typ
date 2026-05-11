#import "/lib/imports.typ": *

#set math.mat(gap: 0.75em)
#set math.vec(gap: 1em)


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
    columns: range(4).map(_ => auto),
    inset: 1.5em,
    align: horizon,

    [], [*Input/Output*], [*Derivatives*], [*Notation*],
    [*Gradient*\ (Derivative)\ ($1 times 1$)],
    [
      $f: RR arrow RR$\
      One Input\
      *One Output*\
      Scalar Function
    ], [*First*\ Order], [
      $
        gradient f(x) = f'(x) = vec((partial f) / (partial x))
      $
    ],

    [*Jacobian*\ ($m times 1$)],
    [
      $f: RR arrow RR^m$\
      One Input\
      *Multiple Output*\
      Vector Function
    ], [*First*\ Order], [
      $
        J_f (x) = vec(
          (partial f_colorMath(1, #red)) / (partial x),
          (partial f_colorMath(2, #red)) / (partial x),
          dots.v,
          (partial f_colorMath(m, #red)) / (partial x),
        )
      $
    ],
    [*Gradient*\ ($n times 1$)],
    [
      $f: RR^n arrow RR$\
      Multiple Input\
      *One Output*\
      Scalar Function
    ], [*First*\ Order], [
      $
        gradient f(bold("x")) = vec(
          (partial f) / (partial x_colorMath(1, #red)),
          (partial f) / (partial x_colorMath(2, #red)),
          dots.v,
          (partial f) / (partial x_colorMath(n, #red)),
        )
      $
    ],
    [*Jacobian*\ ($m times n$)],
    [
      $f: RR^n arrow RR^m$\
      Multiple Input\
      *Multiple Output*\
      Vector Function
    ], [*First*\ Order], [
      $
        J_f (bold("x"))
        &= vec(
          gradient g_1 (x)^T,
          gradient g_2 (x)^T,
          dots.v,
          gradient g_m (x)^T,
        )\

        &= mat(
          (partial f_colorMath(1, #red)) / (partial x_colorMath(1, #red)), dots, (partial f_colorMath(1, #red)) / (partial x_colorMath(n, #red));
          dots.v, dots.down, dots.v;
          (partial f_colorMath(m, #red)) / (partial x_colorMath(1, #red)), dots, (partial f_colorMath(m, #red)) / (partial x_colorMath(n, #red));
        ) \
      $
    ],

    [*Hessian*\ ($n times n$)],
    [
      $f: RR^n arrow RR$\
      Multiple Input\
      One Output\
      Scalar Function
    ], [*Second*\ Order], [
      $
        gradient^2 f(bold("x")) = H_f (bold("x")) = mat(
          (partial^2 f) / (partial x_1^2), dots, (partial^2 f) / (partial x_1 partial x_n);
          dots.v, dots.down, dots.v;
          (partial^2 f) / (partial x_n partial x_1), dots, (partial^2 f) / (partial x_n^2);
        )
      $
    ],
    [*Laplacian*], [Trace of the Hessian\ (sum of diagonal entries)], [], [
      $
        tr(H_f (bold("x"))) = sum_(i=1)^n (partial^2 f) / (partial x_colorMath(i, #red)^2) (x)
      $

      $
        H_f (bold("x")) = mat(
          colorMath((partial^2 f) / (partial x_1^2), #red), dots, (partial^2 f) / (partial x_1 partial x_n);
          dots.v, colorMath(dots.down, #red), dots.v;
          (partial^2 f) / (partial x_n partial x_1), dots, colorMath((partial^2 f) / (partial x_n^2), #red);
        )
      $
    ],
    [], [], [], [],
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
