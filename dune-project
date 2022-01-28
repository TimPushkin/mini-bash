(lang dune 2.9)

(generate_opam_files true)

(cram enable)

(license LGPL-3.0-only)

(authors "Timofey Pushkin")

(maintainers "Timofey Pushkin")

(bug_reports "https://github.com/TimPushkin/mini-bash/issues")

(homepage "https://github.com/TimPushkin/mini-bash")

(package
 (name minibash)
 (synopsis "An implementation of Bash mini-language")
 (description
  "An OCaml-based implementation of Bash mini-language that includes a parser, an interpreter and a REPL.")
 (version 1.0)
 (depends
  dune
  base
  angstrom
  re
  (ppx_inline_test :with-test)
  ppx_deriving
  (odoc :with-doc)
  (ocamlformat :build)))
