# Repository Guidelines

## Project Structure & Module Organization

This repository is a personal NixOS flake. `flake.nix` defines inputs, discovers
hosts under `hosts/`, and exposes NixOS and Home Manager configurations. Shared
NixOS modules live in `os/`, shared Home Manager modules live in `home/`, and
reusable helpers live in `lib/`. Per-machine configuration belongs in
`hosts/<name>/`, with `default.nix` composing `osModules` and `homeModules`,
`os.nix` for host system settings, `home.nix` for host user settings, and
`hardware-configuration.nix` for generated hardware data. Documentation lives in
`docs/`; assets and browser/profile data live in `assets/` and `wallpapers/`.

## Build, Test, and Development Commands

- `nix flake check`: evaluate flake checks and catch broken outputs.
- `nix fmt .`: format Nix files with the configured formatter, Alejandra.
- `nix build .#nixosConfigurations.<host>.config.system.build.toplevel`: build a
  host system closure without switching.
- `nix build .#homeConfigurations."era@<host>".activationPackage`: build a
  standalone Home Manager activation package.
- `nh os switch .` or `nh home switch .`: apply full-system or user-only changes
  from this flake.

Use current hosts such as `mechrevo` or `nec` when replacing `<host>`.

## Coding Style & Naming Conventions

Use idiomatic Nix with two-space indentation, small attribute sets, and
descriptive option names under the `erinite.*` tree. Keep OS-only behavior in
`os/` and Home Manager behavior in `home/`. Prefer existing helpers from
`eriniteLib`, especially local module patterns, before adding new abstractions.
Name files by feature, for example `home/cli/zsh/default.nix` or
`os/system/nvidia.nix`.

## Testing Guidelines

There is no separate unit test suite. Validate changes by formatting, running
`nix flake check`, and building the affected host or Home Manager output. For
host-specific edits, test the exact host target. For shared modules, build both
current hosts when practical.

## Commit & Pull Request Guidelines

Recent commits use short Conventional Commit-style subjects, often scoped:
`feat(wallpapers): ...`, `fix(nh): ...`, `refactor(module): ...`. Keep subjects
imperative and focused. Pull requests should describe the changed modules, list
validation commands run, mention affected hosts, and include screenshots only
for visible desktop or theme changes.

## Agent-Specific Instructions

Before editing, read `docs/README.md`, then the relevant files in `docs/` for
architecture, module-system, or structure context. Do not overwrite host
hardware configuration unless explicitly requested.

- Before modifying or adding any file, first ask the user for approval on the
  intended change and wait for that approval before editing.
- When adding any new file or module, run `git add <path>` so it is present in
  the Git index and available to Git-backed flake evaluation.
- After every code change, update the relevant documentation under `docs/` and
  the root `README.md` in the same task so the docs stay aligned with the code.
- If the user approves creating commits, create them without another prompt, but
  keep code changes and documentation changes in separate commits.
