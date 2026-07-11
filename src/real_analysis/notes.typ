#import "/lib/imports.typ": *

// ───────────────────────── Lean 4 / Mathlib tactic cheat sheet ─────────────────────────
// Compile with: typst compile lean_tactics.typ
// Fonts left to Typst defaults so it compiles anywhere; tweak #set text(font: ...) freely.

#set page(margin: 1.5cm)
#set text(size: 10.5pt)
#set par(justify: false)

#let ink    = rgb("#2b2f36")
#let muted  = rgb("#7a818c")
#let line_c = rgb("#dfe2e7")
#let panel  = rgb("#f6f7f9")
#let edge   = rgb("#c7ccd4")
#let ok     = rgb("#2e7d32")
#let arr    = text(size: 1.25em)[#sym.arrow.r.long]

// ── badges ───────────────────────────────────────────────────────────────
#let badge(label, fg, bg) = box(
  fill: bg, inset: (x: 5pt, y: 2pt), radius: 3pt, baseline: 1.5pt,
)[#text(size: 0.58em, weight: "bold", fill: fg, tracking: 0.4pt)[#upper(label)]]
#let IN    = badge("input",  rgb("#1565c0"), rgb("#e3f0fb"))
#let OUT   = badge("output", rgb("#2e7d32"), rgb("#e6f4ea"))
#let NOARG = badge("no args", rgb("#5a6068"), rgb("#ececef"))

// ── proof-state panel: hypotheses above the turnstile, one target below ────
// goal: none  ⇒  renders a "proof complete" state.
#let pbox(label, hyps, goal) = block(
  width: 100%, fill: panel, stroke: 0.5pt + edge, radius: 5pt, inset: 8pt,
)[
  #text(size: 0.66em, fill: muted)[#smallcaps(label)]
  #v(3pt)
  #if goal == none [
    #text(fill: ok)[#sym.checkmark No goals — proof complete]
  ] else [
    #if hyps.len() > 0 {
      for h in hyps [ #raw(h) \ ]
      line(length: 100%, stroke: 0.4pt + line_c)
    }
    #raw("⊢ " + goal)
  ]
]

#let trans(tac, bh, bg, ah, ag) = grid(
  columns: (1fr, auto, 1fr), align: horizon, column-gutter: 9pt,
  pbox("before", bh, bg),
  align(center)[ #raw(tac) \ #arr ],
  pbox("after", ah, ag),
)

// ── annotated argument list: rows of (token, role-badge, kind, description) ──
#let args(rows) = grid(
  columns: (auto, auto, 1fr),
  row-gutter: 6pt, column-gutter: 9pt, align: left + top,
  ..rows.map(r => (
    raw(r.at(0)),
    r.at(1),
    [#text(size: 0.82em, weight: "medium")[#r.at(2)] #h(5pt) #text(size: 0.82em, fill: muted)[#r.at(3)]],
  )).flatten()
)

#let lbl(t) = text(size: 0.64em, fill: muted, weight: "bold", tracking: 0.5pt)[#t]

// ── one tactic card ────────────────────────────────────────────────────────
#let card(name, defn, argblock, effect, ex) = block(
  breakable: false, width: 100%, inset: 11pt,
  stroke: 0.75pt + edge, radius: 7pt, fill: white,
)[
  #grid(columns: (auto, 1fr), column-gutter: 10pt, align: horizon,
    text(size: 1.18em, weight: "bold")[#raw(name)],
    text(style: "italic", fill: ink)[#defn],
  )
  #v(7pt)
  #lbl("ARGUMENTS")
  #v(3pt)
  #argblock
  #v(8pt)
  #grid(columns: (auto, 1fr), column-gutter: 8pt, align: top,
    lbl("EFFECT"), text(size: 0.86em)[#effect],
  )
  #v(9pt)
  #ex
]

// ═════════════════════════════════ Title ═════════════════════════════════
#align(center)[
  #text(size: 1.6em, weight: "bold")[Lean 4 tactic cheat sheet]
]
#v(8pt)

