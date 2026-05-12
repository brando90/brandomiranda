(* PicoML: a tiny Hindley-Milner type inferencer.
   Single-file, runnable as: ocaml picoml.ml
   Starting point for the experiment described in ../README.md and the
   linked GitHub issue: scale this kernel from HM up to a dependently-typed
   core, then bolt a tactic layer on top to make a toy ITP. *)

(* --- AST ------------------------------------------------------------ *)

type binop = Add | Sub | Mul | Eq | Lt

type expr =
  | EInt  of int
  | EBool of bool
  | EVar  of string
  | EFun  of string * expr
  | EApp  of expr * expr
  | ELet  of string * expr * expr        (* let x = e1 in e2 — polymorphic *)
  | EIf   of expr * expr * expr
  | EBop  of binop * expr * expr

(* --- Types ---------------------------------------------------------- *)

type ty =
  | TInt
  | TBool
  | TVar of string
  | TFun of ty * ty

type scheme = Forall of string list * ty

module SMap = Map.Make (String)
module SSet = Set.Make (String)

type subst = ty SMap.t
type env   = scheme SMap.t

(* --- Substitution & free type variables ----------------------------- *)

let rec apply_ty (s : subst) (t : ty) : ty =
  match t with
  | TInt | TBool -> t
  | TVar a ->
      (match SMap.find_opt a s with
       | Some t' -> apply_ty s t'   (* chase through chains *)
       | None    -> t)
  | TFun (a, b) -> TFun (apply_ty s a, apply_ty s b)

