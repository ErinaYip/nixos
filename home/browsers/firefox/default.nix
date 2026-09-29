{
  pkgs,
  config,
  eriniteLib,
  ...
} @ args: let
  extensions = import ./extensions.nix;
  search = import ./search.nix {inherit pkgs;};
in
  with eriniteLib;
    mkModule args {
      configFn = _: {
        programs.firefox = {
          enable = true;
          package = pkgs.firefox-bin;
          configPath = ".mozilla/firefox";
          languagePacks = ["zh-CN"];

          policies =
            extensions
            // {
              AppAutoUpdate = false;
              BackgroundAppUpdate = false;
              DisableFirefoxStudies = true;
              DisableTelemetry = true;
              DisableSetDesktopBackground = true;
              DisablePocket = true;
              BlockAboutConfig = false;
              BlockAboutSupport = true;

              DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";
            };

          profiles."default" = {
            isDefault = true;
            inherit search;
            extensions.force = true;

            settings = {
              "intl.locale.requested" = "zh-CN,en-US";
              "layout.spellcheckDefault" = 0;
              "media.eme.enabled" = true;
              "browser.newtabpage.enabled" = false;
              "browser.safebrowsing.malware.enabled" = false;
              "browser.safebrowsing.phishing.enabled" = false;
              "browser.search.region" = "HK";
              "browser.startup.page" = 3;
              "browser.tabs.closeWindowWithLastTab" = false;
              "extensions.autoDisableScopes" = 0;
              "nimbus.rollouts.enabled" = false;
              "geo.enabled" = false;

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
          "application/pdf"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];
      };
    }