// ── How to read ──
#block(width: 100%, inset: 11pt, radius: 7pt, fill: rgb("#fbfbfc"), stroke: 0.75pt + edge)[
  #lbl("HOW TO READ THIS SHEET")
  #v(6pt)
  #grid(columns: (1.05fr, 0.95fr), column-gutter: 18pt, align: top,
    [
      #grid(columns: (auto, 1fr), row-gutter: 6pt, column-gutter: 8pt, align: (left, left + horizon),
        IN,  text(size: 0.85em)[must *already exist* in the context],
        OUT, text(size: 0.85em)[the tactic *creates* it and adds it to the context],
      )
      #v(7pt)
      #text(size: 0.85em)[*value* = a term (possibly a function).#linebreak() *hyp* = a proof of a proposition.]
    ],
    [
      #grid(columns: (auto, auto), column-gutter: 12pt, row-gutter: 5pt, align: (left + horizon, left + horizon),
        raw("n : ℕ"),       text(size: 0.72em, fill: muted)[#sym.arrow.l.long the *local context*],
        raw("h : x = 2"),   text(size: 0.72em, fill: muted)[(its *hypotheses*)],
        grid.cell(colspan: 2)[#line(length: 78%, stroke: 0.4pt + line_c)],
        raw("⊢ x + 1 = 3"), text(size: 0.72em, fill: muted)[#sym.arrow.l.long the *target*],
      )
      #v(4pt)
      #text(size: 0.72em, fill: muted)[context + target = one *goal*. Tactics act on the current goal.]
    ],
  )
]
#v(12pt)

// ═══════════════════ 1 · The quantifier map ═══════════════════
#text(size: 1.15em, weight: "bold")[1 · The quantifier map]

Four tactics, one rule of thumb: _which quantifier, and is it in the target or a hypothesis?_

#v(4pt)
#table(
  columns: 3, inset: 9pt, align: (left, center, center),
  stroke: 0.5pt + edge,
  fill: (col, row) => if row == 0 or col == 0 { rgb("#eef1f5") } else { white },
  table.header([], [`∀`  (for all)], [`∃`  (there exists)]),
  [*In the target*],   [`intro`],      [`use`],
  [*In a hypothesis*], [`specialize`], [`choose`],
)
#v(10pt)

#card(
  "intro",
  [Peel a `∀`-binder, or the premise of a `→`, off the target into the context.],
  args((
    ("a b …", OUT, "new binding", [one name per binder; becomes a *value* (`∀` over data) or a *hyp* (`→`-premise / `∀` over a `Prop`)]),
  )),
  [Target `∀ x, P x` → `P x`, adding `x`; or `P → Q` → `Q`, adding `h : P`.],
  trans("intro n", (), "∀ n : ℕ, n = n", ("n : ℕ",), "n = n"),
)
#v(8pt)

#card(
  "use",
  [Supply an explicit witness for a `∃`-target.],
  args((
    ("a", IN, "value", [the witness you provide, `a : T`]),
  )),
  [Target `∃ x : T, P x` → `P a`.],
  trans("use 4", (), "∃ n : ℕ, n > 3", (), "4 > 3"),
)
#v(8pt)

#card(
  "specialize",
  [Instantiate a `∀`-hypothesis at a concrete argument, in place.],
  args((
    ("h", IN, "hyp", [an existing `∀`-hypothesis; it is *replaced* by the result]),
    ("a", IN, "value", [the argument fed to `h`, `a : T`]),
  )),
  [`h : ∀ x, P x` becomes `h : P a`.],
  trans("specialize h 5", ("h : ∀ n, n ≤ n + 1",), "G", ("h : 5 ≤ 5 + 1",), "G"),
)
#v(8pt)

#card(
  "choose",
  [Destructure a `∃`-hypothesis (or a `∀…∃` family) into a witness and its property.],
  args((
    ("w",  OUT, "value", [the witness, `w : T` (a *function* `A → B` in the `∀…∃` case); obtained via the axiom of choice — `noncomputable`]),
    ("hw", OUT, "hyp",   [`hw : P w`]),
    ("h",  IN,  "hyp",   [an existing `∃`-hypothesis; *consumed*]),
  )),
  [Removes `h`; adds `w` and `hw` to the context.],
  trans("choose c hc using h", ("h : ∃ n, n > 3",), "G", ("c : ℕ", "hc : c > 3"), "G"),
)
#v(12pt)

