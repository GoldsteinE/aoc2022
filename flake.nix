{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = (import nixpkgs { inherit system; overlays = [ (import rust-overlay) ]; }); in
    {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          # For checker
          (rust-bin.stable.latest.default.override {
            extensions = [
              "rust-src"
              "rust-analyzer"
            ];
          })
          gcc
          # Generally useful
          gdb
          # For scripts
          shellcheck
          # Day 1
          gawk
          # Day 2
          gnused
          # Day 4
          jq
          # Day 5
          neovim
          # Day 6
          ripgrep
          # Day 8
          gnat
          # Day 9
          ghc
          # Day 10
          octave
          # Day 11
          elixir
          elixir_ls
          # Day 12
          rakudo
          # Day 13
          jdk17
          clojure
          leiningen
          # Day 14
          lua5_4
          # Day 15
          futhark
        ];
      };
    }
  );
}
