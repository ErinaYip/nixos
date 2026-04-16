# Erinite

A minimal, modular NixOS flake example.

## Structure

```text
erinite
├── flake.nix
├── flake.lock
├── lib
│   └── default.nix
├── modules
│   ├── default.nix
│   ├── home.nix
│   ├── cli/git.nix
│   ├── desktop/hyprland.nix
│   └── system/{nix.nix,users.nix}
└── hosts
    └── laptop
        ├── default.nix
        └── hardware.nix
```

## Overview

- `flake.nix`: inputs, host factory, `nixosConfigurations.laptop`, and a dev shell.
- `lib/default.nix`: helper option builders, `mkModule`, and module auto-discovery.
- `modules/default.nix`: auto-imports all module files.
- `modules/home.nix`: bridges `erinite.home.config` into Home Manager.
- `hosts/laptop`: host-specific wiring and module toggles.

## Built-in Modules

- `erinite.system.nix.enable`: Nix settings (flakes, GC, store optimization).
- `erinite.system.users.enable`: creates the default normal user.
- `erinite.cli.git.enable`: installs Git and configures Home Manager Git.
  - user fields: `erinite.cli.git.user.name`, `erinite.cli.git.user.email`
  - extra Git settings: `erinite.cli.git.settings`
- `erinite.desktop.hyprland.enable`: basic Wayland desktop helpers.

## Usage

```bash
nix flake show
sudo nixos-rebuild switch --flake .#laptop
nix develop
```

## Add a New Module

1. Create `modules/<category>/<name>.nix`.
2. Define it with `lib.erinite.mkModule`.
3. Enable it in a host file, for example:

```nix
erinite.<category>.<name>.enable = true;
```

No manual `imports` update is needed.
