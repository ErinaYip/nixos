{
  description = "Minimal modular NixOS flake demo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";

    mkLib = nixpkgs:
      nixpkgs.lib.extend (self: super: {
        demo = import ./lib {lib = self;};
      });

    addHost = {hostName}:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules
          (./. + "/hosts/${hostName}")
        ];
        specialArgs = {
          lib = mkLib nixpkgs;
          inherit inputs hostName;
        };
      };
  in {
    nixosConfigurations = {
      laptop = addHost {
        hostName = "laptop";
      };
    };
  };
}
