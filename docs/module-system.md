# Module System

## Core Entry

The shared module helper lives in `lib/default.nix`. It is imported directly in `flake.nix` and exposed as `eriniteLib` to all module roots through `specialArgs`.

The most important helper is `mkModule`.

## What `mkModule` Does

`mkModule` standardizes how modules are written.

A typical module provides:

- `category`
- `name`
- `imports` (optional)
- `opts` (optional extra options)
- `defaultSettings` (optional)
- `configFn`

`mkModule` then:

1. Binds `cfg = config.erinite.<category>.<name>`.
2. Creates `enable` and `settings` options under that path.
3. Merges `defaultSettings` with `cfg.settings`.
4. Calls `configFn` only when the module is enabled.

## Settings Merge Semantics

The repository intentionally treats module `settings` as recursively merged attribute sets.

Current behavior:

- `defaultSettings` provides module defaults.
- `cfg.settings` provides host or preset overrides.
- The merge is performed through a small `evalModules` step so module-style merges are preserved.

This matters for nested settings trees such as:

- Hyprland settings
- keyd settings
- toolkit or application configuration blocks

Without recursive merging, host overrides can accidentally replace an entire nested subtree.

Hyprland settings are currently structured for Lua output instead of traditional
Hyprland conf strings. Lists such as binds, rules, environment variables,
curves, animations, monitors, and workspace rules use attribute sets with
arguments where needed. Raw Lua snippets use `lib.generators.mkLuaInline`.

## Common Helpers

Useful helpers in `eriniteLib`:

- `mkOpt`, `mkBoolOpt`, `mkStrOpt`, `mkListOpt`, `mkAttrOpt`
- `mkShellAliases`
- `mkInputPkgb`, `mkInputPkga` - import packages from flake inputs
- `mergeSettings` - merge nested attribute sets preserving module semantics
- `enabled` and `disabled`
- `files` and `modules` for recursive module discovery
- `getDir` - scan directory structure recursively

## Module Discovery

`modules/default.nix` imports all modules by calling `eriniteLib.modules ./.`.

`eriniteLib.modules`:

- Recursively scans directories
- Treats a directory with `default.nix` as a single module root
- Includes `.nix` files except `default.nix`

This is why most directories under `modules/` do not need a hand-maintained import list.

## Writing a New Module

Recommended process:

1. Pick a category under `modules/`.
2. Create a module file using `eriniteLib.mkModule`.
3. Keep defaults in `defaultSettings` when the module has a settings tree.
4. Put raw implementation in `configFn`.
5. Enable it from a host or preset through `erinite.<category>.<name>`.

Minimal shape:

```nix
{ lib, ... } @ args:

eriniteLib.mkModule args {
  category = "cli";
  name = "example";

  defaultSettings = {
    foo = "bar";
  };

  configFn = { settings, ... }: {
    erinite.home.programs.example = {
      enable = true;
      settings = settings;
    };
  };
}
```

## Home Manager Composition

- Modules contribute user-level settings by writing to `erinite.home`.
- `modules/home.nix` wraps those definitions into a composed `erinite.homeModule`.
- `erinite.homeModule` adds base `home.*` defaults and becomes the shared entrypoint for both NixOS-integrated Home Manager and standalone `homeConfigurations`.
- Standalone `homeConfigurations` also reuse `config.home-manager.sharedModules` from the host evaluation so third-party Home Manager modules stay available.

Modules often enable a NixOS service or package while also writing the
corresponding user configuration into `erinite.home`. `desktop.hyprland`,
`desktop.dms`, `desktop.matugen`, `cli.codex` and `cli.opencode` all follow this
pattern.
