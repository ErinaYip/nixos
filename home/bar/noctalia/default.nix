{ config, inputs, ... }:
let
  template_path = config.home.homeDirectory + "/nix-config/home/bar/noctalia/templates/";
in{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.quickshell.enable = true;
  programs.noctalia-shell = {
    enable = true;
    user-templates = {
      templates = {
        nvim = {
          input_path = template_path + "nvim/noctalia.lua.template";
          output_path = "~/.config/nvim/lua/noctalia.lua";
        };
        prismlauncher-json = {
          input_path = template_path + "prismlauncher/theme.json.template";
          output_path = "~/.local/share/PrismLauncher/themes/Noctalia/theme.json";
        };
        prismlauncher-css = {
          input_path = template_path + "prismlauncher/themeStyle.css.template";
          output_path = "~/.local/share/PrismLauncher/themes/Noctalia/themeStyle.css";
        };
      };
    };
  };
}
