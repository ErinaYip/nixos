{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
    namespace = ["erinite" "home"];
  category = "cli";
  name = "yazi";

  defaultSettings = import ./settings.nix;

  configFn = {settings, ...}: {
    home.packages = with pkgs; [
      fzf
      fd
      ripgrep
      zoxide
    ];

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      plugins = {
        "smart-enter" = pkgs.yaziPlugins.smart-enter;
      };

      inherit settings;
      keymap = import ./keymap.nix;
    };
  };
}
