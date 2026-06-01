{
  lib,
  pkgs,
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
            };

            keybindings = {
              # Fonts
              "ctrl+backspace" = "change_font_size all 0";
              "ctrl+plus" = "change_font_size all +1";
              "ctrl+equal" = "change_font_size all +1";
              "ctrl+kp_add" = "change_font_size all +1";
              "ctrl+minus" = "change_font_size all -1";
              "ctrl+underscore" = "change_font_size all -1";
              "ctrl+kp_subtract" = "change_font_size all -1";

              # Windows
              "ctrl+x" = "new_os_window_with_cwd";
              "ctrl+shift+enter" = "new_window_with_cwd";
            };

            mouseBindings = {
              "ctrl+left click" = "ungrabbed mouse_handle_click selection link prompt";
              "left click" = "ungrabbed no-op";
            };

            extraConfig = ''
              allow_remote_control yes
              listen_on unix:/tmp/kitty

              action_alias kitty_scrollback_nvim kitten ${pkgs.vimPlugins.kitty-scrollback-nvim}/python/kitty_scrollback_nvim.py

              map ctrl+shift+h kitty_scrollback_nvim
              map ctrl+shift+g kitty_scrollback_nvim --config ksb_builtin_last_cmd_output
            '';
          };
        }

        {
          erinite.home.cli.zsh.aliases = {
            icat = "kitten icat";
          };
        }
      ];
  }
