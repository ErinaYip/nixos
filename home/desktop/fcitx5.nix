{
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  namespace = ["erinite" "home"];
  category = "desktop";
  name = "fcitx5";

  configFn = _: let
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

    home.file.".local/share/fcitx5/rime/${wanxiang}.gram".source = gram;
  };
}
