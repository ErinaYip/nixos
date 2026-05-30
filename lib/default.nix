# init: init git
# chore: add enableT and enableF helpers
# chore: remove enableT and enableF helpers
# refactor: align with root nixos structure
#
# - Rename demo lib to zenyte for consistency
# - Add mkStrOpt and mkAttrOpt helpers
# - Add home-manager module with zenyte.home options
# - Update all modules to use zenyte.* options
# - Add devShell to flake.nix
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
# docs: update README with Erinite architecture spec
# feat: add list and attrs option helpers
# feat: add mkModule helper for module creation
# refactor: migrate modules to mkModule helper
# feat: support default.nix priority in modules scan
# feat: add imports support to mkModule helper
# feat: add imports support to mkModule
# fix: add mkShellAliases function to create shell aliases in configuration
# fix(lib): merge mkModule defaultSettings recursively
# refactor: rename lib.erinite to eriniteLib and add hypr-dynamic-cursors
# Refactor with Alejandra
# feat: add recolor module and integrate into stylix configuration
# refactor: split os and home modules
# refactor: streamline theme specialisations and enhance wallpaper handling
# feat(stylix): enhance matugen theme color generation script
# refactor theme switching scripts
# feat(theme-specialisation): enhance and simplify theme switching sctipts
