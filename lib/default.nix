{
  lib,
  inputs,
  pkgs,
  ...
}:
lib.makeExtensible (final: {
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

  mkDefaultApplications = app: mimes: lib.genAttrs mimes (_: app);

  recolorScript = args: (import ./recolor args).recolorScript;

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

  mkModule = args: module: let
    inferred =
      args.eriniteModule or (final.moduleInfoFromModule module);
    spec = inferred // module;
    namespace = spec.namespace or ["erinite"];
    category =
      spec.category
      or (throw "mkModule requires category; import the module through eriniteLib.modules or set category explicitly.");
    name =
      spec.name
      or (throw "mkModule requires name; import the module through eriniteLib.modules or set name explicitly.");
    imports = spec.imports or [];
    opts = spec.opts or {};
    defaultSettings = spec.defaultSettings or {};
    configFn = spec.configFn;
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

  moduleFiles = dir: let
    allFiles = lib.collect lib.isString (
      lib.mapAttrsRecursive (path: _: lib.concatStringsSep "/" path)
      (final.getDir dir)
    );
  in
    lib.filter (f: lib.hasSuffix ".nix" f && f != "default.nix") allFiles;

  moduleRootNamespace = root:
    ["erinite"] ++ lib.optional (root == "os" || root == "home") root;

  moduleInfoFromFile = file: let
    path = lib.splitString "/" (toString file);
    pathLength = builtins.length path;
    moduleFile = builtins.elemAt path (pathLength - 1);
    isDefault = moduleFile == "default.nix";
  in {
    namespace =
      final.moduleRootNamespace
      (builtins.elemAt path (pathLength
        - (
          if isDefault
          then 4
          else 3
        )));
    category = builtins.elemAt path (pathLength
      - (
        if isDefault
        then 3
        else 2
      ));
    name =
      if isDefault
      then builtins.elemAt path (pathLength - 2)
      else lib.removeSuffix ".nix" moduleFile;
  };

  moduleInfoFromModule = module: let
    position = builtins.unsafeGetAttrPos "configFn" module;
  in
    if position == null
    then {}
    else final.moduleInfoFromFile position.file;

  files = dir: let
    d = toString dir;
  in
    map (f: d + "/" + f)
    (final.moduleFiles dir);

  modules = dir: final.files dir;
})
