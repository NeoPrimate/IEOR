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
  ⟨h.1.2, h.2.2.1.1, h.1.1.1, h.1.1.2⟩

theorem l
  (P C: Prop)
  (p: P)
  (h: P → C) :
  C :=
  h (p)

theorem m
  (C: Prop) :
  C → C :=
  λ h : C ↦ h

theorem commutative_and
  (I S: Prop) :
  I ∧ S → S ∧ I :=
  λ (h : I ∧ S) ↦ ⟨ h.right, h.left ⟩

theorem transitive_imp_1
  (C A S: Prop)
  (h1: C → A)
  (h2: A → S) :
  C → S :=
  λ c : C ↦ h2 (h1 c)

theorem transitive_imp_2
  (C A S: Prop)
  (h1: C → A)
  (h2: A → S) :
  C → S :=
  h2 ∘ h1

theorem n
  (P Q R S T U: Prop)
  (p : P)
  (h1 : P → Q)
  (h2 : Q → R)
  (h3 : Q → T)
  (h4 : S → T)
  (h5 : T → U) :
  U :=
  (h5 ∘ (h3 ∘ h1)) p


theorem conjunction_interacting_with_implication_1
  (C D S: Prop)
  (h: C ∧ D → S) :
  C → D → S :=
  λ (c : C) ↦ λ (d : D) ↦ h ⟨ c, d ⟩

theorem conjunction_interacting_with_implication_2
  (C D S: Prop)
  (h: C → D → S) :
  C ∧ D → S :=
  λ ⟨ c, d ⟩ ↦ h c d

theorem imp_distributes_over_and
  (C D S: Prop)
  (h: (S → C) ∧ (S → D)) :
  S → C ∧ D :=
  λ (s: S) ↦ ⟨ h.left s, h.right s ⟩

theorem o
  (R S: Prop) :
  R → (S → R) ∧ (¬S → R) :=
  λ (r: R) ↦ ⟨λ _ : S ↦ r, λ _ : ¬ S ↦ r⟩

-- OR (∨)

theorem or_introduction_left
  (O S: Prop)
  (s: S) :
  S ∨ O :=
  Or.inl s

theorem or_introduction_right
  (O S: Prop)
  (o: O) :
  S ∨ O :=
  Or.inr o

theorem or_elim
  (B C I: Prop)
  (h1: C → B)
  (h2: I → B)
  (h3: C ∨ I) :
  B :=
  Or.elim h3 h1 h2

theorem commutativity_of_or_1
  (C O: Prop)
  (h: C ∨ O) :
  O ∨ C :=
  Or.elim h Or.inr Or.inl

theorem commutativity_of_or_2
  (C O: Prop)
  (h: C ∨ O) :
  O ∨ C :=
  match h with
    | Or.inl l => Or.inr l
    | Or.inr r => Or.inl r

theorem implication_across_or_1
  (C J R : Prop)
  (h1 : C → J)
  (h2 : C ∨ R) :
  J ∨ R :=
  match h2 with
    | Or.inl c => Or.inl (h1 (c))
    | Or.inr r => Or.inr (r)


theorem implication_across_or_2
  (C J R : Prop)
  (h1 : C → J)
  (h2 : C ∨ R) :
  J ∨ R := by
  cases h2 with
    | inl c => exact Or.inl (h1 c)
    | inr r => exact Or.inr r

theorem implication_across_or_3
  (C J R : Prop)
  (h1 : C → J)
  (h2 : C ∨ R) :
  J ∨ R :=
  Or.imp_left h1 h2

theorem implication_across_or_4
  (C J R : Prop)
  (h1 : C → J)
  (h2 : C ∨ R) :
  J ∨ R :=
  Or.elim h2 (λ (c : C ) ↦ Or.inl (h1 c)) Or.inr

theorem or_over_and_1
  (G H U: Prop)
  (h: G ∨ H ∧ U) :
  (G ∨ H) ∧ (G ∨ U) :=
  match h with
    | Or.inl g => ⟨ Or.inl g, Or.inl g ⟩
    | Or.inr ⟨ hh, hu ⟩ => ⟨ Or.inr hh, Or.inr hu ⟩

