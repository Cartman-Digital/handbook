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
        nativeBuildInputs = [ pkgs.git ] ++ (with pkgs.python312Packages; [
            pip
            venvShellHook
            markdown
            mkdocs
            mkdocs-material
            mkdocs-git-revision-date-localized-plugin
            regex
          ]);
        buildInputs = with pkgs; [ pre-commit go-task ] ++ (nativeBuildInputs);
        in
        {
          devShells.default = pkgs.mkShell {
            venvDir = "venv";
            inherit buildInputs;
          };
          packages = rec {
            generate = pkgs.stdenvNoCC.mkDerivation {
              name = "mkdocs-html";

              src = ./.;

              inherit nativeBuildInputs;
              venvDir = "venv";

              buildPhase = ''
                mkdocs build --strict -d $out
              '';

              # This derivation does no source code compilation or testing
              dontConfigure = true;
              doCheck = false;
              dontInstall = true;
            };
            serve = pkgs.writeScriptBin "mkdocs-serve" ''
              #!/usr/bin/env bash
              mkdocs serve
            '';
            default = generate;
          };
          apps = rec {
            serve = flake-utils.lib.mkApp { drv = self.packages.${system}.serve; };
            default = serve;
          };
        }
      );
      
}
