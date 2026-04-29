<h1 align="center">EriniteOS</h1>

My personal NixOS configuration.

It uses flakes, Home Manager, Hyprland, and small reusable modules.

Detailed project documentation lives in [`docs/`](./docs/README.md).

## Status

- This repository currently supports `nh os` workflows only.
- `nh home` is intentionally not supported in the current configuration.
- Home Manager is integrated through the NixOS module tree instead of being maintained as a stable standalone `nh home` entrypoint.
- Use `nh os switch` or `sudo nixos-rebuild switch --flake .#<host>` for normal updates.

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

| Part | Choice |
| --- | --- |
| Window manager | Hyprland |
| Shell | zsh |
| Terminal | kitty |
| Editor | Nixvim with erina-vim |
| Prompt | starship |
| App launcher | fuzzel |
| Bar / shell | DankMaterialShell |
| Theming | matugen, GTK, Qt, Bibata cursor |
| Input method | Fcitx5 + Rime |

## Screenshots

| `nec` | `mechrevo` |
| --- | --- |
| ![nec](./screenshots/nec.png) | ![mechrevo](./screenshots/mechrevo.png) |

## Usage

Maintenance aliases:

| Alias | Command |
| --- | --- |
| `sns` | switch to the new system |
| `snb` | build the new system for next boot |
| `snr` | update inputs and switch to the new system |

Warning:

- `nh home` is disabled on purpose.
- Do not treat this repository as a stable standalone Home Manager flake right now.
- If you need to update user-level config, apply it through `nh os switch` because Home Manager is embedded in the NixOS configuration.

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

Boot from a NixOS installer, connect to the network, then prepare disks and mount the new system.

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

The `common` preset enables the base system, Hyprland desktop, CLI tools and LocalSend.

## Notes

This repo is made for my own machines. Some values are hardware or user specific, such as username, proxy config path, display layout, NVIDIA bus IDs and Git user info.

## TODO

- Re-evaluate whether standalone `homeConfigurations` should exist at all.
- If `nh home` support is reintroduced later, make host detection, unfree package handling, and documentation consistent first.
