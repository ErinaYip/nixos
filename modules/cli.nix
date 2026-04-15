{
  config,
  lib,
  ...
}:
let
  types = lib.demo.types;
  cliAttrs = config.demo.cli or {};
  
  classify = p:
    if lib.elem p types.homeOnly then "home"
    else if lib.elem p types.nixosOnly then "nixos"
    else if lib.elem p types.both then "both"
    else "unknown";

  isNixosTarget = name:
    let target = classify name; in target == "nixos" || target == "both";

  isHomeTarget = name:
    let target = classify name; in target == "home" || target == "both";

  excluded = ["git"];
  homeExcluded = ["eza"];

  nixosProgs = lib.filterAttrs (n: v: 
    !lib.elem n excluded && isNixosTarget n && (v == true || (lib.isAttrs v && v.enable or false))
  ) cliAttrs;

  homeProgs = lib.filterAttrs (n: v: 
    !lib.elem n homeExcluded && isHomeTarget n && (v == true || (lib.isAttrs v && v.enable or false))
  ) cliAttrs;
in {
  config = lib.mkMerge [
    { programs = nixosProgs; }
    (lib.mkIf config.demo.home.enable {
      home-manager.users.${config.demo.home.user}.programs = homeProgs;
    })
  ];
}