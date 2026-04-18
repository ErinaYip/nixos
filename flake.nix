{
  description = "Erinite Modular NixOS Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland.url = "github:hyprwm/Hyprland";
    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    erina-vim = {
      url = "github:erinayip/erina-vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oh-my-rime-nix = {
      url = "github:erinayip/oh-my-rime-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    default = {
      inherit system;
      username = "era";
      systemStateVersion = "25.11";
      homeStateVersion = "26.05";
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
      mechrevo = addHost "mechrevo";
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [home-manager.packages.${system}.default];
    };
  };
}
