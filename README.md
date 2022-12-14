# Advent of Code 2022: 15/25 langs

I’ll try to solve this Advent of Code using different language for each day.
Any programs needed to run the code will be available via dev shell in the `flake.nix`.

## Languages

| Day | Language                 | Link                 |
| :-: | ------------------------ | -------------------- |
|  1  | GNU Awk                  | [`./day01/`](/day01) |
|  2  | GNU sed                  | [`./day02/`](/day02) |
|  3  | Nix                      | [`./day03/`](/day03) |
|  4  | jq                       | [`./day04/`](/day04) |
|  5  | VimScript                | [`./day05/`](/day05) |
|  6  | PCRE                     | [`./day06/`](/day06) |
|  7  | POSIX Shell              | [`./day07/`](/day07) |
|  8  | Ada                      | [`./day08/`](/day08) |
|  9  | Haskell                  | [`./day09/`](/day09) |
|  10 | GNU Octave               | [`./day10/`](/day10) |
|  11 | Elixir                   | [`./day11/`](/day11) |
|  12 | Raku                     | [`./day12/`](/day12) |
|  13 | Clojure                  | [`./day13/`](/day13) |
|  14 | Lua                      | [`./day14/`](/day14) |
|  15 | Futhark (+ some C)       | [`./day15/`](/day15) |

## `check.sh`

You can use `check.sh` script in the root directory of the repo to run all tests for one or every day.

Working Rust installation is needed for this to work. Development shell in `flake.nix` provides one.

```
$ ./check.sh      # Run all tests for every available day
$ ./check.sh 2    # Run all tests for the second day
$ ./check.sh 1 3  # Run all tests for the first and the third day
```

This script will exit with non-zero status if any of the checks failed.

## Directory structure

In each `day*` directory there are following files and subdirectories:

|  Path                | Contents                                     |
| -------------------- | -------------------------------------------- |
| `./README.md`        | Description & various info                   |
| `./in/`              | Input files for the task                     |
| `./in/demo1.txt`     | Example for the first part                   |
| `./in/demo2.txt`     | Example for the second part                  |
| `./in/part1.txt`     | Input file for the first part                |
| `./in/part2.txt`     | Input file for the second part               |
| `./out/*.txt`        | Correct answers for the corresponding inputs |
| `./code/`            | Code of the solution                         |
| `./build/`           | Build artifacts                              |
| `./build/.keep`      | Empty file, required to commit `./build/`    |
| `./scripts/`         | Scripts for building & running the solution  |
| `./scripts/build.sh` | Build the solution                           |
| `./scripts/run.sh`   | Run the solution with specified input        |

## How to use `run.sh`

```
$ dayX/scripts/run.sh demo 1  # Run the first on the example
$ dayX/scripts/run.sh part 1  # Run the first part on the real input
$ dayX/scripts/run.sh demo 2  # Run the second part on the example
$ dayX/scripts/run.sh part 2  # Run the second part on the real input
```
