{
  pkgs,
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

      dconf.settings."org/cinnamon/desktop/default-applications/terminal".exec = "${pkgs.kitty}/bin/kitty";
      xdg.mimeApps.defaultApplications."inode/directory" = "nemo.desktop";

      services.udiskie = {
        enable = true;
        settings.program_options.file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  }
