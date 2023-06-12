let split_on_char sep s =
  let rec aux i token acc =
    if i = String.length s
    then token :: acc
    else if s.[i] = sep
         then aux (i+1) "" (token::acc)
         else aux (i+1) (token ^ String.make 1 s.[i]) acc
  in List.rev (aux 0 "" [])

let init (n:int) (f:int -> 'a) : 'a list =
  if n < 0 then raise (Invalid_argument "len < 0") else
  let rec aux c =
    if c = n then []
    else f c :: aux (c+1)
  in
  aux 0

let _ = List.iter (fun param -> match param with [s1;s2] -> Printf.printf "%s %s\n" s1 s2 | _ -> ())
  (
  List.sort
  (fun l1 l2 -> String.compare (List.nth l1 0) (List.nth l2 0))
  (List.map (fun _ -> List.rev (split_on_char ' ' (read_line()))) (init (read_int()) (fun _ -> "","")))
)
