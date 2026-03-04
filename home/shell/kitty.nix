{ lib, config, ... }: 
let
  shellAliases = {
    icat = "kitten icat";
  };
in {
  programs = {
    kitty = {
      enable = true;
      settings = {
        shell = "zsh";
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        mouse_hide_wait = "-1.0";
        window_padding_width = 0;
        hide_window_decorations = "yes";
        font_family = "MapleMono NF CN";
        cursor_shape = "beam";
        cursor_trail = 1;

        extraConfig = ''
          map ctrl+plus change_font_size all +1
          map ctrl+equal change_font_size all +1
          map ctrl+kp_add change_font_size all +1
          map ctrl+minus change_font_size all -1
          map ctrl+underscore change_font_size all -1
          map ctrl+kp_subtract change_font_size all -1

          mouse_map left click ungrabbed no_op
        '';

        include = "themes/noctalia.conf";
        # background_opacity = "0.5";
        # background_blur = 5;
      };
    };
    zsh.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
    fish.shellAliases = lib.mkIf config.programs.eza.enable shellAliases;
  };
}
