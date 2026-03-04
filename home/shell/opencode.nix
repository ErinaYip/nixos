{ pkgs, ... }: {
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    settings = {
      theme = "system";
      # plugin = [ "opencode-openai-codex-auth" ];
      provider = {
      };
    };
  };
}
