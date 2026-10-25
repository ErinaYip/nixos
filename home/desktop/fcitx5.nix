{
  lib,
  config,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  configFn = _: let
    inputMethodEnv = {
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
    };
    wanxiang = "wanxiang-lts-zh-hans";
    gram = pkgs.fetchurl {
      url = "https://cnb.cool/Mintimate/rime/oh-my-rime/-/releases/download/latest/${wanxiang}.gram";
      hash = "sha256-FATbJ3db1+LTrC/qCMNcqE9y+tB2fPNEmA9jkQyJjjk=";
    };
  in {
    programs.oh-my-rime = {
      enable = true;
      themes.enable = false;

      rimeConfig = {
        schema_list = [{schema = "rime_mint";}];
        key_binder = {
          bindings = [
            {
              when = "composing";
              accept = "Control+p";
              send = "Up";
            }
            {
              when = "composing";
              accept = "Control+n";
              send = "Down";
            }
            {
              when = "composing";
              accept = "Shift+Tab";
              send = "Up";
            }
            {
              when = "composing";
              accept = "Tab";
              send = "Down";
            }
            {
              when = "paging";
              accept = "minus";
              send = "Page_Up";
            }
            {
              when = "has_menu";
              accept = "equal";
              send = "Page_Down";
            }
            {
              when = "always";
              accept = "Control+Shift+1";
              select = ".next";
            }
          ];
        };
        switcher = {
          caption = "";
          hotkeys = ["Control+grave"];
        };
      };

      schemas."rime_mint.custom.yaml".patch = {
        "speller/algebra/+" = [
          "derive/([ei])n$/$1ng/"
          "derive/([ei])ng$/$1n/"
          "derive/([iu])an$/$lan/"
          "derive/([iu])ang$/$lan/"
          "derive/([aeiou])ng$/$1gn/"
          "derive/([dtngkhrzcs])o(u|ng)$/$1o/"
          "derive/ong$/on/"
          "abbrev/^([a-z]).+$/$1/"
          "derive/v/u/"
        ];
        "grammar/language" = wanxiang;
        "grammar/collocation_max_length" = 5;
        "grammar/collocation_min_length" = 2;

        "translator/contextual_suggestions" = true;
        "translator/max_homophones" = 7;
        "translator/max_homographs" = 7;
      };
    };

    # Stylix's own 30x30 panel/highlight artwork collapses under the nine-slice
    # rewrite in fcitx5 5.1.22 (fcitx5#1615): with 15px margins the centre tiles
    # evaluate to zero width/height and get dropped, which leaves the candidate
    # window fully transparent. assets/fcitx5/ holds the same artwork enlarged to
    # 31x31 with a matching viewBox so a one pixel strip survives. Colours are
    # still rendered from the active palette, so wallpaper switching keeps
    # working. Drop this override once nix-community/stylix#2503 is released.
    i18n.inputMethod.fcitx5.themes = lib.mkIf config.stylix.enable {
      stylix = {
        panelImage = lib.mkForce (config.lib.stylix.colors {
          template = ../../assets/fcitx5/panel.svg;
          extension = ".svg";
        });
        highlightImage = lib.mkForce (config.lib.stylix.colors {
          template = ../../assets/fcitx5/highlight.svg;
          extension = ".svg";
        });
      };
    };

    home.file.".local/share/fcitx5/rime/${wanxiang}.gram".source = gram;
    home.sessionVariables = inputMethodEnv;
    systemd.user.sessionVariables = inputMethodEnv;
  };
}
