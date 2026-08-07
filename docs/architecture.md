# Architecture

## Goal

The repository is organized as a modular personal NixOS configuration. It aims
to keep host definitions short by moving reusable behavior into modules and
presets.

## Main Layers

The configuration has four main layers:

1. `flake.nix` Builds `nixosConfigurations` and injects shared `specialArgs`.
2. `lib/` Defines helper functions exposed as `eriniteLib`.
3. `os/` and `home/` Declares reusable options and translates `erinite.*`
   options into NixOS or Home Manager config.
4. `hosts/` Chooses which modules to enable and provides machine-specific
   overrides.

## Build Flow

The high-level flow is:

1. `flake.nix` defines inputs and discovers host directories under `hosts/`.
2. For each discovered host, `mkHost` imports `hosts/<hostName>/default.nix` and
   reads its `{ osModules, homeModules }` result.
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
7. Modules expose options under `erinite.os.<category>.<name>` or
   `erinite.home.<category>.<name>`.
8. Host modules set values under `erinite.*` and enabled modules emit final
   NixOS or Home Manager configuration.

The shared `wallpapers/` module is imported by both the NixOS and Home Manager
roots. It defines `erinite.wallpapers.definitions` as the raw wallpaper input,
adds the default wallpaper, and exposes processed themes at
`erinite.wallpapers.wallpapers`. Host-specific wallpaper definitions live in
`hosts/<hostName>/wallpapers.nix`; the host default lists that file once in its
top-level `imports`, and flake host construction adds those imports to both
module graphs so OS and Home modules read from their own
`config.erinite.wallpapers` tree.

Hyprland is an important special case in the current tree. The shared
`os.desktop.hyprland` module enables the system package, portal, Home Manager
integration, and Lua config mode. Common binds, rules, animations and base
settings are composed under `home/desktop/hyprland/`. Host-specific monitor and
workspace logic stays in host configuration files when it depends on local
outputs, refresh rates, rotation, or external monitor detection.

## Design Pattern

Most modules follow the same pattern:

1. Use the directory path as the module identity, such as `home/cli/kitty.nix`
   or `os/system/keyd.nix`.
2. Offer `enable` and `settings` options.
3. Merge `defaultSettings` with host overrides.
4. Emit downstream config only when `enable = true`.

This keeps host files focused on intent instead of implementation detail.

## NixOS and Home Manager Split

The repository uses both NixOS modules and Home Manager modules:

- System-level settings are emitted directly as NixOS options.
- User-level settings are emitted directly as Home Manager options.
- OS modules expose options under `erinite.os`.
- Home modules expose options under `erinite.home`.
- `flake.nix` imports the same host `homeModules` into NixOS-integrated Home
  Manager and standalone `homeConfigurations`.
- Both NixOS-integrated Home Manager and standalone `homeConfigurations` import
  the same host Home Manager modules.

That keeps OS and Home behavior symmetrical while still allowing each side to
own its own module tree.

Hardware-specific nixpkgs settings are owned by the module that needs them. For
example, `os/system/nvidia.nix` enables CUDA support alongside the NVIDIA driver
configuration. General unfree package allowance is configured in both
entrypoints: `os/system/nix.nix` for NixOS builds, and the shared `pkgs` import
in `flake.nix` for standalone Home Manager builds such as `nh home switch`.
Host proxy configuration is owned by `os/system/mihomo.nix`; when that module is
enabled, it sets `networking.proxy` so NixOS session environments and
`nix-daemon` receive the same proxy settings.

Stylix's Home Manager module is imported as a shared module, but its Home
Manager-side overlays are disabled for the same reason.

The desktop stack is split by ownership: OS modules configure system services
and packages, while Home modules configure user-session state through
`erinite.home`. Host files enable the two sides explicitly through `osModules`
and `homeModules`.

The `home.desktop.qq` module reuses nixpkgs' QQ packaging logic while overriding
the x86_64 Linux source URL and hash locally. It also normalizes the desktop
entry icon so the installed application can resolve it through the icon theme.

## Current Desktop Flow

The current graphical session is centered on:

- Hyprland from the flake input, with UWSM enabled and Home Manager using
  `configType = "lua"`.
- DankMaterialShell from the `master` flake input as the shell layer, with
  Hyprland window/layer rules and IPC keybinds.
- Theme specialisations switch the NixOS system profile from the DMS wallpaper
  watcher. Stylix uses the default `pkgs.tela-icon-theme` package for its icon
  theme.
- Fcitx5 + Rime for input method packages and user configuration.
- Optional Hyprland plugins from inputs, with `hyprgrass` controlled by the
  host-level `grass` option.

## Presets

`os/presets/common.nix` and `home/presets/common.nix` are convenience presets.
They enable the baseline desktop, CLI, and system stack used by current hosts.
The OS preset owns system services such as Nix, nh, config-source, networking,
fonts, sound, users, keyd, Ly, Hyprland system integration, and LocalSend. The
Home preset owns user-session applications such as browsers, DMS, Hyprland
config, Stylix, Zsh, nh aliases, Codex, nvim, yazi, kitty, and other CLI tools.

Hosts still add their own hardware and behavioral overrides on top of that
preset.
