let prenoms = String.split_on_char ' ' (read_line()) in

let rec nombre (l:string list) : unit =
  match l with
  | [] -> ()
  | t::q ->
    let nb = ref (String.fold_left (fun x c -> x + (Char.code c) -65) 0 t) in
    while !nb >= 10 do
      (* le nombre devient la somme de ses chiffres *)
       nb := String.fold_left (fun x c -> x + int_of_char c - 48) 0 (string_of_int !nb)
    done;
    Printf.printf "%i" !nb;
    if q <> [] then Printf.printf " ";
    nombre q
in
nombre prenoms