theorem or_over_and_2
  (G H U: Prop)
  (h: G ∨ H ∧ U) :
  (G ∨ H) ∧ (G ∨ U) :=

  have gh_from_g : G → G ∨ H := λ (g : G) ↦ Or.inl g
  have gh_from_hu : H ∧ U → G ∨ U := λ ⟨ _, hu ⟩ ↦ Or.inr hu

  have gu_from_g : G → G ∨ U := λ (g : G) ↦ Or.inl g
  have gu_from_hu : H ∧ U → G ∨ H := λ ⟨ hh, _ ⟩ ↦ Or.inr hh

  have lhs : G ∨ H := Or.elim h gh_from_g gu_from_hu
  have rhs : G ∨ U := Or.elim h gu_from_g gh_from_hu

  ⟨lhs, rhs⟩

theorem and_over_or_1
  (G H U: Prop)
  (h: G ∧ (H ∨ U)) :
  G ∧ H ∨ G ∧ U :=
  have ⟨ g, hu ⟩ := h
  match hu with
    | Or.inl h => Or.inl ⟨ g, h ⟩
    | Or.inr u => Or.inr ⟨ g, u ⟩

theorem and_over_or_2
  (G H U : Prop)
  (h : G ∧ (H ∨ U)) :
  G ∧ H ∨ G ∧ U := by
    have g  : G     := And.left h
    have hu : H ∨ U := And.right h
    exact Or.elim hu
      (fun hh => Or.inl (And.intro g hh))
      (fun uu => Or.inr (And.intro g uu))

theorem implication_of_or_1
  (I K P: Prop)
  (h: K → P) :
  K ∨ I → I ∨ P :=
  λ (ki : K ∨ I) ↦ match ki with
    | Or.inl k => Or.inr (h k)
    | Or.inr i => Or.inl i

theorem implication_of_or_2
  (I K P: Prop)
  (h: K → P) :
  K ∨ I → I ∨ P :=
  λ ki => Or.elim  ki
    (λ k => Or.inr (h k))
    (λ i => Or.inl i)

theorem implication_of_or_3
  (I K P: Prop)
  (h: K → P) :
  K ∨ I → I ∨ P := by
  exact λ ki => Or.elim ki (λ k => Or.inr (h k)) (λ i => Or.inl i)

-- Redux

theorem aa
  (P Q : Prop)
  (h1 : P)
  (h : P → Q) :
  Q := by
  apply h (h1)

example
  (P : Prop) :
  P → P := by
  intro p
  exact p

example
  (P : Prop) :
  P → P := by
  intro p
  assumption

example
  (P Q : Prop) :
  P ∧ Q → Q ∧ P :=
  fun ⟨ p, q ⟩ ↦ ⟨ q, p ⟩

example
  (P Q : Prop) :
  P ∧ Q → Q ∧ P := by
  intro h
  obtain ⟨hp, hq⟩ := h
  exact ⟨ hq, hp ⟩

example
  (P Q : Prop) :
  P ∧ Q → Q ∧ P := by
  intro h
  cases h
  constructor
  assumption
  assumption

example
  (C A S : Prop)
  (h1 : C → A)
  (h2 : A → S) :
  C → S := by
  intro
  apply h2
  apply h1
  assumption

example
  (P Q R S T U : Prop)
  (h1: P → Q)
  (h2: Q → R)
  (h3: Q → T)
  (h4: S → T)
  (h5: T → U) :
  P → U := by
  intro p
  exact h5 (h3 (h1 (p)))

example
  (P Q R S T U : Prop)
  (h1: P → Q)
  (h2: Q → R)
  (h3: Q → T)
  (h4: S → T)
  (h5: T → U) :
  P → U := by
  intro
  apply h5
  apply h3
  apply h1
  assumption

example
  (P Q R : Prop)
  (h : P ∧ Q → R) :
  P → Q → R := by
  intro p
  intro q
  exact h ⟨ p, q ⟩

example
  (P Q R : Prop)
  (h : P ∧ Q → R) :
  P → Q → R := by
  intro p
  intro q
  apply h
  constructor
  assumption
  assumption

example
  (P Q R : Prop)
  (h: P → Q → R) :
  P ∧ Q → R := by
  intro ⟨p, q⟩
  exact h p q

example
  (P Q R : Prop)
  (h: P → Q → R) :
  P ∧ Q → R := by
  intro ⟨p, q⟩
  apply h
  assumption
  assumption

example
  (P Q R : Prop)
  (h : (P → Q) ∧ (P → R)) :
  P → Q ∧ R := by
  intro p
  constructor
  apply h.left
  assumption
  apply h.right
  assumption

example
  (P Q R : Prop)
  (h : (P → Q) ∧ (P → R)) :
  P → Q ∧ R :=
  let ⟨ pq, pr ⟩ := h
  fun (p : P) ↦ ⟨ pq (p), pr (p) ⟩

