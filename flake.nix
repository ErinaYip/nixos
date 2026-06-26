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
# chore: update homeStateVersion to 26.05
# feat: add hyprland, mango, and theme inputs
# feat: add mechrevo host configuration
# fix: rename defaults to default in flake
# fix: update default username in flake
# refactor: remove laptop host and rename defaults
# fix: add default stateVersion in flake
# chore: update flake inputs to use github sources
# feat: remove hyprland inputs
# feat: add nec host
# fix: update repository URLs to use Codeberg for erina-vim and oh-my-rime-nix
# feat(hyprland): update flake.lock and flake.nix for new inputs and settings
# refactor: rename lib.erinite to eriniteLib and add hypr-dynamic-cursors
# fix(flake): add hyprgrass input and update hyprland configuration
# fix(flake): update hyprgrass URL to use GitHub
# fix(flake): update hyprgrass URL to reflect new repository owner
# feat(home): enhance home-manager integration with base module and allow unfree packages
# feat(nixos): refactor host and home configuration management for improved clarity and structure
# feat(nvim): migrate to nvf configuration
# Refactor with Alejandra
# feat(nvim): update settings and snacks configurations, enhance folding and add bigfile support
# feat: switch to nixos 25.11
# Revert "feat: switch to nixos 25.11"
#
# This reverts commit 57f13dac0b8de4a38f01ce8077919196af967dbc.
# refactor(flake): remove commentes
# Add Stylix test configuration
# fix: use linux7.0.3 kernel for mechrevo to fix bluetooth failure
# fix: evaluation warning: era profile: You have set either `nixpkgs.config` or `nixpkgs.overlays` while using `home-manager.useGlobalPkgs`.
#                     This will soon not be possible. Please remove all `nixpkgs` options when using `home-manager.useGlobalPkgs`.
# refactor: streamline host configuration and add meta information
# refactor: split os and home modules
# refactor: enhance theme specialisations and integrate with desktop settings
# refactor: move cuda support back to nvidia module
# feat(dms): switch dms to master branch
# fix: add allowunfree for both os and home modules
# update system
# update system
# feat(dms): add dms screenshot plugin
# feat(stylix): siwtch to my fork
# feat(dms): simplify dms settings
# feat(flake): add nix fmt
