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
      erinite.home.cli.zsh.aliases."code" = "codium";

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
