{lib, ...} @ types:
with types;
with lib; let
  classify = program:
    if elem program homeOnly then "home"
    else if elem program nixosOnly then "nixos"
    else if elem program both then "both"
    else "unknown";

  mkModule = program: cfg: userCfg:
    let
      target = classify program;
    in
      {
        nixos = mkIf (target == "nixos" || target == "both") {
          config.programs.${program} = cfg;
        };
        home = mkIf (target == "home" || target == "both") {
          home-manager.users.${userCfg.user}.${program} = cfg;
        };
      };

  resolveModule = program: cfg: userCfg:
    let
      target = classify program;
    in
      mkIf (target != "unknown") (mkModule program cfg userCfg);
in {
  inherit classify mkModule resolveModule;
}