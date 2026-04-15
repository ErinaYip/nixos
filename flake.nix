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
