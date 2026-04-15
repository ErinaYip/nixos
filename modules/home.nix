# init: init git
# refactor: align with root nixos structure
#
# - Rename demo lib to zenyte for consistency
# - Add mkStrOpt and mkAttrOpt helpers
# - Add home-manager module with zenyte.home options
# - Update all modules to use zenyte.* options
# - Add devShell to flake.nix
# refactor: rename zenyte to demo for clarity
# refactor: use extraOptions pattern for home-manager integration
#
# - Add demo.home.extraOptions to pass config to home-manager
# - desktop.nix injects wayland.windowManager.hyprland via extraOptions
# - Aligns with root nixos architecture
# feat: add eza module and refactor cli configuration
