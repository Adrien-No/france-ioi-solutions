(* -------------------------- AFFICHAGE ----------------------------*)
let print_int_list (l:int list) : unit =
  print_string "[";
  let rec aux (l:int list) =
    match l with
    | [] -> print_string "]"
    | t::[] -> (Printf.printf "%d]" t)
    | t::q -> (Printf.printf "%d; " t; aux q)
  in aux l

let print_int_array (t:int array) : unit =
  Printf.printf "[|";
  for i = 0 to Array.length t-1 do
    Printf.printf "%i" t.(i);
    if i <> Array.length t-1 then Printf.printf ";"
  done;
Printf.printf "|]"

let print_int_array a = Printf.printf "[|"; Array.iteri (fun i x -> Printf.printf "%i" x; if i < Array.length a -1 then Printf.printf " ") a; Printf.printf "|]\n"
let print_int_array_array a = Printf.printf "[|\n"; Array.iteri (fun i l -> print_int_array l) a; Printf.printf "|]\n"
let print_bool_array a = Printf.printf "[|"; Array.iteri (fun i x -> if x then Printf.printf "true" else Printf.printf "false"; if i < Array.length a -1 then Printf.printf " ") a; Printf.printf "|]\n"
let print_bool_array_array a = Printf.printf "[|\n"; Array.iteri (fun i l -> print_bool_array l) a; Printf.printf "|]\n"

(* --------------------------- listes ----------------------------- *)
let rec max_list (l:'a list) : 'a =
  match l with
  | [] -> failwith "liste vide"
  | t::q -> if q = [] then t else max t (max_list q)

let rec fold_left (f : 'a -> 'b -> 'a) (b : 'a) (l : 'b list) : 'a =
    match l with
    | [] -> b
    | t::q -> fold_left f (f b t) q

(* --------------------------- String ---------------------------- *)
let split_on_char (sep:char option) (s:string) : string list =
  let rec aux i token acc =
    if i = String.length s
    then token :: acc
    else if Option.is_some sep then
        if s.[i] = Option.get sep
        then aux (i+1) "" (token::acc)
        else aux (i+1) (token ^ String.make 1 s.[i]) acc
    else aux (i+1) "" ((String.make 1 s.[i])::acc)
  in List.rev (aux 0 "" [])

let split_on_char sep s =
  let rec aux i token acc =
    if i = String.length s
    then token :: acc
    else if s.[i] = sep
         then aux (i+1) "" (token::acc)
         else aux (i+1) (token ^ String.make 1 s.[i]) acc
  in List.rev (aux 0 "" [])

let disassemble_string (s:string) : char list =
  let rec aux (i_s : int) (len_s : int) (acc : char list) : char list =
    if i_s = len_s
    then acc
    else aux (i_s+1) len_s (s.[i_s] :: acc)
  in List.rev (aux 0 (String.length s) [])

let rec string_fold_left f b s = List.fold_left f b (disassemble_string s)

(* ------------------------ List ------------------------------ *)
