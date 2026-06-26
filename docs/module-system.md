# Module System

## Core Entry

The shared module helper lives in `lib/default.nix`. It is imported directly in `flake.nix` and exposed as `eriniteLib` to all module roots through `specialArgs`.

The most important helper is `mkModule`.

## What `mkModule` Does

`mkModule` standardizes how modules are written.

A typical module provides:

- `configFn`
- `imports` (optional)
- `opts` (optional extra options)
- `defaultSettings` (optional)
- `namespace`, `category`, and `name` only when overriding the path-derived defaults

`mkModule` then:

1. Infers the option path from the module file path.
2. Binds `cfg = config.<derived-option-path>`.
3. Creates `enable` and `settings` options under that path.
4. Merges `defaultSettings` with `cfg.settings`.
5. Calls `configFn` only when the module is enabled.

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

Modules can also expose extra options through `opts`. For example,
`home/cli/zsh/default.nix` exposes an `aliases` attribute set so other Home
modules can contribute aliases without writing directly to `programs.zsh`, and
`home/cli/codex.nix` exposes `profileFiles` and `model_providers` so provider
definitions can be composed through the normal option tree. Codex profile
overrides are emitted as `~/.codex/<name>.config.toml` files for the current
profile loading model.

Hyprland settings are currently structured for Lua output instead of traditional
Hyprland conf strings. Lists such as binds, rules, environment variables,
curves, animations, monitors, and workspace rules use attribute sets with
arguments where needed. Raw Lua snippets use `lib.generators.mkLuaInline`.

## Common Helpers

Useful helpers in `eriniteLib`:

- `mkOpt`, `mkBoolOpt`, `mkStrOpt`, `mkListOpt`, `mkAttrOpt`
- `mkInputPkgb`, `mkInputPkga` - import packages from flake inputs
- `mergeSettings` - merge nested attribute sets preserving module semantics
- `enabled` and `disabled`
- `files` and `modules` for recursive module discovery
- `getDir` - scan directory structure recursively

Small module-local helper functions are preferred when they clarify repeated
data shapes. Current examples include alias generation in `os/system/nh.nix`
and `home/cli/nh.nix`, Nix rebuild alias generation in `os/system/nix.nix` and
`home/cli/zsh/default.nix`, provider generation in `home/cli/codex.nix`, and
Hyprland bind generation in `home/desktop/dms/hyprland.nix`.

## Module Discovery

`os/default.nix` and `home/default.nix` import their module trees by calling
`eriniteLib.modules ./.`.

`eriniteLib.modules`:

- Recursively scans directories
- Treats a directory with `default.nix` as a single module root
- Includes `.nix` files except `default.nix`
- Lets `mkModule` derive module identity from the file path

This is why most directories under `os/` and `home/` do not need a hand-maintained import list.
It also means modules do not need to repeat their option path:

- `os/system/boot.nix` becomes `erinite.os.system.boot`
- `home/desktop/vscode.nix` becomes `erinite.home.desktop.vscode`
- `home/desktop/dms/default.nix` becomes `erinite.home.desktop.dms`

## Writing a New Module

Recommended process:

1. Pick a category under `os/` or `home/`.
2. Create a module file using `eriniteLib.mkModule`.
3. Keep defaults in `defaultSettings` when the module has a settings tree.
4. Put raw implementation in `configFn`.
5. Enable it from a host or preset through the derived `erinite.*` option path.

Minimal shape:

```nix
{ lib, ... } @ args:

eriniteLib.mkModule args {
  defaultSettings = {
    foo = "bar";
  };

  configFn = { settings, ... }: {
    programs.example = {
      enable = true;
      settings = settings;
    };
  };
}
```

## Home Manager Composition

Home Manager has an explicit root module at `home/default.nix`.
Standalone `homeConfigurations` import that module directly, then import
the host's `homeModules`.

The NixOS side starts from `os/default.nix`, which imports the Home Manager NixOS
module and wires the same Home Manager root into
`home-manager.users.<username>`. Host-specific NixOS configuration lives in
the host's `osModules`.

New user-level configuration should go in `home/` or `hosts/<name>/home.nix`.

Cross-module Home Manager composition should usually target an `erinite.home`
option instead of downstream Home Manager options directly. The current Zsh
alias flow is the pattern: `home/cli/nh.nix` and `home/cli/codex.nix` populate
`erinite.home.cli.zsh.aliases`, and the Zsh module is the only module that
materializes those values into `programs.zsh.shellAliases`.
