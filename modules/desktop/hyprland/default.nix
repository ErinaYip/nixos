{
  inputs,
  config,
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "hyprland";

  configFn = { ... }: {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      slurp
    ];

    erinite.home.config = lib.mkMerge [
      {
        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;
        };

        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
        };
      }

      (import ./settings.nix)
      (import ./binds.nix)
      (import ./rules.nix)
    ];
  };
}
