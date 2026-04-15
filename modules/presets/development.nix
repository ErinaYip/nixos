{
  config,
  lib,
  ...
}:
with lib;
with lib.zenyte; let
  cfg = config.zenyte.presets.development;
in {
  options.zenyte.presets.development.enable = mkBoolOpt false "Enable the development preset.";

  config = mkIf cfg.enable {
    zenyte.cli.git = enabled;
  };
}
