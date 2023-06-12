(* Une case coupante est une case avec trop de moustiques. *)
(* Une parcelle est une zone du camping (tableau de cases).*)

(* Amélioration possible : on choisi la coupante la plus au centre d'une parcelle *)

type parcelle = bool array array
type s_parcelle = (int*int)*(int*int)*(int*int)*(int*int) (* deuxième représentation d'une parcelle, selon ses quatres sommets la délimitant dans le camping *)
type cases_coupantes = (int*int) list

let flip f x y = f y x

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

exception Exit
let coupe_parcelle (t:s_parcelle) (((x,y)::q):cases_coupantes) : (s_parcelle*cases_coupantes) list =
  (* on coupe t selon la première case coupante de la liste. On obtient quatres sous-parcelles, certaines éventuellement vides, avec leurs cases coupantes associées (càd qui ont un impact sur ces dernières) *)
  let hg, hd, bg, bd = t in

  let transmettre_coupantes ((x0,y0),_,_,(x1,y1)) l =
    (* renvoie la liste des cases compantes effectives sur la s_parcelle donnée en paramètre *)
    List.filter (fun (x,y) -> x0 <= x && x <= x1 && y0 <= y && y <= y1) l
  in
  (* ceci n'est pas du hard-coding *)
  [(hg, hd, (fst hg,y-1), (fst hd,y-1)) ; ((fst hg, y+1), (fst hd, y+1), bg, bd) ; (hg, (x-1,snd hd), bg, (x-1,snd bd)) ; ((x+1,snd hg), hd, (x+1,snd bg), bd)] (* sous-parcelles de t *)
  |> List.map (fun t -> t, transmettre_coupantes t q)

let dimension_parcelle ((hg, _, _, bd):s_parcelle) : int*int =
  (* renvoie les dimensions d'une parcelle *)
  (fst bd - fst hg)+1, (snd bd - snd hg)+1

let cote_parcelle t : int = let x,y = dimension_parcelle t in min x y

let trouve_parcelle_max ((t,n,m):parcelle*int*int) : int =
  (* coupe la parcelle principale t de taille n*m jusqu'à trouver une parcelle (carrée) de taille maximale (sans moustiques ie sans cases coupantes)*)

  let taille_max = ref 1 in
  let parcelles = Queue.create () in
  let coupantes = ref [] in Array.iteri (fun i l -> Array.iteri (fun j x -> if x then coupantes := (i,j)::!coupantes) l) t;
  Queue.push ((((0,0),(n-1,0),(0,m-1),(n-1,m-1)),!coupantes):s_parcelle*cases_coupantes) parcelles;

  let tours_boucle = ref 0 in

  try
  while not (Queue.is_empty parcelles) do
    if !tours_boucle > 40000 then raise Exit else incr tours_boucle;
      let parcelle,coupantes = Queue.pop parcelles in
      if cote_parcelle parcelle <= !taille_max then ()
      else
        match coupantes with
          [] -> taille_max := cote_parcelle parcelle (* en accord avec la première condition du IF, pas besoin de comparer avec max *)
        | t::q -> coupe_parcelle parcelle (t::q) |> List.iter ((flip Queue.push)parcelles)
  done;
  !taille_max
  with Exit -> !taille_max

let _ =
  read_entry()
  |> trouve_parcelle_max
  |> Printf.printf "%i"

(* Note : 10000 itérations suffisent à trouver une solution optimale pour tout les tests sauf le 18 *)
