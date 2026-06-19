-- theorem implication_across_or
--   (C J R : Prop)
--   (h1 : C → J)
--   (h2 : C ∨ R) :
--   J ∨ R :=
--   match h2 with
--     | Or.inl c => Or.inl (h1 (c))
--     | Or.inr r => Or.inr (r)


-- theorem implication_across_or
--   (C J R : Prop)
--   (h1 : C → J)
--   (h2 : C ∨ R) :
--   J ∨ R := by
--   cases h2 with
--   | inl c => exact Or.inl (h1 c)
--   | inr r => exact Or.inr r

theorem implication_across_or
  (C J R : Prop)
  (h1 : C → J)
  (h2 : C ∨ R) :
  J ∨ R :=
  Or.imp_left h1 h2

-- AND (∧)

theorem a
  (P S : Prop)
  (p : P)
  (s : S) :
  P ∧ S :=
  And.intro p s

theorem b
  (A I O U: Prop)
  (a : A)
  (i : I)
  (o : O)
  (u : U) :
  (A ∧ I) ∧ (O ∧ U) :=
  ⟨⟨a, i⟩, ⟨o, u⟩⟩

theorem c
  (P S : Prop)
  (h : P ∧ S) :
  P :=
  h.left

theorem d
  (P Q : Prop)
  (h : P ∧ Q) :
  Q :=
  h.right

theorem e
  (A I O U : Prop)
  (h1 : A ∧ I)
  (h2 : O ∧ U) :
  A ∧ U :=
  ⟨ h1.left, h2.right ⟩

theorem navigate_tree
  (C L : Prop)
  (h: (L ∧ ((L ∧ C) ∧ L) ∧ L ∧ L ∧ L) ∧ (L ∧ L) ∧ L) :
  C :=
  h.left.right.left.left.right

theorem f
  (A C I O P S U: Prop)
  (h: ((P ∧ S) ∧ A) ∧ ¬I ∧ (C ∧ ¬O) ∧ ¬U) :
  A ∧ C ∧ P ∧ S :=
  ⟨
    h.left.right,
    h.right.right.left.left,
    h.left.left.left,
    h.left.left.right,
  ⟩

-- Tactics (∧)

theorem assumption
  (P : Prop)
  (h : P) :
  P := by
  assumption

theorem constructor
  (P Q : Prop)
  (h1 : P)
  (h2 : Q) :
  P ∧ Q := by
  constructor
  assumption
  assumption

theorem constructor_assumption
  (P Q R S : Prop)
  (h1 : P)
  (h2 : Q)
  (h3 : R)
  (h4 : S) :
  (P ∧ Q) ∧ R ∧ S := by
  constructor
  constructor
  assumption
  assumption
  constructor
  assumption
  assumption

theorem cases1
  (P Q : Prop)
  (h : P ∧ Q) :
  P := by
  cases h
  assumption

theorem cases2
  (P Q : Prop)
  (h : P ∧ Q) :
  Q := by
  cases h
  assumption

theorem h
  (P Q R S : Prop)
  (h1 : P ∧ Q)
  (h2 : R ∧ S) :
  P ∧ S := by
  cases h1
  cases h2
  constructor
  assumption
  assumption

theorem i
  (P Q : Prop)
  (h: (Q ∧ ((Q ∧ P) ∧ Q) ∧ Q ∧ Q ∧ Q) ∧ (Q ∧ Q) ∧ Q) :
  P := by
  obtain ⟨⟨_, ⟨⟨_, hp⟩, _⟩, _⟩, _⟩ := h
  exact hp

theorem j
  (P Q : Prop)
  (h: (Q ∧ ((Q ∧ P) ∧ Q) ∧ Q ∧ Q ∧ Q) ∧ (Q ∧ Q) ∧ Q) :
  P :=
  h.1.2.1.1.2

theorem k
  (A C I O P S U : Prop)
  (h: ((P ∧ S) ∧ A) ∧ ¬I ∧ (C ∧ ¬O) ∧ ¬U) :
  A ∧ C ∧ P ∧ S :=
  ⟨ {-A-}, {-C-}, {-P-}, {-S-} ⟩
