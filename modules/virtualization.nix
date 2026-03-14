{ config, pkgs, ... }:
{
  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu = {
  #     package = pkgs.qemu_kvm;
  #     runAsRoot = true;
  #     swtpm.enable = true;
  #     vhostUserPackages = [ pkgs.virtiofsd ];
  #   };
  #   onBoot = "ignore";
  #   onShutdown = "shutdown";
  # };
  # programs.virt-manager.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;

  virtualisation.virtualbox = {
    host.enable = true;
  };
  users.extraGroups.vboxusers.members = [
    "user-with-access-to-virtualbox"
    "djw"
  ];

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    docker-compose
  ];
}
