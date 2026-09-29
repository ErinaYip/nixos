{pkgs}: let
  nixIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

  mkEngine = {
    alias,
    template,
    iconUrl,
  }: {
    urls = [{inherit template;}];
    definedAliases = [alias];
    iconMapObj."16" = iconUrl;
  };
in {
  force = true;
  default = "bing";
  engines = {
    "Nix Packages" = mkEngine {
      alias = "@np";
      template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
      iconUrl = nixIcon;
    };

    "Nix Options" = mkEngine {
      alias = "@no";
      template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
      iconUrl = nixIcon;
    };

    "NixOS Wiki" = mkEngine {
      alias = "@nw";
      template = "https://wiki.nixos.cn/w/index.php?search={searchTerms}";
      iconUrl = "https://wiki.nixos.cn/favicon.ico";
    };

    "MyNixOS" = mkEngine {
      alias = "@mn";
      template = "https://mynixos.com/search?q={searchTerms}";
      iconUrl = "https://mynixos.com/favicon.ico";
    };

    "GitHub" = mkEngine {
      alias = "@gh";
      template = "https://github.com/search?q={searchTerms}&type=code";
      iconUrl = "https://github.com/favicon.ico";
    };
  };
}
