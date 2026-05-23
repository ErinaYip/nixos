# Project Docs

This directory is the long-term documentation entry for the repository.

It serves two purposes:

1. Explain the project in enough detail for human maintenance.
2. Give an agent a stable starting point before making changes.

## Reading Order

If you are new to the repository, read in this order:

1. `architecture.md`
2. `module-system.md`
3. `structure.md`

## Repository Summary

This repository contains a personal NixOS flake with:

- Multiple hosts under `hosts/`
- Reusable modules under `os/` and `home/`
- A custom helper library under `lib/`
- Home Manager integration through `home/default.nix`
- Lua-based Hyprland configuration through Home Manager
- Matugen templates for terminal, launcher, file manager, shell, and Hyprland colors

## Current Limitation

- The repository supports both `nh os` and standalone `nh home`.
- Standalone Home Manager reuses the same host `homeModules` list imported by NixOS-integrated Home Manager.
- Full-system changes should still go through the host system switch path.

The project centers on the `erinite.*` option tree. Host files mostly enable or override modules through that tree instead of writing all NixOS and Home Manager options directly.

## Agent Entry

Before changing code, an agent should understand these facts:

- `flake.nix` defines the shared inputs, discovers host directories, and constructs each host with `mkHost`.
- `lib/default.nix` defines `eriniteLib`, including `mkModule`, which is the common wrapper used by most modules.
- `os/default.nix and home/default.nix` imports all module files under `os/` and `home/`.
- `flake.nix` imports the same host `homeModules` into both `home-manager.users.<username>.imports` and standalone `homeConfigurations`.
- `hosts/<name>/default.nix` returns `{ meta, osModules, homeModules }`; `meta` contains host construction flags such as `cudaSupport`.
- Host-specific Hyprland monitor and workspace details can also live in
  `hosts/<name>/home.nix` when they are too machine-specific for the shared module.
- `home/desktop/hyprland/` emits structured Lua config, binds, animations, window rules, and portal integration.
- `home/desktop/dms/` contributes DMS-specific Hyprland rules, binds, hypridle settings, and theming includes.
- `home/desktop/matugen.nix` writes generated theme files, including `~/.config/hypr/colors.lua`.

## Command Aliases

The `system.nh` module generates these shell aliases:

| Alias | Command |
| --- | --- |
| `nos` | `nh os switch` |
| `nob` | `nh os boot` |
| `not` | `nh os test` |
| `nou` | `nh os build` |
| `nhs` | `nh home switch` |
| `nhb` | `nh home boot` |
| `nht` | `nh home test` |
| `nhu` | `nh home build` |

## Maintenance Rules

- Keep these docs factual and close to the current code.
- Prefer explaining actual data flow over restating filenames.
- When the module system changes, update `module-system.md` first.
- When directories, hosts, or ownership boundaries change, update `structure.md`.
- When shared design decisions change, update `architecture.md`.

## TODO

- Keep `homeModules`, `homeConfigurations`, and `nh` usage docs aligned when the Home Manager interface changes.
