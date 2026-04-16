
{
  lib,
  inputs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "desktop";
  name = "qt";

  imports = [ inputs.matugen.nixosModules.default ];

  configFn = { ... }: {
    programs.matugen.enable = true;

    erinite.home.config = {
      xdg.configFile."matugen/config.toml".text = ''
        [config]

        [templates.btop]
        input_path = "${../../asstes/templates/btop.theme}"
        output_path = "~/.config/btop/themes/matugen.theme"
        post_hook = "pkill -USR2 btop || true"

        [templates.fuzzel]
        input_path = "${../../asstes/templates/fuzzel.ini}"
        output_path = "~/.config/fuzzel/themes/matugen"

        [templates.yzai]
        input_path = "${../../asstes/templates/yazi-theme.toml}"
        output_path = "~/.config/yazi/theme.toml"

        [templates.prismlauncher]
        input_path = "${../../asstes/templates/prismlauncher.json}"
        output_path = "~/.local/share/PrismLauncher/themes/Matugen/theme.json"
      '';

      programs.btop.settings.color_theme = "matugen";
      programs.fuzzel.settings.main.include = "~/.config/fuzzel/themes/matugen";
    };
  };
}
