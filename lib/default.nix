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

  mkShellAliases = {
    aliases,
    shells ? [],
    system ? true,
  }:
    lib.mkMerge (
      lib.optional system {
        environment.shellAliases = aliases;
      }
      ++ map (shell:
        lib.setAttrByPath [ "erinite" "home" "programs" shell "shellAliases" ] aliases
      ) shells
    );

  mkModule = args: { category, name, imports ? [], opts ? {}, defaultSettings ? {}, configFn }:
    let
      cfg = args.config.erinite.${category}.${name};
      mergedSettings = args.lib.mkMerge [ defaultSettings cfg.settings ];
    in {
      inherit imports;

      options.erinite.${category}.${name} = {
        enable = final.mkBoolOpt false "Whether to enable ${name}.";
        settings = final.mkOpt args.lib.types.attrs {} "Configuration settings for ${name}.";
      } // opts;

      config = args.lib.mkIf cfg.enable (
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
        if type == "directory" then
          if builtins.pathExists (d + "/" + file + "/default.nix") then
            { "default.nix" = "regular"; }
          else
            final.getDir (d + "/" + file)
        else type
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
