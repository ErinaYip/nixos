<!--toc:start-->

- [Status](#status)
- [Hosts](#hosts)
- [Structure](#structure)
- [Features](#features)
- [Desktop Setup](#desktop-setup)
- [Screenshots](#screenshots)
- [Usage](#usage)
- [Install](#install)
- [Modules](#modules)
- [Notes](#notes)
- [TODO](#todo)

<!--toc:end-->

My personal NixOS configuration.

It uses flakes, Home Manager, Hyprland, and small reusable modules.

Detailed project documentation lives in [`docs/`](./docs/README.md).

## Status

- This repository supports both `nh os` and `nh home` workflows.
- Home Manager still shares the same module graph through `erinite.homeModule`.
- Use `nh os switch` for full system updates, or `nh home switch` for user-only
  updates.

## Hosts

- `mechrevo`: main machine, NVIDIA PRIME, Podman, gaming, dual monitor setup.
- `nec`: laptop, power management, Windows boot entry, simple Hyprland setup.

## Structure

```text
.
├── flake.nix
├── hosts/
│   ├── mechrevo/
│   └── nec/
├── lib/
└── modules/
    ├── browsers/
    ├── cli/
    ├── desktop/
    ├── presets/
    ├── programs/
    └── system/
```

## Features

- NixOS flake with multiple hosts.
- Home Manager integration.
- Modular options under `erinite.*`.
- Hyprland desktop with DankMaterialShell.
- Chinese input with Fcitx5 and Rime.
- Common CLI tools like zsh, kitty, nvim, yazi, bat, eza and starship.
- Optional modules for NVIDIA, Podman, Steam, Sunshine, OBS and more.

## Desktop Setup

| Part           | Choice                          |
| -------------- | ------------------------------- |
| Window manager | Hyprland                        |
| Shell          | zsh                             |
| Terminal       | kitty                           |
| Editor         | Nixvim with erina-vim           |
| Prompt         | starship                        |
| App launcher   | fuzzel                          |
| Bar / shell    | DankMaterialShell               |
| Theming        | matugen, GTK, Qt, Bibata cursor |
| Input method   | Fcitx5 + Rime                   |

## Screenshots

| `nec`                         | `mechrevo`                              |
| ----------------------------- | --------------------------------------- |
| ![nec](./screenshots/nec.png) | ![mechrevo](./screenshots/mechrevo.png) |

## Usage

Maintenance aliases:

| Alias | Command          |
| ----- | ---------------- |
| `nos` | `nh os switch`   |
| `nob` | `nh os boot`     |
| `not` | `nh os test`     |
| `nou` | `nh os build`    |
| `nhs` | `nh home switch` |
| `nhb` | `nh home boot`   |
| `nht` | `nh home test`   |
| `nhu` | `nh home build`  |

Home-only switch:

```bash
nh home switch .
```

Notes:

- `nh os switch` remains the canonical path for full host updates.
- `nh home switch` now reuses the same composed Home Manager module exported as
  `homeConfigurations`.
- Home targets are exposed as `era@mechrevo` and `era@nec`.

Manual switch:

```bash
sudo nixos-rebuild switch --flake .#mechrevo
```

Check flake:

```bash
nix flake check
```

Update inputs:

```bash
nix flake update
```

Enter dev shell:

```bash
nix develop
```

## Install

Boot from a NixOS installer, connect to the network, then prepare disks and
mount the new system.

Clone this repo:

```bash
git clone https://github.com/ErinaYip/nixos.git /mnt/etc/nixos
cd /mnt/etc/nixos
```

Generate hardware config:

```bash
nixos-generate-config --root /mnt
```

Copy the generated hardware config to the target host:

```bash
cp /mnt/etc/nixos/hardware-configuration.nix hosts/mechrevo/hardware-configuration.nix
```

Install the system:

```bash
nixos-install --flake .#mechrevo
```

Reboot:

```bash
reboot
```

## Modules

Modules are enabled like this:

```nix
with eriniteLib; {
  erinite.presets.common = enabled;
  erinite.browsers.firefox = enabled;
}
```

The `common` preset enables the base system, Hyprland desktop, CLI tools and
LocalSend.

## Notes

This repo is made for my own machines. Some values are hardware or user
specific, such as username, proxy config path, display layout, NVIDIA bus IDs
and Git user info.

## TODO

- Keep `nixosConfigurations` and `homeConfigurations` behavior aligned when
  changing the module graph.
