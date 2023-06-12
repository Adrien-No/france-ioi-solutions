let rec pierres_pyramide (pierres : int) (h:int) : int*int =
  (* renvoie la hauteur max et le nb de pierres necessaires *)
  if pierres-h*h >= 0 then pierres_pyramide (pierres-h*h) (h+1)
  else let hmax = h-1 in hmax,hmax*(hmax+1)*(2*hmax+1)/6

let _ =
let h, nb_p = pierres_pyramide (read_int()) 0 in Printf.printf "%i\n%i" h nb_p

(*let rec h_max (pierres : int) (h:int): int =
  match pierres with
  | p when p-h*h >= 0 -> (if h = 0 then 0 else 1) + h_max (pierres-(h*h)) (h+1)
  | _ -> 0

let _ =
  let hmax = h_max (read_int()) 0 in Printf.printf "%i\n%i" hmax (hmax*(hmax+1)*(2*hmax+1)/6)
*)
