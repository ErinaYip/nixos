{
  lib,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  category = "system";
  name = "boot";

  opts = {
    engine =
      eriniteLib.mkOpt
      (lib.types.enum ["systemd-boot" "grub"])
      "systemd-boot"
      "The bootloader engine to use.";
  };

  configFn = {cfg, ...}: {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = lib.mkIf (cfg.engine == "systemd-boot") {
        enable = true;
        configurationLimit = 10;
      };

      grub = lib.mkIf (cfg.engine == "grub") {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
      };
    };
  };
}
