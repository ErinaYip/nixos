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

    wayland.windowManager.hyprland.extraConfig = ''
      local is_ext = false
      for _, mon in ipairs(hl.get_monitors()) do
          if mon.name == "DP-2" or mon.name == "DP-3" then is_ext = true break end
      end

      local function setup_screens(monitors, ws, cfg)
          for _, name in ipairs(monitors) do
              cfg.output = name
              hl.monitor(cfg)

              if is_ext then
                  hl.workspace_rule({workspace = ws, monitor = name, default = true})
              end
          end
      end

      setup_screens({"eDP-1", "eDP-2"}, "2", {mode = "preferred", position = "1920x0", scale = "1.6", transform = is_ext and 1 or 0})
      setup_screens({"DP-2", "DP-3"},   "1", {mode = "1920x1080@260.00Hz", position = "0x0", scale = "1"})

      hl.workspace_rule({workspace = "2", layout = "dwindle"})
    '';
  };

  environment.sessionVariables = {
    SECLISTS = "${pkgs.seclists}/share/wordlists/seclists";
  };
}
