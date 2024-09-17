{
  description = "handbook shell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
        pkgs = import nixpkgs {
          inherit system;
        };
        buildInputs = with pkgs; [ pre-commit go-task ] ++
          (with pkgs.python312Packages; [
            pip
            venvShellHook
            markdown
            mkdocs
            mkdocs-material
            regex
          ]);

        in
        with pkgs;
        {
          devShells.default = mkShell {
            venvDir = "venv";
            inherit buildInputs;
          };
        }
      );
}
