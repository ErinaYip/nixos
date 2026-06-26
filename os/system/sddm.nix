{
  lib,
  pkgs,
  inputs,
  eriniteLib,
  ...
} @ args:
eriniteLib.mkModule args {
  imports = [inputs.silentSDDM.nixosModules.default];

  configFn = _: {
    programs.silentSDDM = {
      enable = true;
      theme = "default";
    };

    services.displayManager.sddm = {
      enable = true;

      package = pkgs.kdePackages.sddm;

      settings = {
        General = {
          InputMethod = lib.mkForce "";
        };
      };

      extraPackages = with pkgs.kdePackages; [
        qtvirtualkeyboard
        qtmultimedia
        qt5compat
      ];
    };
  };
}
