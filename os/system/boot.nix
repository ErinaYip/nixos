{
  lib,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  opts = {
    engine =
      eriniteLib.mkOpt
      (lib.types.enum ["systemd-boot" "grub" "limine"])
      "systemd-boot"
      "The bootloader engine to use.";

    limine.maxGenerations =
      eriniteLib.mkOpt
      lib.types.int
      10
      "Maximum number of generations kept in the Limine boot menu. Limine copies kernels and initrd onto the ESP, so this caps boot partition usage.";
  };

  configFn = {cfg, ...}: {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      timeout = lib.mkIf (cfg.engine == "limine") 5;

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

      limine = lib.mkIf (cfg.engine == "limine") {
        enable = true;
        efiSupport = true;
        maxGenerations = cfg.limine.maxGenerations;
        enableEditor = false;
      };
    };
  };
}
