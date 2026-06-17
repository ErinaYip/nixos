{
  eriniteLib,
  pkgs,
  ...
} @ args:
with eriniteLib;
let
  codeSmart = pkgs.writeShellApplication {
    name = "code";
    runtimeInputs = [pkgs.kitty pkgs.jq];
    text = ''
      set -euo pipefail

      cwd="$(
        { kitty @ ls --to unix:/tmp/kitty --match state:focused --output-format=json 2>/dev/null || true; } \
          | jq -r '.. | objects | select(has("pid") and has("cwd")) | .cwd' \
          | head -n1
      )"

      if [ -n "''${cwd:-}" ] && [ "''${cwd}" != "null" ]; then
        exec codium "''${cwd}"
      fi

      exec codium
    '';
  };
in
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "vscode";

    configFn = _: {
      home.packages = [
        codeSmart
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
