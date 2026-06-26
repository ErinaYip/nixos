{
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib; let
  code = pkgs.writeShellApplication {
    name = "code";
    text = ''
      set -euo pipefail
      if [ "$#" -gt 0 ]; then
        exec codium "$@"
      fi
      exec codium
    '';
  };
in
  mkModule args {
    configFn = _: {
      home.packages = [
        code
      ];

      programs.vscodium = {
        enable = true;

        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            eamodio.gitlens
            ms-ceintl.vscode-language-pack-zh-hans
            pkief.material-icon-theme
          ];

          userSettings = {
            "workbench.iconTheme" = "material-icon-theme";
            "editor.mouseWheelZoom" = true;
          };
        };
      };

      xdg.desktopEntries.code = {
        name = "Code";
        exec = "codium %F";
        icon = "vscodium";
        terminal = false;
        type = "Application";
        categories = ["Development" "IDE"];
        mimeType = ["text/plain" "inode/directory"];
      };
    };
  }