// ═══════════════════ 2 · Closing & rewriting ═══════════════════
#text(size: 1.15em, weight: "bold")[2 · Closing & rewriting]
#v(4pt)

#card(
  "apply",
  [Backward reasoning: match a term's conclusion to the target, leaving its premises as new goals.],
  args((
    ("e", IN, "value (term)", [a proof term — a hypothesis, a lemma name, or an expression; `e : A → B → C`]),
  )),
  [Target `C` → new goals `A`, `B`. If `e : C` exactly, the goal closes.],
  trans("apply h", ("h : x = 3",), "x = 3", ("h : x = 3",), none),
)
#v(8pt)

#card(
  "rfl",
  [Close a target that holds by reflexivity / definitional equality.],
  [#NOARG #h(6pt) #text(size: 0.85em, fill: muted)[takes no arguments]],
  [Target `a = a` → closed.],
  trans("rfl", (), "x ^ 2 + 2 * y = x ^ 2 + 2 * y", (), none),
)
#v(8pt)

#card(
  "rewrite",
  [Substitute via an equality / `↔` in the target; auto-tries `rfl` afterwards.],
  args((
    ("[r, …]", IN, "value (term)", [each rule `r : a = b` or `a ↔ b`; prefix `←` to rewrite right-to-left]),
  )),
  [Rewrites matching occurrences in the target.],
  trans("rw [h]", ("h : x = 2",), "x + y = 2 + y", ("h : x = 2",), "2 + y = 2 + y"),
)
#align(right)[#text(size: 0.78em, fill: muted)[…the trailing `2 + y = 2 + y` is then closed automatically by `rfl`.]]
#v(8pt)

#card(
  "ring_nf",
  [Normalise commutative-(semi)ring expressions on both sides. Sibling `ring` closes such a goal outright.],
  [#NOARG #h(6pt) #text(size: 0.85em, fill: muted)[takes no arguments]],
  [Both sides of `e₁ = e₂` rewritten to a canonical form; closes if they coincide.],
  trans("ring_nf", (), "(x + y) ^ 2 = x ^ 2 + 2 * x * y + y ^ 2", (), none),
)
#align(right)[#text(size: 0.78em, fill: muted)[Both sides share one normal form, so the goal closes — `ring` does it in a single step.]]


= Logic

#let card(objects, assumptions, goal, solution) = grid(
  columns: (1fr, 1fr),
  gutter: 0.5em,
  stroke: 0.5pt,
  inset: 1em,
  align: left + top,
  [*Objects* \ #objects],
  grid.cell(rowspan: 2)[*Goal* \ #goal],
  [*Assumption* \ #assumptions],
  grid.cell(colspan: 2)[*Solution* \ #solution],
)

= Conjunction ($and$)

== $and$ Commutative

#card(
  [
    I S: Props
  ],
  [],
  [
    $
      I and S arrow S and I
    $
  ],
  [
    $
      "exact" lambda h : I and S arrow.bar chevron.l h."right", h."left" chevron.r
    $
  ]
)

== $arrow$ Transitive

#card(
  [
    C A S: Props
  ],
  [
    $
      "h1": C arrow A \
      "h2": A arrow S \
    $
  ],
  [
    $
      C arrow S
    $
  ],
  [
    $
      "exact" lambda "hc" arrow.bar "h2" ("h1" "hc")  
    $
  ],
)

== d

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#fletcher.diagram(cell-size: 15mm,
	node((0, 0), $P$, name: "P"),
	node((1, 0), $Q$, name: "Q"),
	node((2, 0), $R$, name: "R"),
	node((0, 1), $S$, name: "S"),
	node((1, 1), $T$, name: "T"),
	node((2, 1), $U$, name: "U"),
  edge(<P>, <Q>, $h_1$, "->"),
  edge(<Q>, <R>, $h_2$, "->"),
  edge(<Q>, <T>, $h_3$, "->"),
  edge(<S>, <T>, $h_4$, "->"),
  edge(<T>, <U>, $h_5$, "->"),
)
#card(
  [
    P Q R S T U: Prop
  ],
  [
    $
      p: P \
      "h1": P arrow Q \
      "h2": Q arrow R \
      "h3": Q arrow T \
      "h4": S arrow T \
      "h5": T arrow U \
    $
  ],
  [
    $
      U
    $
  ],
  [
    $
      "exact" "h5" ("h3" ("h1" p))
    $
    
    or

    $
      ("h1" >> "h3" >> "h5") p 
    $
  ],
)

