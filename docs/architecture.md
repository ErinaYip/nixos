# Architecture

## Goal

The repository is organized as a modular personal NixOS configuration. It aims to keep host definitions short by moving reusable behavior into modules and presets.

## Main Layers

The configuration has four main layers:

1. `flake.nix`
   Builds `nixosConfigurations` and injects shared `specialArgs`.
2. `lib/`
   Defines helper functions exposed as `eriniteLib`.
3. `modules/`
   Declares reusable options and translates `erinite.*` options into NixOS or Home Manager config.
4. `hosts/`
   Chooses which modules to enable and provides machine-specific overrides.

## Build Flow

The high-level flow is:

1. `flake.nix` defines inputs and discovers host directories under `hosts/`.
2. For each discovered host, `mkHost` imports `hosts/<hostName>/default.nix` and reads its `{ meta, module }` result.
3. `mkHost` creates a host-specific `pkgs` with shared nixpkgs config and host metadata such as `meta.cudaSupport`.
4. `mkHost` creates a `nixosSystem` with four module roots:
   - `{ nixpkgs.pkgs = hostPkgs; }`
   - `modules/home.nix`
   - `modules/`
   - `hosts/<hostName>/default.nix`'s `module`
5. `specialArgs` injects:
   - `lib` extended with `eriniteLib`
   - `inputs`
   - `hostName`
   - `default`
6. Modules expose options under `erinite.<category>.<name>`.
7. Host modules set values under `erinite.*`.
8. Enabled modules emit final NixOS and Home Manager configuration.

Hyprland is an important special case in the current tree. The shared
`desktop.hyprland` module enables the system package, portal, Home Manager
integration, and Lua config mode. Common binds, rules, animations and base
settings are composed under `modules/desktop/hyprland/`. Host-specific monitor
and workspace logic stays in host configuration files when it depends on local
outputs, refresh rates, rotation, or external monitor detection.

## Design Pattern

Most modules follow the same pattern:

1. Declare a namespace like `erinite.cli.kitty` or `erinite.system.keyd`.
2. Offer `enable` and `settings` options.
3. Merge `defaultSettings` with host overrides.
4. Emit downstream config only when `enable = true`.

This keeps host files focused on intent instead of implementation detail.

## NixOS and Home Manager Split

The repository uses both NixOS modules and Home Manager modules:

- System-level settings are emitted directly as NixOS options.
- User-level settings are emitted through `erinite.home`.
- `modules/home.nix` composes `config.erinite.homeModule` and imports it into `home-manager.users.${default.username}`.
- `flake.nix` also exports that same composed module as standalone `homeConfigurations` for `nh home`, along with any host-level `home-manager.sharedModules`.
- Both NixOS-integrated Home Manager and standalone `homeConfigurations` use the same host-specific `hostPkgs`.

That means a system module can also contribute Home Manager configuration by writing to `erinite.home`.

Because `home-manager.useGlobalPkgs = true`, host-level nixpkgs settings are
applied while importing `hostPkgs` in `flake.nix` instead of through
`nixpkgs.config` module options. `hostPkgs` is then passed to NixOS with
`nixpkgs.pkgs`. This avoids Home Manager's warning about `nixpkgs.config` and
`nixpkgs.overlays` under `useGlobalPkgs`.

Stylix's Home Manager module is imported as a shared module, but its Home
Manager-side overlays are disabled for the same reason.

The desktop stack uses this bridge heavily. For example, `desktop.hyprland`,
`desktop.dms`, `desktop.matugen`, `system.fcitx5`, and several CLI modules all
contribute Home Manager state through `erinite.home` even when their enablement
is selected from the NixOS host.

## Current Desktop Flow

The current graphical session is centered on:

- Hyprland from the flake input, with UWSM enabled and Home Manager using `configType = "lua"`.
- DankMaterialShell as the shell layer, with Hyprland window/layer rules and IPC keybinds.
- Matugen-generated theme files for btop, fuzzel, yazi, PrismLauncher, cava, and Hyprland.
- Fcitx5 + Rime for input method packages and user configuration.
- Optional Hyprland plugins from inputs, with `hyprgrass` controlled by the host-level `grass` option.

## Presets

`modules/presets/common.nix` is a convenience preset. It enables the baseline desktop, CLI, and system stack used by both current hosts.

Hosts still add their own hardware and behavioral overrides on top of that preset.
