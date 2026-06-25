{
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "media";
    name = "nemo";

    configFn = _: {
      home.packages = with pkgs; [
        nemo-with-extensions
        nemo-fileroller
        gvfs
        file-roller
      ];

      dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "kitty";

      services.udiskie = {
        enable = true;
        settings.program_options.file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  }
