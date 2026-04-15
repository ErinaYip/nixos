{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.demo.programs;
  homeCfg = config.demo.home;
  types = lib.demo.types;
in {
  options.demo.programs = with types; {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable programs configuration";
    };
    extra = mkOption {
      type = types.attrsOf (types.attrs);
      default = {};
      description = "Extra programs to configure";
    };
  };

  config = mkIf cfg.enable (let
    dispatch = program: programCfg:
      let
        target = if elem program types.homeOnly then "home"
          else if elem program types.nixosOnly then "nixos"
          else if elem program types.both then "both"
          else "unknown";
      in
        mkIf (target != "unknown" && programCfg.enable or false) (
          mkMerge [
            (mkIf (target == "nixos" || target == "both") {
              config.programs.${program} = removeAttrs programCfg ["enable"];
            })
            (mkIf (homeCfg.enable && (target == "home" || target == "both")) {
              home-manager.users.${homeCfg.user}.${program} = removeAttrs programCfg ["enable"];
            })
          ]
        );
  in
    mapAttrs dispatch cfg.extra);
}