{
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "system";
  name = "fcitx5";

  configFn = _: {
    home-manager.sharedModules = [
      inputs.oh-my-rime-nix.homeModules.default
    ];

    erinite.home = let
      wanxiang = "wanxiang-lts-zh-hans";
      gram = pkgs.fetchurl {
        url = "https://cnb.cool/Mintimate/rime/oh-my-rime/-/releases/download/latest/${wanxiang}.gram";
        hash = "sha256-FATbJ3db1+LTrC/qCMNcqE9y+tB2fPNEmA9jkQyJjjk=";
      };
    in {
      programs = {
        oh-my-rime = {
          enable = true;

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
              # "erase/^xx$/"
              # "derive/^([zcs])h/$1/" # zh, ch, sh => z, c, s
              # "derive/^([zcs])([^h])/$1h$2/" # z, c, s => zh, ch, sh
              "derive/([ei])n$/$1ng/" # en => eng, in => ing
              "derive/([ei])ng$/$1n/" # eng => en, ing => in
              "derive/([iu])an$/$lan/" # ian => iang, uan => uang
              "derive/([iu])ang$/$lan/" # iang => ian, uang => uan
              "derive/([aeiou])ng$/$1gn/" # dagn => dang
              "derive/([dtngkhrzcs])o(u|ng)$/$1o/" # zho => zhong|zhou
              "derive/ong$/on/" # zhonguo => zhong guo
              "abbrev/^([a-z]).+$/$1/" #简拼（首字母）
              # "abbrev/^([zcs]h).+$/$1/" #简拼（zh, ch, sh）
              "derive/v/u/" # u => ü
            ];
            # 语言模型
            "grammar/language" = wanxiang;
            "grammar/collocation_max_length" = 5;
            "grammar/collocation_min_length" = 2;

            # translator 内加载
            "translator/contextual_suggestions" = true;
            "translator/max_homophones" = 7;
            "translator/max_homographs" = 7;
          };
        };
      };

      # wayland.windowManager.hyprland.settings.exec-once = [
      #   "fcitx5 -d -r"
      # ];

      home.file.".local/share/fcitx5/rime/${wanxiang}.gram" = {
        source = gram;
      };
    };
  };
}
