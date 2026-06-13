#import "/lib/imports.typ": *
#show: formatting

$
  f(x) = 1 / sqrt(2 pi sigma^2) exp(- (x - mu)^2 / (2 sigma^2))
$

We want $f'(x) = dif / (dif x) f(x)$

- $mu$, $sigma$: constants
- $x$: variable

Step 1. Structure

Two factors:

$
  f(x) = underbrace(1 / sqrt(2 pi sigma^2), "constant") dot underbrace(exp(- (x - mu)^2 / (2 sigma^2)), "function of" x)
$

First factor is a constant (does not depend on $x$):

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2))
$

Step 2: Set up the chain rule

$
  u(x) = - (x - mu)^2 / (2 sigma^2)
$

Then

$
  exp(- (x - mu)^2 / (2 sigma^2)) = exp(u(x))
$

The chain rule:

$
  dif / (dif x) exp(u(x)) = exp(u(x)) dot u'(x)
$

We need 2 things:
- $exp(u(x)) = exp(u(x))$
- $u'(x)$

Step 3. Differentiate $u(x)$

$
  u(x) = - (x - mu)^2 / (2 sigma^2)
$

3.a. Pull out constant

$
  u(x) = - 1 / (2 sigma^2) dot (x - mu)^2
$

The factor $- 1 / 2 sigma^2$ depends only on $sigma$, not $x$. Constants pull out of derivatives:

$
  u'(x) = - 1 / (2 sigma^2) dot dif / (dif x) (x - mu)^2
$

Now we need $dif / (dif x) (x - mu)^2$

3.b. Apply chain rule again to $(x - mu)^2$

This is itself a composition:
- Outer function: $v^2$ where $v = x - mu$
- Inner function: $v(x) = x - mu$

Chain rule:

$
  dif / (dif x) (x - mu)^2 = dif / (dif v) (v^2) dot (dif v) / (dif x)
$

Outer derivative:

$
  dif / (dif v) (v^2) = 2 v = 2 (x - mu)
$

Inner derivative: $v(x) = x - mu$

Since $mu$ is a constant, $(dif u) / (dif x) = 0$. So:

$
  (dif v) / (dif x) = dif / (dif x) (x - mu) = dif / (dif x) (x) - dif / (dif x) (mu) = 1 - 0 = 1
$

Combine:

$
  dif / (dif x) (x - mu)^2 = 2 (x - mu) dot 1 = 2 (x - mu)
$

3.c. Put Step 3 together

Substitute back into expression for $u'(x)$

$
  u'(x) = - 1 / (2 sigma^2) dot (x - mu)
$

Simplify be canceling the 2's:

$
  u'(x) = - (2 (x - mu) / (2 sigma^2)) = - (x - mu) / sigma^2
$

So:

$
  u'(x) = - (x - mu) / sigma^2
$

Step 4. Apply chain tule from Step 2

We had:

$
  dif / (dif x) exp(u(x)) = exp(u(x)) dot u'(x)
$

Plug in:
- $exp(u(x)) = exp(- (x - mu)^2 / (2 sigma^2))$
- $u'(x) = - (x - mu) / sigma^2$

So:

$
  dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2)) = exp(- (x - mu)^2 / (2 sigma^2)) dot (- (x - mu) / sigma^2)
$

Move the factor to the front for clarity:

$
  - (x - mu) / sigma^2 dot exp(- (x - mu)^2 / (2 sigma^2))
$

Step 5. Putting everything together

Recall from Step 1:

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot dif / (dif x) exp(- (x - mu)^2 / (2 sigma^2))
$

Substitute what we found:

$
  f'(x) = 1 / sqrt(2 pi sigma^2) dot [- (x - mu) / sigma^2 dot exp(- (x - mu)^2 / (2 sigma^2))]
$

Pull the $- (x - mu) / sigma^2$ out front:

$
  f'(x) = - (x - mu) / sigma^2 dot 1 / sqrt(2 pi sigma^2) dot exp(- (x - mu)^2 / (2 sigma^2))
$

Step 6. Recognize $f(x)$ on the right side

Look at the last two factors

$
  1 / sqrt(2 pi sigma^2) dot exp(- (x - mu)^2 / (2 sigma^2)) = f(x)
$

That's exactly the original PDF. So:

$
  f'(x) = - (x - mu) / sigma^2 dot f(x)
$

Step 7. Standard Normal

Does this collapse to $phi.alt'(z)$ when $mu = 0$ and $sigma = 1$?

Plug in $mu = 0$, $sigma = 1$:

$
  f'(x) = - (x - 0) / 1^2 dot f(x) = - x dot f(x)
$

With $mu = 0$ and $sigma = 1$, $f(x)$ becomes $phi.alt(x)$, so:

$
  phi.alt(x) = -x dot phi.alt(x)
$

#table(
  columns: 2,
  inset: 1em,
  [Distribution], [Derivative],
  [General Normal $f(x)$], [
    $
      f'(x) = - (x - mu) / sigma^2 dot f(x)
    $
  ],
  [Standard Normal $phi.alt(x)$], [
    $
      phi.alt'(z) = -z dot phi.alt(z)
    $
  ],
)

