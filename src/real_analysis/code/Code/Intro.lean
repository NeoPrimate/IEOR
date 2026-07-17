import Mathlib

#eval 2 + 3
#eval "Lean" ++ " 4"

#check Nat
#check String
#check (Nat → Nat)

#eval "Hello, Lean!"
#check "Hello, Lean!"

def triple (x : Nat) : Nat :=
  x * 3

#check triple
#eval triple (4)

#check 42        -- Nat
#check (-3 : Int)
#check true      -- Bool
#check (3 < 10)  -- Prop


#check "Lean"            -- String
#check [1, 2, 3]         -- List Nat
#eval [1, 2, 3].length   -- 3

#check ["proof", "code", "types"]
#eval ["proof", "code", "types"].length

def farewell : String := "See you soon"

-- Primitive types

#check Nat
#check Int
#check Bool
#check String

-- List & Options

#check List Nat
#check Option String

#eval ([1, 2, 3] : List Nat)
#eval (none : Option String)
#eval (some "Lean" : Option String)

def safeDiv
  (x : Nat)
  (y : Nat) :
  Option Nat :=
  match y with
    | 0 => none
    | _ => some (x / y)

#eval safeDiv 12 4

def getOrZero (value : Option Nat) : Nat :=
  match value with
  | some n => n
  | none => 0

#eval getOrZero (some 0)

-- Structs

structure User where
  name : String
  age : Nat

#check User

def alice : User := {
  name := "Alice",
  age := 30
}

#eval alice.name

-- Update Structs

def birthday (user : User) : User :=
  { user with age := user.age + 1 }

#eval (birthday (alice)).age

-- Bool & Prop
-- Bool is computed.
-- Prop is proven.

  -- Prop to Bool

def isEven (n : Nat) : Bool :=
  n % 2 = 0

#eval isEven 4

  -- Bool to Prop

def IsEven (n : Nat) : Prop :=
  n % 2 = 0

#check IsEven 4

-- Recursion

def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

#eval factorial 5


def sumList : List Nat → Nat
  | [] => 0
  | x :: xs => x + sumList xs

#eval sumList [1, 2, 3]

-- Induction

example (n : Nat) : n + 0 = n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp [Nat.add_succ, ih]
