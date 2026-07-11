import Mathlib

-- Succ

example :
  (4 : ℕ) =
  Nat.succ (Nat.succ (Nat.succ (Nat.succ 0))) :=
  rfl


-- Natural Numbers

theorem rfl_1
  (x q : ℕ) :
  37 * x + q = 37 * x + q :=
  rfl

theorem rw_1
  (x y : ℕ)
  (h : y = x + 7) :
  2 * y = 2 * (x + 7) := by
  rw [h]

example :
  2 = Nat.succ (Nat.succ 0) :=
  rfl

example
  (a b c : ℕ) :
  a + (b + 0) + (c + 0) = a + b + c := by
  rfl

example
  (a b c : ℕ) :
  a + (b + 0) + (c + 0) = a + b + c := by
  rw [
    add_zero,
    add_zero
  ]

example
  (a b c : ℕ) :
  a + (b + 0) + (c + 0) = a + b + c := by
  rw [
    add_zero c,
    add_zero b
  ]

example
  (n : Nat) :
  0 + n = n := by
  induction n with
    | zero => rfl
    | succ k ih =>
      rw [
        Nat.add_succ,
        ih
      ]

example :
  2 + 2 = 4 := by
  rfl

-- Addition (+)

example
  (n : ℕ) :
  n + 0 = n := by
  induction n with
    | zero => rfl
    | succ k ih =>
      rw [
        Nat.add_succ,
        ih
      ]

example
  (a b : ℕ) :
  Nat.succ a + b = Nat.succ (a + b) := by
  rw [Nat.succ_add]

example
  (a b : ℕ) :
  a + b = b + a := by
  induction b with
    | zero =>
      rw [
        Nat.add_zero,
        Nat.zero_add
      ]
    | succ k ih =>
      rw [
        Nat.add_succ,
        Nat.succ_add,
        ih
      ]

example
  (a b c : ℕ) :
  a + b + c = a + (b + c) := by
  induction a with
    | zero =>
      rw [
        Nat.zero_add,
        Nat.zero_add
      ]
    | succ k ih =>
      rw [
        Nat.succ_add,
        Nat.succ_add,
        Nat.succ_add,
        ih
      ]

example
  (a b c : ℕ) :
  a + b + c = a + (b + c) := by
  induction c with
    | zero => rfl
    | succ d hd =>
      rw [
        Nat.add_succ,
        Nat.add_succ,
        Nat.add_succ,
        hd
      ]

example
  (a b c : ℕ) :
  a + b + c = a + c + b := by
  rw [
    Nat.add_assoc,
    Nat.add_assoc,
    Nat.add_comm b c,
  ]

-- Advanced Addition

example
  (a b n : ℕ) :
  a + n = b + n → a = b :=
  fun (eq : a + n = b + n) ↦ Nat.add_right_cancel eq

example
  (a b n : ℕ) :
  a + n = b + n → a = b := by
  intro h
  induction n with
    | zero =>
      rw [
        Nat.add_zero,
        Nat.add_zero,
      ] at h
      exact h
    | succ k ih =>
      rw [
        Nat.add_one,
        Nat.add_succ,
        Nat.add_succ,
        Nat.succ_inj
      ] at h
      exact ih h

-- Multiplication

example
  (m : ℕ) :
  m * 1 = m := by
  rw [Nat.mul_one]

example
  (m : ℕ) :
  0 * m = 0 := by
  rw [Nat.zero_mul]

example
  (a b : ℕ) :
  Nat.succ a * b = a * b + b := by
  rw [Nat.succ_mul]

example
  (a b : ℕ) :
  a * b = b * a := by
  rw [Nat.mul_comm]

example
  (m : ℕ) :
  1 * m = m := by
  rw [Nat.one_mul]

example
  (m : ℕ) :
  2 * m = m + m := by
  rw [Nat.two_mul]

example
  (a b c : ℕ) :
  a * (b + c) = a * b + a * c := by
  rw [Nat.mul_add]

example
  (a b c : ℕ) :
  (a + b) * c = a * c + b * c := by
  rw [Nat.add_mul]

example
  (a b c : ℕ) :
  a * b * c = a * (b * c) := by
  rw [Nat.mul_assoc]

-- Implication (→)

example
  (x y : ℕ)
  (h : 0 + x = 0 + y + 2) :
  x = y + 2 := by
  rw [
    Nat.zero_add,
    Nat.zero_add
  ] at h
  exact h

example
  (x y : ℕ)
  (h1 : x = 37)
  (h2 : x = 37 → y = 42) :
  y = 42 := by
  apply h2 at h1
  exact h1

