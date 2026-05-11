{
  description = "Erinite Modular NixOS Architecture";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
    # erina-vim = {
    #   url = "git+https://codeberg.org/erina/erina-vim.git";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    oh-my-rime-nix = {
      url = "git+https://codeberg.org/erina/oh-my-rime-nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    # self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    inherit (nixpkgs) lib;
    pkgs = import nixpkgs {inherit system;};
    homePkgs = import nixpkgs {
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

    hostNames = [
      "mechrevo"
      "nec"
    ];

    addHost = hostName: let
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./modules/home.nix
          ./modules
          (./. + "/hosts/${hostName}")
        ];
        specialArgs = {
          inherit inputs hostName default;
          inherit eriniteLib;
        };
      };
    in {
      inherit nixos;
      home = home-manager.lib.homeManagerConfiguration {
        pkgs = homePkgs;
        extraSpecialArgs = {
          inherit inputs hostName default eriniteLib;
        };
        modules =
          nixos.config.home-manager.sharedModules
          ++ [
            nixos.config.erinite.homeModule
          ];
      };
    };

    hosts = lib.genAttrs hostNames addHost;
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
