{
  lib,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "presets";
  name = "common";

  configFn = { ... }: {
    erinite.system = {
      nix = enabled;
      nix-ld = enabled;
      users = enabled;
      sound = enabled;
      fonts = enabled;
      i18n = enabled;
      fcitx5 = enabled;
      keyd = enabled;
      sddm = enabled;
      boot = enabled;
      network = enabled;
    };

    erinite.desktop = {
      hyprland = enabled;
      fuzzel = enabled;
      cursor = enabled;
      gtk = enabled;
      qt = enabled;
      dms = enabled;
      nemo = enabled;
      matugen = enabled;
    };

    erinite.cli = {
      git = enabled;
      nvim = enabled;
      zsh = enabled;
      bat = enabled;
      eza = enabled;
      zoxide = enabled;
      yazi = enabled;
      starship = enabled;
      fastfetch = enabled;
      kitty = enabled;
    };
  };
}
