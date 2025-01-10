# effektivecompile2riscv: A Compiler for Risc-V written in Effekt

Credits: This project uses the following effekt project template: https://github.com/jiribenes/effekt-template

## Table of contents

- [Setup for testing the riscv assembly code](#setup)
- [Useful commands](#useful-commands)
  - [Effekt commands](#effekt-commands)
  - [Nix-related commands](#nix-related-commands)
- [Repository structure](#repository-structure)
- [CI](#ci)

---

## Setup for testing the riscv assembly code 

To be able to run the binaries you have to follow these steps:

1. Install the RiscV toolchain: https://github.com/riscv-collab/riscv-gnu-toolchain  
   Wichtig: Es wird die ELF Version mit newlib benötigt. 
2. Install an Emulator like Quemu: https://www.qemu.org/download/
3. Run the following commands to run a test riscv assembly:
```sh
riscv64-unknown-elf-as -o test.o test.s

riscv64-unknown-elf-gcc -o test test.o

./test 
# or if you dont have qemu-user-binfmt installed 
#qemu-riscv64 ./test

```


## Overview

A project overview can be found here.

## Useful commands

### Effekt commands

Run the main file:
```sh
effekt src/main.effekt
```
This (like many other Effekt commands) uses the JavaScript backend by default.
To use a different backend, add the `--backend <backend>` flag.

Run the tests:
```sh
effekt src/test.effekt
```

Open the REPL:
```sh
effekt
```

Build the project:
```sh
effekt --build src/main.effekt
```
This builds the project into the `out/` directory, creating a runnable file `out/main`.

To see all available options and backends, run:
```sh
effekt --help
```

### Nix-related commands

While Nix installation is optional, it provides several benefits:

Update dependencies (also runs automatically in CI):
```sh
nix flake update
```

Open a shell with all necessary dependencies:
```sh
nix develop
```

Run the main entry point:
```sh
nix run
```

Build the project (output in `result/bin/`):
```sh
nix build
```

## Repository structure

- `.github/workflows/*.yml`: Contains the [CI](#ci) definitions
- `src/`: Contains the source code
  - `main.effekt`: Main entry point
  - `test.effekt`: Entry point for tests
  - `lib.effekt`: Library code imported by `main` and `test`
- `flake.nix`: Package configuration in a Nix flake
- `flake.lock`: Auto-generated lockfile for dependencies
- `LICENSE`: Project license
- `README`: This README file

## CI

Two GitHub Actions are set up:

1. `flake-check`:
   - Checks the `flake.nix` file, builds and tests the project
   - Runs on demand, on `main`, and on PRs
   - To run custom commands, add a step using:
     - `nix run -- <ARGS>` to run the main entry point with the given arguments
     - `nix develop -c '<bash command to run>'` to run commands in the correct environment

2. `update-flake-lock`:
   - Updates package versions in `flake.nix`
   - Runs on demand and weekly (Tuesdays at 00:00 UTC)
