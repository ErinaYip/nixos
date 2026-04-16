{
  description = "Erinite Modular NixOS Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    default = {
      inherit system;
      username = "demo";
      systemStateVersion = "25.11";
      homeStateVersion = "25.11";
    };

    mkLib = pkgs: pkgs.lib.extend (final: prev: {
      erinite = import ./lib {lib = prev;};
    });

    addHost = hostName: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./modules/home.nix
        ./modules
        (./. + "/hosts/${hostName}")
      ];
      specialArgs = {
        lib = mkLib nixpkgs;
        inherit inputs hostName default;
      };
    };
  in {
    nixosConfigurations = {
      laptop = addHost "laptop";
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [home-manager.packages.${system}.default];
    };
  };
}
