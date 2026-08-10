{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args: let
  sessionAtomType = with lib.types; oneOf [str int bool path];
  sessionValueType = with lib.types; nullOr (oneOf [sessionAtomType (listOf sessionAtomType)]);
  sessionEntryType = with lib.types; oneOf [lines (attrsOf sessionValueType)];
  sessionSettingsType = with lib.types;
    oneOf [
      (attrsOf sessionValueType)
      (listOf sessionEntryType)
    ];
  sessionType = lib.types.submodule {
    options = {
      text = lib.mkOption {
        type = with lib.types; nullOr lines;
        default = null;
        description = "Raw kitty session config text.";
      };

      settings = lib.mkOption {
        type = with lib.types; nullOr sessionSettingsType;
        default = null;
        description = "Structured kitty session entries converted to config text.";
      };
    };
  };

  formatAtom = value:
    if lib.isBool value
    then
      if value
      then "yes"
      else "no"
    else toString value;

  formatValue = value:
    if value == null
    then ""
    else if builtins.isList value
    then lib.concatMapStringsSep " " formatAtom value
    else formatAtom value;

  formatCommand = command: value: let
    rendered = formatValue value;
  in
    if rendered == ""
    then command
    else "${command} ${rendered}";

  formatEntry = entry:
    if builtins.isString entry
    then entry
    else lib.concatStringsSep "\n" (lib.mapAttrsToList formatCommand entry);

  ensureFinalNewline = text:
    if text == "" || lib.hasSuffix "\n" text
    then text
    else "${text}\n";

  formatSettings = settings:
    if builtins.isList settings
    then lib.concatMapStringsSep "\n" formatEntry settings
    else formatEntry settings;

  formatSession = name: session: let
    hasText = session.text != null;
    hasSettings = session.settings != null;
  in
    ensureFinalNewline (
      if hasText && hasSettings
      then throw "kitty session ${name} must not set both text and settings."
      else if hasText
      then session.text
      else if hasSettings
      then formatSettings session.settings
      else throw "kitty session ${name} must set either text or settings."
    );

  sessionFileName = name:
    if lib.hasSuffix ".conf" name
    then name
    else "${name}.conf";

  sessionFiles = sessions:
    lib.mapAttrs' (name: session:
      lib.nameValuePair "kitty/${sessionFileName name}" {
        text = formatSession name session;
      })
    sessions;
in
  with eriniteLib;
    mkModule args {
      opts = {
        sessions = mkAttrOpt sessionType {} ''
          Kitty session files written under ~/.config/kitty. Each session is an
          attribute set with either raw kitty session config text or structured
          Nix entries converted to kitty conf lines.
        '';
      };

      configFn = {cfg, ...}:
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

            xdg.configFile = sessionFiles cfg.sessions;
          }

          {
            erinite.home.cli.zsh.aliases = {
              icat = "kitten icat";
            };
          }
        ];
    }
