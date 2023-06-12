(* Problème de programmation dynamique. *)
(* L'on construit le tableau (ou ici on mémoïse à l'aide d'un cache) des carrés de tailles maximum partant des coordonnées (x,y) pour x et y variant dans (n,m) les bordures du camping.*)
(* Il suffit ensuite de pendre la taille maximale parmis les n*m cases du tableau nouvellement créé. *)

(* ---------------- fonctions de la stdlib ---------------- *)
let split_on_char sep s =
  let rec aux i token acc =
    if i = String.length s
    then token :: acc
    else if s.[i] = sep
    then aux (i+1) "" (token::acc)
    else aux (i+1) (token ^ String.make 1 s.[i]) acc
  in List.rev (aux 0 "" [])
let list_init len f = Array.init len f |> Array.to_list
let min3 x y z = min (min x y) z
(* -------------------------------------------------------- *)

let read_entry () =
  let nbLignes, nbColonnes = read_line() |> split_on_char ' ' |> List.map int_of_string |> function [l;c] -> l,c | _ -> failwith "erreur dans la lecture de l'entrée" in

  let t = Array.make nbLignes [||] in
  for i = 0 to nbLignes-1 do
    t.(i) <- read_line()
             |> split_on_char ' '
             |> List.map (fun x -> if x = "1" then true else false)
             |> Array.of_list
  done;
  t, nbLignes, nbColonnes

let compute_solution (t, n, m) =
  let h = Hashtbl.create (n*m) in
  let rec pgcl_cache c = if Hashtbl.mem h c then Hashtbl.find h c else begin let res = pgcl c in Hashtbl.add h c res; res end
  and pgcl (x,y) =
    (* Plus Grand Carré Libre ayant pour coin haut-gauche le point de coordonnées (x,y)*)
    if x = n || y = m || t.(x).(y) then 0
    else 1 + min3 (pgcl_cache (x+1,y)) (pgcl_cache (x,y+1)) (pgcl_cache (x+1,y+1))
  in
  list_init n (fun i -> list_init m (fun j -> pgcl_cache (i,j)))
  |> List.concat
  |> List.fold_left max 0

let _ =
  read_entry()
  |> compute_solution
  |> Printf.printf "%i"
