{
  lib,
  inputs,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "sddm";

  imports = [ inputs.silentSDDM.nixosModules.default ];

  configFn = { ... }: {
    programs.silentSDDM = {
      enable = true;
      theme = "default";
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

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
