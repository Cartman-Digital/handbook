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
        runtimeInputs = (with pkgs.python312Packages; [
            markdown
            mkdocs
            mkdocs-material
            regex
          ]);
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
        {
          devShells.default = pkgs.mkShell {
            venvDir = "venv";
            inherit buildInputs;
          };
          packages = rec {
            mkdocs = pkgs.writeShellApplication {
              name = "mkdocs";

              inherit runtimeInputs;

              text = ''
                mkdocs build
              '';
            };
            default = mkdocs;
          };

          apps = rec {
            mkdocs = flake-utils.lib.mkApp { drv = self.packages.${system}.mkdocs; };
            default = mkdocs;
          };
        }
      );
      
}