example
  (x : ℕ)
  (h : x + 1 = 4) :
  x = 3 := by
  rw [← Nat.succ_eq_add_one] at h
  change Nat.succ x = Nat.succ 3 at h
  apply Nat.succ.inj at h
  exact h

example
  (x : ℕ)
  (h : x + 1 = 4) :
  x = 3 := by
  apply Nat.succ.inj at h
  exact h

example
  (x : ℕ) :
  x = 37 → x = 37 := by
  intro h
  exact h

example
  (x y : ℕ) :
  x + 1 = y + 1 → x = y := by
  intro h
  repeat rw [← Nat.succ_eq_add_one] at h
  apply Nat.succ.inj
  exact h

example
  (x y : ℕ)
  (h1 : x = y)
  (h2 : x ≠ y) :
  False := by
  apply h2
  exact h1

example :
  0 ≠ 1 := by
  intro h
  exact Nat.zero_ne_one h

example :
  1 ≠ 0 := by
  intro h
  exact Nat.one_ne_zero h

example :
  2 + 2 ≠ 5 := by
  decide

example :
  2 + 2 ≠ 5 := by
  omega

example : 2 + 2 ≠ 5 := by
  intro h
  rw [Nat.add_succ, Nat.add_succ, Nat.add_zero] at h
  repeat apply Nat.succ.inj at h
  exact Nat.succ_ne_zero 0 h.symm

-- Power

example :
  0 ^ 0 = 1 := by
  rw [Nat.pow_zero]

example
  (m : ℕ) :
  0 ^ Nat.succ m = 0 := by
  rw [Nat.pow_succ, Nat.mul_zero]

example
  (a : ℕ) :
  a ^ 1 = a := by
  change a ^ Nat.succ 0 = a
  rw [
    Nat.pow_succ,
    Nat.pow_zero,
    Nat.one_mul
  ]

example :
  1 ^ m = 1 := by
  induction m with
    | zero => rw [Nat.pow_zero]
    | succ k ih =>
      rw [
        Nat.pow_succ,
        Nat.one_pow,
        Nat.one_mul,
      ]

example
  (a : ℕ) :
  a ^ 2 = a * a := by
  change a ^ Nat.succ (Nat.succ 0) = a * a
  rw [
    Nat.pow_succ,
    Nat.pow_one
  ]

example
  (a m n : ℕ) :
  a ^ (m + n) = a ^ m * a ^ n := by
  induction m with
    | zero => rw [
      Nat.zero_add,
      Nat.pow_zero,
      Nat.one_mul,
    ]
    | succ k ih => rw [
      Nat.succ_add,
      Nat.pow_succ,
      ih,
      Nat.pow_succ,
      Nat.mul_assoc,
      Nat.mul_comm (a ^ n) a,
      ← mul_assoc,
    ]

example
  (a b n: ℕ) :
  (a * b) ^ n = a ^ n * b ^ n := by
  induction n with
    | zero => rw [
      Nat.pow_zero,
      Nat.pow_zero,
      Nat.pow_zero,
      Nat.mul_one,
    ]
    | succ k ih => rw [
      Nat.pow_succ,
      Nat.pow_succ,
      Nat.pow_succ,
      ih,
      Nat.mul_assoc,
      Nat.mul_assoc,
      ← mul_assoc (b ^ k) a b,
      mul_comm (b ^ k) a,
      mul_assoc a (b ^ k) b
    ]

example
  (a m n : ℕ) :
  (a ^ m) ^ n = a ^ (m * n) := by
  induction n with
    | zero => rw [
      Nat.pow_zero,
      Nat.mul_zero,
      Nat.pow_zero,
    ]
    | succ k ih => rw [
      Nat.pow_succ,
      Nat.mul_succ,
      ih,
      Nat.pow_add
    ]

example
  (a b : ℕ) :
  (a + b) ^ 2 = a ^ 2 + b ^ 2 + 2 * a * b := by
  repeat rw [
    Nat.pow_two,
  ]
  rw [
    Nat.add_mul,
    Nat.mul_add,
    Nat.mul_add,
    Nat.two_mul,
    Nat.add_mul,
    Nat.mul_comm b a,
    Nat.add_assoc (a*a) (a*b) (a*b + b*b),
    Nat.add_assoc (a*a) (b*b) (a*b + a*b),
    ← Nat.add_assoc (a*b) (a*b) (b*b),
    Nat.add_comm (a*b + a*b) (b*b)
  ]

example
  (a b c n : ℕ) :
  (a + 1) ^ (n + 3) + (b + 1) ^ (n + 3) ≠ (c + 1) ^ (n + 3) := by
  sorry
