import Mathlib

example
  (P Q : Prop) :
  (P → Q) → ¬Q → ¬P := by
  unfold Not
  intro p_imp_q
  intro q_imp_false
  intro p
  exact q_imp_false (p_imp_q p)

example
  (P Q : Prop) :
  P ∧ ¬P → Q := by
  unfold Not
  intro h
  obtain ⟨ p, p_imp_false ⟩ := h
  exfalso
  exact p_imp_false p

example
  (x y a b : ℝ)
  (h1 : x < y)
  (h2 : a < b) :
  x + a < y + b := by
  linarith
  -- exact Nat.add_lt_add h1 h2

example
  (G : Type)
  (h g : Group G)
  (a b c : G) :
  a * a⁻¹ * 1 * b = b * c * c⁻¹ := by
  simp

example
  (x : ℕ) :
  x ≤ 1 + x := by
  omega

example :
  ∃ n : ℕ, n + 3 = 5 := by
  use 2

example : ∃ a b : ℕ, a + b = 5 := by
  use 2, 3

example
  (n : ℕ) :
  0 + n = n := by
  rw [Nat.zero_add]

example
  (n : ℕ) :
  0 + n = n := by
  induction n with
    | zero => rfl
    | succ n h => simp

example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (w : V) :
  (0 : K) • w = 0 := by
  apply add_right_cancel (b := (0 : K) • w)
  rw [
    zero_add,
    ← add_smul,
    zero_add
  ]

example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (w : V) :
  0 • w = 0 := by
  rw [zero_smul]

example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (a : K) :
  a • (0 : V) = 0 := by
  rw [smul_zero]

example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (a : K) :
  -1 • v = -v := by
  rw [neg_one_smul]

theorem zero_mem_example_1
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (W : Submodule K V) :
  0 ∈ W := by
  exact W.zero_mem

theorem add_mem_example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (W : Submodule K V)
  (u v : V)
  (hu : u ∈ W)
  (hv : v ∈ W) :
  u + v ∈ W := by
  exact W.add_mem hu hv

theorem smul_mem_example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (a : K)
  (W : Submodule K V)
  (v : V)
  (hv : v ∈ W) :
  a • v ∈ W := by
  exact W.smul_mem a hv

theorem neg_mem_example
  (K V : Type)
  (fld : Field K)
  (grp : AddCommGroup V)
  (mod : Module K V)
  (W : Submodule K V)
  (v : V)
  (hv : v ∈ W) :
  -v ∈ W := by
  exact W.neg_mem hv
