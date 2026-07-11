import Mathlib

def ContinuousAtPoint (f : ℝ → ℝ) (a : ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, |x - a| < δ → |f x - f a| < ε


example (a : ℝ) : ContinuousAtPoint (fun x => x) a := by
  intro ε hε          -- ε : ℝ,  hε : ε > 0       (built the ∀ and the →)
  use ε               -- supply δ := ε            (built the ∃)
  constructor
  · exact hε          -- δ > 0   is just  ε > 0    (left half of ∧)
  · intro x hx        -- x : ℝ,  hx : |x - a| < ε  (built ∀ and →)
    exact hx          -- goal |x - a| < ε  IS hx

example (a : ℝ) : ContinuousAtPoint (fun x => 2 * x) a := by
  intro ε hε                 -- hε : ε > 0
  use ε / 2                  -- δ := ε/2
  constructor
  · linarith                 -- ε/2 > 0  follows from ε > 0
  · intro x hx               -- hx : |x - a| < ε/2
    -- show |2 * x - 2 * a| < ε -- restate goal (beta-reduce the (fun..) application)
    have h2 : |2 * x - 2 * a| = 2 * |x - a| := by
      rw [← mul_sub, abs_mul] -- 2*x - 2*a = 2*(x-a),  then |2*(x-a)| = |2|*|x-a|
      norm_num                -- |2| = 2
    rw [h2]                  -- goal becomes  2 * |x - a| < ε
    linarith                 -- from hx : |x-a| < ε/2,  2*|x-a| < ε
