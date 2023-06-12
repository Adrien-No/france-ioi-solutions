let print_int_array (a:int array) : unit =
  Printf.printf "[|";
  for i = 0 to Array.length a -2 do
    Printf.printf "%i ;"a.(i)
  done;
  Printf.printf "%i|]\n" a.(Array.length a -1)

let split_on_char (sep_char:char) (s:string) : string list=
  let string_rev (s:string) : string =
  let string_list = ref [] in
  for i = 0 to String.length s -1 do
    string_list := (String.make 1 s.[i]) :: !string_list
  done;
  String.concat "" !string_list in

  let temp_string = ref []
  and string_list = ref [] in
  for i = 0 to String.length s-1 do
    if s.[i] = sep_char  then
      begin
        string_list := (String.concat "" !temp_string) :: !string_list;
        temp_string := []
      end

    else if i = String.length s -1 then
      begin
        temp_string := (String.make 1 s.[i]) :: !temp_string;
        string_list := (String.concat "" !temp_string) :: !string_list
      end
    else
      temp_string := (String.make 1 s.[i]) :: !temp_string
  done;

  let rev_elts_list = ref [] in
  for i = 0 to List.length !string_list -1 do
    rev_elts_list := string_rev (List.nth !string_list i) :: !rev_elts_list
  done;
  !rev_elts_list

let rec min_list (l:'a list) (min:'a): int =
  match l with
  | [] -> min
  | t::q -> min_list q (if t < min then t else min)

let there_is_strict_max (a:'a array) : bool =
  if a = [||] then failwith "tableau vide" else
  let temp_max = ref a.(0)
  and strict = ref true in
  for i = 0 to Array.length a -1 do
    if a.(i) = !temp_max then
      strict := false
    else if a.(i) > !temp_max then
      begin
        temp_max := a.(i);
        strict := true
      end
  done;
  !strict

let i_max_tab (a:'a array) : int =
  let i_max = ref 0 in
  for i = 0 to Array.length a -1 do
    if a.(i) > a.(!i_max) then
        i_max := i
  done;
  !i_max

let _ = let nbGrenouille = read_int() in
let total_walk = Array.make nbGrenouille 0 and
times_first = Array.make nbGrenouille 0 and
nbTours = read_int() in

(* pour chaque tours on :
 * - ajoute la distance parcourue ce tour-ci
 * - regarde qui est premier *)
  (*print_string "Grenouilles : ";
for i = 1 to nbGrenouille do
  Printf.printf "%i " i
done;
    print_string "\n";*)
for i = 1 to nbTours do
  (*Printf.printf "Tour %i : " i;
  for i = 0 to nbGrenouille-1 do
    Printf.printf "%i " total_walk.(i)
  done;
     print_newline();*)

  (* qui est en tête en début de tour ? *)
  if there_is_strict_max total_walk then
    (* on incrémente le compteur de "être en début de tour" *)
    begin
      let i_max = i_max_tab total_walk in
      times_first.(i_max) <- times_first.(i_max) + 1
    end;

  (* une grenouille fait un bond *)
  let line = read_line() in
    let liste = split_on_char ' ' line in
    let i_grenouille, distance = int_of_string (List.hd liste)-1, int_of_string (List.nth liste 1) in

  (* la grenouille d'indice num_grenouille-1 (car on compte le 0) fait un bond de distance *)
    total_walk.(i_grenouille) <- total_walk.(i_grenouille) + distance;

done;

 (* Maintenant on résout le pb des égalités en choisissant dans ce cas là le + petit numéro *)
let temp_i_max = ref 0 in
for i = 0 to nbGrenouille-1 do

  if times_first.(i) > times_first.(!temp_i_max) then
    temp_i_max := i;
  (*Printf.printf "i : %i | i_max : %i\n" i !temp_i_max*)
done;

print_int (!temp_i_max+1)(*; print_newline();(* c'est un indice partant de 0 donc on ajoute un pour décaler car les grenouilles commencent à 1*)
print_int_array times_first;
  print_int_array total_walk*)
