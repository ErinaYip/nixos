{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "gtk";

  configFn = { ... }: {
    erinite.home.config.gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      iconTheme = {
        name = "Tela-dracula-dark";
        package = pkgs.tela-icon-theme;
      };
      gtk3 = {
        extraConfig.gtk-application-prefer-dark-theme = true;
      };
    };
  };
}
