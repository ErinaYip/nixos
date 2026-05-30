{
  lib,
  inputs,
  pkgs,
  ...
}:
lib.makeExtensible (final: {
  imports = [
    ./recolor
  ];

  mkOpt = type: default: description:
    lib.mkOption {inherit type default description;};

  mkBoolOpt = default: description:
    final.mkOpt lib.types.bool default description;

  mkStrOpt = default: description:
    final.mkOpt lib.types.str default description;

  mkIntOpt = default: description:
    final.mkOpt lib.types.int default description;

  mkListOpt = elemType: default: description:
    final.mkOpt (lib.types.listOf elemType) default description;

  mkAttrOpt = valueType: default: description:
    final.mkOpt (lib.types.attrsOf valueType) default description;

  mkInputPkgb = input: pkg: inputs.${input}.packages.${pkgs.stdenv.hostPlatform.system}.${pkg};
  mkInputPkga = input: final.mkInputPkgb input input;

  recolorScript = args: (import ./recolor args).recolorScript;

  themeSpecialisations = import ./theme-specialisations.nix {
    inherit lib pkgs;
    eriniteLib = final;
  };

  themeSwitching = import ./theme-switching {
    inherit lib pkgs;
  };

  mergeSettings = definitions:
    (lib.evalModules {
      modules = [
        {
          options.settings = lib.mkOption {
            type = lib.types.attrsOf lib.types.anything;
            default = {};
          };

          config.settings = lib.mkMerge definitions;
        }
      ];
    }).config.settings;

  mkModule = args: {
    category,
    name,
    namespace ? ["erinite"],
    imports ? [],
    opts ? {},
    defaultSettings ? {},
    configFn,
  }: let
    optionPath = namespace ++ [category name];
    cfg = lib.getAttrFromPath optionPath args.config;
    mergedSettings = final.mergeSettings [defaultSettings cfg.settings];
  in {
    inherit imports;

    options = lib.setAttrByPath optionPath ({
        enable = final.mkBoolOpt false "Whether to enable ${name}.";
        settings = final.mkOpt (args.lib.types.attrsOf args.lib.types.anything) {} "Configuration settings for ${name}.";
      }
      // opts);

    config = args.lib.mkIf cfg.enable (
      configFn {
        inherit cfg;
        settings = mergedSettings;
      }
    );
  };

  enabled = {enable = true;};
  disabled = {enable = false;};

  getDir = dir: let
    d = toString dir;
  in
    lib.mapAttrs
    (
      file: type:
        if type == "directory"
        then
          if builtins.pathExists (d + "/" + file + "/default.nix")
          then {"default.nix" = "regular";}
          else final.getDir (d + "/" + file)
        else type
    )
    (builtins.readDir d);

  files = dir: let
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
