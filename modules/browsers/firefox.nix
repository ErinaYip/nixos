{
  lib,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "browsers";
    name = "firefox";

    opts = {
      profiles = mkAttrOpt lib.types.attrs {
        "default" = {
          isDefault = true;
        };
      } "Firefox profiles configuration";
    };

    configFn = {cfg, ...}: {
      erinite.home.programs.firefox = {
        enable = true;
        inherit (cfg) profiles;
      };
    };
  }
