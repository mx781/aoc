(* Ocaml 4.06.0 *)
let load_file filename =
  let channel = open_in filename in
  let length = in_channel_length channel in
  let input = really_input_string channel length in
  Str.split (Str.regexp "\n") input;;

let valid_passphrase phrase = 
  let words = Str.split (Str.regexp " ") phrase in
  List.map (fun x -> print_endline x) words in
  List.fold_left (
    fun is_valid word ->
      if is_valid == false
        then false
      else
        let all_word_instances = List.filter (fun x -> x == word) words in
        (List.length all_word_instances) == 1
  ) true words;;

let passphrase_list = load_file "input" in
let validity = List.map valid_passphrase passphrase_list in
let valid_ones = List.filter (fun e -> e == true) validity in
let valid_count = List.length valid_ones in
valid_count;;
