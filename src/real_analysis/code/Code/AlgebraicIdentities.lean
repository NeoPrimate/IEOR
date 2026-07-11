import Mathlib

-- ── Commutativity ──────────────────────────────────────────────────────────

-- a + b = b + a
example
  (a b : ℕ) :
  a + b = b + a := by
  rw [add_comm]

example
  (a b : ℕ) :
  a + b = b + a :=
  add_comm a b

-- a * b = b * a
example
  (a b : ℕ) :
  a * b = b * a := by
  rw [mul_comm]

example
  (a b : ℕ) :
  a * b = b * a :=
  mul_comm a b

-- ── Associativity ──────────────────────────────────────────────────────────

-- (a + b) + c = a + (b + c)
example
  (a b c : ℕ) :
  a + b + c = a + (b + c) := by
  rw [add_assoc]

example
  (a b c : ℕ) :
  a + b + c = a + (b + c) :=
  add_assoc a b c

-- (a * b) * c = a * (b * c)
example
  (a b c : ℕ) :
  a * b * c = a * (b * c) := by
  rw [mul_assoc]

example
  (a b c : ℕ) :
  a * b * c = a * (b * c) :=
  mul_assoc a b c

-- ── Distributivity ─────────────────────────────────────────────────────────

-- a * (b + c) = a * b + a * c
example
  (a b c : ℕ) :
  a * (b + c) = a * b + a * c := by
  rw [mul_add]

example
  (a b c : ℕ) :
  a * (b + c) = a * b + a * c :=
  mul_add a b c

-- (a + b) * c = a * c + b * c
example
  (a b c : ℕ) :
  (a + b) * c = a * c + b * c := by
  rw [add_mul]

example
  (a b c : ℕ) :
  (a + b) * c = a * c + b * c :=
  add_mul a b c

-- ── Identity elements ───────────────────────────────────────────────────────

example
  (a : ℕ) : a + 0 = a := by
  rw [add_zero]

example
  (a : ℕ) : a + 0 = a :=
  add_zero a

example
  (a : ℕ) : 0 + a = a := by
  rw [zero_add]

example
  (a : ℕ) : 0 + a = a :=
  zero_add a

example
  (a : ℕ) : a * 1 = a := by
  rw [mul_one]

example
  (a : ℕ) : a * 1 = a :=
  mul_one a

example
  (a : ℕ) : 1 * a = a := by
  rw [one_mul]

example
  (a : ℕ) : 1 * a = a :=
  one_mul a

example
  (a : ℕ) : a * 0 = 0 := by
  rw [mul_zero]

example
  (a : ℕ) : a * 0 = 0 :=
  mul_zero a

example
  (a : ℕ) : 0 * a = 0 := by
  rw [zero_mul]

example
  (a : ℕ) : 0 * a = 0 :=
  zero_mul a

-- ── Inverses & subtraction ──────────────────────────────────────────────────
-- ℕ has no negation; use ℤ for additive inverses, ℝ for multiplicative

-- a + (-a) = 0
example
  (a : ℤ) :
  a + -a = 0 :=
  add_neg_cancel a

example
  (a : ℤ) :
  a + -a = 0 := by
  rw [add_neg_cancel]

-- (-a) + a = 0
example
  (a : ℤ) :
  -a + a = 0 :=
  neg_add_cancel a

example
  (a : ℤ) :
  -a + a = 0 := by
  rw [neg_add_cancel]

-- a * a⁻¹ = 1  (a ≠ 0)
example
  (a : ℝ)
  (ha : a ≠ 0) :
  a * a⁻¹ = 1 :=
  mul_inv_cancel₀ ha

example
  (a : ℝ)
  (ha : a ≠ 0) :
  a * a⁻¹ = 1 := by
  rw [mul_inv_cancel₀ ha]

-- a - b = a + (-b)
example
  (a b : ℤ) :
  a - b = a + -b :=
  sub_eq_add_neg a b

example
  (a b : ℤ) :
  a - b = a + -b := by
  rw [sub_eq_add_neg]

-- a - a = 0
example
  (a : ℤ) :
  a - a = 0 :=
  sub_self a

example
  (a : ℤ) :
  a - a = 0 := by
  rw [sub_self]

-- ── Exponent rules ──────────────────────────────────────────────────────────

-- a^(m+n) = a^m * a^n
example
  (a : ℕ)
  (m n : ℕ) :
  a ^ (m + n) = a ^ m * a ^ n := by
  rw [pow_add]

