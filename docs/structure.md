# Structure

## Top-Level Directories

### `flake.nix`

Project entry point. Defines inputs, host construction, and the development shell.

### `lib/`

Holds `eriniteLib`, the helper library used by the module layer. Imported and exposed in `flake.nix` as `eriniteLib`.

### `modules/`

Current categories under `modules/`:

- `system/` for NixOS system services and platform behavior
- `desktop/` for graphical environment and desktop integration
- `cli/` for shell and terminal applications
- `browsers/` for browser modules
- `programs/` for optional application stacks
- `presets/` for grouped enablement

### `hosts/`

Contains per-machine entry points and hardware-specific configuration.

Current hosts:

- `mechrevo`
  Main machine. Uses NVIDIA PRIME, Podman, gaming modules, OBS Studio, and a more complex Hyprland monitor layout.
- `nec`
  Laptop. Uses laptop-specific modules, simpler Hyprland setup, and has Codex CLI enabled.

### `docs/`

Repository documentation and agent onboarding material.

### `assets/`

Repository assets and templates used by modules.

## Important Files

### `modules/home.nix`

Bridge from NixOS module space into Home Manager module space.

### `modules/default.nix`

Auto-imports the module tree.

### `hosts/<name>/default.nix`

Primary host definition. This is usually the best place to inspect host intent first.

### `hosts/<name>/configuration.nix`

Additional host-specific system configuration not abstracted into shared modules.

### `hosts/<name>/hardware-configuration.nix`

Generated hardware configuration.

## Where To Look For Changes

If you need to understand or change behavior, start here:

- Shared behavior across hosts:
  `modules/` and `lib/default.nix`
- Home Manager behavior:
  `modules/home.nix` and any module writing to `erinite.home`
- Host-only behavior:
  `hosts/<name>/`
- Feature enablement defaults:
  `modules/presets/common.nix`
