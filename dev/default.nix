{pkgs, ...}:
pkgs.mkShell {
  packages = [
    pkgs.nixd
    pkgs.alejandra
    pkgs.deadnix
    pkgs.statix
  ];
}
