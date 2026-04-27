{
  lib,
  inputs,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "boot";

  opts = {
    engine = eriniteLib.mkOpt
      (lib.types.enum [ "systemd-boot" "grub" ])
      "systemd-boot" 
      "The bootloader engine to use.";
  };

  imports = [ inputs.grub2-themes.nixosModules.default ];

  configFn = { cfg, ... }: {
    boot.loader.efi.canTouchEfiVariables = true;

    boot.loader.systemd-boot = lib.mkIf (cfg.engine == "systemd-boot") {
      enable = true;
      configurationLimit = 10;
    };

    boot.loader.grub = lib.mkIf (cfg.engine == "grub") {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };

    boot.loader.grub2-theme = lib.mkIf (cfg.engine == "grub") {
      enable = true;
      theme = "stylish";
      footer = true;
    };
  };
}
