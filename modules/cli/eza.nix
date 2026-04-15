{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.demo.cli;
in {
  options.demo.cli.eza = mkOption {
    type = types.bool;
    default = false;
    description = "Enable eza - a modern replacement for ls";
  };

  config = mkIf cfg.eza {
    environment.systemPackages = [pkgs.eza];
  };
}