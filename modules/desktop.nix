# feat: add hyprland desktop module with home-manager
#
# - Add hyprland input to flake.nix
# - Create desktop.nix module for hyprland configuration
# - Add demo.desktop.hyprland option to enable wayland desktop
# - Include hyprland in dev shell
# refactor: use extraOptions pattern for home-manager integration
#
# - Add demo.home.extraOptions to pass config to home-manager
# - desktop.nix injects wayland.windowManager.hyprland via extraOptions
# - Aligns with root nixos architecture
