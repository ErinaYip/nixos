{ ... }: {
  networking.firewall = {
    allowedTCPPorts = [
      25565 # minecraft
    ];
  };
}