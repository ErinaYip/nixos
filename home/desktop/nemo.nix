{pkgs, eriniteLib, ...} @ args:
eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
  category = "desktop";
  name = "nemo";

  configFn = _: {
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "kitty";

    services.udiskie = {
      enable = true;
      settings.program_options.file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
    };
  };
}
