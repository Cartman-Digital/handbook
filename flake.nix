{
  description = "handbook shell";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-github-actions.url = "github:nix-community/nix-github-actions";
    nix-github-actions.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { self, nixpkgs, flake-utils, nix-github-actions }:
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
        {
          devShells.default = pkgs.mkShell {
            venvDir = "venv";
            inherit buildInputs;
          };
          packages = rec {
            mkdocs = pkgs.mkdocs;
            default = mkdocs;
          };
          githubActions = nix-github-actions.lib.mkGithubMatrix {
            checks = nixpkgs.lib.getAttrs [ "x86_64-linux" "x86_64-darwin" ] self.packages;
          };

          apps = rec {
            mkdocs = flake-utils.lib.mkApp { drv = self.packages.${system}.mkdocs; };
            default = mkdocs;
          };
        }
      );
      
}
