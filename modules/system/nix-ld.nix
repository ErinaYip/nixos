{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "system";
  name = "nix-ld";

  configFn = { ... }: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc.lib
      ];
    };
  };
}
