{
  description = "bootstraping scripts for Ubunut based systems";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system:
          f {
            inherit system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in {
      
      packages = forAllSystems ({ pkgs, system }: {
        system-bootstrap = pkgs.callPackage ./default.nix {};
        default = self.packages.${system}.system-bootstrap;
      });
    };
}
