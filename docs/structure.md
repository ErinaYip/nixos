# Structure

## Top-Level Directories

### `flake.nix`

Project entry point. Defines inputs, host construction, and the development shell.

### `lib/`

Holds `eriniteLib`, the helper library used by the module layer. Imported and exposed in `flake.nix` as `eriniteLib`.

### `os/` and `home/`

Current categories under `os/` and `home/`:

- `system/` for NixOS system services and platform behavior
- `desktop/` for graphical environment and desktop integration
- `cli/` for shell and terminal applications
- `browsers/` for browser modules
- `programs/` for optional application stacks
- `presets/` for grouped enablement

Recently added system modules:

- `os/system/adb.nix` installs Android platform tools and adds the default user
  to `adbusers`.
- `os/system/config-source.nix` links the flake source into
  `/run/current-system/configuration-source` and adds the `nixos-source` shell
  alias.
- `os/system/nix.nix` owns Nix settings, NixOS-side unfree package allowance,
  AppImage support, direnv, and `sudo nixos-rebuild` aliases.

### `hosts/`

Contains per-machine entry points and hardware-specific configuration. Host
directories are discovered automatically when they contain a `default.nix`.

Current hosts:

- `mechrevo`
  Main machine. Uses NVIDIA PRIME, Podman, VirtualBox, Wine, gaming modules, OBS Studio, and dynamic Hyprland monitor/workspace logic for internal and external displays.
- `nec`
  Laptop. Uses laptop-specific modules, a simple scaled Hyprland monitor setup, and has Codex CLI enabled.

### `docs/`

Repository documentation and agent onboarding material.

### `assets/`

Repository assets and templates used by modules.

Current templates include generated themes for btop, fuzzel, yazi,
PrismLauncher, cava, and Hyprland Lua colors.
Browser profile assets also live here, including Chromium bookmarks and
Firefox extension/profile settings.

## Important Files

### `home/default.nix`

Bridge from NixOS module space into Home Manager module space.

### `os/default.nix` and `home/default.nix`

Auto-import the module tree. Module option paths are derived from this tree:
`os/system/boot.nix` maps to `erinite.system.boot`, while
`home/desktop/dms/default.nix` maps to `erinite.home.desktop.dms`.

### `hosts/<name>/default.nix`

Primary host definition. This is usually the best place to inspect host intent first.

Each file returns an attribute set:

```nix
{
  osModules = [
    ./hardware-configuration.nix
    ./os.nix
    # Host-specific NixOS modules.
  ];

  homeModules = [
    # Host-specific Home Manager modules.
    ./home.nix
  ];
}
```

The `osModules` list is imported into `nixosSystem`, and the `homeModules` list
is imported by both standalone Home Manager and the Home Manager user inside
NixOS. Hardware-specific nixpkgs settings such as CUDA support live in the
module that needs them, for example `os/system/nvidia.nix`. NixOS-side nixpkgs
policy such as `allowUnfree` lives in `os/system/nix.nix`; standalone Home
Manager gets the same unfree allowance from the `pkgs` import in `flake.nix`.

### `hosts/<name>/hardware-configuration.nix`

Generated hardware configuration.

## Where To Look For Changes

If you need to understand or change behavior, start here:

- Shared behavior across hosts:
  `os/` and `home/` and `lib/default.nix`
- Home Manager behavior:
  `home/default.nix` and any module writing to `erinite.home`
- Hyprland behavior:
  `home/desktop/hyprland/`, `home/desktop/dms/hyprland.nix`, and host-level
  `wayland.windowManager.hyprland` overrides
- Theme generation:
  `home/desktop/matugen.nix` and `assets/templates/`
- Runtime source snapshot:
  `/run/current-system/configuration-source`, provided by
  `os/system/config-source.nix`
- Host-only behavior:
  `hosts/<name>/`
- Feature enablement defaults:
  `os/presets/common.nix` and `home/presets/common.nix`