example
  (a : ℕ)
  (m n : ℕ) :
  a ^ (m + n) = a ^ m * a ^ n :=
  pow_add a m n

-- (a^m)^n = a^(m*n)
example
  (a : ℕ)
  (m n : ℕ) :
  (a ^ m) ^ n = a ^ (m * n) := by
  rw [pow_mul]

example
  (a : ℕ)
  (m n : ℕ) :
  a ^ (m * n) = (a ^ m) ^ n :=
  pow_mul a m n

example
  (a : ℕ)
  (m n : ℕ) :
  (a ^ m) ^ n  = a ^ (m * n) :=
  (pow_mul a m n).symm

-- (a * b)^n = a^n * b^n
example
  (a b n : ℕ) :
  (a * b) ^ n = a ^ n * b ^ n := by
  rw [mul_pow]

example
  (a b n : ℕ) :
  (a * b) ^ n = a ^ n * b ^ n :=
  mul_pow a b n

example
  (a b n : ℕ) :
  a ^ n * b ^ n = (a * b) ^ n :=
  (mul_pow a b n).symm

-- a^0 = 1
example
  (a : ℕ) :
  a ^ 0 = 1 :=
  pow_zero a

example
  (a : ℕ) :
  a ^ 0 = 1 := by
  rw [pow_zero]

-- a^1 = a
example
  (a : ℕ) :
  a ^ 1 = a :=
  pow_one a

example
  (a : ℕ) :
  a ^ 1 = a := by
  rw [pow_one]

-- a^(-n) = (a^n)⁻¹  — needs ℤ exponents and a division ring
example
  (a : ℝ)
  (n : ℤ) :
  a ^ (-n) = (a ^ n)⁻¹ :=
  zpow_neg a n

example
  (a : ℝ)
  (n : ℤ) :
  a ^ (-n) = (a ^ n)⁻¹ := by
  rw [zpow_neg]

-- ── Binomial identities ─────────────────────────────────────────────────────
-- ℕ has no subtraction; use ℝ

