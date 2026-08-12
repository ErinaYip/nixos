# Structure

## Top-Level Directories

### `flake.nix`

Project entry point. Defines inputs, host construction, and the development
shell output.

### `dev/`

Holds repository-local development environment definitions. `dev/default.nix`
builds the default `nix develop` shell with `nixd`, formatting, and linting
tools for Nix files. Neovim's nvf configuration passes flake-aware `nixd`
settings so the language server can evaluate the current flake's NixOS and
Home Manager options for the active host.

### `.envrc`

Loads the default flake dev shell through direnv and watches `flake.nix` and
`flake.lock` for environment reloads. Run `direnv allow` after reviewing the file.

### `lib/`

Holds `eriniteLib`, the helper library used by the module layer. Imported and
exposed in `flake.nix` as `eriniteLib`.

### `os/` and `home/`

Current categories under `os/` and `home/`:

- `system/` for NixOS system services and platform behavior
- `desktop/` for graphical environment and desktop integration
- `cli/` for shell and terminal applications
- `browsers/` for browser modules
- `programs/` for optional application stacks
- `presets/` for grouped enablement

The shared Neovim module lives under `home/cli/nvim/`. It is built through nvf;
`blink-cmp.nix` owns completion menu behavior, including nvim-cmp-compatible
completion kind appearance. `settings.nix` also owns the Fcitx5 mode-switch
autocmd that calls `fcitx5-remote` to disable Chinese input outside
insert-oriented modes and restore it on insert entry when needed.

Recently added system modules:

- `os/system/adb.nix` installs Android platform tools and adds the default user
  to `adbusers`.
- `os/desktop/niri.nix` enables nixpkgs' Niri NixOS module with the
  `sodiboo/niri-flake` package output and cache so Niri is installed
  system-wide and exposed to Ly through display-manager session data.
- `os/system/laptop.nix` owns shared laptop power policy, including UPower,
  power-profiles-daemon, and logind lid handling.
- `os/system/config-source.nix` links the flake source into
  `/run/current-system/configuration-source` and adds the `nixos-source` shell
  alias.
- `os/system/nix.nix` owns Nix settings, NixOS-side unfree package allowance,
  AppImage support, direnv, and `sudo nixos-rebuild` aliases.

### `hosts/`

Contains per-machine entry points and hardware-specific configuration. Host
directories are discovered automatically when they contain a `default.nix`.

Current hosts:

- `mechrevo` Main machine. Uses NVIDIA PRIME, Podman, VirtualBox, Wine, gaming
  modules, OBS Studio, and dynamic Hyprland monitor/workspace logic for internal
  and external displays.
- `nec` Laptop. Uses laptop-specific modules, a simple scaled Hyprland monitor
  setup, and has Codex CLI enabled.

### `docs/`

Repository documentation and agent onboarding material.

### `assets/`

Repository assets and templates used by modules.

Current templates include generated themes for btop, fuzzel, yazi,
PrismLauncher, cava, and Hyprland Lua colors. Browser profile assets also live
here, including Chromium bookmarks and Firefox extension/profile settings.

## Important Files

### `home/default.nix`

Bridge from NixOS module space into Home Manager module space.

### `os/default.nix` and `home/default.nix`

Auto-import the module tree. Module option paths are derived from this tree:
`os/system/boot.nix` maps to `erinite.os.system.boot`, while
`home/desktop/dms/default.nix` maps to `erinite.home.desktop.dms`.

### `hosts/<name>/default.nix`

Primary host definition. This is usually the best place to inspect host intent
first.

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

### `hosts/<name>/wallpapers.nix`

Optional host wallpaper definitions. The shared `wallpapers/` module imports
this file through the top-level `imports` returned by `hosts/<name>/default.nix`.
Hosts set `erinite.wallpapers.definitions` here once, and OS/Home modules
consume the processed result from `config.erinite.wallpapers.wallpapers`.

### `hosts/<name>/hardware-configuration.nix`

Generated hardware configuration.

## Where To Look For Changes

If you need to understand or change behavior, start here:

- Shared behavior across hosts: `os/` and `home/` and `lib/default.nix`
- Home Manager behavior: `home/default.nix` and any module writing to
  `erinite.home`
- Hyprland behavior: `home/desktop/hyprland/`, `home/desktop/dms/hyprland.nix`,
  and host-level `wayland.windowManager.hyprland` overrides
- Niri behavior: `os/desktop/niri.nix` for system/session integration and
  `home/desktop/niri/` for user settings, binds, and rules
- DMS idle and power policy: `home/desktop/dms/` and `os/system/laptop.nix`
- Runtime source snapshot: `/run/current-system/configuration-source`, provided
  by `os/system/config-source.nix`
- Host-only behavior: `hosts/<name>/`
- Feature enablement defaults: `os/presets/common.nix` and
  `home/presets/common.nix`
