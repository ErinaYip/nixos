{lib, ...}:
with lib; rec {
  mkOpt = type: default: description:
    mkOption {inherit type default description;};

  mkBoolOpt = mkOpt types.bool;

  enabled = {enable = true;};
  disabled = {enable = false;};

  getDir = dir:
    mapAttrs
    (
      file: type:
        if type == "directory"
        then getDir "${dir}/${file}"
        else type
    )
    (builtins.readDir dir);

  files = dir:
    collect isString (mapAttrsRecursive (path: _: concatStringsSep "/" path) (getDir dir));

  validFiles = dir:
    map
    (file: dir + "/${file}")
    (filter
      (file: hasSuffix ".nix" file && file != "default.nix")
      (files dir));
}
