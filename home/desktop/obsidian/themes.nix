{
  lib,
  obsidianAssets,
}: {
  packages = lib.genAttrs ["Blue Topaz"] (name:
    builtins.path {
      name = "obsidian-theme-${lib.strings.sanitizeDerivationName name}";
      path = obsidianAssets + "/themes/${name}";
      filter = path: type:
        type
        == "directory"
        || builtins.elem (baseNameOf path) [
          "manifest.json"
          "theme.css"
        ];
    });
}