example
  (P Q : Prop) :
  Q → (P → Q) ∧ (¬P → Q) := by
  intro p
  constructor
  intro p
  assumption
  intro np
  assumption

example
  (P Q : Prop) :
  Q → (P → Q) ∧ (¬P → Q) :=
  fun (q : Q) ↦ ⟨ fun (_ : P) ↦ q, fun (_ : ¬P) ↦ q ⟩

-- Not

example :
  ¬False :=
  fun (f : False) ↦ f

example :
  ¬False := by
  intro f
  exact f

example :
  ¬False := by
  exact fun h ↦ h

example
  (X : Prop)
  (f : False) :
  X :=
  False.elim (C := X) f

example
  (X P : Prop)
  (p : P)
  (np : ¬P) :
  X :=
  let f := np (p)
  False.elim (C := X) f

example
  (B S : Prop)
  (h : ¬S) : -- fun S ↦ False
  S → B := by
  exact fun (s : S) ↦ False.elim (C := B) (h (s))

example
  (B S : Prop)
  (h : ¬S) : -- fun S ↦ False
  S → B := by
  intro s
  have contra : False := h s
  exact False.elim (C := B) (contra)

example
  (P: Prop)
  (p: P) :
  ¬¬P := by
  intro np
  apply np
  exact p

example
  (P: Prop)
  (p: P) :
  ¬¬P :=
  fun (np : P → False) ↦ np p

example
  (P: Prop)
  (p: P) :
  ¬¬P := by
  exact fun (np : P → False) ↦ np p

example
  (L : Prop) :
  ¬(L ∧ ¬L) := by
  intro lnl
  let ⟨ l, nl ⟩ := lnl
  have contra : False :=  nl l
  exact False.elim (C := False) (contra)

example
  (L : Prop) :
  ¬(L ∧ ¬L) :=
  fun (⟨l, nl⟩ : L ∧ ¬L) ↦ nl l

example
  (B S : Prop)
  (h1 : B → S)
  (h2 : ¬S) :
  ¬B :=
  fun (b : B) ↦ h2 (h1 (b))

example
  (A : Prop)
  (h : A → ¬A) :
  ¬A :=
  fun (a : A) ↦ h (a) (a)

example
  (B C : Prop)
  (h : ¬(B → C)) : -- fun (h : B → C) ↦ False
  ¬C :=
  fun (c : C) ↦ h ( fun (_ : B) ↦ c )

example
  (C S : Prop)
  (s : S) :
  ¬(¬S ∧ C) :=
  -- fun (s : S) ↦ False
  fun ( ⟨ fs, _ ⟩ : ¬S ∧ C ) ↦ fs (s)

example
  (A P : Prop)
  (h : P → ¬A) :
  ¬(P ∧ A) :=
  fun (⟨p, a⟩ : P ∧ A) ↦ h (p) (a)

example
  (A P : Prop)
  (h : ¬(P ∧ A)) :
  P → ¬A := by
  intro p
  exact fun (a : A) ↦ h (⟨ p, a ⟩)

example
  (A P : Prop)
  (h : ¬(P ∧ A)) :
  P → ¬A :=
  fun (p : P) ↦ fun (a : A) ↦ h (⟨ p, a ⟩)

example
  (A : Prop)
  (h : ¬¬¬A) :
  ¬A := by
  intro a
  apply h
  intro na
  apply na
  assumption

example
  (A : Prop)
  (h : ¬¬¬A) :
  -- ¬A : A → False
  -- ¬¬A : (A → False) → False
  -- ¬¬¬A : ((A → False) → False) → False
  ¬A :=
  fun (a : A) ↦ h (fun (na : A → False) ↦ na (a))

example
  (B C : Prop)
  (h: ¬(B → C)) :
  ¬¬B := by
  exact fun (nb : ¬B) => h (fun (b : B) => (nb b).elim)

example
  (B C : Prop)
  (h: ¬(B → C)) : -- fun (bc : B → C) ↦ False
  ¬¬B := -- (B → False) → False
  fun (nb : B → False) ↦
    let bf := fun (b : B) ↦ False.elim (C := C) (nb (b))
    h (bf)

-- ↔

-- P ↔ Q ≣ (P → Q) ∧ (Q → P)

example
  (J S : Prop)
  (hsj : S → J)
  (hjs : J → S) :
  S ↔ J :=
  have h : S ↔ J := ⟨ hsj, hjs ⟩
  h

example
  (J S : Prop)
  (hsj : S → J)
  (hjs : J → S) :
  S ↔ J :=
  ⟨ hsj, hjs ⟩

