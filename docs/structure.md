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
- `media/` for media viewers and communication apps
- `programs/` for optional application stacks
- `presets/` for grouped enablement

The shared Neovim module lives under `home/cli/nvim/`. It is built through nvf;
`blink-cmp.nix` owns completion menu behavior, including nvim-cmp-compatible
completion kind appearance and kind-colored labels. `highlights.nix` owns shared
completion and symbol kind highlights for blink.cmp, nvim-navic, and
nvim-navbuddy. `settings.nix` also owns the Fcitx5 mode-switch autocmd that
calls `fcitx5-remote` to disable Chinese input outside insert-oriented modes and
restore it on insert entry when needed. `lualine.nix` uses nvf's explicit
`_type = "lua-inline"` and `expr` representation for custom lualine components.

Recently added system modules:

- `os/system/adb.nix` installs Android platform tools and adds the default user
  to `adbusers`.
- `home/desktop/noctalia/` configures Noctalia Shell through its upstream Home
  Manager module. `default.nix` combines the settings files, `bars.nix` owns
  the bar, `settings.nix` owns shell and wallpaper settings, and `hyprland.nix`
  owns IPC binds and Hyprland surface rules.
- `home/desktop/theme-specialisations.nix` maps Noctalia's persisted
  `wallpaper_changed` hook to a safe systemd instance token for the matching
  NixOS specialisation. `os/desktop/theme-specialisations.nix` builds those
  specialisations with matching system and Home Manager Stylix settings and a
  `wheel`-authorized systemd activation service.
- `os/system/laptop.nix` owns shared laptop power policy, including UPower,
  power-profiles-daemon, and logind lid handling.
- `os/system/zswap.nix` enables the kernel Zswap compressed swap cache for the
  `/var/lib/swapfile` backing store. It uses the `zstd` compressor, the
  `zsmalloc` zpool, and a 50% pool cap so compressed pages stay in RAM instead
  of being written to the NVMe swapfile. It is mutually exclusive with the
  in-kernel `zramSwap` module.
- `os/system/config-source.nix` links the flake source into
  `/run/current-system/configuration-source` and adds the `nixos-source` shell
  alias.
- `home/media/wemeet.nix` overrides the nixpkgs `wemeet` package so both the
  Wayland and XWayland launchers export
  `__EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json`,
  and rewrites the installed `wemeetapp.desktop` entry so `Exec` points at
  `wemeet-xwayland`. The EGL override applies per-process through the existing
  `makeWrapper` indirection, so it fixes NVIDIA black-screen and desktop
  bleed-through during Tencent Meeting screen shares without setting the
  variable globally, while the desktop entry makes the XWayland backend the
  default launch path. This follows the upstream AUR package advice at
  <https://aur.archlinux.org/packages/wemeet-bin>.
- `os/system/nix.nix` owns Nix settings, NixOS-side unfree package allowance,
  AppImage support, direnv, and `sudo nixos-rebuild` aliases.
- `os/system/udisks.nix` enables the system-wide `services.udisks2` daemon. It
  provides the D-Bus mount service that the user-level `udiskie` auto-mount
  agent in `home/media/nemo.nix` relies on, so USB drives automount and open in
  Nemo on hosts that enable the common preset.

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
here, including Chromium bookmarks. Firefox extension policies are kept in
`home/browsers/firefox/extensions.nix`.

`home/browsers/firefox/default.nix` installs the `zh-CN` language pack through
`programs.firefox.languagePacks` and pins `intl.locale.requested` to
`zh-CN,en-US`, keeping the Chinese UI across updates. Its extensions and their
settings are supplied by the sibling `extensions.nix` module. Search engines are
configured separately in `search.nix`, including MyNixOS (`@mn`) and GitHub
code search (`@gh`).

## Important Files

### `home/default.nix`

Bridge from NixOS module space into Home Manager module space.

### `os/default.nix` and `home/default.nix`

Auto-import the module tree. Module option paths are derived from this tree:
`os/system/boot.nix` maps to `erinite.os.system.boot`, while
`home/desktop/noctalia/default.nix` maps to `erinite.home.desktop.noctalia`.

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

Firefox extensions and their settings are defined in
`home/browsers/firefox/extensions.nix` using Mozilla Add-ons `latest.xpi` URLs,
Firefox `ExtensionSettings`, and `3rdparty.Extensions` policies.

## Where To Look For Changes

If you need to understand or change behavior, start here:

- Shared behavior across hosts: `os/` and `home/` and `lib/default.nix`
- Home Manager behavior: `home/default.nix` and any module writing to
  `erinite.home`
- Hyprland behavior: `home/desktop/hyprland/` and host-level
  `wayland.windowManager.hyprland` overrides
- Noctalia shell behavior: `home/desktop/noctalia/default.nix` for
  package/service enablement and settings composition, `settings.nix` for
  wallpaper and shell settings, `bars.nix` for the bar, and `hyprland.nix` for
  IPC binds and Hyprland surface rules
- Wallpaper-driven theme switching: `home/desktop/theme-specialisations.nix`
  for the hook and `os/desktop/theme-specialisations.nix` for NixOS
  specialisations
- Laptop lid and power-profile policy: `os/system/laptop.nix`
- Obsidian behavior: `home/desktop/obsidian/`. Community plugins and themes are
  packaged declaratively as fixed-output derivations in `plugins.nix` and
  `themes.nix`, while `settings.nix` enables them and `plugin-settings.nix`
  holds their per-plugin settings.
- Runtime source snapshot: `/run/current-system/configuration-source`, provided
  by `os/system/config-source.nix`
- Host-only behavior: `hosts/<name>/`
- Feature enablement defaults: `os/presets/common.nix` and
  `home/presets/common.nix`