== H

#card(
  [
    C D S: Prop
  ],
  [
    $
      h: C and D arrow S 
    $
  ],
  [
    $
      C arrow D arrow S
    $
  ],
  [
    $
      "exact" lambda c d |-> h chevron.l c, d chevron.r 
    $
    
    or

    $
      "exact" lambda (c : C) |-> lambda (d : D) |-> h chevron.l c, d chevron.r 
    $
  ],
)

= j

#card(
  [C D S: Prop],
  [
    $
      h: C arrow D arrow S
    $
  ],
  [
    $
      C and D arrow S
    $
  ],
  [
    $
      "exact" lambda chevron.l c, d chevron.r |-> h c d 
    $
  ],
)


#card(
  [C D S: Prop],
  [
    $
      h: (S arrow C) ∧ (S arrow D)
    $
  ],
  [
    $
      S arrow C and D
    $
  ],
  [
    $
      "exact" lambda (s : S) ↦ ⟨ h."left" (s), h."right" (s) ⟩ 
    $
  ],
)

= h

#card(
  [
    R S: Prop
  ],
  [],
  [
    $
      R → (S → R) ∧ (¬S → R)
    $
  ],
  [
    $
      "exact" lambda r : R |-> chevron.l lambda s : S |-> r, lambda s : not S |-> r chevron.r 
    $
    or
    $
      "exact" λ r ↦ ⟨λ\_ ↦ r, λ\_ ↦ r⟩
    $
  ],
)

= Disjunction ($or$)

== Or Introduction Left

#card(
  [O S: Prop],
  [
    $
     s: S     
    $
  ],
  [
    $
      S ∨ O
    $
  ],
  [
    $
      "exact" "or_inl" s
    $
  ],
)

== Or Introduction Right

#card(
  [K O S: Prop],
  [
    $
       s: S     
    $
  ],
  [
    $
       K ∨ S     
    $
  ],
  [
    $
       "exact" "or_inr" s      
    $
  ],
)

==

#card(
  [B C I: Prop],
  [
    $
      "h1": C → B \
      "h2": I → B \
      "h3": C ∨ I \
    $
  ],
  [
    $
      B
    $
  ],
  [
    $
       "exact" "or_elim" "h3" "h1" "h2"     
    $
  ],
)

== Commutativity of $or$

#card(
  [C O: Prop],
  [
    $
       h: C ∨ O     
    $
  ],
  [
    $
       O ∨ C     
    $
  ],
  [
    $
       "exact" "or_elim" h "or_inr" "or_inl"     
    $
  ],
)

== 
 
#card(
  [C J R: Prop],
  [
    $
      "h1": C → J \
      "h2": C ∨ R \
    $
  ],
  [
    $
      J ∨ R
    $
  ],
  [
    $
        
    $
  ],
)

#table(
  columns: 3,
  inset: 1em,
  stroke: none,
  [], [Induction], [Elimination],
  table.hline(),
  [$A and B$], [$chevron.l a, b chevron.r$], [`a` `b`],
  table.hline(),
  [$A arrow B$], [$lambda a |-> ...$], [`h a`],
  table.hline(),
  [$A or B$], [`Or.inl` `Or.inr`], [`match` / `cases`],
  table.hline(),
)

- *Introduction*: the GOAL. You introduce (build) a connective when it's the thing you're trying to make.
- *Elimination*: an ASSUMPTION. You eliminate (use up) a connective when you already have it as a given.

The essence: introduce the goal down to atoms; eliminate assumptions up to meet them.

The steps:

- Read the goal — build its shape (introduction). Write the constructor for its top connective: → → λ, ∧ → ⟨_, _⟩, ∨ → pick a side. Repeat until the goal is atomic. (Each → you introduce hands you a new assumption.)
- Fill the holes from the assumptions (elimination). Each hole needs a specific atomic fact. Make it by consuming assumptions: apply a →, project a ∧, split a ∨.
- Meet in the middle. Build inward from the goal, take apart outward from the assumptions, until the pieces connect.

Rule of thumb: goal → constructors, assumptions → destructors.
