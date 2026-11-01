{
  pkgs,
  config,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      home.packages = with pkgs; [
        nemo-with-extensions
        nemo-fileroller
        gvfs
        file-roller
      ];

      xdg.desktopEntries.nemo = {
        name = "Nemo";
        exec = "${pkgs.nemo-with-extensions}/bin/nemo";
      };

      xdg.mimeApps.defaultApplications = {
        "inode/directory" = ["nemo.desktop"];
        "application/x-gnome-saved-search" = ["nemo.desktop"];
      };

      dconf.settings = {
        "org/cinnamon/desktop/applications/terminal" = {
          exec = "kitty";
        };
        "org/cinnamon/desktop/interface" = {
          can-change-accels = true;
        };
      };

      home.file.".config/gtk-3.0/bookmarks".text = ''
        file://${config.home.homeDirectory}/Applications Applications
        file://${config.home.homeDirectory}/Desktop Desktop
        file://${config.home.homeDirectory}/Development Development
        file://${config.home.homeDirectory}/Documents Documents
        file://${config.home.homeDirectory}/Downloads Downloads
        file://${config.home.homeDirectory}/Library Library
        file://${config.home.homeDirectory}/nixos nixos
        file://${config.home.homeDirectory}/Pictures Pictures
        file://${config.home.homeDirectory}/Videos Videos
      '';

      services.udiskie = {
        enable = true;
        settings.program_options.file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  }
