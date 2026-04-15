{
  description = "Minimal modular NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    mkLib = lib:
      let
        demoLib = import ./lib {inherit lib;};
      in
        lib // demoLib // inputs.home-manager.lib;

    lib = mkLib nixpkgs.lib;

    addHost = hostName:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/home.nix
          ./modules/desktop.nix
          ./modules/cli/git.nix
          ./hosts/${hostName}
          inputs.home-manager.nixosModules.home-manager
        ];
        specialArgs = {inherit lib inputs;};
      };
  in {
    nixosConfigurations.laptop = addHost "laptop";

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [inputs.home-manager.packages.${system}.default];
    };
  };
}