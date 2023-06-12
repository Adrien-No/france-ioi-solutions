(* On va mettre en évidence le problème de programmation dynamique. *)

(* On part de la sous-matrice de taille 1*1 : le coin BD (bas-droit), et on va progresser vers la matrice toute entière.*)

(* Soit un point p de coordonnées (x,y), le plus grand carré libre (pgcl) ayant pour coin HG (haut-gauche) le point p est de taille :
   pgcl(x,y) = 1 + min (pgcl (x+1,y)) (pgcl(x,y+1))
*)

(* Il faudra ensuite gérer le cas particulier du rectangle obtenu en soustrayant un certain carré de taille maximale au rectangle représentant le camping. *)

(* Enfin, l'on renverra le maximum obtenable par un point de coordonnées (x,y) variant dans le rectangle. *)

let split_on_char sep s =
  let rec aux i token acc =
    if i = String.length s
    then token :: acc
    else if s.[i] = sep
    then aux (i+1) "" (token::acc)
    else aux (i+1) (token ^ String.make 1 s.[i]) acc
  in List.rev (aux 0 "" [])

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

let compute_solution() =
  let t, n, m = read_entry() in
  let pgctl (x,y) =
    (* Plus Grand Carré Libre dans le sous-rectangle de coin haut-gauche (x,y)*)
    if x = n || y = m then 0
    else begin
      if
      1 + min (pgctl (x+1,y)) (pgctl (x,y+1))
        end
