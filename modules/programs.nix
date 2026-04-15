{
  config,
  lib,
  ...
}:
let
  types = lib.demo.types;
  cfg = config.demo.programs;
  homeCfg = config.demo.home;
in {
  options.demo.programs = {
    enable = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Enable programs configuration";
    };
    extra = lib.mkOption {
      type = types.attrsOf (types.attrs);
      default = {};
      description = "Extra programs to configure";
    };
  };

  config = let
    enabled = cfg.enable or false;
    programs = cfg.extra or {};

    classify = p:
      if builtins.elem p types.homeOnly then "home"
      else if builtins.elem p types.nixosOnly then "nixos"
      else if builtins.elem p types.both then "both"
      else "unknown";

    isNixosTarget = name:
      let target = classify name; in target == "nixos" || target == "both";

    isHomeTarget = name:
      let target = classify name; in target == "home" || target == "both";

    nixosProgs = lib.filterAttrs (n: _: isNixosTarget n) programs;
    homeProgs = lib.filterAttrs (n: _: isHomeTarget n) programs;
  in
    lib.mkMerge [
      (lib.mkIf enabled { programs = nixosProgs; })
      (lib.mkIf (enabled && homeCfg.enable) {
        home-manager.users.${homeCfg.user}.programs = homeProgs;
      })
    ];
}