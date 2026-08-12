{pkgs, ...}:
pkgs.mkShell {
  packages = [
    pkgs.nil
    pkgs.alejandra
    pkgs.deadnix
    pkgs.statix
  ];
}
