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
            local handle = io.popen("hyprctl monitors all -j")
            if not handle then return false end
            local result = handle:read("*a")
            handle:close()

            if string.find(result, '"name":%s*"DP%-2"') or string.find(result, '"name":%s*"DP%-3"') then
                return true
            end
            return false
        end

        local is_external_connected = has_external_monitor()
        local internal_transform = is_external_connected and 1 or 0

        -- settings.monitor
        hl.monitor({
          ["mode"] = "preferred",
          ["output"] = "eDP-1",
          ["position"] = "1920x0",
          ["scale"] = "1.6",
          ["transform"] = internal_transform
        })

        hl.monitor({
          ["mode"] = "preferred",
          ["output"] = "eDP-2",
          ["position"] = "1920x0",
          ["scale"] = "1.6",
          ["transform"] = internal_transform
        })

        hl.monitor({
          ["mode"] = "1920x1080@260.00Hz",
          ["output"] = "DP-2",
          ["position"] = "0x0",
          ["scale"] = "1"
        })

        hl.monitor({
          ["mode"] = "1920x1080@260.00Hz",
          ["output"] = "DP-3",
          ["position"] = "0x0",
          ["scale"] = "1"
        })
      '';
    };
  };

  environment.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
