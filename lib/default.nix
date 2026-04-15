{lib}:
with lib; rec {
  mkOpt = type: def: desc:
    mkOption {type = type; default = def; description = desc;};

  mkBoolOpt = def: desc:
    mkOption {type = types.bool; default = def; description = desc;};

  mkStrOpt = def: desc:
    mkOption {type = types.str; default = def; description = desc;};

  getDir = dir:
    mapAttrs
      (file: type:
        if type == "directory" then getDir "${dir}/${file}" else type
      )
      (builtins.readDir dir);

  files = dir:
    collect isString (mapAttrsRecursive (path: _: concatStringsSep "/" path) (getDir dir));

  collectModules = dir:
    filter
      (file: hasSuffix ".nix" file && file != "default.nix")
      (files dir);
}