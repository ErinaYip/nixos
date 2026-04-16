{
  lib,
  pkgs,
  ...
} @ args:

lib.erinite.mkModule args {
  category = "development";
  name = "development";

  configFn = { ... }: {
    environment.systemPackages = with pkgs; [
      vim
      wget
      git

      zip
      unzip
      nodejs
      pnpm
      gcc
      gdb
      openjdk
      php
      python3
      uv
    ];

    programs.direnv.enable = true;
  };
}
