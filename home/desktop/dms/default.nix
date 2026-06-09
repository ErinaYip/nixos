{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "dms";

    opts = {
      session = mkOpt lib.types.attrs {} "Dms session state settings.";
    };

    defaultSettings = import ./settings.nix;

    configFn = {
      cfg,
      settings,
      ...
    }: let
      fcitx5Enabled = args.config.erinite.home.desktop.fcitx5.enable;
      inputMethodEnv = {
        QT_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
        SDL_IM_MODULE = "fcitx";
        GLFW_IM_MODULE = "ibus";
      };
      inputMethodEnvironment =
        lib.mapAttrsToList
        (name: value: "${name}=${toString value}")
        inputMethodEnv;
      inputMethodLaunchWrapper = pkgs.writeShellScript "dms-fcitx5-launch" ''
        exec env ${lib.concatStringsSep " " inputMethodEnvironment} "$@"
      '';
    in
      lib.mkMerge [
        {
          programs.dank-material-shell = {
            enable = true;

            inherit settings;
            inherit (cfg) session;

            systemd = {
              enable = true;
              inherit (cfg) restartIfChanged;
            };

            enableSystemMonitoring = true;
            enableVPN = false;
            enableDynamicTheming = true;
            enableAudioWavelength = true;
            enableCalendarEvents = true;
            enableClipboardPaste = true;

            plugins = {
              quickCapture = enabled;
            };
          };
        }

        (lib.mkIf fcitx5Enabled {
          systemd.user.services.dms.Service.Environment =
            inputMethodEnvironment
            ++ ["DMS_DEFAULT_LAUNCH_PREFIX=${inputMethodLaunchWrapper}"];
        })

        (import ./hyprland.nix args)
      ];
  }
