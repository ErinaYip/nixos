{
  description = "Erinite Modular NixOS Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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
    stylix = {
      url = "github:erinayip/stylix";
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
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
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
      hostOsModules = host.osModules;
      hostHomeModules = [./home] ++ host.homeModules;

      nixos = lib.nixosSystem {
        inherit system;
        modules =
          [
            ./os
            {home-manager.users.${default.username}.imports = hostHomeModules;}
          ]
          ++ hostOsModules;
        specialArgs = {
          inherit inputs hostName default;
          inherit eriniteLib;
        };
      };
    in {
      inherit nixos;
      home = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit pkgs inputs hostName default eriniteLib;
        };
        modules = hostHomeModules;
      };
    };

    hosts = lib.genAttrs hostNames mkHost;
  in {
    formatter.${system} = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = lib.mapAttrs (_: host: host.nixos) hosts;

    homeConfigurations =
      lib.mapAttrs'
      (hostName: host: lib.nameValuePair "${default.username}@${hostName}" host.home)
      hosts;
  };
}
