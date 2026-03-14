{ pkgs, ... }: 
let
  oh-my-rime = pkgs.fetchFromGitHub {
    owner = "Mintimate";
    repo = "oh-my-rime";
    rev = "main";
    sha256 = "sha256-FzxHMdVENeHkY8INGoRPFbO8lu3UWCQmCGhhro2xxIA=";
  };
  fcitx5-theme-mint = pkgs.fetchFromGitHub {
    owner = "witt-bit";
    repo = "fcitx5-theme-mint";
    rev = "master";
    sha256 = "sha256-RnQ0D78+e0wQXoWZ09D5JQsDjwxinbPmtEV04ygl+5E=";
  };
in {
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-rime
      ];
    };
  };

  home.file.".local/share/fcitx5/rime" = {
    source = oh-my-rime;
    recursive = true;
  };
  
  home.file.".local/share/fcitx5/themes" = {
    source = fcitx5-theme-mint;
    recursive = true;
  };
}
