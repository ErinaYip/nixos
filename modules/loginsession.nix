{ config, pkgs, lib, inputs, ... }: {
  imports = [ inputs.silentSDDM.nixosModules.default ];
  
  programs.silentSDDM = {
    enable = true;
    theme = "default";
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;

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

  services.greetd = {
    enable = false;
  };
}
