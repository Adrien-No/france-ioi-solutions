let _ =
  let t = Array.make 26 0 in
  let ch = read_line() in
  (* let n = String.length ch in*)
  let nb_chars = ref 0 in

  let treat_char c =
    let code = c |> Char.uppercase_ascii |> Char.code in
    if 65 <= code && code < (65+26) then begin
      t.(code-65) <- t.(code-65) + 1;
      incr nb_chars end
  in

  String.iter (treat_char) ch;

  (* affichage *)
  Array.iter (fun nb_letters -> Printf.printf "%f\n" ((float_of_int nb_letters) /. (float_of_int !nb_chars))) t
