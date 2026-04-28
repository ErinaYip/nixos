{
  lib,
  config,
  eriniteLib,
  ...
} @ args:

eriniteLib.mkModule args {
  category = "system";
  name = "nvidia";

  opts = {
    prime = {
      enable = eriniteLib.mkBoolOpt false "Enable NVIDIA PRIME Offload.";
      nvidiaBusId = eriniteLib.mkStrOpt "" "Nvidia dGPU Bus ID (e.g., PCI:1:0:0)";
      amdgpuBusId = eriniteLib.mkStrOpt "" "AMD iGPU Bus ID (e.g., PCI:6:0:0)";
      intelBusId  = eriniteLib.mkStrOpt "" "Intel iGPU Bus ID (e.g., PCI:0:2:0)";
    };
  };

  configFn = { cfg, ... }: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    services.xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = lib.mkIf cfg.prime.enable {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = cfg.prime.nvidiaBusId;

        amdgpuBusId = lib.mkIf (cfg.prime.amdgpuBusId != "") cfg.prime.amdgpuBusId;
        intelBusId  = lib.mkIf (cfg.prime.intelBusId != "") cfg.prime.intelBusId;
      };
    };

    nixpkgs.config.cudaSupport = true;
    nix.settings.substituters = [
      "https://cache.nixos-cuda.org"
    ];
    nix.settings.trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };
}
