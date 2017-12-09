let load_file filename =
  let channel = open_in filename in
  let length = in_channel_length channel in
  let input = really_input_string channel length in
  Str.split (Str.regexp "\n") input;;

let rec validate word_list =
  match word_list with
  | [] -> true
  | hd::tl -> let lookup = List.filter (fun w -> w = hd) tl in
              if (List.length lookup) > 0 then false else (validate tl);;

let char_frequency word =
  let char_list = List.map (fun s -> String.get s 0) (Str.split (Str.regexp "") word) in
  let freqs = List.map (fun c -> (c, List.length (List.filter (fun c' -> c = c') char_list))) char_list in
  List.sort_uniq (fun a b ->
    let c1 = int_of_char (fst a) in
    let c2 = int_of_char (fst b) in
    if c1 = c2 then
      0
    else
      if c1 > c2 then
        1
      else -1
  ) freqs;;

let rec validate2 word_list =
  match word_list with
  | [] -> true
  | hd::tl -> let lookup = List.filter (fun w -> char_frequency w = char_frequency hd) tl in
              if (List.length lookup) > 0 then false else (validate2 tl);;

let valid_passphrase phrase = 
  let words = Str.split (Str.regexp " ") phrase in
  validate2 words;;

let passphrases = load_file "input" in
let validity = List.map valid_passphrase passphrases in
let valid_ones = List.filter (fun e -> e == true) validity in
let valid_count = List.length valid_ones in
print_endline (string_of_int valid_count);;
