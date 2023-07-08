let rec vider = function
  (* on suppose qu'au début de l'appel de cette fonction, le tableau est rempli jusqu'à n *)
    1 -> Printf.printf "1\n"
  | 2 -> Printf.printf "2\n1\n"
  (* | 3 -> vider 1; Printf.printf "3\n"; remplir 1; Printf.printf "%i\n" 2; vider 1 *)
  (* | 4 -> vider 2; Printf.printf "4\n"; remplir 2; vider 3 *)
  (* | 5 -> vider 3; Printf.printf "5\n"; remplir 3; vider 4 *)
  | n -> vider (n-2) ; Printf.printf "%i\n" n; remplir (n-2); vider (n-1)

and remplir = function
  (* on suppose qu'au début de l'appel le tableau est vide jusqu'à n *)
    0 -> ()
  | 1 -> Printf.printf "1\n"
  | 2 -> remplir 1; Printf.printf "2\n"
  (* | 3 -> remplir 2; vider 1; Printf.printf "3\n"; remplir 1 *)
  (* | 4 -> remplir 3; vider 2; Printf.printf "4\n"; remplir 2 *)
  | n -> remplir (n-1) ; vider (n-2) ; Printf.printf "%i\n" n ; remplir (n-2)

let _ =
  vider (read_int())
