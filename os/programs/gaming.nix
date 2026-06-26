{eriniteLib, ...} @ args:
eriniteLib.mkModule args {
  configFn = _: {
    programs = {
      gamescope.enable = true;
      gamemode.enable = true;

      steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
    };
  };
}