example
  (J S : Prop)
  (hsj : S → J)
  (hjs : J → S) :
  S ↔ J := by
  have h : S ↔ J := ⟨ hsj, hjs ⟩
  exact h

example
  (B P : Prop)
  (h : B ↔ ¬P) :
  (B → ¬P) ∧ (¬P → B) :=
  have ⟨ lhs, rhs ⟩ := h
  ⟨ lhs, rhs ⟩

example
  (P Q R : Prop)
  (h1 : Q ↔ R)
  (h2 : P → Q) :
  P → R :=
  have ⟨ lhs, _ ⟩ := h1
  fun (p : P) ↦ lhs (h2 (p))

example
  (P Q R : Prop)
  (h1 : P ↔ R)
  (h2 : P → Q) :
  R → Q :=
  have ⟨ _, rhs ⟩ := h1
  fun (r : R) ↦ h2 (rhs (r))

example
  (A C L P : Prop)
  (h1 : L ↔ P)
  (h2 : ¬((A → C ∨ ¬P) ∧ (P ∨ A → ¬C) → P → C) ↔ A ∧ C ∧ ¬P) :
  ¬((A → C ∨ ¬L) ∧ (L ∨ A → ¬C) → L → C) ↔ A ∧ C ∧ ¬L := by
  rw [h1]
  exact h2

example
  (A C L P : Prop)
  (h1 : L ↔ P)
  (h2 : ¬((A → C ∨ ¬P) ∧ (P ∨ A → ¬C) → P → C) ↔ A ∧ C ∧ ¬P) :
  ¬((A → C ∨ ¬L) ∧ (L ∨ A → ¬C) → L → C) ↔ A ∧ C ∧ ¬L :=
  propext h1 ▸ h2

example
  (A C L P : Prop)
  (h1 : L ↔ P)
  (h2 : ¬((A → C ∨ ¬P) ∧ (P ∨ A → ¬C) → P → C) ↔ A ∧ C ∧ ¬P) :
  ¬((A → C ∨ ¬L) ∧ (L ∨ A → ¬C) → L → C) ↔ A ∧ C ∧ ¬L :=
  ⟨
    fun h3 =>
      have ⟨a, c, np⟩ := h2.mp fun h4 =>
        h3 fun ⟨hl, hr⟩ l =>
          h4 ⟨
            fun ha => (hl ha).elim Or.inl (fun nl => Or.inr fun p => nl (h1.mpr p)),
            fun _ => hr (Or.inl l)
          ⟩ (h1.mp l)
      ⟨a, c, fun l => np (h1.mp l)⟩
  ,
    fun ⟨a, c, nl⟩ _ =>
      h2.mpr ⟨a, c, fun p => nl (h1.mpr p)⟩ (fun _ _ => c)
  ⟩

example
  (P Q R : Prop)
  (h: P ∨ Q ∨ R → ¬(P ∧ Q ∧ R)) :
  (P ∨ Q) ∨ R → ¬((P ∧ Q) ∧ R) := by
  rw [or_assoc, and_assoc]
  exact h

example
  (P Q R : Prop)
  (h: P ∨ Q ∨ R → ¬(P ∧ Q ∧ R)) :
  (P ∨ Q) ∨ R → ¬((P ∧ Q) ∧ R) :=
  fun hpqr => (h (or_assoc.mp hpqr)) ∘ and_assoc.mp

example
  (P Q R : Prop)
  (h: P ∨ Q ∨ R → ¬(P ∧ Q ∧ R)) :
  (P ∨ Q) ∨ R → ¬((P ∧ Q) ∧ R) :=
  fun (hpqr : (P ∨ Q) ∨ R) =>
    fun (hpqr2 : (P ∧ Q) ∧ R) =>
      h (or_assoc.mp hpqr) (and_assoc.mp hpqr2)

-- P ↔ Q ≣ (P → Q) ∧ (Q → P)

example
  (P Q R : Prop) :
  (P ∧ Q ↔ R ∧ Q) ↔ Q → (P ↔ R) :=
  ⟨
    -- (P ∧ Q ↔ R ∧ Q) → (Q → (P ↔ R))
    fun (⟨ pq_rq, rq_pq ⟩ : P ∧ Q ↔ R ∧ Q) ↦
      fun (q : Q) ↦
        ⟨
          -- P → R
          fun (p : P) ↦
            let ⟨ r, q ⟩ := pq_rq (⟨ p, q ⟩)
            r,
          -- R → P
          fun (r : R) ↦
            let ⟨ p, q ⟩ := rq_pq (⟨ r, q ⟩)
            p,
        ⟩
  ,
    -- (Q → (P ↔ R)) → (P ∧ Q ↔ R ∧ Q)
    fun (qpr : Q → (P ↔ R)) ↦
      ⟨
        fun (⟨ p, q ⟩ : P ∧ Q) ↦ ⟨ (qpr (q)).mp p, q ⟩
      ,
        fun (⟨ r, q ⟩ : R ∧ Q) ↦ ⟨ (qpr (q)).mpr r, q ⟩
      ⟩
  ⟩

