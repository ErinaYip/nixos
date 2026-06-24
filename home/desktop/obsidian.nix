{
  pkgs,
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib; let
  obsidianAssets = ../../assets/obsidian;

  readJson = path: builtins.fromJSON (builtins.readFile path);

  pluginSrc = id: obsidianAssets + "/plugins/${id}";
  pluginData = id: readJson (pluginSrc id + "/data.json");

  mkPluginPkg = id:
    builtins.path {
      name = "obsidian-plugin-${id}";
      path = pluginSrc id;
      filter = path: type:
        type
        == "directory"
        || builtins.elem (baseNameOf path) [
          "main.js"
          "manifest.json"
          "styles.css"
        ];
    };

  mkThemePkg = name:
    builtins.path {
      name = "obsidian-theme-${lib.strings.sanitizeDerivationName name}";
      path = obsidianAssets + "/themes/${name}";
      filter = path: type:
        type
        == "directory"
        || builtins.elem (baseNameOf path) [
          "manifest.json"
          "theme.css"
        ];
    };

  pluginPackages =
    lib.genAttrs [
      "easy-typing-obsidian"
      "editor-width-slider"
      "novel-word-count"
      "obsidian-icon-folder"
      "obsidian-quiet-outline"
      "obsidian-style-settings"
      "quick-explorer"
    ]
    mkPluginPkg;

  themePackages =
    lib.genAttrs ["Blue Topaz"]
    mkThemePkg;
in
  mkModule args {
    namespace = ["erinite" "home"];
    category = "desktop";
    name = "obsidian";

    defaultSettings = {
      vault = {
        name = "notes";
        target = "Documents/notes";
      };
    };

    configFn = {settings, ...}: {
      programs.obsidian = {
        enable = true;
        package = pkgs.obsidian;

        defaultSettings = {
          app = {
            showLineNumber = true;
            livePreview = false;
            spellcheck = false;
            useTab = false;
            promptDelete = false;
            vimMode = false;
            newLinkFormat = "shortest";
            alwaysUpdateLinks = true;
            useMarkdownLinks = false;
            pdfExportSettings = {
              includeName = true;
              pageSize = "A4";
              landscape = false;
              margin = "0";
              downscalePercent = 100;
            };
            showInlineTitle = true;
          };

          appearance = {
            baseFontSizeAction = true;
            accentColor = "";
            nativeMenus = false;
          };

          communityPlugins = [
            {
              pkg = pluginPackages."editor-width-slider";
              settings = pluginData "editor-width-slider";
            }
            {
              pkg = pluginPackages."obsidian-icon-folder";
              settings = pluginData "obsidian-icon-folder";
            }
            {
              pkg = pluginPackages."novel-word-count";
              settings.settings = (pluginData "novel-word-count").settings;
            }
            {
              pkg = pluginPackages."obsidian-style-settings";
              settings = pluginData "obsidian-style-settings";
            }
            {
              enable = false;
              pkg = pluginPackages."easy-typing-obsidian";
              settings = pluginData "easy-typing-obsidian";
            }
            {
              enable = false;
              pkg = pluginPackages."obsidian-quiet-outline";
              settings = pluginData "obsidian-quiet-outline";
            }
            {
              enable = false;
              pkg = pluginPackages."quick-explorer";
            }
          ];

          themes = [
            {pkg = themePackages."Blue Topaz";}
          ];
        };

        vaults.${settings.vault.name} = {
          target = settings.vault.target;
        };
      };
    };
  }
