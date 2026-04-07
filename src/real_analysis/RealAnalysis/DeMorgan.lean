import Mathlib.Data.Set.Basic

open Set

variable {α : Type}

theorem deMorgan_union (B C : Set α) :
  (B ∪ C)ᶜ = Bᶜ ∩ Cᶜ := by
  -- To prove equality of sets, prove mutual inclusion
  apply le_antisymm
  -- <one>
  -- Prove: (B ∪ C)ᶜ ⊆ Bᶜ ∩ Cᶜ
  · intro x hx
    -- hx : x ∈ (B ∪ C)ᶜ
    -- Goal: x ∈ Bᶜ ∩ Cᶜ
    -- unfold complement
    have h : x ∉ B ∪ C := hx
    -- From ¬ (x ∈ B ∨ x ∈ C), get both parts
    have hB : x ∉ B := by
      intro hBx
      exact h (Or.inl hBx)
    have hC : x ∉ C := by
      intro hCx
      exact h (Or.inr hCx)
    -- build intersection
    exact ⟨hB, hC⟩
  -- <two>
  -- Prove: Bᶜ ∩ Cᶜ ⊆ (B ∪ C)ᶜ
  · intro x hx
    -- hx : x ∈ Bᶜ ∩ Cᶜ
    -- Goal: x ∈ (B ∪ C)ᶜ
    -- break intersection
    rcases hx with ⟨hB, hC⟩
    -- hB : x ∉ B
    -- hC : x ∉ C
    -- show x ∉ (B ∪ C)
    intro hx_union
    rcases hx_union with hBx | hCx
    · exact hB hBx
    · exact hC hCx
