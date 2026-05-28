# Architecture

## Goal

The repository is organized as a modular personal NixOS configuration. It aims to keep host definitions short by moving reusable behavior into modules and presets.

## Main Layers

The configuration has four main layers:

1. `flake.nix`
   Builds `nixosConfigurations` and injects shared `specialArgs`.
2. `lib/`
   Defines helper functions exposed as `eriniteLib`.
3. `os/` and `home/`
   Declares reusable options and translates `erinite.*` options into NixOS or Home Manager config.
4. `hosts/`
   Chooses which modules to enable and provides machine-specific overrides.

## Build Flow

The high-level flow is:

1. `flake.nix` defines inputs and discovers host directories under `hosts/`.
2. For each discovered host, `mkHost` imports `hosts/<hostName>/default.nix` and reads its `{ osModules, homeModules }` result.
3. The host result is split into `hostOsModules` and `hostHomeModules`.
   `hostHomeModules` is always `[ ./home ] ++ host.homeModules`.
4. `mkHost` creates a `nixosSystem` with these module roots:
   - `os/`
   - `hosts/<hostName>/default.nix`'s `osModules`
   - `home-manager.users.<username>.imports = hostHomeModules`
5. `specialArgs` injects:
   - `inputs`
   - `hostName`
   - `default`
   - `eriniteLib`
6. Standalone `homeConfigurations` imports the same `hostHomeModules` list.
7. Modules expose options under `erinite.<category>.<name>` or `erinite.home.<category>.<name>`.
8. Host modules set values under `erinite.*` and enabled modules emit final NixOS or Home Manager configuration.

Hyprland is an important special case in the current tree. The shared
`desktop.hyprland` module enables the system package, portal, Home Manager
integration, and Lua config mode. Common binds, rules, animations and base
settings are composed under `home/desktop/hyprland/`. Host-specific monitor
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
- User-level settings are emitted directly as Home Manager options.
- Home modules expose options under `erinite.home`.
- `flake.nix` imports the same host `homeModules` into NixOS-integrated Home Manager and standalone `homeConfigurations`.
- Both NixOS-integrated Home Manager and standalone `homeConfigurations` import the same host Home Manager modules.

That keeps OS and Home behavior symmetrical while still allowing each side to
own its own module tree.

Hardware-specific nixpkgs settings are owned by the module that needs them.
For example, `os/system/nvidia.nix` enables CUDA support alongside the NVIDIA
driver configuration. General unfree package allowance is owned by
`os/system/nix.nix`.

Stylix's Home Manager module is imported as a shared module, but its Home
Manager-side overlays are disabled for the same reason.

The desktop stack is split by ownership: OS modules configure system services
and packages, while Home modules configure user-session state through
`erinite.home`. Host files enable the two sides explicitly through `osModules`
and `homeModules`.

## Current Desktop Flow

The current graphical session is centered on:

- Hyprland from the flake input, with UWSM enabled and Home Manager using `configType = "lua"`.
- DankMaterialShell from the `master` flake input as the shell layer, with Hyprland window/layer rules and IPC keybinds.
- Matugen-generated theme files for btop, fuzzel, yazi, PrismLauncher, cava, and Hyprland.
- Fcitx5 + Rime for input method packages and user configuration.
- Optional Hyprland plugins from inputs, with `hyprgrass` controlled by the host-level `grass` option.

## Presets

`os/presets/common.nix` and `home/presets/common.nix` are convenience presets.
They enable the baseline desktop, CLI, and system stack used by current hosts.
The OS preset owns system services such as Nix, nh, config-source, networking,
fonts, sound, users, keyd, Ly, Hyprland system integration, and LocalSend. The
Home preset owns user-session applications such as browsers, DMS, Hyprland
config, Stylix, Zsh, nh aliases, Codex, nvim, yazi, kitty, and other CLI tools.

Hosts still add their own hardware and behavioral overrides on top of that preset.
