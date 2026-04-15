{lib, ...}:

lib.makeExtensible (final: {
  mkOpt = type: default: description:
    lib.mkOption {inherit type default description;};

  mkBoolOpt = default: description:
    final.mkOpt lib.types.bool default description;

  mkStrOpt = default: description:
    final.mkOpt lib.types.str default description;

  mkListOpt = elemType: default: description:
    final.mkOpt (lib.types.listOf elemType) default description;

  mkAttrOpt = valueType: default: description:
    final.mkOpt (lib.types.attrsOf valueType) default description;

  mkModule = args: {category, name, opts ? {}, defaultSettings ? {}, configFn}:
    let
      cfg = args.config.erinite.${category}.${name};
      mergedSettings = lib.mkMerge [defaultSettings cfg.settings];
    in {
      options.erinite.${category}.${name} = {
        enable = final.mkBoolOpt false "Whether to enable ${name}.";
        settings = final.mkOpt lib.types.attrs {} "Configuration settings for ${name}.";
      } // opts;

      config = lib.mkIf cfg.enable (
        configFn {
          inherit cfg;
          settings = mergedSettings;
        }
      );
    };

  enabled = {enable = true;};
  disabled = {enable = false;};

  getDir = dir:
    let
      d = toString dir;
    in
    lib.mapAttrs
      (file: type:
        if type == "directory" then final.getDir (d + "/" + file) else type
      )
      (builtins.readDir d);

  files = dir:
    let
      d = toString dir;
      allFiles = lib.collect lib.isString (
        lib.mapAttrsRecursive (path: _: lib.concatStringsSep "/" path)
          (final.getDir dir)
      );
    in
    map (f: d + "/" + f)
      (lib.filter (f: lib.hasSuffix ".nix" f && f != "default.nix") allFiles);

  modules = dir: final.files dir;
})