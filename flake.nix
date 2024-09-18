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
        nativeBuildInputs = with pkgs.python312Packages; [
            pip
            venvShellHook
            markdown
            mkdocs
            mkdocs-material
            regex
          ];
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

              # allow-list filter for what we need: No readmes, nix files, source code
              # of the project, etc... --> this avoids unnecessary rebuilds
              src = pkgs.lib.sourceByRegex ./. [
                "^docs.*"
                "^templates.*"
                "mkdocs.yml"
              ];

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
            default = generate;
          };
        }
      );
      
}