-- (a + b)² = a² + 2ab + b²
example
  (a b : ℝ) :
  (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 :=
  add_sq a b

example
  (a b : ℝ) :
  (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by
  rw [add_sq]

-- (a - b)² = a² - 2ab + b²
example
  (a b : ℝ) :
  (a - b) ^ 2 = a ^ 2 - 2 * a * b + b ^ 2 :=
  sub_sq a b

example
  (a b : ℝ) :
  (a - b) ^ 2 = a ^ 2 - 2 * a * b + b ^ 2 := by
  rw [sub_sq]

-- (a + b)³ = a³ + 3a²b + 3ab² + b³
example
  (a b : ℝ) :
  (a + b) ^ 3 = a ^ 3 + 3 * a ^ 2 * b + 3 * a * b ^ 2 + b ^ 3 := by
  ring

-- (a - b)³ = a³ - 3a²b + 3ab² - b³
example
  (a b : ℝ) :
  (a - b) ^ 3 = a ^ 3 - 3 * a ^ 2 * b + 3 * a * b ^ 2 - b ^ 3 := by
  ring

-- ── Difference of powers ────────────────────────────────────────────────────

-- a² - b² = (a + b)(a - b)
example
  (a b : ℝ) :
  a ^ 2 - b ^ 2 = (a + b) * (a - b) :=
  sq_sub_sq a b

example
  (a b : ℝ) :
  a ^ 2 - b ^ 2 = (a + b) * (a - b) := by
  rw [sq_sub_sq]

-- a³ - b³ = (a - b)(a² + ab + b²)
example
  (a b : ℝ) :
  a ^ 3 - b ^ 3 = (a - b) * (a ^ 2 + a * b + b ^ 2) := by
  ring

-- a³ + b³ = (a + b)(a² - ab + b²)
example
  (a b : ℝ) :
  a ^ 3 + b ^ 3 = (a + b) * (a ^ 2 - a * b + b ^ 2) := by
  ring

-- ── Fraction rules ──────────────────────────────────────────────────────────

-- (a/b) * (c/d) = (a*c)/(b*d)
example
  (a b c d : ℝ) :
  a / b * (c / d) = a * c / (b * d) := by
  rw [div_mul_div_comm]

example
  (a b c d : ℝ) :
  a / b * (c / d) = a * c / (b * d) :=
  div_mul_div_comm a b c d

-- (a + c) / b = a/b + c/b
example
  (a b c : ℝ) :
  (a + c) / b = a / b + c / b :=
  add_div a c b

example
  (a b c : ℝ) :
  (a + c) / b = a / b + c / b := by
  rw [add_div]

-- a/b + c/d = (a*d + b*c) / (b*d)
example
  (a b c d : ℝ)
  (hb : b ≠ 0)
  (hd : d ≠ 0) :
  a / b + c / d = (a * d + b * c) / (b * d) :=
  div_add_div a c hb hd

example
  (a b c d : ℝ)
  (hb : b ≠ 0)
  (hd : d ≠ 0) :
  a / b + c / d = (a * d + b * c) / (b * d) := by
  rw [div_add_div a c hb hd]

-- (a/b) / (c/d) = (a*d) / (b*c)
example
  (a b c d : ℝ)
  (hb : b ≠ 0)
  (hc : c ≠ 0)
  (hd : d ≠ 0) :
  a / b / (c / d) = a * d / (b * c) := by
  field_simp

-- ── Absolute value ──────────────────────────────────────────────────────────

-- |a * b| = |a| * |b|
example
  (a b : ℝ) :
  |a * b| = |a| * |b| :=
  abs_mul a b

example
  (a b : ℝ) :
  |a * b| = |a| * |b| := by
  rw [abs_mul]

-- |a + b| ≤ |a| + |b|
example
  (a b : ℝ) :
  |a + b| ≤ |a| + |b| :=
  abs_add_le a b

-- 0 ≤ |a|   (Lean's form of |a| ≥ 0)
example
  (a : ℝ) :
  0 ≤ |a| :=
  abs_nonneg a

-- |-a| = |a|
example
  (a : ℝ) :
  |-a| = |a| :=
  abs_neg a

example
  (a : ℝ) :
  |-a| = |a| := by
  rw [abs_neg]

-- ── Logarithm rules ─────────────────────────────────────────────────────────
-- Real.log is the natural logarithm
-- Real.logb b is log base b

-- log(a * b) = log a + log b
example
  (a b : ℝ)
  (ha : a ≠ 0)
  (hb : b ≠ 0) :
  Real.log (a * b) = Real.log a + Real.log b :=
  Real.log_mul ha hb

example
  (a b : ℝ)
  (ha : a ≠ 0)
  (hb : b ≠ 0) :
  Real.log (a * b) = Real.log a + Real.log b := by
  rw [Real.log_mul ha hb]

-- log(a / b) = log a - log b
example
  (a b : ℝ)
  (ha : a ≠ 0)
  (hb : b ≠ 0) :
  Real.log (a / b) = Real.log a - Real.log b :=
  Real.log_div ha hb

example
  (a b : ℝ)
  (ha : a ≠ 0)
  (hb : b ≠ 0) :
  Real.log (a / b) = Real.log a - Real.log b := by
  rw [Real.log_div ha hb]

example
  (a b : ℝ)
  (ha : a ≠ 0)
  (hb : b ≠ 0) :
  Real.log (a / b) = Real.log a - Real.log b :=
  Real.log_div ha hb

example
  (a b : ℝ)
  (ha : a ≠ 0)
  (hb : b ≠ 0) :
  Real.log (a / b) = Real.log a - Real.log b := by
  rw [Real.log_div ha hb]

-- log(a^n) = n * log a
example
  (a : ℝ)
  (n : ℕ) :
  Real.log (a ^ n) = n * Real.log a :=
  Real.log_pow a n

example
  (a : ℝ)
  (n : ℕ) :
  Real.log (a ^ n) = n * Real.log a := by
  rw [Real.log_pow a n]

-- log 1 = 0
example :
  Real.log 1 = 0 :=
  Real.log_one

example :
  Real.log 1 = 0 := by
  rw [Real.log_one]

-- log(exp x) = x
example
  (x : ℝ) :
  Real.log (Real.exp x) = x :=
  Real.log_exp x

example
  (x : ℝ) :
  Real.log (Real.exp x) = x := by
  rw [Real.log_exp x]

-- logb b b = 1  (log base b of b)
example
  (b : ℝ)
  (hb : 1 < b) :
  Real.logb b b = 1 :=
  Real.logb_self_eq_one hb

example
  (b : ℝ)
  (hb : 1 < b) :
  Real.logb b b = 1 := by
  rw [Real.logb_self_eq_one hb]

-- logb b 1 = 0  (log base b of 1)
example
  (b : ℝ) :
  Real.logb b 1 = 0 :=
  Real.logb_one

example
  (b : ℝ) :
  Real.logb b 1 = 0 := by
  rw [Real.logb_one]
