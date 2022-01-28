open Minibash
open Interpreter.Eval (Interpreter.Result)
open Angstrom.Buffered

let try_finish st =
  match feed st `Eof with
  | Done ({ len }, res) when len = 0 -> Ok res
  | Done ({ buf; off; len }, _) ->
    Error (Printf.sprintf "syntax error: %s" (Bigstringaf.substring buf ~off ~len))
  | Fail (_, _, e) -> Error ("parser failed" ^ e)
  | Partial _ -> Error "partial parsing state"
;;

let rec parse_input st =
  let line =
    try read_line () with
    | End_of_file ->
      print_endline "exit";
      "exit"
  in
  match line with
  | "" -> Some (try_finish st)
  | "exit" -> None
  | _ ->
    let st = feed st (`String (line ^ "\n")) in
    (match try_finish st with
    | Ok res -> Some (Ok res)
    | Error _ ->
      print_string "> ";
      parse_input st)
;;

let rec repl env =
  print_string "$ ";
  match parse_input (Parser.make_state ()) with
  | Some (Ok script) ->
    (match ev_script env script with
    | Ok env ->
      Printf.printf "return code: %d\n" env.retcode;
      repl env
    | Error e ->
      Printf.printf "evaluation error: %s\n" e;
      repl env)
  | Some (Error e) ->
    print_endline e;
    repl env
  | None -> exit 0
;;

let () =
  print_endline "\tMiniBash REPL";
  print_endline
    "- To run a command, type it and press Enter\n\
     - To stop typing a multiline command prematurely, enter an empty line\n\
     - To exit REPL type `exit` or press Ctrl-D";
  repl empty_env
;;
