{
  description = "Flake for c3c compiler";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    c3c-last = {
      url = "github:c3lang/c3c?ref=v0.6.4";
      flake = false;
    };
    c3c-latest = {
      url = "github:c3lang/c3c?ref=latest";
      flake = false;
    };
  };

  outputs = { self, ... } @ inputs: inputs.flake-utils.lib.eachDefaultSystem 
  (system: 
    let pkgs = import inputs.nixpkgs { inherit system; };
    in 
    {
      packages = {
        default = self.packages.${system}.last;
        
        last = pkgs.callPackage ./default.nix { 
          c3c-src = inputs.c3c-last;
          c3c-ver = "0.6.4";
        };

        latest = pkgs.callPackage ./default.nix {
          c3c-src = inputs.c3c-latest;
          c3c-ver = "0.6.5";
        };
      };
    }
  );
}