-- ∨

example
  (P Q : Prop)
  (h1 : P) :
  (P ∨ Q) :=
  Or.inl (h1)

example
  (P Q : Prop)
  (h1: Q) :
  P ∨ Q :=
  Or.inr (h1)

example
  (P Q R : Prop)
  (h1 : Q → P)
  (h2 : R → P)
  (h3 : Q ∨ R) :
  P :=
  Or.elim h3 h1 h2

example
  (P Q R : Prop)
  (h1 : Q → P)
  (h2 : R → P)
  (h3 : Q ∨ R) :
  P := by
  cases h3 with
    | inl q => exact h1 q
    | inr r => exact h2 r

example
  (P Q R : Prop)
  (h1 : Q → P)
  (h2 : R → P)
  (h3 : Q ∨ R) :
  P :=
  match h3 with
    | Or.inl q => h1 q
    | Or.inr r => h2 r

example
  (P Q : Prop)
  (h : P ∨ Q) :
  (Q ∨ P) :=
  match h with
    | Or.inl p => Or.inr p
    | Or.inr q => Or.inl q

example
  (P Q R : Prop)
  (h1 : P → Q)
  (h2 : P ∨ R) :
  Q ∨ R :=
  match h2 with
    | Or.inl p => Or.inl (h1 p)
    | Or.inr r => Or.inr r

example
  (P Q R : Prop)
  (h : P ∨ Q ∧ R) :
  (P ∨ Q) ∧ (P ∨ R) :=
  ⟨
    match h with
      | Or.inl p => Or.inl p
      | Or.inr ⟨ q, r ⟩ => Or.inr q
  ,
    match h with
      | Or.inl p => Or.inl p
      | Or.inr ⟨ q, r ⟩ => Or.inr r
  ⟩

example
  (P Q R : Prop)
  (h: P ∧ (Q ∨ R)) :
  P ∧ Q ∨ P ∧ R :=
  let ⟨ p, qr ⟩ := h
  match qr with
    | Or.inl q => Or.inl ⟨ p, q ⟩
    | Or.inr r => Or.inr ⟨ p, r ⟩

example
  (P Q R : Prop)
  (h : Q → R) :
  Q ∨ P → P ∨ R :=
  fun (qp : Q ∨ P) ↦
    match qp with
      | Or.inl q => Or.inr (h q)
      | Or.inr p => Or.inl p

-- ¬

example :
  ¬ False :=
  fun (f : False) ↦ f

example
  (P Q : Prop)
  (h1 : ¬P) :
  P → Q :=
  fun (p : P) ↦ False.elim (C := Q) (h1 p)


example
  (P : Prop)
  (h1: P) :
  ¬¬P :=
  fun (hp : P → False) ↦ hp (h1)

example
  (P : Prop) :
  ¬(P ∧ ¬P) :=
  fun (⟨ p, pf ⟩ : P ∧ (P → False)) ↦
    pf (p)

example
  (P Q : Prop)
  (h1 : P → Q)
  (h2 : ¬Q) :
  ¬P :=
  fun (p : P) ↦ False.elim (h2 (h1 (p)))

example
  (P : Prop)
  (h : P → ¬P) :
  ¬P :=
  fun (p : P) ↦ h (p) (p)

example
  (P Q : Prop)
  (h : ¬(P → Q)) : -- fun (pq : P → Q) ↦ False
  ¬Q :=
  fun (q : Q) ↦ h (fun (_ : P) ↦ q)

example
  (P Q : Prop)
  (h : Q) :
  ¬(¬Q ∧ P) :=
  fun (⟨ nq, p ⟩ : (Q → False) ∧ P) ↦ nq (h)

example
  (P Q : Prop)
  (h : Q → ¬P) :
  ¬(Q ∧ P) :=
  fun (⟨ q, p ⟩ : Q ∧ P) ↦ h (q) (p)

example
  (P Q : Prop)
  (h : ¬(Q ∧ P)) :
  Q → ¬P :=
  fun (q : Q) ↦ fun (p : P) ↦ h (⟨ q, p ⟩)
