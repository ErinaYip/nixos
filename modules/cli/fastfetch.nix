{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
with eriniteLib;
  mkModule args {
    category = "cli";
    name = "fastfetch";

    configFn = _: let
      fastfetch-icons = pkgs.fetchgit {
        url = "https://codeberg.org/erina/eps.git";
        rev = "3c1781b5d34098b8e17943dc5ea304aa7bc01597";
        sha256 = "sha256-nfKM9hudU8kJqEwMMjVrhObKgTRwn7wjV9Yb1c+hFqs=";
      };
    in
      lib.mkMerge [
        {
          erinite.home.programs.fastfetch = {
            enable = true;
            settings = {
              logo = {
                type = "kitty";
                height = 30;
                padding.right = 1;
              };
              display.separator = " ";
              modules = [
                {
                  key = "╭───────────────╮";
                  type = "custom";
                }
                {
                  key = "│ {#31} user        {#keys}│";
                  type = "title";
                }
                {
                  key = "├───────────────┤";
                  type = "custom";
                }
                {
                  key = "│ {#32}󰅐 uptime      {#keys}│";
                  type = "uptime";
                }
                {
                  key = "│ {#33}󱄅 distro      {#keys}│";
                  type = "os";
                }
                {
                  key = "│ {#34} kernel      {#keys}│";
                  type = "kernel";
                }
                {
                  key = "│ {#35}󰏖 generations {#keys}│";
                  type = "command";
                  text = "readlink /nix/var/nix/profiles/system | cut -d- -f2";
                }
                # { key = "│ {#35}󰏖 packages {#keys}│"; type = "packages"; } # very bad performance
                {
                  key = "│ {#36} shell       {#keys}│";
                  type = "shell";
                }
                {
                  key = "│ {#32}󰩟 IP          {#keys}│";
                  type = "localip";
                }
                {
                  key = "├───────────────┤";
                  type = "custom";
                }
                {
                  key = "│ {#33} WM          {#keys}│";
                  type = "wm";
                }
                {
                  key = "│ {#34}󰓸 wmtheme     {#keys}│";
                  type = "wmtheme";
                }
                {
                  key = "│ {#35}󰇄 theme       {#keys}│";
                  type = "theme";
                }
                {
                  key = "│ {#36}󰉼 desktop     {#keys}│";
                  type = "de";
                }
                {
                  key = "│ {#32} icons       {#keys}│";
                  type = "icons";
                }
                {
                  key = "│ {#33} font        {#keys}│";
                  type = "font";
                }
                {
                  key = "│ {#34} Termfont    {#keys}│";
                  type = "terminalfont";
                }
                {
                  key = "│ {#35}󰆿 cursor      {#keys}│";
                  type = "cursor";
                }
                {
                  key = "│ {#36} icons       {#keys}│";
                  type = "terminal";
                }
                {
                  key = "├───────────────┤";
                  type = "custom";
                }
                {
                  key = "│ {#32} battery     {#keys}│";
                  type = "battery";
                }
                {
                  key = "│ {#33} CPU         {#keys}│";
                  type = "cpu";
                }
                {
                  key = "│ {#34} GPU {1}       {#keys}│";
                  type = "gpu";
                }
                {
                  key = "│ {#35} memory      {#keys}│";
                  type = "memory";
                }
                {
                  key = "│ {#36}󰉉 disk        {#keys}│";
                  type = "disk";
                  folders = "/";
                }
                {
                  key = "│ {#32}󰓡 swap        {#keys}│";
                  type = "swap";
                }
                {
                  key = "├───────────────┤";
                  type = "custom";
                }
                {
                  key = "│ {#33}󰍹 {2:2}          {#keys}│";
                  type = "display";
                }
                {
                  key = "├───────────────┤";
                  type = "custom";
                }
                {
                  key = "│ {#34}󱦟 OS Age      {#keys}│";
                  type = "command";
                  text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
                }
                {
                  key = "│ {#35} colors      {#keys}│";
                  type = "colors";
                  symbol = "circle";
                }
                {
                  key = "╰───────────────╯";
                  type = "custom";
                }
                "break"
              ];
            };
          };
        }

        (mkShellAliases {
          aliases = {
            fastfetch = "fastfetch --logo $(find ${fastfetch-icons} -type f | shuf -n 1)";
            ff = "fastfetch";
          };
          shells = ["zsh"];
        })
      ];
  }
