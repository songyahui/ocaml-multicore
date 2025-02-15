effect Foo : (unit -> int)

effect Goo : (unit -> int)

let f () 
(*@ requires emp @*)
(*@ ensures  Foo @*)
  = perform Foo ()

let res : int
  (*@ requires emp @*)
  (*@ ensures  Foo.Goo @*)
  =
  match f () with
  | x -> 1
  | effect Foo k ->
     continue k (fun () -> perform Goo ())

  | effect Goo k ->
     continue k (fun () -> 1)

