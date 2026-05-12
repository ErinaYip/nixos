{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "desktop";
  name = "nemo";

  configFn = _: {
    environment.systemPackages = with pkgs; [
      nemo-with-extensions
      nemo-fileroller
      gvfs
      file-roller
    ];

    services.udisks2.enable = true;
    xdg.mime.defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "application/x-gnome-saved-search" = ["nemo.desktop"];
    };

    erinite.home = {
      dconf.settings = {
        "org/cinnamon/desktop/applications/terminal" = {
          exec = "kitty";
        };
      };

      services.udiskie = {
        enable = true;
        settings = {
          # workaround for
          # https://github.com/nix-community/home-manager/issues/632
          program_options = {
            # replace with your favorite file manager
            file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
          };
        };
      };
    };
  };
}
