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
        ];
      };
    }
  );
}
