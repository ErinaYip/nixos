{
  eriniteLib,
  pkgs,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "vscode";

    configFn = _: {
      programs.vscodium = {
        enable = true;

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            pkief.material-icon-theme
          ];

          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
          };
        };
      };
    };
  }
