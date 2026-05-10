{
  lib,
  pkgs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "programs";
  name = "gaming";

  configFn = {...}: {
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      prismlauncher
      hmcl
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
