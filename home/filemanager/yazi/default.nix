{ pkgs, ... }: {
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
      "starship" = pkgs.yaziPlugins.starship;
    };
    initLua = ''
      require("starship"):setup()
    '';
    settings = import ./settings.nix;
    keymap = import ./keymap.nix;
  };
}
