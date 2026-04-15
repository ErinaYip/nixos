# init: init git
# refactor: restructure git config settings
# chore: update system.stateVersion to 25.11
# refactor: align with root nixos structure
#
# - Rename demo lib to zenyte for consistency
# - Add mkStrOpt and mkAttrOpt helpers
# - Add home-manager module with zenyte.home options
# - Update all modules to use zenyte.* options
# - Add devShell to flake.nix
# refactor: rename zenyte to demo for clarity
# feat: add hyprland desktop module with home-manager
#
# - Add hyprland input to flake.nix
# - Create desktop.nix module for hyprland configuration
# - Add demo.desktop.hyprland option to enable wayland desktop
# - Include hyprland in dev shell
# feat: add eza module and refactor cli configuration
# refactor: remove hyprland and simplify modules
# refactor: adopt Erinite architecture
#
# - Add core/home-manager.nix: infrastructure layer for Home Manager bridging
# - Add lib/default.nix: use makeExtensible pattern for custom erinite lib
# - Restructure modules: cli/git.nix, desktop/hyprland.nix
# - Update hosts/laptop/default.nix: use erinite.* namespace
# - Update flake.nix: addHost factory function with dependency injection
#
# This architecture separates:
# - core/: infrastructure (Home Manager bridge)
# - lib/: custom syntax sugar (makeExtensible)
# - modules/: business logic (auto-loaded)
# - hosts/: host-specific configuration
# feat: add system module with nix and users
