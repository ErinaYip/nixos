{
  pkgs,
  eriniteLib,
  ...
}:
with eriniteLib; {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget

    zip
    unzip
    nodejs
    pnpm
    gcc
    gdb
    openjdk
    php
    python3
    uv

    cowsay
    lolcat
    tldr
    jq
    foremost
    binwalk
    john
    ffuf
    feroxbuster
    seclists
    exiftool
    zsteg
    zola
    python312Packages.dirsearch

    wavemon

    # wireshark
    # bottles

    qq
    wechat
    materialgram

    vscode
    obsidian
    libreoffice
  ];

  erinite.home = {
    programs.cava = enabled;

    wayland.windowManager.hyprland = {
      settings.workspace_rule = [
        {
          workspace = "1";
          monitor = "DP-2";
          default = true;
        }
        {
          workspace = "1";
          monitor = "DP-3";
          default = true;
        }
        {
          workspace = "2";
          monitor = "eDP-1";
          default = true;
        }
        {
          workspace = "2";
          monitor = "eDP-2";
          default = true;
        }
        {
          workspace = "2";
          layout = "dwindle";
        }
      ];

      extraConfig = ''
        local function has_external_monitor()
            local monitors = hl.get_monitors()
            for _, mon in ipairs(monitors) do
                if mon.name == "DP-2" or mon.name == "DP-3" then
                    return true
                end
            end
            return false
        end
        local is_ext = has_external_monitor()
        local trans = is_ext and 1 or 0

        local internal_screens = {"eDP-1", "eDP-2"}
        for _, name in ipairs(internal_screens) do
            hl.monitor({
                ["output"] = name,
                ["mode"] = "preferred",
                ["position"] = "1920x0",
                ["scale"] = "1.6",
                ["transform"] = trans
            })
        end

        local external_screens = {"DP-2", "DP-3"}
        for _, name in ipairs(external_screens) do
            hl.monitor({
                ["output"] = name,
                ["mode"] = "1920x1080@260.00Hz",
                ["position"] = "0x0",
                ["scale"] = "1"
            })
        end
      '';
    };
  };

  environment.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
