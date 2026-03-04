{ config, pkgs, ... }: {
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
}