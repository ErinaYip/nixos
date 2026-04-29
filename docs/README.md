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

- The current repository should be treated as `nh os`-only.
- Standalone `nh home` usage is not considered reliable or supported.
- Home Manager is wired into the NixOS module graph, so routine changes should be applied through the host system switch path.

The project centers on the `erinite.*` option tree. Host files mostly enable or override modules through that tree instead of writing all NixOS and Home Manager options directly.

## Agent Entry

Before changing code, an agent should understand these facts:

- `flake.nix` defines the shared inputs and constructs each host with `addHost`.
- `lib/default.nix` defines `eriniteLib`, including `mkModule`, which is the common wrapper used by most modules.
- `modules/default.nix` imports all module files under `modules/`.
- `modules/home.nix` bridges `erinite.home` into Home Manager through `home-manager.users.<username>.imports`.
- `hosts/<name>/default.nix` is the main host entry where modules are enabled and per-host overrides are set.

## Maintenance Rules

- Keep these docs factual and close to the current code.
- Prefer explaining actual data flow over restating filenames.
- When the module system changes, update `module-system.md` first.
- When directories, hosts, or ownership boundaries change, update `structure.md`.
- When shared design decisions change, update `architecture.md`.

## TODO

- Revisit whether standalone Home Manager outputs belong in this flake.
- If standalone Home Manager support returns, document the supported command path and validation rules before re-enabling `nh home` workflows.
