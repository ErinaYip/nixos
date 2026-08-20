{
  config,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    configFn = _: {
      programs.firefox = {
        enable = true;
        configPath = ".mozilla/firefox";

        profiles."default" = {
          # id = 0;
          isDefault = true;
          # path = "3kyzzdo5.default";

          extensions = {
            force = true;
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              zeroomega
              ublock-origin
              auth-helper
              darkreader
            ];

            settings = {};
          };

          search = {
            force = true;
            default = "bing";
          };

          settings = {
            "layout.spellcheckDefault" = 0;
            "media.eme.enabled" = true;
            "browser.download.dir" = "${config.home.homeDirectory}/Downloads";
            "browser.download.folderList" = 2;
            "browser.newtabpage.enabled" = false;
            "browser.safebrowsing.malware.enabled" = false;
            "browser.safebrowsing.phishing.enabled" = false;
            "browser.search.region" = "HK";
            "browser.startup.page" = 3;
            "browser.tabs.closeWindowWithLastTab" = false;
            "extensions.autoDisableScopes" = 0;
            "nimbus.rollouts.enabled" = false;
            "geo.enabled" = false;
            "gfx.webrender.all" = true;

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
            };

            # Fully disable Pocket. See
            # https://www.reddit.com/r/linux/comments/zabm2a.
            "extensions.pocket.enabled" = false;
            "extensions.pocket.api" = "0.0.0.0";
            "extensions.pocket.loggedOutVariant" = "";
            "extensions.pocket.oAuthConsumerKey" = "";
            "extensions.pocket.onSaveRecs" = false;
            "extensions.pocket.onSaveRecs.locales" = "";
            "extensions.pocket.showHome" = false;
            "extensions.pocket.site" = "0.0.0.0";
            "browser.newtabpage.activity-stream.pocketCta" = "";
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "services.sync.prefs.sync.browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
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
