{
  description = "Minimal modular NixOS flake demo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    mkLib = nixpkgs:
      nixpkgs.lib.extend (self: super: {
        demo = import ./lib {lib = self;};
      }
      // inputs.home-manager.lib);

    addHost = {hostName}:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/default.nix
          ./modules/home.nix
          ./modules/desktop.nix
          ./modules/cli/git.nix
          (./. + "/hosts/${hostName}")
          inputs.hyprland.nixosModules.default
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

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        inputs.home-manager.packages.${system}.default
        inputs.hyprland.packages.${system}.default
      ];
    };
  };
}