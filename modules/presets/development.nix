{
  config,
  lib,
  ...
}:
with lib;
with lib.demo; let
  cfg = config.demo.presets.development;
in {
  options.demo.presets.development.enable = mkBoolOpt false "Enable the development preset.";

  config = mkIf cfg.enable {
    demo.cli.git = enabled;
  };
}
