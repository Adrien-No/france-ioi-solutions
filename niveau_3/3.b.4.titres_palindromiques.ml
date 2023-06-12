let nbLivres = read_int()

let rec no_space_no_maj s =
  if s = "" then ""
  else if s.[0] = ' ' then
    no_space_no_maj (String.sub s 1 (String.length s-1))
  else
    (String.uncapitalize_ascii (String.sub s 0 1)) ^ no_space_no_maj (String.sub s 1 (String.length s-1))

let is_palindrome s =
  (*  Printf.printf "test palindrome : %s\n" s;*)
  let rec aux (acc:string) : unit =
    (*  Printf.printf "%s\n" acc;*)
    let n = String.length acc in
    if n = 0 || n = 1 then begin
      if s != "" then Printf.printf "%s\n" s end
    else if acc.[0] = acc.[n-1] then begin
      (* Printf.printf "%c = %c\n" acc.[0] acc.[n-1];*)
      aux (String.sub acc 1 (n-2)) end
    (* else Printf.printf " %c != %c\n" acc.[0] acc.[n-1]*)
  in
  s |> no_space_no_maj |> aux

let _ =
  Array.iter (is_palindrome) (Array.map (fun _ -> read_line()) (Array.make nbLivres ""))
