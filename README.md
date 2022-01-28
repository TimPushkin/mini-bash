# miniBash

An OCaml-based implementation of Bash mini-language including a parser, an interpreter, and a REPL.

## Get started

The library uses [dune](https://github.com/ocaml/dune) as a build system. Run the following command for it to be built:

```
dune build
```

REPL is ready to be run as an executable after it is built:

```
dune exec ./REPL.exe
```

Contents:
- The library itself is available in `lib`
- Usage demos are available in `demos`
- REPL is in `REPL.ml`

## Features

Currently miniBash supports the following features:

- Quoting
- Commands
    - Simple commands
    - Pipelines (concurrent execution is not supported)
    - Command lists (`&&` and `||`)
    - Compound commands
        - `while`
        - `for` (two syntactic variants)
        - `if`
        - `case`
        - `((...))`
        - `{...}`
- Functions (with recursion)
- Variables and parameters
    - Out of positional and special parameters only numerical positional parameters are supported
- Expansions (expansions are not allowed to be nested)
    - Brace expansion
    - Shell parameter expansion
    - Command substitution (in two forms, but both of them behave in the same new-fashioned way)
    - Word splitting (partial; on \<space>, \<tab> and \<newline> only)
    - Arithmetical expansion (with variables)
    - Filename expansion
- Pattern matching
- Redirections (`<`, `>`, `>>`, `<&`, `>&`)
    - No checking for input/output availability
    - No descriptors from variables
- Arrays
    - Indexed: `name=(value1 value2 value3 ...)`
    - Associative: `name=(key1=value1 key2=value2 ...)`
- External executables
    - An executable is first attemted to be interpreted as a miniBash script, and if this fails then it is run via a system's shell

## REPL

The implemented miniBash REPL is a mix of a traditional REPL and a command-line shell:
- after each command is executed its return code is printed
- commands do not need to be terminated with any special sequence to be executed

Example:

```shell
        MiniBash REPL
- To run a command, type it and press Enter
- To stop typing a multiline command prematurely, enter an empty line
- To exit REPL type `exit` or press Ctrl-D
$ echo "Hello $(echo "world!")"
Hello world!
return code: 0
$ for i in a b c; do
> echo $i
> done
a
b
c
return code: 0
$ 
```
