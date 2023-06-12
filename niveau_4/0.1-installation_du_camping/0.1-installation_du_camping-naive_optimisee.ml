Printexc.record_backtrace true

let print_int_array a = Printf.printf "[|"; Array.iteri (fun i x -> Printf.printf "%i" x; if i < Array.length a -1 then Printf.printf " ") a; Printf.printf "|]\n"
let print_int_array_array a = Printf.printf "[|\n"; Array.iteri (fun i l -> print_int_array l) a; Printf.printf "|]\n"
let print_bool_array a = Printf.printf "[|"; Array.iteri (fun i x -> if x then Printf.printf "true" else Printf.printf "false"; if i < Array.length a -1 then Printf.printf " ") a; Printf.printf "|]\n"
let print_bool_array_array a = Printf.printf "[|\n"; Array.iteri (fun i l -> print_bool_array l) a; Printf.printf "|]\n"

let split_on_char sep s =
  let rec aux i token acc =
    if i = String.length s
    then token :: acc
    else if s.[i] = sep
    then aux (i+1) "" (token::acc)
    else aux (i+1) (token ^ String.make 1 s.[i]) acc
  in List.rev (aux 0 "" [])

let study f x = f x; x

(* let read_entry () = *)
(*   let nbLignes,nbColonnes = Scanf.scanf "%i %i" (fun l c -> l,c) in *)
(*   (fun _ -> read_line() *)
(*   |> String.split_on_char ' ' *)
(*   |> List.map int_of_string *)
(*   |> Array.of_list) *)
(*   |> Array.init nbLignes *)
(*   |> study print_int_array_array, nbColonnes, nbLignes *)

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

let compute_solution () =
  let t, n, m = read_entry() in
  (* t est le tableau représentant le camping, *)
  (* n et m sont les dimensions du tableau *)

  let next_square (x,y) (c:int) : bool =
    (* on suppose le carré de bord haut-gauche de coordonées (x,y) et de coté c possible, on renvoie si le carré de côté (c+1) est possible*)

    (* test dépassement *)
    if x + c > n-1 || y + c > m-1 then false

    (* Très impératif mais c'est plus simple de raisonner ainsi dans ce cas. *)
    else
      let res = ref true in
      for j = 0 to c do
        if t.(x+c).(y+j) then res := false
      done;
      for i = 0 to c do
        if t.(x+i).(y+c) then res := false
      done;
      (* l'on a testé deux fois la case de coordonée (x+c,y+c) mais c'est pas gênant. *)
      !res
  in

  let taille_max cote_max (x,y) =
    (* renvoie le carré de taille maximale avec pour coin haut-gauche le point de coordonées (x,y) *)

    if not (next_square (x,y) (2*cote_max/2)) || not (next_square (x,y) cote_max) then 0 else
      let rec aux c =
        if next_square (x,y) c then aux (c+1)
        else c
      in
      aux 0
  in

  let maxi = ref 0 in
  (* for i = 0 to n-1 do *)
  (*   for j = 0 to m-1 do *)
  (*     maxi := max !maxi (taille_max !maxi (i,j)) *)
  (*   done; *)
  (* done; *)

  (* on envisage un autre parcours des couples (i,j). *)
  for distance = 0 to min (n-1) (m-1) do
    for i = 0 to n-1 do
      for j = 0 to m-1 do
        if i+j = distance then
          maxi := max !maxi (taille_max !maxi (i,j))
      done;
    done;
  done;
  (* puisque c'est pas un carré, il manque encore à parcourir les couples où i ou j > min (n-1) (m-1)*)
  begin
    if n > m then
      for i = m to n-1 do
        for j = 0 to m-1 do
          maxi := max !maxi (taille_max !maxi (i,j))
        done;
      done
    else
      for i = 0 to n-1 do
        for j = n to m-1 do
          maxi := max !maxi (taille_max !maxi (i,j))
        done;
      done
  end;
  !maxi

let _ =
  Printf.printf "%i" (compute_solution())
