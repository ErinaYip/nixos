# Repository Guidelines

## Project Structure & Module Organization
This repository is a flake-based NixOS configuration.
- `flake.nix` and `flake.lock`: entrypoint and pinned inputs.
- `nixos/`: host-level configuration (`default.nix`, hardware, boot, GPU).
- `modules/`: reusable system modules (network, fonts, virtualization, etc.).
- `home/`: Home Manager config for user `era` (shell, desktop, editors, programs, bar).

Keep changes scoped to the closest module. Example: terminal behavior belongs in `home/shell/*.nix`, not `nixos/default.nix`.

## Build, Test, and Development Commands
Run commands from the repo root:
- `nix flake check`: evaluate flake outputs and catch basic issues.
- `sudo nixos-rebuild build --flake .#nixos`: build system closure without switching.
- `sudo nixos-rebuild switch --flake .#nixos`: apply system + Home Manager changes.
- `sudo nixos-rebuild test --flake .#nixos`: test activation for the current boot only.

Convenience alias configured in this repo: `sns` -> `sudo nixos-rebuild switch --flake ~/nixos`.

## Coding Style & Naming Conventions
- Language: Nix.
- Indentation: 2 spaces; keep attribute sets readable and grouped logically.
- File naming: lowercase with hyphens where needed (e.g., `nix-ld.nix`).
- Module pattern: expose options in focused files, aggregate with `default.nix` imports.
- Formatting: use `nixfmt` for Nix files (configured in editor tooling).

## Testing Guidelines
There is no dedicated unit test suite in this repo. Treat evaluation/build as the test gate:
- Run `nix flake check` before commits.
- Run `sudo nixos-rebuild build --flake .#nixos` for non-trivial changes.
- For risky desktop/session changes, prefer `... test --flake` before `switch`.

## Commit & Pull Request Guidelines
Recent history favors short, imperative commit subjects (e.g., `rewrite lsp for nixvim`, `add keymaps`).
- Keep subject lines concise and action-focused.
- One logical change per commit.
- In PRs, include: purpose, impacted paths (e.g., `home/desktop/hyprland/*`), validation commands run, and screenshots for UI/theme changes.
- Link related issues/tasks when available.

## Security & Configuration Tips
- Never commit secrets or machine-specific credentials.
- Review changes to `nixos/hardware-configuration.nix` carefully; keep hardware-specific edits intentional.
- Keep `flake.lock` updates explicit and review input bumps before merging.
