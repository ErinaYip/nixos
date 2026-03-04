{ pkgs, inputs, ... }: {
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = false;
    configurationLimit = 10;
  };
  imports = [ inputs.grub2-themes.nixosModules.default ];
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    # theme =  pkgs.stdenv.mkDerivation {
    #   pname = "particle-circle-grub-theme";
    #   version = "unstable-2025-03-18";

    #   src = pkgs.fetchFromGitHub {
    #     owner = "yeyushengfan258";
    #     repo = "Particle-circle-grub-theme";
    #     rev = "f27991237562f93aacc3f333be4284430889f5bb";
    #     hash = "sha256-3yusy7V+ASj6vS7yPe9xhi2YY9TGFKKJpZQwZqITJ0U=";
    #   };

    #   nativeBuildInputs = [ pkgs.imagemagick ];

    #   buildPhase = ''
    #     patchShebangs generate.sh
    #     ./generate.sh -t window
    #   '';

    #   installPhase = ''
    #     mkdir -p $out
    #     cp -r Particle-circle-window/* $out/
    #   '';
    # };
  };
  boot.loader.grub2-theme = {
    enable = true;
    theme = "stylish";
    footer = true;
  };
}
