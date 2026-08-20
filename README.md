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
- NixOS and Home Manager now have separate top-level entrypoints: `os/` and
  `home/`.
- Use `nh os switch` for full system updates, or `nh home switch` for user-only
  updates.

## Hosts

- `mechrevo`: main machine, NVIDIA PRIME, Podman, Wine, gaming, dynamic dual
  monitor setup for Hyprland and Niri.
- `nec`: laptop, power management, Windows boot entry, simple Hyprland monitor
  setup.

Hosts are discovered automatically from directories under `hosts/`. Each host
uses `default.nix` to compose OS and Home Manager modules, `os.nix` for
machine-specific NixOS configuration, and `home.nix` for machine-specific Home
Manager configuration.

## Structure

```text
.
├── flake.nix
├── hosts/
│   ├── mechrevo/
│   └── nec/
├── home/
├── lib/
└── os/
```

## Features

- NixOS flake with multiple hosts.
- Automatic host discovery from `hosts/<name>/default.nix`.
- Home Manager integration.
- Modular options under `erinite.*`.
- Hyprland and Niri desktop integration with DankMaterialShell.
- Niri configuration through `sodiboo/niri-flake` with native Home Manager
  settings and OS-side Ly session integration.
- DMS owns idle detection, lock, suspend, and power menu flow across both
  compositors.
- Chinese input with Fcitx5 and Rime.
- Common CLI tools like zsh, kitty, nvim, yazi, bat, eza and starship.
- Neovim completion uses blink.cmp with nvim-cmp-compatible completion kind
  appearance and shared kind coloring for completion labels and symbol UIs.
- Neovim uses `fcitx5-remote` from the Fcitx5/Rime setup to switch Fcitx5 off
  outside insert-oriented modes and restore it when returning to insert mode.
- QQ uses the official x86_64 Linux package source overridden by its Home
  Manager module.
- Optional modules for NVIDIA, Podman, VirtualBox, Wine, Steam, streaming, OBS
  and more.

## Desktop Setup

| Part           | Choice                 |
| -------------- | ---------------------- |
| Window manager | Hyprland / Niri        |
| Shell          | zsh                    |
| Terminal       | kitty                  |
| Editor         | Nixvim with erina-vim  |
| Prompt         | starship               |
| App launcher   | fuzzel                 |
| Bar / shell    | DankMaterialShell      |
| Theming        | GTK, Qt, Bibata cursor |
| Input method   | Fcitx5 + Rime          |

Hyprland is generated through Home Manager's Lua config mode. Shared defaults
live in `home/desktop/hyprland/`, while host-specific monitor and workspace
logic lives in each host's configuration.

Niri settings are generated through `sodiboo/niri-flake`. Shared Niri binds and
rules live in `home/desktop/niri/` using native `programs.niri.settings` action
and match attributes. The OS-side Niri module enables nixpkgs' Niri NixOS module
with the `sodiboo/niri-flake` package output and cache so Ly can list Niri as a
Wayland session. Home-side Niri packages are read directly from the flake input
so standalone `nh home` does not depend on NixOS overlays. DMS IPC controls are
available through Niri keybindings, and DMS owns idle, lock, suspend, and power
menu behavior for both Hyprland and Niri. On `mechrevo`, Niri matches the laptop
and external displays by their full descriptions, assigns workspaces 1 and 2 to
them, and rotates the laptop display at session startup when the external display
is connected.

Theme specialisations are driven by wallpapers. Stylix uses the default
`pkgs.tela-icon-theme` package for the icon theme.

## Screenshots

| `nec`                         | `mechrevo`                              |
| ----------------------------- | --------------------------------------- |
| ![nec](./screenshots/nec.png) | ![mechrevo](./screenshots/mechrevo.png) |

## Usage

Quality of life commands:

| Alias | Command                             |
| ----- | ----------------------------------- |
| `nos` | `nh os switch`                      |
| `nob` | `nh os boot`                        |
| `not` | `nh os test`                        |
| `nou` | `nh os build`                       |
| `nhs` | `nh home switch`                    |
| `nhb` | `nh home boot`                      |
| `nht` | `nh home test`                      |
| `nhu` | `nh home build`                     |
| `sns` | `sudo nixos-rebuild switch --flake` |
| `snb` | `sudo nixos-rebuild boot --flake`   |
| `snt` | `sudo nixos-rebuild test --flake`   |
| `snu` | `sudo nixos-rebuild build --flake`  |

Home-only switch:

```bash
nh home switch .
```

Notes:

- `nh` commands are preferred than `sudo nixos-rebuild` commands because they
  have gc enabled.
- `nh os switch` remains the canonical path for full host updates.
- `nh home switch` evaluates `home/default.nix` directly, plus the selected
  host's `home.nix`.
- Standalone Home Manager uses the shared flake `pkgs` import, including its
  unfree package allowance and NUR overlay. NixOS-integrated Home Manager uses
  the same NUR overlay through the host package set.
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

The dev shell provides `nixd`, `alejandra`, `statix`, and `deadnix` for editing,
formatting, and linting Nix files. Neovim is configured through nvf to pass
flake-aware `nixd` settings, including `nixos` and `home-manager` option
sources for the current flake host. The dev shell implementation lives in
`dev/default.nix`.

Enable direnv for automatic loading:

```bash
direnv allow
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
  erinite.os.presets.common = enabled;
  erinite.home.browsers.firefox = enabled;
}
```

The `common` preset enables the base system, Hyprland desktop, CLI tools and
LocalSend.

Kitty session presets can be generated under `~/.config/kitty/<name>.conf` and
started with `kitty --session <name>.conf`. Multiple sessions are defined under
`erinite.home.cli.kitty.sessions.<name>`:

```nix
erinite.home.cli.kitty.sessions = {
  raw.text = ''
    new_tab editor
    launch nvim
  '';

  dev.settings = [
    {new_tab = "editor";}
    {launch = ["--cwd" "~/src/project" "nvim"];}
    {new_tab = "shell";}
    {launch = ["--cwd" "~/src/project" "zsh"];}
  ];
};
```

## Notes

This repo is made for my own machines. Some values are hardware or user
specific, such as username, proxy config path, display layout, NVIDIA bus IDs,
Codex provider experiments and Git user info.

Hardware-specific nixpkgs settings live with the module that needs them; for
example, the NVIDIA module enables CUDA support when it is turned on.

When enabled, the Mihomo module publishes its local proxy through
`networking.proxy`, so NixOS session environments and `nix-daemon` use the same
proxy settings.

Workflow expectations for agents and contributors:

- Ask for approval before modifying or adding files.
- Run `git add <path>` after creating a new file or module so Git-backed flake
  evaluation includes it.
- Update `docs/` and the root `README.md` alongside every code change.
- If commits are approved, keep code changes and documentation changes in
  separate commits.

## TODO

- Keep OS-only modules under `os/` and Home Manager modules under `home/`.
