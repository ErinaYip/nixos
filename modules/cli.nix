{
  config,
  lib,
  ...
}:
let
  types = lib.demo.types;
in {
  options.demo.cli = {
    enable = lib.mkOption {
      type = types.bool;
      default = false;
      description = "Enable CLI programs configuration";
    };
  };

  config = let
    enabled = config.demo.cli.enable or false;
    
    classify = p:
      if builtins.elem p types.homeOnly then "home"
      else if builtins.elem p types.nixosOnly then "nixos"
      else if builtins.elem p types.both then "both"
      else "unknown";

    isNixosTarget = name:
      let target = classify name; in target == "nixos" || target == "both";

    isHomeTarget = name:
      let target = classify name; in target == "home" || target == "both";

    cliAttrs = config.demo.cli or {};
    
    nixosProgs = lib.filterAttrs (n: v: isNixosTarget n && (v.enable or false)) cliAttrs;
    homeProgs = lib.filterAttrs (n: v: isHomeTarget n && (v.enable or false)) cliAttrs;
  in
    lib.mkMerge [
      (lib.mkIf enabled { programs = nixosProgs; })
      (lib.mkIf enabled {
        home-manager.users.${config.demo.home.user}.programs = homeProgs;
      })
    ];
}