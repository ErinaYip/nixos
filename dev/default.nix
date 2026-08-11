{
  pkgs,
  system,
}: let
  nixdConfig = builtins.toJSON {
    nixd = {
      nixpkgs.expr = ''
        import (builtins.getFlake "@FLAKE_ROOT@").inputs.nixpkgs {
          system = "${system}";
          config.allowUnfree = true;
        }
      '';

      options = {
        nixos.expr = ''
          (builtins.getFlake "@FLAKE_ROOT@").inputs.nixpkgs.lib.nixosSystem {
            system = "${system}";
            modules = [];
          }.options
        '';

        home-manager.expr = ''
          let
            flake = builtins.getFlake "@FLAKE_ROOT@";
            pkgs = import flake.inputs.nixpkgs {
              system = "${system}";
            };
          in
            flake.inputs.home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                {
                  home.homeDirectory = "/tmp/nix-home";
                  home.stateVersion = "25.11";
                }
              ];
            }.options
        '';
      };

      formatting.command = ["${pkgs.lib.getExe pkgs.alejandra}"];
    };
  };

  nixd = pkgs.writeShellApplication {
    name = "nixd";
    runtimeInputs = [pkgs.gitMinimal];
    text = ''
      set -euo pipefail

      flake_root="$PWD"
      if git_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
        flake_root="$git_root"
      fi

      config='${nixdConfig}'
      config="''${config//@FLAKE_ROOT@/$flake_root}"

      exec ${pkgs.lib.getExe pkgs.nixd} --config "$config" "$@"
    '';
  };
in
  pkgs.mkShell {
    packages = [
      nixd
      pkgs.alejandra
      pkgs.deadnix
      pkgs.statix
    ];
  }
