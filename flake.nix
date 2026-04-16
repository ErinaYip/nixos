# init: init git
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
# feat: add program dispatcher and types module
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
# refactor: move home-manager.nix to modules
# refactor: add stateVersion and remove home-manager import
# refactor: rename defaults to default
# refactor: split stateVersion into system and home
# feat: add hyprland, mango, and theme inputs
# feat: add mechrevo host configuration
# fix: update default username in flake
# refactor: remove laptop host and rename defaults
# system/nix: remove mango input
# chore: add newline at end of file
