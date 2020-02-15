(** Generated by coq-of-ocaml *)
Require Import OCaml.OCaml.

Local Open Scope string_scope.
Local Open Scope Z_scope.
Local Open Scope type_scope.
Import ListNotations.

Unset Positivity Checking.
Unset Guard Checking.

Require Import Tezos.Environment.
Require Tezos.Alpha_context.
Require Tezos.Storage_description.

Import Alpha_context.

Module rpc_context.
  Record record := Build {
    block_hash : (|Block_hash|).(S.HASH.t);
    block_header : Alpha_context.Block_header.shell_header;
    context : Alpha_context.t }.
  Definition with_block_hash block_hash (r : record) :=
    Build block_hash r.(block_header) r.(context).
  Definition with_block_header block_header (r : record) :=
    Build r.(block_hash) block_header r.(context).
  Definition with_context context (r : record) :=
    Build r.(block_hash) r.(block_header) context.
End rpc_context.
Definition rpc_context := rpc_context.record.

Definition rpc_init (function_parameter : Updater.rpc_context)
  : Lwt.t (Error_monad.tzresult rpc_context) :=
  let '{|
    Updater.rpc_context.block_hash := block_hash;
      Updater.rpc_context.block_header := block_header;
      Updater.rpc_context.context := context
      |} := function_parameter in
  let level := block_header.(Block_header.shell_header.level) in
  let timestamp := block_header.(Block_header.shell_header.timestamp) in
  let fitness := block_header.(Block_header.shell_header.fitness) in
  Error_monad.op_gtgteqquestion
    (Alpha_context.prepare context level timestamp timestamp fitness)
    (fun context =>
      Error_monad.__return
        {| rpc_context.block_hash := block_hash;
          rpc_context.block_header := block_header;
          rpc_context.context := context |}).

Definition rpc_services
  : Pervasives.ref (RPC_directory.t Updater.rpc_context) :=
  Pervasives.__ref_value RPC_directory.empty.

Definition register0_fullctxt {A B C : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      Updater.rpc_context A B C)
  (f : rpc_context -> A -> B -> Lwt.t (Error_monad.tzresult C)) : unit :=
  Pervasives.op_coloneq rpc_services
    (RPC_directory.register (Pervasives.op_exclamation rpc_services) s
      (fun ctxt =>
        fun q =>
          fun i =>
            Error_monad.op_gtgteqquestion (rpc_init ctxt)
              (fun ctxt => f ctxt q i))).

Definition opt_register0_fullctxt {A B C : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      Updater.rpc_context A B C)
  (f : rpc_context -> A -> B -> Lwt.t (Error_monad.tzresult (option C)))
  : unit :=
  Pervasives.op_coloneq rpc_services
    (RPC_directory.opt_register (Pervasives.op_exclamation rpc_services) s
      (fun ctxt =>
        fun q =>
          fun i =>
            Error_monad.op_gtgteqquestion (rpc_init ctxt)
              (fun ctxt => f ctxt q i))).

Definition register0 {A B C : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      Updater.rpc_context A B C)
  (f : Alpha_context.t -> A -> B -> Lwt.t (Error_monad.tzresult C)) : unit :=
  register0_fullctxt s
    (fun function_parameter =>
      let '{| rpc_context.context := context |} := function_parameter in
      f context).

Definition register0_noctxt {A B C D : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context A B C D)
  (f : B -> C -> Lwt.t (Error_monad.tzresult D)) : unit :=
  Pervasives.op_coloneq rpc_services
    (RPC_directory.register (Pervasives.op_exclamation rpc_services) s
      (fun function_parameter =>
        let '_ := function_parameter in
        fun q => fun i => f q i)).

Definition register1_fullctxt {A B C D : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      (Updater.rpc_context * A) B C D)
  (f : rpc_context -> A -> B -> C -> Lwt.t (Error_monad.tzresult D)) : unit :=
  Pervasives.op_coloneq rpc_services
    (RPC_directory.register (Pervasives.op_exclamation rpc_services) s
      (fun function_parameter =>
        let '(ctxt, arg) := function_parameter in
        fun q =>
          fun i =>
            Error_monad.op_gtgteqquestion (rpc_init ctxt)
              (fun ctxt => f ctxt arg q i))).

Definition register1 {A B C D : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      (Updater.rpc_context * A) B C D)
  (f : Alpha_context.t -> A -> B -> C -> Lwt.t (Error_monad.tzresult D))
  : unit :=
  register1_fullctxt s
    (fun function_parameter =>
      let '{| rpc_context.context := context |} := function_parameter in
      fun x => f context x).

Definition register1_noctxt {A B C D E : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context (A * B) C D E)
  (f : B -> C -> D -> Lwt.t (Error_monad.tzresult E)) : unit :=
  Pervasives.op_coloneq rpc_services
    (RPC_directory.register (Pervasives.op_exclamation rpc_services) s
      (fun function_parameter =>
        let '(_, arg) := function_parameter in
        fun q => fun i => f arg q i)).

Definition register2_fullctxt {A B C D E : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      ((Updater.rpc_context * A) * B) C D E)
  (f : rpc_context -> A -> B -> C -> D -> Lwt.t (Error_monad.tzresult E))
  : unit :=
  Pervasives.op_coloneq rpc_services
    (RPC_directory.register (Pervasives.op_exclamation rpc_services) s
      (fun function_parameter =>
        let '((ctxt, arg1), arg2) := function_parameter in
        fun q =>
          fun i =>
            Error_monad.op_gtgteqquestion (rpc_init ctxt)
              (fun ctxt => f ctxt arg1 arg2 q i))).

Definition register2 {A B C D E : Set}
  (s :
    RPC_service.t
      ((* `DELETE *) unit + (* `GET *) unit + (* `PATCH *) unit +
        (* `POST *) unit + (* `PUT *) unit) Updater.rpc_context
      ((Updater.rpc_context * A) * B) C D E)
  (f : Alpha_context.t -> A -> B -> C -> D -> Lwt.t (Error_monad.tzresult E))
  : unit :=
  register2_fullctxt s
    (fun function_parameter =>
      let '{| rpc_context.context := context |} := function_parameter in
      fun a1 => fun a2 => fun q => fun i => f context a1 a2 q i).

Definition get_rpc_services (function_parameter : unit)
  : RPC_directory.directory Updater.rpc_context :=
  let '_ := function_parameter in
  let __p_value :=
    RPC_directory.map
      (fun c =>
        Error_monad.op_gtgteq (rpc_init c)
          (fun function_parameter =>
            match function_parameter with
            | Pervasives.Error _ =>
              (* ❌ Assert instruction is not handled. *)
              assert false
            | Pervasives.Ok c => Lwt.__return c.(rpc_context.context)
            end))
      (Storage_description.build_directory Alpha_context.description) in
  RPC_directory.register_dynamic_directory None
    (Pervasives.op_exclamation rpc_services)
    (RPC_path.op_div
      (RPC_path.op_div (RPC_path.op_div RPC_path.open_root "context") "raw")
      "json")
    (fun function_parameter =>
      let '_ := function_parameter in
      Lwt.__return __p_value).
