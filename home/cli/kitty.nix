{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "cli";
    name = "kitty";

    configFn = _:
      lib.mkMerge [
        {
          programs.kitty = {
            enable = true;
            settings = {
              shell = "zsh";
              # linux_display_server = "x11";
              confirm_os_window_close = 0;
              dynamic_background_opacity = true;
              enable_audio_bell = false;
              mouse_hide_wait = "-1.0";
              window_padding_width = 0;
              hide_window_decorations = "yes";
              font_family = "MapleMono NF CN";
              cursor_shape = "beam";
              cursor_trail = 1;
              scrollback_lines = 10000;
              touch_scroll_multiplier = 1.5;
            };

            keybindings = {
              "ctrl+backspace" = "change_font_size all 0";
              "ctrl+plus" = "change_font_size all +1";
              "ctrl+equal" = "change_font_size all +1";
              "ctrl+kp_add" = "change_font_size all +1";
              "ctrl+minus" = "change_font_size all -1";
              "ctrl+underscore" = "change_font_size all -1";
              "ctrl+kp_subtract" = "change_font_size all -1";
            };

            mouseBindings = {
              "ctrl+left click" = "ungrabbed mouse_handle_click selection link prompt";
              "left click" = "ungrabbed no-op";
            };
          };
        }

        {
          erinite.home.cli.zsh.aliases = {
            icat = "kitten icat";
          };
        }
      ];
  }
