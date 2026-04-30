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

1. `flake.nix` defines inputs and a helper `addHost`.
2. `addHost` creates a `nixosSystem` with three module roots:
   - `modules/home.nix`
   - `modules/`
   - `hosts/<hostName>`
3. `specialArgs` injects:
   - `lib` extended with `eriniteLib`
   - `inputs`
   - `hostName`
   - `default`
4. Modules expose options under `erinite.<category>.<name>`.
5. Host files set values under `erinite.*`.
6. Enabled modules emit final NixOS and Home Manager configuration.

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

That means a system module can also contribute Home Manager configuration by writing to `erinite.home`.

## Presets

`modules/presets/common.nix` is a convenience preset. It enables the baseline desktop, CLI, and system stack used by both current hosts.

Hosts still add their own hardware and behavioral overrides on top of that preset.
