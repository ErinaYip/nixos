{
  description = "Erinite Modular NixOS Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-kernel-good.url = "github:NixOS/nixpkgs/549bd84";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland";
    };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen = {
      url = "github:InioX/matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
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
    oh-my-rime-nix = {
      url = "git+https://codeberg.org/erina/oh-my-rime-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;
    mkNixpkgsConfig = {cudaSupport ? false}: {
      allowUnfree = true;
      inherit cudaSupport;
    };
    pkgs = import nixpkgs {
      inherit system;
      config = mkNixpkgsConfig {};
    };
    eriniteLib = import ./lib {
      inherit inputs pkgs;
      inherit (pkgs) lib;
    };

    default = {
      inherit system;
      username = "era";
      systemStateVersion = "25.11";
      homeStateVersion = "26.05";
    };

    hostNames =
      lib.attrNames
      (lib.filterAttrs
        (_: type: type == "directory")
        (builtins.readDir ./hosts));

    mkHost = hostName: let
      host = import (./. + "/hosts/${hostName}") {
        inherit inputs lib eriniteLib pkgs;
      };
      hostMeta = host.meta or {};
      hostPkgs = import nixpkgs {
        inherit system;
        config = mkNixpkgsConfig {
          cudaSupport = hostMeta.cudaSupport or false;
        };
      };
      hostOsModules = host.osModules or [];
      hostHomeModules = [./home] ++ (host.homeModules or []);

      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          {nixpkgs.pkgs = hostPkgs;}
          ./os
        ]
        ++ hostOsModules
        ++ [
          {
            home-manager.users.${default.username}.imports = hostHomeModules;
          }
        ];
        specialArgs = {
          inherit inputs hostName default;
          inherit eriniteLib;
        };
      };
    in {
      inherit nixos;
      home = home-manager.lib.homeManagerConfiguration {
        pkgs = hostPkgs;
        extraSpecialArgs = {
          pkgs = hostPkgs;
          inherit inputs hostName default eriniteLib;
        };
        modules = hostHomeModules;
      };
    };

    hosts = lib.genAttrs hostNames mkHost;
  in {
    nixosConfigurations = lib.mapAttrs (_: host: host.nixos) hosts;

    homeConfigurations =
      lib.mapAttrs'
      (hostName: host: lib.nameValuePair "${default.username}@${hostName}" host.home)
      hosts;

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [home-manager.packages.${system}.default];
    };
  };
}
