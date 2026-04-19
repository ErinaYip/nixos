{
  lib,
  ...
} @ args:

with lib.erinite; mkModule args {
  category = "presets";
  name = "common";

  configFn = { ... }: {
    erinite.system = {
      boot = enabled;
      fcitx5 = enabled;
      fonts = enabled;
      i18n = enabled;
      keyd = enabled;
      # laptop = enabled;
      network = enabled;
      nix-ld = enabled;
      nix = enabled;
      # nvidia = enabled;
      sddm = enabled;
      sound = enabled;
      users = enabled;
      # virtualisation = enabled;
    };

    erinite.desktop = {
      dms = enabled;
      hyprland = enabled;
      cursor = enabled;
      fuzzel = enabled;
      gtk = enabled;
      matugen = enabled;
      nemo = enabled;
      qt = enabled;
      # sunshine = enabled;
    };

    erinite.cli = {
      yazi = enabled;
      zsh = enabled;
      bat = enabled;
      btop = enabled;
      eza = enabled;
      fastfetch = enabled;
      git = enabled;
      kitty = enabled;
      nix = enabled;
      nvim = enabled;
      starship = enabled;
      zoxide = enabled;
    };

    erinite.programs = {
      # gaming = enabled;
      localsend = enabled;
    };
  };
}
