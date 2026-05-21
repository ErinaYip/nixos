{
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "desktop";
  name = "matugen";

  imports = [inputs.matugen.nixosModules.default];

  configFn = _: {
    programs.matugen.enable = true;

    erinite.home = {
      xdg.configFile."matugen/config.toml".text = ''
        [config]

        [templates.btop]
        input_path = "${../../assets/templates/btop.theme}"
        output_path = "~/.config/btop/themes/matugen.theme"
        post_hook = "pkill -USR2 btop || true"

        [templates.fuzzel]
        input_path = "${../../assets/templates/fuzzel.ini}"
        output_path = "~/.config/fuzzel/themes/matugen"

        [templates.yzai]
        input_path = "${../../assets/templates/yazi-theme.toml}"
        output_path = "~/.config/yazi/theme.toml"

        [templates.prismlauncher]
        input_path = "${../../assets/templates/prismlauncher.json}"
        output_path = "~/.local/share/PrismLauncher/themes/Matugen/theme.json"

        [templates.cava]
        input_path = "${../../assets/templates/cava-colors.ini}"
        output_path = '~/.config/cava/themes/matugen'
        post_hook = 'pkill -USR1 cava'

        [templates.hyprland]
        input_path = "${../../assets/templates/hyprland-color.lua}"
        output_path = '~/.config/hypr/colors.lua'
      '';

      programs = {
        btop.settings.color_theme = "matugen";
        fuzzel.settings.main.include = "~/.config/fuzzel/themes/matugen";
        cava.settings.color.theme = "matugen";
      };
      # waylard.windowManager.hyprland.extraConfig = ''require("colors")'';
    };
  };
}
