/-!
# Lean vs ATPs — two illustrative theorems

Companion code for the blog post *Lean vs ATPs: there are things you cannot
write in SMT solvers*.

The two theorems below were chosen to make a single point sharper:

* **Example A** is a statement that SMT-LIB cannot even *express*, because it
  quantifies universally over functions `ℕ → ℕ`. SMT-LIB is many-sorted
  *first-order* logic; you can speak about specific function symbols, but not
  about *all* functions.
* **Example B** is a statement any reasonable ATP can prove, but the Lean
  proof is a step-by-step `calc` that reads like the argument a human would
  write on a blackboard. That structured style is what makes ITP corpora a
  rich training signal for ML.
-/

/-! ## Example A — a theorem SMT cannot state

If `f : ℕ → ℕ` is strictly increasing on consecutive arguments, then
`n ≤ f n` for every `n`. The leading `∀ f : ℕ → ℕ` is the obstacle for
SMT-LIB: there is no way to write "for every function" in standard SMT.
-/

theorem strict_mono_ge_id
    (f : Nat → Nat) (hf : ∀ n, f n < f (n + 1)) :
    ∀ n, n ≤ f n := by
  intro n
  induction n with
  | zero =>
      exact Nat.zero_le _
  | succ k ih =>
      -- From `hf k` we get `f k < f (k+1)`, i.e. `f k + 1 ≤ f (k+1)`.
      -- The IH gives `k ≤ f k`, i.e. `k + 1 ≤ f k + 1`. Chain them.
      have step : f k + 1 ≤ f (k + 1) := hf k
      have ih'  : k + 1 ≤ f k + 1     := Nat.succ_le_succ ih
      exact Nat.le_trans ih' step

/-! ## Example B — a human-readable structured proof

`xs.reverse.reverse = xs` is trivial for any ATP, but here the *proof object*
is the point: each `calc` step names a specific lemma, in the order a human
would invoke them. -/

theorem reverse_reverse {α : Type} (xs : List α) :
    xs.reverse.reverse = xs := by
  induction xs with
  | nil => rfl
  | cons h t ih =>
      calc (h :: t).reverse.reverse
          = (t.reverse ++ [h]).reverse := by
              rw [List.reverse_cons]
        _ = [h].reverse ++ t.reverse.reverse := by
              rw [List.reverse_append]
        _ = [h] ++ t.reverse.reverse := rfl
              -- `[h].reverse` is definitionally `[h]`.
        _ = [h] ++ t := by
              rw [ih]
        _ = h :: t := rfl
