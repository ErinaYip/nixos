{ ... }: {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
    ];
  };

  services.upower.enable = true;
  services.tuned.enable = true;

}
