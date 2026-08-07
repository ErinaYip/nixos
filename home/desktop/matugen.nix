{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    xdg.configFile."matugen/config.toml".source = pkgs.writers.writeTOML "config.toml" {
      config.templates = {
        millennium = {
          input_path = ../../assets/matugen/millennium.css;
          output_path = "~/.steam/steam/millennium/themes/Material-Theme/css/main/colors/matugen.css";
        };

        prismlauncher = {
          input_path = ../../assets/matugen/prismlauncher.json;
          output_path = "~/.local/share/PrismLauncher/themes/Matugen/theme.json";
        };
      };
    };
  };
}