let apply_scheme (s : subst) (Forall (vs, t)) : scheme =
  let s' = List.fold_left (fun m v -> SMap.remove v m) s vs in
  Forall (vs, apply_ty s' t)

let apply_env (s : subst) (e : env) : env =
  SMap.map (apply_scheme s) e

(* s1 ∘ s2  — apply s1 to the rhs of s2, then union (s1 wins on clash) *)
let compose (s1 : subst) (s2 : subst) : subst =
  let s2' = SMap.map (apply_ty s1) s2 in
  SMap.union (fun _ a _ -> Some a) s1 s2'

let rec ftv_ty = function
  | TInt | TBool -> SSet.empty
  | TVar a       -> SSet.singleton a
  | TFun (a, b)  -> SSet.union (ftv_ty a) (ftv_ty b)

let ftv_scheme (Forall (vs, t)) =
  SSet.diff (ftv_ty t) (SSet.of_list vs)

let ftv_env (e : env) =
  SMap.fold (fun _ s acc -> SSet.union (ftv_scheme s) acc) e SSet.empty

(* --- Fresh type variables ------------------------------------------ *)

let counter = ref 0
let fresh () =
  incr counter;
  TVar (Printf.sprintf "a%d" !counter)

(* --- Unification (Robinson) ---------------------------------------- *)

exception Type_error of string

let bind_var a t =
  if t = TVar a then SMap.empty
  else if SSet.mem a (ftv_ty t)
  then raise (Type_error (Printf.sprintf "occurs check: %s in larger type" a))
  else SMap.singleton a t

let rec unify (t1 : ty) (t2 : ty) : subst =
  match t1, t2 with
  | TInt, TInt | TBool, TBool       -> SMap.empty
  | TVar a, t  | t, TVar a          -> bind_var a t
  | TFun (a1, b1), TFun (a2, b2)    ->
      let s1 = unify a1 a2 in
      let s2 = unify (apply_ty s1 b1) (apply_ty s1 b2) in
      compose s2 s1
  | _ ->
      raise (Type_error "type mismatch")

(* --- Generalisation & instantiation -------------------------------- *)

let generalize (e : env) (t : ty) : scheme =
  let vs = SSet.diff (ftv_ty t) (ftv_env e) in
  Forall (SSet.elements vs, t)

let instantiate (Forall (vs, t)) : ty =
  let s =
    List.fold_left (fun m v -> SMap.add v (fresh ()) m) SMap.empty vs
  in
  apply_ty s t

(* --- Algorithm W --------------------------------------------------- *)

let rec infer (e : env) (ex : expr) : subst * ty =
  match ex with
  | EInt  _ -> SMap.empty, TInt
  | EBool _ -> SMap.empty, TBool
  | EVar x ->
      (match SMap.find_opt x e with
       | Some sch -> SMap.empty, instantiate sch
       | None     -> raise (Type_error ("unbound variable: " ^ x)))
  | EFun (x, body) ->
      let tv  = fresh () in
      let e'  = SMap.add x (Forall ([], tv)) e in
      let s, t = infer e' body in
      s, TFun (apply_ty s tv, t)
  | EApp (f, a) ->
      let s1, tf = infer e f in
      let s2, ta = infer (apply_env s1 e) a in
      let tv = fresh () in
      let s3 = unify (apply_ty s2 tf) (TFun (ta, tv)) in
      compose s3 (compose s2 s1), apply_ty s3 tv
  | ELet (x, e1, e2) ->
      let s1, t1 = infer e e1 in
      let e'     = apply_env s1 e in
      let sch    = generalize e' t1 in
      let s2, t2 = infer (SMap.add x sch e') e2 in
      compose s2 s1, t2
  | EIf (c, th, el) ->
      let s1, tc = infer e c in
      let s2     = unify tc TBool in
      let s12    = compose s2 s1 in
      let e1     = apply_env s12 e in
      let s3, tt = infer e1 th in
      let s4, te = infer (apply_env s3 e1) el in
      let s5     = unify (apply_ty s4 tt) te in
      let s      = compose s5 (compose s4 (compose s3 s12)) in
      s, apply_ty s te
  | EBop (op, a, b) ->
      let s1, ta = infer e a in
      let s2, tb = infer (apply_env s1 e) b in
      let s3 = unify (apply_ty s2 ta) TInt in
      let s4 = unify (apply_ty s3 tb) TInt in
      let s  = compose s4 (compose s3 (compose s2 s1)) in
      let result = match op with Eq | Lt -> TBool | _ -> TInt in
      s, result

(* --- Pretty printing ----------------------------------------------- *)

let rec pp_ty = function
  | TInt        -> "int"
  | TBool       -> "bool"
  | TVar a      -> "'" ^ a
  | TFun (a, b) ->
      let l = match a with TFun _ -> "(" ^ pp_ty a ^ ")" | _ -> pp_ty a in
      l ^ " -> " ^ pp_ty b

let type_of (ex : expr) : ty =
  counter := 0;
  let s, t = infer SMap.empty ex in
  apply_ty s t

(* --- Smoke tests --------------------------------------------------- *)

let () =
  let cases = [
    "42",                EInt 42;
    "true",              EBool true;
    "fun x -> x",        EFun ("x", EVar "x");
    "let id = fun x -> x in id 3",
      ELet ("id", EFun ("x", EVar "x"),
            EApp (EVar "id", EInt 3));
    "let id = fun x -> x in (id 1, id true) ~ poly",
      ELet ("id", EFun ("x", EVar "x"),
            EBop (Add, EApp (EVar "id", EInt 1),
                       EIf (EApp (EVar "id", EBool true), EInt 0, EInt 1)));
    "if true then 1 else 2",
      EIf (EBool true, EInt 1, EInt 2);
    "fun f -> fun x -> f (f x)",
      EFun ("f", EFun ("x",
                  EApp (EVar "f", EApp (EVar "f", EVar "x"))));
  ] in
  List.iter
    (fun (label, e) ->
       try
         let t = type_of e in
         Printf.printf "%-50s : %s\n" label (pp_ty t)
       with Type_error msg ->
         Printf.printf "%-50s : TYPE ERROR (%s)\n" label msg)
    cases
