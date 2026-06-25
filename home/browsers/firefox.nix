{
  config,
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    namespace = ["erinite" "home"];
    category = "browsers";
    name = "firefox";

    configFn = _: let
      repoRoot = ../../.;
      homeDir = config.home.homeDirectory;
      profilePath = "3kyzzdo5.default";
      localAddon = name: file:
        pkgs.stdenvNoCC.mkDerivation {
          pname = "firefox-local-addon-${name}";
          version = "local";
          xpi = builtins.path {
            name = "${name}.xpi";
            path = repoRoot + "/assets/browser-profiles/firefox/extensions/${file}";
          };
          dontUnpack = true;
          installPhase = ''
            install -Dm644 "$xpi" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/${file}"
          '';
        };
    in {
      programs.firefox = {
        enable = true;
        configPath = ".mozilla/firefox";
        languagePacks = ["zh-CN"];

        policies = {
          DefaultDownloadDirectory = "${homeDir}/Downloads";
          DontCheckDefaultBrowser = true;

          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;

          Preferences = {
            "accessibility.typeaheadfind.flashBar" = 0;
            "browser.contentblocking.category" = "standard";
            "browser.download.folderList" = 2;
            "browser.download.panel.shown" = true;
            "browser.ml.chat.page.menuBadge" = false;
            "browser.newtabpage.enabled" = false;
            "dom.forms.autocomplete.formautofill" = true;

            "browser.safebrowsing.malware.enabled" = false;
            "browser.safebrowsing.phishing.enabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.usage.uploadEnabled" = false;

            "browser.search.region" = "HK";
            "browser.theme.content-theme" = 0;
            "browser.theme.toolbar-theme" = 0;
            "browser.urlbar.suggest.trending" = false;
            "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
            "intl.accept_languages" = "zh-cn,en-us,en";
            "intl.locale.requested" = "zh-CN,en-US";
            "layout.spellcheckDefault" = 0;
            "media.eme.enabled" = true;
            "nimbus.rollouts.enabled" = false;
          };
        };

        profiles."default" = {
          id = 0;
          isDefault = true;
          path = profilePath;

          extensions = {
            packages = lib.mapAttrsToList localAddon {
              darkreader = "addon@darkreader.org.xpi";
            };

            settings =
              {"FirefoxColor@mozilla.com".force = true;}
              // builtins.fromJSON (builtins.readFile (repoRoot + "/assets/browser-profiles/firefox/extension-settings.json"));
          };

          search = {
            force = true;
            default = "bing";
            order = [
              "google"
              "bing"
              "ddg"
              "perplexity"
              "baidu"
              "wikipedia-zh-CN"
              "wikipedia"
            ];
            engines = {
              google.metaData.hasBeenUsed = true;
              bing = {};
              ddg = {};
              perplexity = {};
              baidu = {};
              wikipedia-zh-CN = {};
              wikipedia = {};
            };
          };

          settings = {
            "layout.spellcheckDefault" = 0;
            "media.eme.enabled" = true;
            "browser.download.dir" = "${homeDir}/Downloads";
            "browser.download.folderList" = 2;
            "browser.newtabpage.enabled" = false;
            "browser.safebrowsing.malware.enabled" = false;
            "browser.safebrowsing.phishing.enabled" = false;
            "browser.search.region" = "HK";
            "extensions.autoDisableScopes" = 0;
            "nimbus.rollouts.enabled" = false;

            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                "widget-overflow-fixed-list" = [
                  "profiler-button"
                  "screenshot-button"
                  "fxa-toolbar-menu-button"
                ];
                "nav-bar" = [
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "customizableui-special-spring1"
                  "vertical-spacer"
                  "urlbar-container"
                  "customizableui-special-spring2"
                  "downloads-button"
                  "unified-extensions-button"
                  "suziwen1_gmail_com-browser-action"
                  "sidebar-button"
                ];
                "toolbar-menubar" = ["menubar-items"];
                "TabsToolbar" = [
                  "tabbrowser-tabs"
                  "new-tab-button"
                ];
                "vertical-tabs" = [];
                "PersonalToolbar" = ["personal-bookmarks"];
              };
              seen = [
                "addon_darkreader_org-browser-action"
                "firefoxcolor_mozilla_com-browser-action"
              ];
              currentVersion = 23;
              newElementCount = 6;
            };
          };
        };
      };

      xdg.mimeApps.defaultApplications = mkDefaultApplications "firefox.desktop" [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };
  }
