#import "/lib/imports.typ": *
#show: formatting

A mixture is what you get when you randomly pick one of several distributions and then draw from it. You're not combining the random variables — you're choosing between them.

$
  f(x) = sum_i w_i f_i (x) quad quad w_i gt.eq 0, sum_i w_i = 1
$

- Flip a biased coin: with probability $w_1$, pick component 1, with probability $w_2 = 1 - w_1$ pick component 2.
- Draw your value from whichever component the coin selected.

#example[
  $
    f(x) = 0.7 dot cal(N)(x; 0, 1) + 0.3 dot cal(N)(x; 5, 1)
  $

#let w1 = 0.7
#let w2 = 0.3

#let mix(x) = w1 * norm.pdf(x, mean: 0, std_dev: 1) + w2 * norm.pdf(x, mean: 5, std_dev: 1)

#let x = lq.linspace(-4, 10, num: 1000)

#lq.diagram(
  lq.plot(x, x => w1 * norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: blue),  // 0.7·𝒩(0,1)
  lq.plot(x, x => w2 * norm.pdf(x, mean: 5, std_dev: 1), mark: none, stroke: blue),  // 0.3·𝒩(5,1)
  lq.fill-between(x, mix, fill: red.transparentize(75%)),
  lq.plot(x, mix, mark: none, stroke: black),                                        // the mixture f
)

$
  f(x) = 0.6 dot cal(N)(0,1) + 0.4 dot cal(N) (3,1)
$

#let w1 = 0.6
#let w2 = 0.4
#let mix(x) = w1 * norm.pdf(x, mean: 0, std_dev: 1) + w2 * norm.pdf(x, mean: 3, std_dev: 1)
#let x = lq.linspace(-4, 7, num: 1000)
#lq.diagram(
  ylim: (0, auto),
  lq.plot(x, x => w1 * norm.pdf(x, mean: 0, std_dev: 1), mark: none, stroke: blue),  // 0.6·𝒩(0,1)
  lq.plot(x, x => w2 * norm.pdf(x, mean: 3, std_dev: 1), mark: none, stroke: blue),  // 0.4·𝒩(3,1)
  lq.fill-between(x, mix, fill: red.transparentize(75%)),
  lq.plot(x, mix, mark: none, stroke: black),                                        // the mixture f
)

$
  f(x) =  0.5 dot cal(N) (2,0.6) + 0.5 dot cal(N) (2,3)
$

#let w1 = 0.5
#let w2 = 0.5
#let mix(x) = w1 * norm.pdf(x, mean: 2, std_dev: 0.6) + w2 * norm.pdf(x, mean: 2, std_dev: 3)
#let x = lq.linspace(-7, 11, num: 1000)
#lq.diagram(
  ylim: (0, auto),
  lq.plot(x, x => w1 * norm.pdf(x, mean: 2, std_dev: 0.6), mark: none, stroke: blue),  // 0.5·𝒩(2,0.6) — sharp spike
  lq.plot(x, x => w2 * norm.pdf(x, mean: 2, std_dev: 3),   mark: none, stroke: blue),  // 0.5·𝒩(2,3)   — broad base
  lq.fill-between(x, mix, fill: red.transparentize(75%)),
  lq.plot(x, mix, mark: none, stroke: black),                                          // the mixture f
)

]

