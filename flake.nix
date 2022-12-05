{
  inputs = {
    nixpkgs.url      = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = (import nixpkgs { inherit system; }); in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
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
        ];
      };
    }
  );
}
