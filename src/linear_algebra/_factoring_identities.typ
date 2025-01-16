#import "../../../utils/code.typ": code
#import "../../../utils/examples.typ": eg

== Factorization

1. Common Factor

$
a x + a y = a (x + y)
$

2. Difference of Squares

$
a^2 - b^2 = (a - b)(a + b)
$

3. Perfect Square Trinomial

- Positive

$
a^2 + 2 a b + b^2
$

- Negative

$
a^2 - 2 a b + b^2 = (a - b)^2
$

4. Sum of Cubes

$
a^3 + b^3 = (a + b)(a^2 - 2 a b + b^2)
$

5. Difference of Cubes

$
a^3 - b^3 = (a - b)(a^2 + 2 a b + b^2)
$

6. Quadratic Trinomial (Factoring $a x^2 + b x + c$)

Find two numbers that multiply to $a dot c$ and add to $b$

$
6 x^2 + 7 x + 2 = (3 x + 2)(2 x + 1)
$

7. Grouping

Group terms to find common factors within smaller groups

$
a x + a y + b x + b y = a (x + y) + b (x + y) = (a + b)(x + y)
$

8. Factor by Substitution

If an expression resembles a quadratic, substitute to simplify

$
x^4 + 6 x^2 + 9 = (x^2 + 3)^2
$

9. Prime Factorization (Numbers)

Break down a number into its prime factors

$
60 = s^2 dot 3 dot 5
$

10. Factorizing Quadratics using the AC Method

Multiply $a$ and $c$, and factor based on this product

$
2x^2 + 5x + 3 = (2x + 3)(x + 1)
$

11. Factoring Special Polynomials

Recognizing patterns like sum/difference of powers or higher-degree polynomials

$
x^4 - 16 = (x^2 - 4)(x^2 + 4) = (x - 2)(x + 2)(x^2 + 4)
$



// 1. Powers

// - Sum

// $
// a^n + b^n = (a + b)(a^(n-1) - a^(n-2) b + dots + (-1)^(n-1) b^(n-1))
// $

// #eg[
//   $
//   a^2 + b^2 &= (a + b)(a + b) \
//   a^3 + b^3 &= (a + b)(a^2 - 2 a b + b^2) \
//   a^4 + b^4 &= (a + b)(a^3 - a^2 b + a b^2 - b^3) \
//   a^5 + b^5 &= (a + b)(a^4 - a^3 b + a^2 b^2 - a b^3 + b^4) \
//   $
// ]

// - Difference

// $
// a^n - b^n = (a - b)(a^(n-1) + a^(n-2) b + dots + + a b^(n-2) + b^(n-1))
// $

// #eg[
//   $
//   a^2 - b^2 &= (a - b)(a + b) \
//   a^3 - b^3 &= (a - b)(a^2 + a b + b^2) \
//   a^4 - b^4 &= (a - b)(a^3 + a^2 b + a b^2 + b^3) \
//   a^5 - b^5 &= (a - b)(a^4 + a^3 b + a^2 b^2 + a b^3 + b^4) \
//   $
// ]

// 2. Binomial Expansion

// - Power of Sum

// $
// (a + b)^n = sum_(k=0)^n vec(n, k) a^(n-k) b^k
// $

// Where:

// - $vec(n, k) = n! / (k! (n - k)!)$ binomial coefficient
// - $a^(n-k)$: increasing power of $a$
// - $b^k$: decreasing the power of $b$

// #eg[
//   $
//   (a + b)^2 &= a^2 + 2 a b + b^2 \
//   (a + b)^3 &= a^3 + 3 a^2 b + 3 a b^2 + b^3 \
//   (a + b)^4 &= a^4 + 4 a^3 b + 6 a^2 b^2 + 4 a b^3 + b^4 \
//   (a + b)^5 &= a^5 + 5 a^4 b + 10 a^3 b^2 + 10 a^2 b^3 + 5 a b^4 + b^5 \
//   $
// ]

// - $(a + b)^2$: 1, 2, 1
// - $(a + b)^3$: 1, 3, 3, 1
// - $(a + b)^4$: 1, 4, 6, 4, 1
// - $(a + b)^5$: 1, 5, 10, 10, 5, 1

// - Power of Difference

// $
// (a - b)^n = sum_(k=0)^n vec(n, k) a^(n-k) (-b)^k
// $

// Where:

// - $vec(n, k) = n! / (k! (n - k)!)$ binomial coefficient
// - $a^(n-k)$: increasing power of $a$
// - $b^k$: decreasing the power of $b$

// #eg[
//   $
//   (a - b)^2 &= a^2 - 2 a b + b^2 \
//   (a - b)^3 &= a^3 - 3 a^2 b + 3 a b^2 - b^3 \
//   (a - b)^4 &= a^4 - 4 a^3 b + 6 a^2 b^2 - 4 a b^3 + b^4 \
//   (a - b)^5 &= a^5 - 5 a^4 b + 10 a^3 b^2 - 10 a^2 b^3 + 5 a b^4 - b^5 \
//   $
// ]

// - $(a + b)^2$: 1, -2, 1
// - $(a + b)^3$: 1, -3, 3, -1
// - $(a + b)^4$: 1, -4, 6, -4, 1
// - $(a + b)^5$: 1, -5, 10, -10, 5, -1


// 4. Factoring by Grouping

// $
// a x + a y + b x + b y = (a + b)(x + y)
// $

// #eg[
//   $
//   x^3 + 3x^2 + 2x + 6 = (x^2 + 2)(x + 3)
//   $
// ]

// 5. General Quadratic Trinomial

// $
// a x^2 + b x + c = (m x + n)(p x + q)
// $

// #eg[
//   $
//   x^2 + 5x + 6 = (x + 2)(x + 3)
//   $
// ]

