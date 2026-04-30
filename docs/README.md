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
- Reusable modules under `modules/`
- A custom helper library under `lib/`
- Home Manager integration through `modules/home.nix`

## Current Limitation

- The repository supports both `nh os` and standalone `nh home`.
- Standalone Home Manager reuses the same composed `erinite.homeModule` exported from each host evaluation.
- Full-system changes should still go through the host system switch path.

The project centers on the `erinite.*` option tree. Host files mostly enable or override modules through that tree instead of writing all NixOS and Home Manager options directly.

## Agent Entry

Before changing code, an agent should understand these facts:

- `flake.nix` defines the shared inputs and constructs each host with `addHost`.
- `lib/default.nix` defines `eriniteLib`, including `mkModule`, which is the common wrapper used by most modules.
- `modules/default.nix` imports all module files under `modules/`.
- `modules/home.nix` composes `erinite.homeModule` and bridges it into both `home-manager.users.<username>.imports` and standalone `homeConfigurations`.
- `hosts/<name>/default.nix` is the main host entry where modules are enabled and per-host overrides are set.

## Maintenance Rules

- Keep these docs factual and close to the current code.
- Prefer explaining actual data flow over restating filenames.
- When the module system changes, update `module-system.md` first.
- When directories, hosts, or ownership boundaries change, update `structure.md`.
- When shared design decisions change, update `architecture.md`.

## TODO

- Keep `erinite.homeModule`, `homeConfigurations`, and `nh` usage docs aligned when the Home Manager interface changes.
